--[[
    TextBox.lua - TextBox Component
]]

local TextBox = {}
TextBox.__index = TextBox

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)

--[[
    Create a new TextBox instance
]]
function TextBox.new(config, section)
    local self = setmetatable({}, TextBox)
    
    self.Config = config or {}
    self.Section = section
    self.Enabled = self.Config.Enabled ~= false
    self.Value = self.Config.Default or ""
    
    self:CreateUI()
    
    return self
end

--[[
    Create the textbox UI
]]
function TextBox:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- TextBox container
    self.TextBoxFrame = Instance.new("Frame")
    self.TextBoxFrame.Name = self.Config.Name or "TextBox"
    self.TextBoxFrame.Size = UDim2.new(1, 0, 0, 40)
    self.TextBoxFrame.BackgroundTransparency = 1
    self.TextBoxFrame.Parent = self.Section.SectionFrame
    
    -- Label
    if self.Config.Name then
        local label = Instance.new("TextLabel")
        label.Name = "Label"
        label.Size = UDim2.new(1, 0, 0, 20)
        label.BackgroundTransparency = 1
        label.TextColor3 = theme.TextColor
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Gotham
        label.Text = self.Config.Name
        label.Parent = self.TextBoxFrame
    end
    
    -- TextBox input
    self.Input = Instance.new("TextBox")
    self.Input.Name = "Input"
    self.Input.Size = UDim2.new(1, 0, 0, 28)
    self.Input.Position = UDim2.new(0, 0, 0, 12)
    self.Input.BackgroundColor3 = theme.InputBackground
    self.Input.TextColor3 = theme.TextColor
    self.Input.TextSize = 12
    self.Input.Font = Enum.Font.Gotham
    self.Input.Text = self.Value
    self.Input.PlaceholderText = self.Config.Placeholder or ""
    self.Input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    self.Input.Parent = self.TextBoxFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = self.Input
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = self.Input
    
    -- Text change
    self.Input.Changed:Connect(function()
        self.Value = self.Input.Text
        if self.Config.Callback then
            self.Config.Callback(self.Value)
        end
    end)
end

--[[
    Set textbox value
]]
function TextBox:SetValue(value)
    self.Value = value
    self.Input.Text = value
end

--[[
    Get textbox value
]]
function TextBox:GetValue()
    return self.Value
end

return TextBox
