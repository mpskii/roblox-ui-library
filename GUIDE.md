# Getting Started

## Installation

1. Copy the entire `src` folder to your Roblox script
2. Require the main UILibrary module
3. Start creating your UI!

## Basic Usage

### Step 1: Create a Window

```lua
local UILibrary = require(script.src.UILibrary)

local UI = UILibrary:CreateWindow({
    Title = "My Application",
    Size = UDim2.new(0, 500, 0, 600)
})
```

### Step 2: Create Tabs

```lua
local HomeTab = UI:CreateTab("Home")
local SettingsTab = UI:CreateTab("Settings")
local AboutTab = UI:CreateTab("About")
```

### Step 3: Add Components to Tabs

```lua
local section = HomeTab:CreateSection("Welcome")

section:CreateLabel({
    Text = "Welcome to the app!"
})

section:CreateButton({
    Name = "Get Started",
    Callback = function()
        print("Button clicked!")
    end
})
```

### Step 4: Add More Components

```lua
local settingsSection = SettingsTab:CreateSection("Settings")

-- Toggle
settingsSection:CreateToggle({
    Name = "Enable Notifications",
    Default = true,
    Callback = function(value)
        print("Notifications:", value)
    end
})

-- Slider
settingsSection:CreateSlider({
    Name = "Volume",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Volume:", value)
    end
})

-- Dropdown
settingsSection:CreateDropdown({
    Name = "Theme",
    Options = {"Dark", "Light"},
    Default = "Dark",
    Callback = function(selected)
        print("Theme:", selected)
    end
})

-- Text Input
settingsSection:CreateTextBox({
    Name = "Username",
    Placeholder = "Enter your name",
    Callback = function(value)
        print("Username:", value)
    end
})
```

## File Structure

```
src/
├── UILibrary.lua              # Main entry point
├── Core/
│   ├── Window.lua             # Window management
│   ├── Tab.lua                # Tab system
│   └── Section.lua            # Section grouping
├── Components/
│   ├── Button.lua
│   ├── Toggle.lua
│   ├── Slider.lua
│   ├── Dropdown.lua
│   ├── TextBox.lua
│   ├── Label.lua
│   ├── Divider.lua
│   ├── Notification.lua
│   └── Keybind.lua
├── Themes/
│   ├── Dark.lua               # Dark theme (default)
│   └── ThemeManager.lua       # Theme management
├── Animation/
│   └── Animator.lua           # Animation utilities
├── Config/
│   └── ConfigManager.lua      # Save/load settings
└── Utils/
    ├── Utility.lua            # Helper functions
    └── Input.lua              # Input handling
```

## Common Patterns

### Storing Component References

```lua
local myToggle = section:CreateToggle({
    Name = "My Toggle",
    Default = false
})

-- Later, change its value
myToggle:SetValue(true)
local currentValue = myToggle:GetValue()
```

### Creating Dynamic Content

```lua
local section = tab:CreateSection("Dynamic")

-- Create components based on data
local items = {"Item 1", "Item 2", "Item 3"}

for _, item in pairs(items) do
    section:CreateButton({
        Name = item,
        Callback = function()
            print("Clicked:", item)
        end
    })
end
```

### Handling Settings

```lua
local ConfigManager = require(script.src.Config.ConfigManager)

-- Save user preference
local toggle = section:CreateToggle({
    Name = "Remember Me",
    Default = ConfigManager:Load("remember_me", false),
    Callback = function(value)
        ConfigManager:Save("remember_me", value)
    end
})
```

### Custom Styling

```lua
local ThemeManager = require(script.src.Themes.ThemeManager)

-- Create custom theme
local myTheme = {
    BackgroundColor = Color3.fromRGB(15, 15, 15),
    TextColor = Color3.fromRGB(255, 255, 255),
    ButtonBackground = Color3.fromRGB(35, 35, 35),
    ButtonHover = Color3.fromRGB(45, 45, 45),
    AccentColor = Color3.fromRGB(0, 150, 255),
    -- ... other colors
}

ThemeManager:RegisterTheme("MyCustom", myTheme)
ThemeManager:SetTheme("MyCustom")
```

## Tips and Tricks

1. **Use Sections** to organize related settings
2. **Add Dividers** between logical groups
3. **Use Callbacks** to react to user input
4. **Store References** for components you'll modify
5. **Save Settings** with ConfigManager for persistence
6. **Create Custom Themes** for brand consistency

## Troubleshooting

### Components not appearing?
- Make sure the tab is selected
- Check that components are added to a section
- Verify the parent window is visible

### Callbacks not firing?
- Ensure the callback function is properly defined
- Check for errors in the console
- Verify the component is enabled

### UI not draggable?
- The window is draggable by the header
- Make sure you're clicking and dragging the header bar

### Colors not updating?
- Theme changes apply to new components
- Recreate components to see theme changes
- Use ConfigManager to save color preferences
