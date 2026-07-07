--[[
    Slider.lua - Slider Component
]]

local Slider = {}
Slider.__index = Slider

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)
local Animator = require(script.Parent.Parent.Animation.Animator)

--[[
    Create a new Slider instance
]]
function Slider.new(config, section)
    local self = setmetatable({}, Slider)
    
    self.Config = config or {}
    self.Section = section
    self.Enabled = self.Config.Enabled ~= false
    self.Min = self.Config.Min or 0
    self.Max = self.Config.Max or 100
    self.Increment = self.Config.Increment or 1
    self.Value = self.Config.Default or self.Min
    self.IsDragging = false
    
    self:CreateUI()
    
    return self
end

--[[
    Create the slider UI
]]
function Slider:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Slider container
    self.SliderFrame = Instance.new("Frame")
    self.SliderFrame.Name = self.Config.Name or "Slider"
    self.SliderFrame.Size = UDim2.new(1, 0, 0, 50)
    self.SliderFrame.BackgroundTransparency = 1
    self.SliderFrame.Parent = self.Section.SectionFrame
    
    -- Label and value
    local headerFrame = Instance.new("Frame")
    headerFrame.Name = "Header"
    headerFrame.Size = UDim2.new(1, 0, 0, 24)
    headerFrame.BackgroundTransparency = 1
    headerFrame.Parent = self.SliderFrame
    
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = theme.TextColor
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Text = self.Config.Name or "Slider"
    label.Parent = headerFrame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "Value"
    valueLabel.Size = UDim2.new(0.5, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.TextColor3 = theme.AccentColor
    valueLabel.TextSize = 13
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.Text = tostring(self.Value)
    valueLabel.Parent = headerFrame
    
    self.ValueLabel = valueLabel
    
    -- Slider background
    local sliderBg = Instance.new("Frame")
    sliderBg.Name = "Background"
    sliderBg.Size = UDim2.new(1, 0, 0, 6)
    sliderBg.Position = UDim2.new(0, 0, 1, -8)
    sliderBg.BackgroundColor3 = theme.SliderBackground
    sliderBg.Parent = self.SliderFrame
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 3)
    bgCorner.Parent = sliderBg
    
    -- Slider fill
    self.SliderFill = Instance.new("Frame")
    self.SliderFill.Name = "Fill"
    self.SliderFill.Size = UDim2.new((self.Value - self.Min) / (self.Max - self.Min), 0, 1, 0)
    self.SliderFill.BackgroundColor3 = theme.SliderFill
    self.SliderFill.Parent = sliderBg
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 3)
    fillCorner.Parent = self.SliderFill
    
    -- Slider thumb
    self.SliderThumb = Instance.new("Frame")
    self.SliderThumb.Name = "Thumb"
    self.SliderThumb.Size = UDim2.new(0, 14, 0, 14)
    self.SliderThumb.Position = UDim2.new((self.Value - self.Min) / (self.Max - self.Min), -7, 0.5, -7)
    self.SliderThumb.BackgroundColor3 = theme.SliderThumb
    self.SliderThumb.Parent = sliderBg
    
    local thumbCorner = Instance.new("UICorner")
    thumbCorner.CornerRadius = UDim.new(0, 7)
    thumbCorner.Parent = self.SliderThumb
    
    -- Dragging
    self.SliderThumb.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.IsDragging = true
        end
    end)
    
    self.SliderThumb.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.IsDragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if self.IsDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = input.Position.X
            local bgPos = sliderBg.AbsolutePosition.X
            local bgSize = sliderBg.AbsoluteSize.X
            
            local percent = math.clamp((mousePos - bgPos) / bgSize, 0, 1)
            local newValue = self.Min + (percent * (self.Max - self.Min))
            
            -- Round to increment
            newValue = math.floor(newValue / self.Increment + 0.5) * self.Increment
            
            self:SetValue(newValue)
        end
    end)
end

--[[
    Set slider value
]]
function Slider:SetValue(value)
    value = math.clamp(value, self.Min, self.Max)
    self.Value = value
    
    local percent = (value - self.Min) / (self.Max - self.Min)
    
    self.SliderFill.Size = UDim2.new(percent, 0, 1, 0)
    self.SliderThumb.Position = UDim2.new(percent, -7, 0.5, -7)
    self.ValueLabel.Text = tostring(math.floor(value * 100) / 100)
    
    if self.Config.Callback then
        self.Config.Callback(value)
    end
end

--[[
    Get slider value
]]
function Slider:GetValue()
    return self.Value
end

return Slider
