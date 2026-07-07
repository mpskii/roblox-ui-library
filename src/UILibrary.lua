--[[
    UILibrary - Main Entry Point
    A lightweight, reusable Roblox UI framework
]]

local UILibrary = {}
UILibrary.__index = UILibrary

local Window = require(script.Parent.Core.Window)
local ThemeManager = require(script.Parent.Themes.ThemeManager)
local ConfigManager = require(script.Parent.Config.ConfigManager)

--[[
    Create a new UI Window
    @param config table - Configuration options
        - Title (string): Window title
        - Size (UDim2): Window size
        - Position (UDim2): Window position (optional)
        - Resizable (boolean): Allow resizing (default: true)
        - CanClose (boolean): Show close button (default: true)
        - Theme (string): Theme name (default: "Dark")
    @return Window object
]]
function UILibrary:CreateWindow(config)
    config = config or {}
    
    local defaultConfig = {
        Title = "UI Library",
        Size = UDim2.new(0, 500, 0, 600),
        Position = UDim2.new(0.5, -250, 0.5, -300),
        Resizable = true,
        CanClose = true,
        Theme = "Dark"
    }
    
    for key, value in pairs(defaultConfig) do
        if config[key] == nil then
            config[key] = value
        end
    end
    
    ThemeManager:SetTheme(config.Theme)
    local window = Window.new(config)
    
    return window
end

--[[
    Get the current theme
    @return table - Current theme configuration
]]
function UILibrary:GetTheme()
    return ThemeManager:GetCurrentTheme()
end

--[[
    Set the current theme
    @param themeName string - Theme name
]]
function UILibrary:SetTheme(themeName)
    ThemeManager:SetTheme(themeName)
end

--[[
    Save configuration
    @param key string - Configuration key
    @param value any - Value to save
]]
function UILibrary:SaveConfig(key, value)
    ConfigManager:Save(key, value)
end

--[[
    Load configuration
    @param key string - Configuration key
    @param defaultValue any - Default value if not found
    @return any - Loaded value
]]
function UILibrary:LoadConfig(key, defaultValue)
    return ConfigManager:Load(key, defaultValue)
end

return UILibrary
