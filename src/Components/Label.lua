--[[
    Label.lua - Label Component
]]

local Label = {}
Label.__index = Label

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)

--[[
    Create a new Label instance
]]
function Label.new(config, section)
    local self = setmetatable({}, Label)
    
    self.Config = config or {}
    self.Section = section
    
    self:CreateUI()
    
    return self
end

--[[
    Create the label UI
]]
function Label:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Label frame
    self.LabelFrame = Instance.new("Frame")
    self.LabelFrame.Name = "Label"
    self.LabelFrame.Size = UDim2.new(1, 0, 0, 24)
    self.LabelFrame.BackgroundTransparency = 1
    self.LabelFrame.Parent = self.Section.SectionFrame
    
    -- Label text
    self.Label = Instance.new("TextLabel")
    self.Label.Name = "Text"
    self.Label.Size = UDim2.new(1, 0, 1, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.TextColor3 = theme.TextColor
    self.Label.TextSize = 12
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.TextWrapped = true
    self.Label.Font = Enum.Font.Gotham
    self.Label.Text = self.Config.Text or "Label"
    self.Label.Parent = self.LabelFrame
end

--[[
    Set label text
]]
function Label:SetText(text)
    self.Label.Text = text
end

--[[
    Get label text
]]
function Label:GetText()
    return self.Label.Text
end

return Label
