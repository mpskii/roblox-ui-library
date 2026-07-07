--[[
    ProgressBar.lua - ProgressBar Component
    Displays progress visually
]]

local ProgressBar = {}
ProgressBar.__index = ProgressBar

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)

--[[
    Create a new ProgressBar instance
]]
function ProgressBar.new(config, section)
    local self = setmetatable({}, ProgressBar)
    
    self.Config = config or {}
    self.Section = section
    self.Value = self.Config.Default or 0
    self.Max = self.Config.Max or 100
    
    self:CreateUI()
    
    return self
end

--[[
    Create the progress bar UI
]]
function ProgressBar:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Container
    self.ProgressFrame = Instance.new("Frame")
    self.ProgressFrame.Name = self.Config.Name or "ProgressBar"
    self.ProgressFrame.Size = UDim2.new(1, 0, 0, 50)
    self.ProgressFrame.BackgroundTransparency = 1
    self.ProgressFrame.Parent = self.Section.SectionFrame
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.TextColor3 = theme.TextColor
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Text = self.Config.Name or "Progress"
    label.Parent = self.ProgressFrame
    
    -- Progress background
    local progressBg = Instance.new("Frame")
    progressBg.Name = "Background"
    progressBg.Size = UDim2.new(1, 0, 0, 12)
    progressBg.Position = UDim2.new(0, 0, 1, -20)
    progressBg.BackgroundColor3 = theme.SliderBackground
    progressBg.BorderSizePixel = 0
    progressBg.Parent = self.ProgressFrame
    
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 6)
    bgCorner.Parent = progressBg
    
    -- Progress fill
    self.ProgressFill = Instance.new("Frame")
    self.ProgressFill.Name = "Fill"
    self.ProgressFill.Size = UDim2.new(self.Value / self.Max, 0, 1, 0)
    self.ProgressFill.BackgroundColor3 = theme.SliderFill
    self.ProgressFill.BorderSizePixel = 0
    self.ProgressFill.Parent = progressBg
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 6)
    fillCorner.Parent = self.ProgressFill
end

--[[
    Set progress value
]]
function ProgressBar:SetValue(value)
    self.Value = math.clamp(value, 0, self.Max)
    self.ProgressFill.Size = UDim2.new(self.Value / self.Max, 0, 1, 0)
end

--[[
    Get progress value
]]
function ProgressBar:GetValue()
    return self.Value
end

return ProgressBar
