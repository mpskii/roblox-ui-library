--[[
    Toggle.lua - Toggle Component
]]

local Toggle = {}
Toggle.__index = Toggle

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)
local Animator = require(script.Parent.Parent.Animation.Animator)

--[[
    Create a new Toggle instance
]]
function Toggle.new(config, section)
    local self = setmetatable({}, Toggle)
    
    self.Config = config or {}
    self.Section = section
    self.Enabled = self.Config.Enabled ~= false
    self.Value = self.Config.Default or false
    
    self:CreateUI()
    
    return self
end

--[[
    Create the toggle UI
]]
function Toggle:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Toggle container
    self.ToggleFrame = Instance.new("Frame")
    self.ToggleFrame.Name = self.Config.Name or "Toggle"
    self.ToggleFrame.Size = UDim2.new(1, 0, 0, 36)
    self.ToggleFrame.BackgroundTransparency = 1
    self.ToggleFrame.Parent = self.Section.SectionFrame
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, -50, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = theme.TextColor
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Text = self.Config.Name or "Toggle"
    label.Parent = self.ToggleFrame
    
    -- Toggle button
    self.ToggleButton = Instance.new("TextButton")
    self.ToggleButton.Name = "ToggleButton"
    self.ToggleButton.Size = UDim2.new(0, 44, 0, 24)
    self.ToggleButton.Position = UDim2.new(1, -50, 0.5, -12)
    self.ToggleButton.BackgroundColor3 = self.Value and theme.ToggleOn or theme.ToggleOff
    self.ToggleButton.TextTransparency = 1
    self.ToggleButton.Parent = self.ToggleFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = self.ToggleButton
    
    -- Toggle indicator
    self.ToggleIndicator = Instance.new("Frame")
    self.ToggleIndicator.Name = "Indicator"
    self.ToggleIndicator.Size = UDim2.new(0, 20, 0, 20)
    self.ToggleIndicator.Position = self.Value and UDim2.new(0, 22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    self.ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.ToggleIndicator.Parent = self.ToggleButton
    
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 10)
    indicatorCorner.Parent = self.ToggleIndicator
    
    -- Toggle click
    self.ToggleButton.MouseButton1Click:Connect(function()
        self:SetValue(not self.Value)
    end)
end

--[[
    Set toggle value
]]
function Toggle:SetValue(value)
    local theme = ThemeManager:GetCurrentTheme()
    self.Value = value
    
    self.ToggleButton.BackgroundColor3 = value and theme.ToggleOn or theme.ToggleOff
    
    Animator:TweenProperty(self.ToggleIndicator, "Position", 
        value and UDim2.new(0, 22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10), 
        0.2
    )
    
    if self.Config.Callback then
        self.Config.Callback(value)
    end
end

--[[
    Get toggle value
]]
function Toggle:GetValue()
    return self.Value
end

return Toggle
