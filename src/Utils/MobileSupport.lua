--[[
    MobileSupport.lua - Mobile and Tablet Support
    Handles responsive design and touch input for mobile devices
]]

local MobileSupport = {}

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--[[
    Check if running on mobile device
    @return boolean - Whether on mobile
]]
function MobileSupport:IsMobile()
    return UserInputService:GetLastInputType() == Enum.UserInputType.Touch
end

--[[
    Check if running on tablet
    @return boolean - Whether on tablet
]]
function MobileSupport:IsTablet()
    -- Tablets typically have larger screens
    local screenSize = game:GetService("GuiService"):GetScreenSize()
    return screenSize.X > 1000 or screenSize.Y > 1000
end

--[[
    Get touch-friendly size
    @param minWidth number - Minimum width in pixels
    @param minHeight number - Minimum height in pixels
    @return UDim2 - Touch-friendly size
]]
function MobileSupport:GetTouchFriendlySize(minWidth, minHeight)
    minWidth = minWidth or 40
    minHeight = minHeight or 40
    
    if self:IsMobile() then
        -- Increase sizes for touch on mobile
        minWidth = math.max(minWidth, 44)
        minHeight = math.max(minHeight, 44)
    end
    
    return UDim2.new(0, minWidth, 0, minHeight)
end

--[[
    Add touch support to button
    @param button Instance - Button to add touch support to
    @param callback function - Callback on touch
]]
function MobileSupport:AddTouchSupport(button, callback)
    if not self:IsMobile() then return end
    
    button.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.Touch then
            if callback then
                callback()
            end
        end
    end)
end

--[[
    Get responsive window size for device
    @param baseWidth number - Base width
    @param baseHeight number - Base height
    @return UDim2 - Responsive size
]]
function MobileSupport:GetResponsiveSize(baseWidth, baseHeight)
    local screenSize = game:GetService("GuiService"):GetScreenSize()
    
    if self:IsMobile() then
        -- Use 90% of screen width on mobile
        return UDim2.new(0.9, 0, 0.9, 0)
    elseif self:IsTablet() then
        -- Use 80% of screen width on tablet
        return UDim2.new(0.8, 0, 0.8, 0)
    else
        -- Use fixed size on desktop
        return UDim2.new(0, baseWidth, 0, baseHeight)
    end
end

--[[
    Adjust UI for mobile screen
    @param ui Instance - UI element to adjust
]]
function MobileSupport:AdaptUIForMobile(ui)
    if not self:IsMobile() then return end
    
    -- Center on screen
    ui.Position = UDim2.new(0.05, 0, 0.05, 0)
    
    -- Add padding
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 5)
    padding.PaddingRight = UDim.new(0, 5)
    padding.PaddingTop = UDim.new(0, 5)
    padding.PaddingBottom = UDim.new(0, 5)
    padding.Parent = ui
end

--[[
    Scale element for screen size
    @param element Instance - Element to scale
    @param scaleFactor number - Scale factor (0-1)
]]
function MobileSupport:ScaleForScreen(element, scaleFactor)
    scaleFactor = scaleFactor or 1
    
    if element:FindFirstChild("UIScale") then
        element:FindFirstChild("UIScale"):Destroy()
    end
    
    local scale = Instance.new("UIScale")
    scale.Scale = scaleFactor
    scale.Parent = element
end

return MobileSupport
