--[[
    Keybind.lua - Keybind Component
    Allows users to bind keys to actions
]]

local Keybind = {}
Keybind.__index = Keybind

local ThemeManager = require(script.Parent.Parent.Themes.ThemeManager)
local Input = require(script.Parent.Parent.Utils.Input)

--[[
    Create a new Keybind instance
]]
function Keybind.new(config, section)
    local self = setmetatable({}, Keybind)
    
    self.Config = config or {}
    self.Section = section
    self.Enabled = self.Config.Enabled ~= false
    self.BoundKey = self.Config.Default or Enum.KeyCode.F1
    self.IsListening = false
    
    self:CreateUI()
    self:SetupKeybind()
    
    return self
end

--[[
    Create the keybind UI
]]
function Keybind:CreateUI()
    local theme = ThemeManager:GetCurrentTheme()
    
    -- Keybind container
    self.KeybindFrame = Instance.new("Frame")
    self.KeybindFrame.Name = self.Config.Name or "Keybind"
    self.KeybindFrame.Size = UDim2.new(1, 0, 0, 36)
    self.KeybindFrame.BackgroundTransparency = 1
    self.KeybindFrame.Parent = self.Section.SectionFrame
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = theme.TextColor
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.Text = self.Config.Name or "Keybind"
    label.Parent = self.KeybindFrame
    
    -- Keybind button
    self.KeybindButton = Instance.new("TextButton")
    self.KeybindButton.Name = "Button"
    self.KeybindButton.Size = UDim2.new(0.6, -8, 1, 0)
    self.KeybindButton.Position = UDim2.new(0.4, 8, 0, 0)
    self.KeybindButton.BackgroundColor3 = theme.ButtonBackground
    self.KeybindButton.TextColor3 = theme.TextColor
    self.KeybindButton.TextSize = 12
    self.KeybindButton.Font = Enum.Font.Gotham
    self.KeybindButton.Text = tostring(self.BoundKey):match("(.+)$")
    self.KeybindButton.Parent = self.KeybindFrame
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = self.KeybindButton
    
    self.KeybindButton.MouseButton1Click:Connect(function()
        self:StartListening()
    end)
end

--[[
    Start listening for key press
]]
function Keybind:StartListening()
    self.IsListening = true
    self.KeybindButton.Text = "Press a key..."
    
    local connection
    connection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if self.IsListening and input.UserInputType == Enum.UserInputType.Keyboard then
            self.BoundKey = input.KeyCode
            self.KeybindButton.Text = tostring(self.BoundKey):match("(.+)$")
            self.IsListening = false
            connection:Disconnect()
        end
    end)
end

--[[
    Setup the keybind action
]]
function Keybind:SetupKeybind()
    game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == self.BoundKey and self.Config.Callback then
            self.Config.Callback()
        end
    end)
end

--[[
    Get the bound key
]]
function Keybind:GetKey()
    return self.BoundKey
end

return Keybind
