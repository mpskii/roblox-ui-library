--[[
    Animator.lua - Animation Utilities
    Handles all UI animations and tweens
]]

local Animator = {}

local TweenService = game:GetService("TweenService")

--[[
    Tween a property
    @param object Instance - Object to tween
    @param property string - Property to tween
    @param endValue any - End value
    @param duration number - Duration in seconds
    @param callback function - Callback when complete (optional)
]]
function Animator:TweenProperty(object, property, endValue, duration, callback)
    local tweenInfo = TweenInfo.new(
        duration,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.InOut
    )
    
    local tween = TweenService:Create(object, tweenInfo, {[property] = endValue})
    
    if callback then
        tween.Completed:Connect(function()
            callback()
        end)
    end
    
    tween:Play()
    return tween
end

--[[
    Fade in an object
    @param object Instance - Object to fade in
    @param duration number - Duration in seconds
    @param callback function - Callback when complete (optional)
]]
function Animator:Fadein(object, duration, callback)
    return self:TweenProperty(object, "BackgroundTransparency", 0, duration, callback)
end

--[[
    Fade out an object
    @param object Instance - Object to fade out
    @param duration number - Duration in seconds
    @param callback function - Callback when complete (optional)
]]
function Animator:Fadeout(object, duration, callback)
    return self:TweenProperty(object, "BackgroundTransparency", 1, duration, callback)
end

--[[
    Scale an object
    @param object Instance - Object to scale
    @param startSize UDim2 - Start size
    @param endSize UDim2 - End size
    @param duration number - Duration in seconds
    @param callback function - Callback when complete (optional)
]]
function Animator:ScaleObject(object, startSize, endSize, duration, callback)
    object.Size = startSize
    return self:TweenProperty(object, "Size", endSize, duration, callback)
end

--[[
    Slide an object
    @param object Instance - Object to slide
    @param startPos UDim2 - Start position
    @param endPos UDim2 - End position
    @param duration number - Duration in seconds
    @param callback function - Callback when complete (optional)
]]
function Animator:SlideObject(object, startPos, endPos, duration, callback)
    object.Position = startPos
    return self:TweenProperty(object, "Position", endPos, duration, callback)
end

return Animator
