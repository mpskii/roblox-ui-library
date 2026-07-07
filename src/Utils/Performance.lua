--[[
    Performance.lua - Performance Optimization Utilities
    Helps optimize UI rendering and event handling
]]

local Performance = {}

local RunService = game:GetService("RunService")

--[[
    Pool for reusable objects to reduce garbage collection
]]
local ObjectPool = {}

--[[
    Create a debounced callback
    @param callback function - Function to debounce
    @param delay number - Delay in seconds
    @return function - Debounced function
]]
function Performance:Debounce(callback, delay)
    local lastCall = 0
    return function(...)
        local now = tick()
        if now - lastCall >= delay then
            lastCall = now
            callback(...)
        end
    end
end

--[[
    Throttle a callback to fire at most once per interval
    @param callback function - Function to throttle
    @param interval number - Interval in seconds
    @return function - Throttled function
]]
function Performance:Throttle(callback, interval)
    local lastCall = 0
    return function(...)
        local now = tick()
        if now - lastCall >= interval then
            lastCall = now
            callback(...)
        end
    end
end

--[[
    Run on next frame
    @param callback function - Callback to run
]]
function Performance:NextFrame(callback)
    RunService.RenderStepped:Wait()
    callback()
end

--[[
    Run on next game step
    @param callback function - Callback to run
]]
function Performance:NextStep(callback)
    RunService.Heartbeat:Wait()
    callback()
end

--[[
    Create a reusable object pool
    @param createFunc function - Function to create objects
    @param resetFunc function - Function to reset objects
    @return table - Pool with Get/Return methods
]]
function Performance:CreateObjectPool(createFunc, resetFunc)
    local pool = {
        Available = {},
        InUse = {}
    }
    
    function pool:Get()
        local obj
        if #self.Available > 0 then
            obj = table.remove(self.Available)
        else
            obj = createFunc()
        end
        table.insert(self.InUse, obj)
        return obj
    end
    
    function pool:Return(obj)
        if resetFunc then
            resetFunc(obj)
        end
        local index = table.find(self.InUse, obj)
        if index then
            table.remove(self.InUse, index)
            table.insert(self.Available, obj)
        end
    end
    
    function pool:Clear()
        for _, obj in pairs(self.Available) do
            if obj.Parent then
                obj:Destroy()
            end
        end
        self.Available = {}
    end
    
    return pool
end

--[[
    Lazy load a module
    @param modulePath string - Path to module
    @return function - Function that loads module on call
]]
function Performance:LazyRequire(modulePath)
    local module = nil
    return function()
        if not module then
            module = require(modulePath)
        end
        return module
    end
end

--[[
    Cache a function result
    @param func function - Function to cache
    @param duration number - Cache duration in seconds
    @return function - Cached function
]]
function Performance:CacheFunction(func, duration)
    duration = duration or 60
    local cache = {}
    local lastUpdate = 0
    
    return function(...)
        local now = tick()
        if now - lastUpdate > duration then
            cache = func(...)
            lastUpdate = now
        end
        return cache
    end
end

--[[
    Batch update operations
    @param operations table - List of operations to perform
    @param batchSize number - Number of operations per batch
]]
function Performance:BatchOperations(operations, batchSize)
    batchSize = batchSize or 10
    local index = 1
    
    while index <= #operations do
        local endIndex = math.min(index + batchSize - 1, #operations)
        
        for i = index, endIndex do
            operations[i]()
        end
        
        index = endIndex + 1
        RunService.Heartbeat:Wait()
    end
end

return Performance
