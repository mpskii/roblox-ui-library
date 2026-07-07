--[[
    Tab.lua - Tab Management
    Manages content within a tab
]]

local Tab = {}
Tab.__index = Tab

local Section = require(script.Parent.Section)
local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)

--[[
    Create a new Tab instance
]]
function Tab.new(name, window)
    local self = setmetatable({}, Tab)
    
    self.Name = name
    self.Window = window
    self.Sections = {}
    self.SectionOrder = {}
    
    self:CreateUI()
    
    return self
end

--[[
    Create the tab UI
]]
function Tab:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Tab frame
    self.TabFrame = Instance.new("Frame")
    self.TabFrame.Name = self.Name .. "_Tab"
    self.TabFrame.Size = UDim2.new(1, 0, 1, 0)
    self.TabFrame.BackgroundTransparency = 1
    self.TabFrame.Visible = false
    self.TabFrame.Parent = self.Window.ScrollFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 8)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = self.TabFrame
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.PaddingTop = UDim.new(0, 12)
    padding.PaddingBottom = UDim.new(0, 12)
    padding.Parent = self.TabFrame
end

--[[
    Create a section
    @param sectionName string - Name of the section
    @return Section object
]]
function Tab:CreateSection(sectionName)
    local section = Section.new(sectionName, self)
    
    self.Sections[sectionName] = section
    table.insert(self.SectionOrder, sectionName)
    
    return section
end

--[[
    Create a button
    @param config table - Button configuration
        - Name (string): Button text
        - Callback (function): Function to call on click
        - Description (string): Optional description
]]
function Tab:CreateButton(config)
    local section = self:CreateSection("Default")
    return section:CreateButton(config)
end

--[[
    Create a toggle
    @param config table - Toggle configuration
        - Name (string): Toggle label
        - Default (boolean): Default state
        - Callback (function): Function to call on change
]]
function Tab:CreateToggle(config)
    local section = self:CreateSection("Default")
    return section:CreateToggle(config)
end

--[[
    Create a slider
    @param config table - Slider configuration
        - Name (string): Slider label
        - Min (number): Minimum value
        - Max (number): Maximum value
        - Default (number): Default value
        - Increment (number): Step size
        - Callback (function): Function to call on change
]]
function Tab:CreateSlider(config)
    local section = self:CreateSection("Default")
    return section:CreateSlider(config)
end

--[[
    Create a dropdown
    @param config table - Dropdown configuration
        - Name (string): Dropdown label
        - Options (table): List of options
        - Default (string): Default option
        - Callback (function): Function to call on selection
]]
function Tab:CreateDropdown(config)
    local section = self:CreateSection("Default")
    return section:CreateDropdown(config)
end

--[[
    Create a text box
    @param config table - TextBox configuration
        - Name (string): Label
        - Placeholder (string): Placeholder text
        - Default (string): Default value
        - Callback (function): Function to call on change
]]
function Tab:CreateTextBox(config)
    local section = self:CreateSection("Default")
    return section:CreateTextBox(config)
end

--[[
    Create a label
    @param config table - Label configuration
        - Text (string): Label text
        - Size (UDim): Optional size
]]
function Tab:CreateLabel(config)
    local section = self:CreateSection("Default")
    return section:CreateLabel(config)
end

return Tab
