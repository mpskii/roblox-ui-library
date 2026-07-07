--[[
    ConfigManager.lua - Configuration Management
    Handles saving and loading user settings
]]

local ConfigManager = {}

local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local configCache = {}
local configFile = "UILibrary_Config"

--[[
    Save a configuration value
    @param key string - Configuration key
    @param value any - Value to save
]]
function ConfigManager:Save(key, value)
    configCache[key] = value
    
    -- Only save to file if not in play mode or if using HttpService
    if not RunService:IsRunning() then
        self:WriteToFile()
    end
end

--[[
    Load a configuration value
    @param key string - Configuration key
    @param defaultValue any - Default value if not found
    @return any - Loaded value
]]
function ConfigManager:Load(key, defaultValue)
    if configCache[key] ~= nil then
        return configCache[key]
    end
    
    return defaultValue
end

--[[
    Save all configurations to file
]]
function ConfigManager:WriteToFile()
    -- This is a placeholder for file writing
    -- In actual implementation, would use HttpService or other storage
    if HttpService then
        local json = HttpService:JSONEncode(configCache)
        -- Store in a way appropriate to your system
    end
end

--[[
    Load all configurations from file
]]
function ConfigManager:ReadFromFile()
    -- This is a placeholder for file reading
    -- In actual implementation, would use HttpService or other storage
    if HttpService then
        -- Load from stored location
    end
end

--[[
    Clear all configurations
]]
function ConfigManager:Clear()
    configCache = {}
end

return ConfigManager
