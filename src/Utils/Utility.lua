--[[
    Utility.lua - Utility Functions
    Common helper functions for the UI framework
]]

local Utility = {}

--[[
    Clamp a value between min and max
    @param value number - Value to clamp
    @param min number - Minimum value
    @param max number - Maximum value
    @return number - Clamped value
]]
function Utility:Clamp(value, min, max)
    return math.max(math.min(value, max), min)
end

--[[
    Lerp between two values
    @param a number - Start value
    @param b number - End value
    @param t number - Interpolation factor (0-1)
    @return number - Interpolated value
]]
function Utility:Lerp(a, b, t)
    return a + (b - a) * t
end

--[[
    Check if point is in bounds
    @param point Vector2 - Point to check
    @param min Vector2 - Minimum bounds
    @param max Vector2 - Maximum bounds
    @return boolean - Whether point is in bounds
]]
function Utility:PointInBounds(point, min, max)
    return point.X >= min.X and point.X <= max.X and point.Y >= min.Y and point.Y <= max.Y
end

--[[
    Create a deep copy of a table
    @param tbl table - Table to copy
    @return table - Copied table
]]
function Utility:DeepCopy(tbl)
    local copy = {}
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            copy[k] = self:DeepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

--[[
    Merge two tables
    @param base table - Base table
    @param override table - Override table
    @return table - Merged table
]]
function Utility:MergeTables(base, override)
    local merged = self:DeepCopy(base)
    for k, v in pairs(override) do
        merged[k] = v
    end
    return merged
end

--[[
    Debounce a function
    @param func function - Function to debounce
    @param delay number - Delay in seconds
    @return function - Debounced function
]]
function Utility:Debounce(func, delay)
    local lastCall = 0
    return function(...)
        local now = tick()
        if now - lastCall >= delay then
            lastCall = now
            func(...)
        end
    end
end

--[[
    Format a number with commas
    @param num number - Number to format
    @return string - Formatted number
]]
function Utility:FormatNumber(num)
    local formatted = tostring(num)
    local k
    while true do
        formatted, k = formatted:gsub("^(-?%d+)(%d{3})", "%1,%2")
        if (k == 0) then break end
    end
    return formatted
end

return Utility
