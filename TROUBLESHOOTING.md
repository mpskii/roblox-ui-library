# Troubleshooting Guide

## Common Issues

### Window not appearing

**Problem:** The UI window doesn't show up on screen.

**Solutions:**
1. Check that the script is running (no errors in console)
2. Verify the window is being created:
   ```lua
   local UI = UILibrary:CreateWindow({...})
   print("Window created:", UI)
   ```
3. Ensure CoreGui is accessible in your script context
4. Check if another script is hiding the UI

---

### Components not responding

**Problem:** Buttons don't click, toggles don't toggle, etc.

**Solutions:**
1. Verify the component is enabled:
   ```lua
   component:SetEnabled(true)
   ```
2. Check that callbacks are properly defined
3. Look for errors in the callback function
4. Ensure the component parent is visible

---

### Callbacks not firing

**Problem:** Component callbacks are not executing.

**Solutions:**
1. Verify the callback is being passed:
   ```lua
   button:CreateButton({
       Name = "Test",
       Callback = function()
           print("Callback fired")
       end
   })
   ```
2. Check console for errors
3. Add debug prints in the callback
4. Ensure the component is enabled

---

### UI is too small/large

**Problem:** Window size doesn't look right.

**Solutions:**
1. Adjust the Size parameter:
   ```lua
   local UI = UILibrary:CreateWindow({
       Size = UDim2.new(0, 600, 0, 700) -- (offset, scale)
   })
   ```
2. Use UDim2.new(0, pixels, 0, pixels) for fixed sizes
3. Test on different screen sizes

---

### Text is cut off

**Problem:** Text in labels or buttons is truncated.

**Solutions:**
1. Increase component size
2. Use TextWrapped for long text
3. Reduce font size if appropriate
4. Add padding to the container

---

### Colors look wrong

**Problem:** Theme colors don't match expectations.

**Solutions:**
1. Verify theme is set correctly:
   ```lua
   local currentTheme = UILibrary:GetTheme()
   print(currentTheme)
   ```
2. Check RGB values (0-255)
3. Recreate components after theme change
4. Verify custom theme has all required colors

---

### Memory issues

**Problem:** Script is using too much memory or causing lag.

**Solutions:**
1. Clean up old windows:
   ```lua
   window:Destroy()
   ```
2. Disconnect unused events
3. Avoid creating too many components at once
4. Use ConfigManager to cache data
5. Clear unused connections

---

### Mobile/Tablet not working

**Problem:** UI doesn't respond properly on mobile devices.

**Solutions:**
1. Use touch-friendly button sizes (at least 40x40 pixels)
2. Test with GuiInset for proper positioning
3. Use InputBegan for touch input
4. Consider mobile-specific layouts
5. Test on actual devices if possible

---

### Dragging doesn't work

**Problem:** Window can't be dragged around.

**Solutions:**
1. Only drag from the header area
2. Verify mouse is not over another UI element
3. Check that the window is not locked
4. Ensure InputBegan event is firing

---

### Theme change doesn't apply

**Problem:** Changing theme doesn't update existing UI.

**Solutions:**
1. Theme changes only apply to new components
2. Recreate components after theme change:
   ```lua
   window:Destroy()
   -- Create new window with new theme
   ```
3. Or manually update component colors

---

### Script errors

**Problem:** Getting error messages in the console.

**Common Errors:**

**Error:** "attempt to index nil with 'Parent'"
- **Cause:** Component parent doesn't exist
- **Fix:** Ensure section exists before adding components

**Error:** "attempt to call a nil value"
- **Cause:** Function not found or module not loaded
- **Fix:** Check module paths in require statements

**Error:** "Cannot use non-integers as indices"
- **Cause:** Trying to use string as table index incorrectly
- **Fix:** Use proper table indexing: `table["key"]` or `table.key`

---

## Debug Tips

### Enable verbose logging

```lua
local UILibrary = require(script.src.UILibrary)

-- Add debug prints
local UI = UILibrary:CreateWindow({...})
print("Window:", UI)
print("MainFrame:", UI.MainFrame)
print("Tabs:", UI.Tabs)
```

### Test components individually

```lua
local section = tab:CreateSection("Test")
local button = section:CreateButton({
    Name = "Test Button",
    Callback = function()
        print("Button works!")
    end
})
print("Button created:", button)
```

### Check connections

```lua
local toggle = section:CreateToggle({
    Name = "Test Toggle",
    Default = false,
    Callback = function(value)
        print("Toggle value changed to:", value)
    end
})
```

### Verify configuration

```lua
local ConfigManager = require(script.src.Config.ConfigManager)
ConfigManager:Save("test_key", "test_value")
local value = ConfigManager:Load("test_key", "default")
print("Saved value:", value)
```

---

## Still having issues?

1. Check the API documentation: `API.md`
2. Review the getting started guide: `GUIDE.md`
3. Look at the example script: `example.lua`
4. Check the changelog for known issues: `CHANGELOG.md`
5. Open an issue on GitHub with:
   - Description of the problem
   - Steps to reproduce
   - Error messages
   - Example code
   - Your Roblox Studio version
