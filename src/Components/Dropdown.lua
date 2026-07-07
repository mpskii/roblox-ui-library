--[[
    Dropdown.lua - Dropdown Component
]]

local Dropdown = {}
Dropdown.__index = Dropdown

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)

--[[
    Create a new Dropdown instance
]]
function Dropdown.new(config, section)
    local self = setmetatable({}, Dropdown)
    
    self.Config = config or {}
    self.Section = section
    self.Enabled = self.Config.Enabled ~= false
    self.Options = self.Config.Options or {}
    self.Selected = self.Config.Default or (self.Options[1] or "None")
    self.IsOpen = false
    
    self:CreateUI()
    
    return self
end

--[[
    Create the dropdown UI
]]
function Dropdown:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Dropdown container
    self.DropdownFrame = Instance.new("Frame")
    self.DropdownFrame.Name = self.Config.Name or "Dropdown"
    self.DropdownFrame.Size = UDim2.new(1, 0, 0, 36)
    self.DropdownFrame.BackgroundTransparency = 1
    self.DropdownFrame.Parent = self.Section.SectionFrame
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = theme.TextColor
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Text = self.Config.Name or "Dropdown"
    label.Parent = self.DropdownFrame
    
    -- Dropdown button
    self.DropdownButton = Instance.new("TextButton")
    self.DropdownButton.Name = "Button"
    self.DropdownButton.Size = UDim2.new(0.6, -8, 1, 0)
    self.DropdownButton.Position = UDim2.new(0.4, 8, 0, 0)
    self.DropdownButton.BackgroundColor3 = theme.ButtonBackground
    self.DropdownButton.TextColor3 = theme.TextColor
    self.DropdownButton.TextSize = 12
    self.DropdownButton.Font = Enum.Font.Gotham
    self.DropdownButton.Text = self.Selected
    self.DropdownButton.Parent = self.DropdownFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = self.DropdownButton
    
    -- Dropdown list
    self.ListFrame = Instance.new("Frame")
    self.ListFrame.Name = "List"
    self.ListFrame.Size = UDim2.new(0.6, -8, 0, 0)
    self.ListFrame.Position = UDim2.new(0.4, 8, 1, 4)
    self.ListFrame.BackgroundColor3 = theme.ButtonBackground
    self.ListFrame.Visible = false
    self.ListFrame.Parent = self.DropdownFrame
    
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 6)
    listCorner.Parent = self.ListFrame
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 0)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = self.ListFrame
    
    self.ListLayout = listLayout
    
    -- Button click to toggle list
    self.DropdownButton.MouseButton1Click:Connect(function()
        self.IsOpen = not self.IsOpen
        self.ListFrame.Visible = self.IsOpen
        
        if self.IsOpen then
            local listHeight = #self.Options * 32
            self.ListFrame.Size = UDim2.new(0.6, -8, 0, listHeight)
        end
    end)
    
    -- Populate dropdown options
    self:RefreshOptions()
end

--[[
    Refresh dropdown options
]]
function Dropdown:RefreshOptions()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Clear old options
    for _, child in pairs(self.ListFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    -- Add new options
    for _, option in pairs(self.Options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = option
        optionButton.Size = UDim2.new(1, 0, 0, 32)
        optionButton.BackgroundColor3 = theme.ButtonBackground
        optionButton.TextColor3 = theme.TextColor
        optionButton.TextSize = 12
        optionButton.Font = Enum.Font.Gotham
        optionButton.Text = option
        optionButton.Parent = self.ListFrame
        
        optionButton.MouseButton1Click:Connect(function()
            self:SetSelected(option)
        end)
    end
end

--[[
    Set selected option
]]
function Dropdown:SetSelected(option)
    self.Selected = option
    self.DropdownButton.Text = option
    self.IsOpen = false
    self.ListFrame.Visible = false
    
    if self.Config.Callback then
        self.Config.Callback(option)
    end
end

--[[
    Get selected option
]]
function Dropdown:GetSelected()
    return self.Selected
end

return Dropdown
