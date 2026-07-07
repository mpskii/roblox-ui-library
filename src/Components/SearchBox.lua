--[[
    SearchBox.lua - SearchBox Component
    Allows users to search through content
]]

local SearchBox = {}
SearchBox.__index = SearchBox

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)

--[[
    Create a new SearchBox instance
]]
function SearchBox.new(config, section)
    local self = setmetatable({}, SearchBox)
    
    self.Config = config or {}
    self.Section = section
    self.Enabled = self.Config.Enabled ~= false
    self.Value = ""
    self.Results = {}
    
    self:CreateUI()
    
    return self
end

--[[
    Create the search box UI
]]
function SearchBox:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Container
    self.SearchFrame = Instance.new("Frame")
    self.SearchFrame.Name = self.Config.Name or "SearchBox"
    self.SearchFrame.Size = UDim2.new(1, 0, 0, 40)
    self.SearchFrame.BackgroundTransparency = 1
    self.SearchFrame.Parent = self.Section.SectionFrame
    
    -- Input
    self.Input = Instance.new("TextBox")
    self.Input.Name = "Input"
    self.Input.Size = UDim2.new(1, 0, 0, 32)
    self.Input.BackgroundColor3 = theme.InputBackground
    self.Input.TextColor3 = theme.TextColor
    self.Input.TextSize = 13
    self.Input.Font = Enum.Font.Gotham
    self.Input.PlaceholderText = self.Config.Placeholder or "Search..."
    self.Input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    self.Input.Parent = self.SearchFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = self.Input
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = self.Input
    
    -- Search on text change
    self.Input.Changed:Connect(function()
        self.Value = self.Input.Text
        
        if self.Config.OnSearch then
            self.Config.OnSearch(self.Value)
        end
    end)
end

--[[
    Get search value
]]
function SearchBox:GetValue()
    return self.Value
end

--[[
    Set search value
]]
function SearchBox:SetValue(value)
    self.Value = value
    self.Input.Text = value
end

return SearchBox
