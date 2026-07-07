--[[
    ThemeManager.lua - Theme Management
    Handles theme selection and application
]]

local ThemeManager = {}
ThemeManager.__index = ThemeManager

local DarkTheme = require(script.Parent.Dark)

local themes = {
    Dark = DarkTheme,
}

local currentTheme = DarkTheme

--[[
    Register a new theme
    @param name string - Theme name
    @param theme table - Theme configuration
]]
function ThemeManager:RegisterTheme(name, theme)
    themes[name] = theme
end

--[[
    Set the current theme
    @param themeName string - Name of the theme to set
]]
function ThemeManager:SetTheme(themeName)
    if themes[themeName] then
        currentTheme = themes[themeName]
    else
        warn("Theme '" .. themeName .. "' not found. Using Dark theme.")
        currentTheme = DarkTheme
    end
end

--[[
    Get the current theme
    @return table - Current theme configuration
]]
function ThemeManager:GetCurrentTheme()
    return currentTheme
end

--[[
    Get a specific theme
    @param themeName string - Name of the theme
    @return table - Theme configuration
]]
function ThemeManager:GetTheme(themeName)
    return themes[themeName]
end

--[[
    List all available themes
    @return table - List of theme names
]]
function ThemeManager:GetThemeList()
    local list = {}
    for name, _ in pairs(themes) do
        table.insert(list, name)
    end
    return list
end

return ThemeManager
