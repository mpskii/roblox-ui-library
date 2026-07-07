--[[
    Notification.lua - Notification Component
    Displays temporary notifications to the user
]]

local Notification = {}
Notification.__index = Notification

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)
local Animator = require(script.Parent.Parent.Animation.Animator)

--[[
    Create a new Notification instance
]]
function Notification.new(config)
    local self = setmetatable({}, Notification)
    
    self.Config = config or {}
    self.Title = self.Config.Title or "Notification"
    self.Message = self.Config.Message or ""
    self.Duration = self.Config.Duration or 3
    self.Type = self.Config.Type or "Info" -- Info, Success, Warning, Error
    
    self:CreateUI()
    self:Show()
    
    return self
end

--[[
    Create the notification UI
]]
function Notification:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Notification container
    self.NotificationFrame = Instance.new("Frame")
    self.NotificationFrame.Name = "Notification"
    self.NotificationFrame.Size = UDim2.new(0, 300, 0, 80)
    self.NotificationFrame.Position = UDim2.new(1, -320, 0, 20)
    self.NotificationFrame.BackgroundColor3 = theme.ButtonBackground
    self.NotificationFrame.BorderSizePixel = 0
    self.NotificationFrame.Parent = game:GetService("CoreGui"):FindFirstChild("UILibrary_Window") or game:GetService("CoreGui")
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.NotificationFrame
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -20, 0, 24)
    titleLabel.Position = UDim2.new(0, 10, 0, 8)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = theme.TextColor
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = self.Title
    titleLabel.Parent = self.NotificationFrame
    
    -- Message
    local messageLabel = Instance.new("TextLabel")
    messageLabel.Name = "Message"
    messageLabel.Size = UDim2.new(1, -20, 0, 40)
    messageLabel.Position = UDim2.new(0, 10, 0, 32)
    messageLabel.BackgroundTransparency = 1
    messageLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    messageLabel.TextSize = 12
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextWrapped = true
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Text = self.Message
    messageLabel.Parent = self.NotificationFrame
end

--[[
    Show the notification
]]
function Notification:Show()
    Animator:Fadein(self.NotificationFrame, 0.3)
    
    task.wait(self.Duration)
    
    Animator:Fadeout(self.NotificationFrame, 0.3, function()
        self.NotificationFrame:Destroy()
    end)
end

return Notification
