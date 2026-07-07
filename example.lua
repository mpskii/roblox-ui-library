--[[
    Example Usage - Roblox UI Library
    Shows how to use the UI framework
]]

local UILibrary = require(script.UILibrary)

-- Create a new window
local UI = UILibrary:CreateWindow({
    Title = "Welcome",
    Size = UDim2.new(0, 500, 0, 600),
    Resizable = true,
    CanClose = true,
    Theme = "Dark"
})

-- Create a Home tab
local HomeTab = UI:CreateTab("Home")

-- Create a welcome section
local welcomeSection = HomeTab:CreateSection("Welcome")

-- Add a label
welcomeSection:CreateLabel({
    Text = "Welcome to the UI Framework"
})

welcomeSection:CreateLabel({
    Text = "This is a blank template you can customize with your own features."
})

welcomeSection:CreateDivider()

-- Create a Settings tab
local SettingsTab = UI:CreateTab("Settings")

-- Settings section
local settingsSection = SettingsTab:CreateSection("General")

-- Add a toggle
settingsSection:CreateToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(value)
        print("Toggle changed:", value)
    end
})

-- Add a slider
settingsSection:CreateSlider({
    Name = "Volume",
    Min = 0,
    Max = 100,
    Default = 50,
    Increment = 1,
    Callback = function(value)
        print("Slider value:", value)
    end
})

-- Add a dropdown
settingsSection:CreateDropdown({
    Name = "Theme",
    Options = {"Dark", "Light"},
    Default = "Dark",
    Callback = function(selected)
        print("Selected:", selected)
    end
})

-- Add a text box
settingsSection:CreateTextBox({
    Name = "Username",
    Placeholder = "Enter your username",
    Callback = function(value)
        print("Text changed:", value)
    end
})

-- Add a button
settingsSection:CreateButton({
    Name = "Save Settings",
    Callback = function()
        print("Settings saved!")
    end
})

-- Create an About tab
local AboutTab = UI:CreateTab("About")

local aboutSection = AboutTab:CreateSection("Information")

aboutSection:CreateLabel({
    Text = "Roblox UI Framework v1.0"
})

aboutSection:CreateLabel({
    Text = "A lightweight, reusable UI library for Roblox"
})

aboutSection:CreateButton({
    Name = "Documentation",
    Callback = function()
        print("Opening documentation...")
    end
})
