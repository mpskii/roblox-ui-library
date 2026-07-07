--[[
    Input.lua - Input Handling
    Handles user input for UI components
]]

local Input = {}

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--[[
    Check if a key is pressed
    @param keyCode Enum.KeyCode - Key to check
    @return boolean - Whether key is pressed
]]
function Input:IsKeyPressed(keyCode)
    return UserInputService:IsKeyDown(keyCode)
end

--[[
    Check if mouse button is pressed
    @param mouseButton Enum.UserInputType - Mouse button to check
    @return boolean - Whether button is pressed
]]
function Input:IsMouseButtonPressed(mouseButton)
    return UserInputService:IsMouseButtonDown(mouseButton)
end

--[[
    Get mouse position
    @return Vector2 - Mouse position
]]
function Input:GetMousePosition()
    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
    return Vector2.new(mouse.X, mouse.Y)
end

--[[
    Connect to key press event
    @param keyCode Enum.KeyCode - Key to listen for
    @param callback function - Callback function
    @return RBXScriptConnection - Connection handle
]]
function Input:OnKeyPress(keyCode, callback)
    return UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == keyCode then
            callback()
        end
    end)
end

--[[
    Connect to key release event
    @param keyCode Enum.KeyCode - Key to listen for
    @param callback function - Callback function
    @return RBXScriptConnection - Connection handle
]]
function Input:OnKeyRelease(keyCode, callback)
    return UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == keyCode then
            callback()
        end
    end)
end

--[[
    Connect to mouse button press event
    @param mouseButton Enum.UserInputType - Mouse button to listen for
    @param callback function - Callback function
    @return RBXScriptConnection - Connection handle
]]
function Input:OnMouseButtonPress(mouseButton, callback)
    return UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == mouseButton then
            callback()
        end
    end)
end

--[[
    Connect to mouse movement event
    @param callback function - Callback function receives mouse position
    @return RBXScriptConnection - Connection handle
]]
function Input:OnMouseMove(callback)
    return RunService.RenderStepped:Connect(function()
        local mouse = game:GetService("Players").LocalPlayer:GetMouse()
        callback(Vector2.new(mouse.X, mouse.Y))
    end)
end

return Input
