--[[
    Divider.lua - Divider Component
]]

local Divider = {}
Divider.__index = Divider

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)

--[[
    Create a new Divider instance
]]
function Divider.new(config, section)
    local self = setmetatable({}, Divider)
    
    self.Config = config or {}
    self.Section = section
    
    self:CreateUI()
    
    return self
end

--[[
    Create the divider UI
]]
function Divider:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Divider frame
    self.DividerFrame = Instance.new("Frame")
    self.DividerFrame.Name = "Divider"
    self.DividerFrame.Size = UDim2.new(1, 0, 0, 16)
    self.DividerFrame.BackgroundTransparency = 1
    self.DividerFrame.Parent = self.Section.SectionFrame
    
    -- Line
    local line = Instance.new("Frame")
    line.Name = "Line"
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 0.5, 0)
    line.BackgroundColor3 = theme.DividerColor
    line.BorderSizePixel = 0
    line.Parent = self.DividerFrame
end

return Divider
