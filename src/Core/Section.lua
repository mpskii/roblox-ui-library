--[[
    Section.lua - Section Management
    Manages components within a section
]]

local Section = {}
Section.__index = Section

local Button = require(script.Parent.Parent.Components.Button)
local Toggle = require(script.Parent.Parent.Components.Toggle)
local Slider = require(script.Parent.Parent.Components.Slider)
local Dropdown = require(script.Parent.Parent.Components.Dropdown)
local TextBox = require(script.Parent.Parent.Components.TextBox)
local Label = require(script.Parent.Parent.Components.Label)
local Divider = require(script.Parent.Parent.Components.Divider)
local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)

--[[
    Create a new Section instance
]]
function Section.new(name, tab)
    local self = setmetatable({}, Section)
    
    self.Name = name
    self.Tab = tab
    self.Components = {}
    
    self:CreateUI()
    
    return self
end

--[[
    Create the section UI
]]
function Section:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Section container
    self.SectionFrame = Instance.new("Frame")
    self.SectionFrame.Name = self.Name .. "_Section"
    self.SectionFrame.Size = UDim2.new(1, 0, 0, 0)
    self.SectionFrame.BackgroundTransparency = 1
    self.SectionFrame.Parent = self.Tab.TabFrame
    
    -- Section layout
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = self.SectionFrame
    
    -- Section title
    if self.Name ~= "Default" then
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Size = UDim2.new(1, 0, 0, 24)
        titleLabel.BackgroundTransparency = 1
        titleLabel.TextColor3 = theme.TextColor
        titleLabel.TextSize = 14
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.Text = self.Name
        titleLabel.Parent = self.SectionFrame
    end
end

--[[
    Create a button
    @param config table - Button configuration
]]
function Section:CreateButton(config)
    local button = Button.new(config, self)
    table.insert(self.Components, button)
    return button
end

--[[
    Create a toggle
    @param config table - Toggle configuration
]]
function Section:CreateToggle(config)
    local toggle = Toggle.new(config, self)
    table.insert(self.Components, toggle)
    return toggle
end

--[[
    Create a slider
    @param config table - Slider configuration
]]
function Section:CreateSlider(config)
    local slider = Slider.new(config, self)
    table.insert(self.Components, slider)
    return slider
end

--[[
    Create a dropdown
    @param config table - Dropdown configuration
]]
function Section:CreateDropdown(config)
    local dropdown = Dropdown.new(config, self)
    table.insert(self.Components, dropdown)
    return dropdown
end

--[[
    Create a text box
    @param config table - TextBox configuration
]]
function Section:CreateTextBox(config)
    local textBox = TextBox.new(config, self)
    table.insert(self.Components, textBox)
    return textBox
end

--[[
    Create a label
    @param config table - Label configuration
]]
function Section:CreateLabel(config)
    local label = Label.new(config, self)
    table.insert(self.Components, label)
    return label
end

--[[
    Create a divider
    @param config table - Divider configuration (optional)
]]
function Section:CreateDivider(config)
    local divider = Divider.new(config or {}, self)
    table.insert(self.Components, divider)
    return divider
end

return Section
