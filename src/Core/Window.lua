--[[
    Window.lua - Main Window Management
    Handles window creation, dragging, resizing, and animations
]]

local Window = {}
Window.__index = Window

local Animator = require(script.Parent.Parent.Animation.Animator)
local Input = require(script.Parent.Parent.Utils.Input)
local Utility = require(script.Parent.Parent.Utils.Utility)
local Tab = require(script.Parent.Tab)
local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)

--[[
    Create a new Window instance
]]
function Window.new(config)
    local self = setmetatable({}, Window)
    
    self.Config = config
    self.Tabs = {}
    self.TabOrder = {}
    self.CurrentTab = nil
    self.IsOpen = true
    self.IsDragging = false
    self.DragStart = nil
    self.Connections = {}
    
    self:CreateUI()
    self:SetupInput()
    
    return self
end

--[[
    Create the main UI structure
]]
function Window:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Main window container
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "UILibrary_Window"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Main frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Size = self.Config.Size
    self.MainFrame.Position = self.Config.Position
    self.MainFrame.BackgroundColor3 = theme.BackgroundColor
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Parent = self.ScreenGui
    
    -- Corner radius
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = self.MainFrame
    
    -- Stroke
    local stroke = Instance.new("UIStroke")
    stroke.Color = theme.StrokeColor
    stroke.Thickness = 1
    stroke.Parent = self.MainFrame
    
    -- Header
    self:CreateHeader(theme)
    
    -- Content area (sidebar + main content)
    self:CreateContentArea(theme)
    
    -- Add dragging capability
    self:MakeDraggable(self.HeaderFrame)
end

--[[
    Create the window header with title and buttons
]]
function Window:CreateHeader(theme)
    self.HeaderFrame = Instance.new("Frame")
    self.HeaderFrame.Name = "Header"
    self.HeaderFrame.Size = UDim2.new(1, 0, 0, 40)
    self.HeaderFrame.BackgroundColor3 = theme.HeaderBackground
    self.HeaderFrame.BorderSizePixel = 0
    self.HeaderFrame.Parent = self.MainFrame
    
    -- Header title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -80, 1, 0)
    titleLabel.Position = UDim2.new(0, 12, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = theme.TextColor
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = self.Config.Title
    titleLabel.Parent = self.HeaderFrame
    
    self.TitleLabel = titleLabel
    
    -- Close button
    if self.Config.CanClose then
        local closeButton = Instance.new("TextButton")
        closeButton.Name = "CloseButton"
        closeButton.Size = UDim2.new(0, 32, 0, 32)
        closeButton.Position = UDim2.new(1, -38, 0.5, -16)
        closeButton.BackgroundColor3 = theme.ButtonBackground
        closeButton.TextColor3 = theme.TextColor
        closeButton.TextSize = 16
        closeButton.Font = Enum.Font.GothamBold
        closeButton.Text = "✕"
        closeButton.Parent = self.HeaderFrame
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = closeButton
        
        closeButton.MouseButton1Click:Connect(function()
            self:Close()
        end)
    end
    
    -- Divider
    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.Size = UDim2.new(1, 0, 0, 1)
    divider.Position = UDim2.new(0, 0, 1, 0)
    divider.BackgroundColor3 = theme.DividerColor
    divider.BorderSizePixel = 0
    divider.Parent = self.HeaderFrame
end

--[[
    Create the content area with sidebar and main panel
]]
function Window:CreateContentArea(theme)
    self.ContentFrame = Instance.new("Frame")
    self.ContentFrame.Name = "Content"
    self.ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    self.ContentFrame.Position = UDim2.new(0, 0, 0, 40)
    self.ContentFrame.BackgroundTransparency = 1
    self.ContentFrame.Parent = self.MainFrame
    
    -- Sidebar
    self:CreateSidebar(theme)
    
    -- Main panel
    self:CreateMainPanel(theme)
end

--[[
    Create the sidebar with tab buttons
]]
function Window:CreateSidebar(theme)
    self.SidebarFrame = Instance.new("Frame")
    self.SidebarFrame.Name = "Sidebar"
    self.SidebarFrame.Size = UDim2.new(0, 140, 1, 0)
    self.SidebarFrame.BackgroundColor3 = theme.SidebarBackground
    self.SidebarFrame.BorderSizePixel = 0
    self.SidebarFrame.Parent = self.ContentFrame
    
    -- Sidebar list
    self.TabListFrame = Instance.new("Frame")
    self.TabListFrame.Name = "TabList"
    self.TabListFrame.Size = UDim2.new(1, 0, 1, 0)
    self.TabListFrame.BackgroundTransparency = 1
    self.TabListFrame.Parent = self.SidebarFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 4)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = self.TabListFrame
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.Parent = self.TabListFrame
end

--[[
    Create the main content panel
]]
function Window:CreateMainPanel(theme)
    self.PanelFrame = Instance.new("Frame")
    self.PanelFrame.Name = "Panel"
    self.PanelFrame.Size = UDim2.new(1, -140, 1, 0)
    self.PanelFrame.Position = UDim2.new(0, 140, 0, 0)
    self.PanelFrame.BackgroundColor3 = theme.PanelBackground
    self.PanelFrame.BorderSizePixel = 0
    self.PanelFrame.Parent = self.ContentFrame
    
    -- Scrollable content area
    self.ScrollFrame = Instance.new("ScrollingFrame")
    self.ScrollFrame.Name = "ScrollFrame"
    self.ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    self.ScrollFrame.BackgroundTransparency = 1
    self.ScrollFrame.BorderSizePixel = 0
    self.ScrollFrame.ScrollBarThickness = 8
    self.ScrollFrame.ScrollBarImageColor3 = theme.ScrollBarColor
    self.ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.ScrollFrame.Parent = self.PanelFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 0)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = self.ScrollFrame
    
    self.ScrollFrame:FindFirstChild("UIListLayout").Changed:Connect(function()
        self.ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, self.ScrollFrame:FindFirstChild("UIListLayout").AbsoluteContentSize.Y)
    end)
end

--[[
    Create a new tab
    @param tabName string - Name of the tab
    @return Tab object
]]
function Window:CreateTab(tabName)
    local tab = Tab.new(tabName, self)
    
    self.Tabs[tabName] = tab
    table.insert(self.TabOrder, tabName)
    
    -- Create tab button in sidebar
    self:CreateTabButton(tabName, tab)
    
    -- If this is the first tab, select it
    if #self.TabOrder == 1 then
        self:SelectTab(tabName)
    end
    
    return tab
end

--[[
    Create a tab button in the sidebar
]]
function Window:CreateTabButton(tabName, tab)
    local theme = ThemeManager:GetCurrentTheme()
    
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName .. "_TabButton"
    tabButton.Size = UDim2.new(1, 0, 0, 36)
    tabButton.BackgroundColor3 = theme.TabButtonBackground
    tabButton.TextColor3 = theme.TextColor
    tabButton.TextSize = 13
    tabButton.Font = Enum.Font.Gotham
    tabButton.Text = tabName
    tabButton.Parent = self.TabListFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = tabButton
    
    tab.TabButton = tabButton
    
    tabButton.MouseButton1Click:Connect(function()
        self:SelectTab(tabName)
    end)
end

--[[
    Select a tab
    @param tabName string - Name of the tab to select
]]
function Window:SelectTab(tabName)
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Deselect current tab
    if self.CurrentTab then
        local oldTab = self.Tabs[self.CurrentTab]
        if oldTab and oldTab.TabButton then
            oldTab.TabButton.BackgroundColor3 = theme.TabButtonBackground
            oldTab.TabButton.TextColor3 = theme.TextColor
        end
        if oldTab and oldTab.TabFrame then
            oldTab.TabFrame.Visible = false
        end
    end
    
    -- Select new tab
    self.CurrentTab = tabName
    local newTab = self.Tabs[tabName]
    
    if newTab then
        if newTab.TabButton then
            newTab.TabButton.BackgroundColor3 = theme.TabButtonActive
            newTab.TabButton.TextColor3 = theme.TextColor
        end
        if newTab.TabFrame then
            newTab.TabFrame.Visible = true
        end
    end
end

--[[
    Make the window draggable
]]
function Window:MakeDraggable(handle)
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    handle.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = self.MainFrame.Position
        end
    end)
    
    handle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and dragStart then
            local delta = input.Position - dragStart
            self.MainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
        end
    end)
end

--[[
    Close the window
]]
function Window:Close()
    Animator:Fadeout(self.MainFrame, 0.3, function()
        self.ScreenGui:Destroy()
    end)
    self.IsOpen = false
end

--[[
    Show the window
]]
function Window:Show()
    self.ScreenGui.Enabled = true
    self.IsOpen = true
    Animator:Fadein(self.MainFrame, 0.3)
end

--[[
    Destroy the window and all connections
]]
function Window:Destroy()
    for _, connection in pairs(self.Connections) do
        connection:Disconnect()
    end
    self.ScreenGui:Destroy()
end

return Window
