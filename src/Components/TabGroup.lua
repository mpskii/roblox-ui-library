--[[
    TabGroup.lua - Advanced Tab Management
    Allows creating tab groups with custom behavior
]]

local TabGroup = {}
TabGroup.__index = TabGroup

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)

--[[
    Create a new TabGroup instance
]]
function TabGroup.new(config, section)
    local self = setmetatable({}, TabGroup)
    
    self.Config = config or {}
    self.Section = section
    self.Tabs = {}
    self.SelectedTab = nil
    
    self:CreateUI()
    
    return self
end

--[[
    Create the tab group UI
]]
function TabGroup:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Container
    self.TabGroupFrame = Instance.new("Frame")
    self.TabGroupFrame.Name = self.Config.Name or "TabGroup"
    self.TabGroupFrame.Size = UDim2.new(1, 0, 0, 100)
    self.TabGroupFrame.BackgroundTransparency = 1
    self.TabGroupFrame.Parent = self.Section.SectionFrame
    
    -- Tab buttons frame
    self.TabButtonsFrame = Instance.new("Frame")
    self.TabButtonsFrame.Name = "TabButtons"
    self.TabButtonsFrame.Size = UDim2.new(1, 0, 0, 32)
    self.TabButtonsFrame.BackgroundTransparency = 1
    self.TabButtonsFrame.Parent = self.TabGroupFrame
    
    local buttonsLayout = Instance.new("UIListLayout")
    buttonsLayout.Padding = UDim.new(0, 4)
    buttonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    buttonsLayout.FillDirection = Enum.FillDirection.Horizontal
    buttonsLayout.Parent = self.TabButtonsFrame
    
    -- Content frame
    self.ContentFrame = Instance.new("Frame")
    self.ContentFrame.Name = "Content"
    self.ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    self.ContentFrame.Position = UDim2.new(0, 0, 0, 40)
    self.ContentFrame.BackgroundColor3 = theme.InputBackground
    self.ContentFrame.BorderSizePixel = 0
    self.ContentFrame.Parent = self.TabGroupFrame
    
    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 6)
    contentCorner.Parent = self.ContentFrame
end

--[[
    Add a tab to the group
]]
function TabGroup:AddTab(tabName)
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Create tab button
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName .. "_Tab"
    tabButton.Size = UDim2.new(0, 80, 1, 0)
    tabButton.BackgroundColor3 = theme.ButtonBackground
    tabButton.TextColor3 = theme.TextColor
    tabButton.TextSize = 12
    tabButton.Font = Enum.Font.Gotham
    tabButton.Text = tabName
    tabButton.Parent = self.TabButtonsFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = tabButton
    
    -- Create tab content frame
    local tabContent = Instance.new("Frame")
    tabContent.Name = tabName .. "_Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.Parent = self.ContentFrame
    
    self.Tabs[tabName] = {
        Button = tabButton,
        Content = tabContent
    }
    
    -- Select first tab by default
    if self.SelectedTab == nil then
        self:SelectTab(tabName)
    end
    
    tabButton.MouseButton1Click:Connect(function()
        self:SelectTab(tabName)
    end)
    
    return tabContent
end

--[[
    Select a tab
]]
function TabGroup:SelectTab(tabName)
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Deselect old tab
    if self.SelectedTab and self.Tabs[self.SelectedTab] then
        self.Tabs[self.SelectedTab].Button.BackgroundColor3 = theme.ButtonBackground
        self.Tabs[self.SelectedTab].Content.Visible = false
    end
    
    -- Select new tab
    self.SelectedTab = tabName
    if self.Tabs[tabName] then
        self.Tabs[tabName].Button.BackgroundColor3 = theme.AccentColor
        self.Tabs[tabName].Content.Visible = true
    end
end

return TabGroup
