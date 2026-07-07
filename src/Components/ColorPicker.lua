--[[
    ColorPicker.lua - Color Picker Component
    Allows users to select colors
]]

local ColorPicker = {}
ColorPicker.__index = ColorPicker

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)

--[[
    Create a new ColorPicker instance
]]
function ColorPicker.new(config, section)
    local self = setmetatable({}, ColorPicker)
    
    self.Config = config or {}
    self.Section = section
    self.Enabled = self.Config.Enabled ~= false
    self.Value = self.Config.Default or Color3.fromRGB(255, 255, 255)
    
    self:CreateUI()
    
    return self
end

--[[
    Create the color picker UI
]]
function ColorPicker:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Container
    self.PickerFrame = Instance.new("Frame")
    self.PickerFrame.Name = self.Config.Name or "ColorPicker"
    self.PickerFrame.Size = UDim2.new(1, 0, 0, 36)
    self.PickerFrame.BackgroundTransparency = 1
    self.PickerFrame.Parent = self.Section.SectionFrame
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = theme.TextColor
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Text = self.Config.Name or "Color"
    label.Parent = self.PickerFrame
    
    -- Color display
    local colorDisplay = Instance.new("Frame")
    colorDisplay.Name = "ColorDisplay"
    colorDisplay.Size = UDim2.new(0, 30, 0, 30)
    colorDisplay.Position = UDim2.new(1, -40, 0.5, -15)
    colorDisplay.BackgroundColor3 = self.Value
    colorDisplay.BorderSizePixel = 0
    colorDisplay.Parent = self.PickerFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = colorDisplay
    
    self.ColorDisplay = colorDisplay
    
    -- Click to open picker
    colorDisplay.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self:OpenPicker()
        end
    end)
end

--[[
    Open the color picker
]]
function ColorPicker:OpenPicker()
    -- Placeholder - would open a color picker UI
    if self.Config.Callback then
        self.Config.Callback(self.Value)
    end
end

--[[
    Set the color
]]
function ColorPicker:SetColor(color)
    self.Value = color
    self.ColorDisplay.BackgroundColor3 = color
    
    if self.Config.Callback then
        self.Config.Callback(color)
    end
end

--[[
    Get the color
]]
function ColorPicker:GetColor()
    return self.Value
end

return ColorPicker
