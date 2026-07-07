--[[
    Button.lua - Button Component
]]

local Button = {}
Button.__index = Button

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)
local Animator = require(script.Parent.Parent.Animation.Animator)

--[[
    Create a new Button instance
]]
function Button.new(config, section)
    local self = setmetatable({}, Button)
    
    self.Config = config or {}
    self.Section = section
    self.Enabled = self.Config.Enabled ~= false
    
    self:CreateUI()
    
    return self
end

--[[
    Create the button UI
]]
function Button:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Button container
    self.ButtonFrame = Instance.new("Frame")
    self.ButtonFrame.Name = self.Config.Name or "Button"
    self.ButtonFrame.Size = UDim2.new(1, 0, 0, 36)
    self.ButtonFrame.BackgroundTransparency = 1
    self.ButtonFrame.Parent = self.Section.SectionFrame
    
    -- Button
    self.Button = Instance.new("TextButton")
    self.Button.Name = "Button"
    self.Button.Size = UDim2.new(1, 0, 1, 0)
    self.Button.BackgroundColor3 = theme.ButtonBackground
    self.Button.TextColor3 = theme.TextColor
    self.Button.TextSize = 13
    self.Button.Font = Enum.Font.Gotham
    self.Button.Text = self.Config.Name or "Button"
    self.Button.Parent = self.ButtonFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = self.Button
    
    -- Button click
    self.Button.MouseButton1Click:Connect(function()
        if self.Config.Callback then
            self.Config.Callback()
        end
    end)
    
    -- Hover effects
    self.Button.MouseEnter:Connect(function()
        Animator:TweenProperty(self.Button, "BackgroundColor3", theme.ButtonHover, 0.2)
    end)
    
    self.Button.MouseLeave:Connect(function()
        Animator:TweenProperty(self.Button, "BackgroundColor3", theme.ButtonBackground, 0.2)
    end)
end

--[[
    Set button enabled state
]]
function Button:SetEnabled(enabled)
    self.Enabled = enabled
    self.Button.Active = enabled
    self.Button.TextTransparency = enabled and 0 or 0.5
end

return Button
