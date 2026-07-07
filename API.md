# API Documentation

## UILibrary

The main entry point for the UI framework.

### Methods

#### `CreateWindow(config)`
Creates a new UI window.

**Parameters:**
- `config` (table) - Configuration options
  - `Title` (string): Window title
  - `Size` (UDim2): Window size
  - `Position` (UDim2): Window position (optional)
  - `Resizable` (boolean): Allow resizing (default: true)
  - `CanClose` (boolean): Show close button (default: true)
  - `Theme` (string): Theme name (default: "Dark")

**Returns:** Window object

**Example:**
```lua
local UI = UILibrary:CreateWindow({
    Title = "My UI",
    Size = UDim2.new(0, 500, 0, 600)
})
```

---

## Window

Represents a main UI window.

### Methods

#### `CreateTab(tabName)`
Creates a new tab in the window.

**Parameters:**
- `tabName` (string): Name of the tab

**Returns:** Tab object

#### `SelectTab(tabName)`
Selects a tab to display.

**Parameters:**
- `tabName` (string): Name of the tab

#### `Close()`
Closes the window with fade animation.

#### `Show()`
Shows the window with fade animation.

#### `Destroy()`
Completely destroys the window and all connections.

---

## Tab

Represents a tab within a window.

### Methods

#### `CreateSection(sectionName)`
Creates a new section in the tab.

**Parameters:**
- `sectionName` (string): Name of the section

**Returns:** Section object

#### Component Creation Methods

All of these create components directly in a default section:

- `CreateButton(config)`
- `CreateToggle(config)`
- `CreateSlider(config)`
- `CreateDropdown(config)`
- `CreateTextBox(config)`
- `CreateLabel(config)`

---

## Section

Represents a section that groups components.

### Methods

#### `CreateButton(config)`
Creates a clickable button.

**Parameters:**
- `config` (table)
  - `Name` (string): Button text
  - `Callback` (function): Function to call on click
  - `Enabled` (boolean): Button enabled state (default: true)

**Returns:** Button object

**Example:**
```lua
local button = section:CreateButton({
    Name = "Click Me",
    Callback = function()
        print("Button clicked!")
    end
})
```

#### `CreateToggle(config)`
Creates a toggle switch.

**Parameters:**
- `config` (table)
  - `Name` (string): Toggle label
  - `Default` (boolean): Initial state (default: false)
  - `Callback` (function): Function called on change
  - `Enabled` (boolean): Toggle enabled state (default: true)

**Returns:** Toggle object

**Example:**
```lua
local toggle = section:CreateToggle({
    Name = "Enable Feature",
    Default = false,
    Callback = function(value)
        print("Toggle:", value)
    end
})

local currentValue = toggle:GetValue()
toggle:SetValue(true)
```

#### `CreateSlider(config)`
Creates a value slider.

**Parameters:**
- `config` (table)
  - `Name` (string): Slider label
  - `Min` (number): Minimum value
  - `Max` (number): Maximum value
  - `Default` (number): Initial value
  - `Increment` (number): Step size (default: 1)
  - `Callback` (function): Function called on change
  - `Enabled` (boolean): Slider enabled state (default: true)

**Returns:** Slider object

**Example:**
```lua
local slider = section:CreateSlider({
    Name = "Volume",
    Min = 0,
    Max = 100,
    Default = 50,
    Increment = 5,
    Callback = function(value)
        print("Volume:", value)
    end
})

local volume = slider:GetValue()
slider:SetValue(75)
```

#### `CreateDropdown(config)`
Creates a dropdown menu.

**Parameters:**
- `config` (table)
  - `Name` (string): Dropdown label
  - `Options` (table): List of options
  - `Default` (string): Initial selection
  - `Callback` (function): Function called on selection
  - `Enabled` (boolean): Dropdown enabled state (default: true)

**Returns:** Dropdown object

**Example:**
```lua
local dropdown = section:CreateDropdown({
    Name = "Choose Option",
    Options = {"Option 1", "Option 2", "Option 3"},
    Default = "Option 1",
    Callback = function(selected)
        print("Selected:", selected)
    end
})

local selected = dropdown:GetSelected()
dropdown:SetSelected("Option 2")
```

#### `CreateTextBox(config)`
Creates a text input field.

**Parameters:**
- `config` (table)
  - `Name` (string): Label
  - `Placeholder` (string): Placeholder text
  - `Default` (string): Initial value
  - `Callback` (function): Function called on change
  - `Enabled` (boolean): TextBox enabled state (default: true)

**Returns:** TextBox object

**Example:**
```lua
local textbox = section:CreateTextBox({
    Name = "Username",
    Placeholder = "Enter your username",
    Default = "",
    Callback = function(value)
        print("Text:", value)
    end
})

local text = textbox:GetValue()
textbox:SetValue("NewName")
```

#### `CreateLabel(config)`
Creates a text label.

**Parameters:**
- `config` (table)
  - `Text` (string): Label text
  - `Size` (UDim): Custom size (optional)

**Returns:** Label object

**Example:**
```lua
local label = section:CreateLabel({
    Text = "This is a label"
})

label:SetText("Updated text")
local text = label:GetText()
```

#### `CreateDivider(config)`
Creates a visual divider line.

**Parameters:**
- `config` (table, optional): Configuration (usually empty)

**Returns:** Divider object

**Example:**
```lua
section:CreateDivider()
```

---

## Theming

### ThemeManager

#### `SetTheme(themeName)`
Changes the active theme.

**Parameters:**
- `themeName` (string): Theme name

#### `GetCurrentTheme()`
Gets the current theme configuration.

**Returns:** Table with color values

#### `RegisterTheme(name, theme)`
Registers a custom theme.

**Parameters:**
- `name` (string): Theme name
- `theme` (table): Theme configuration with colors

**Example:**
```lua
local ThemeManager = require(script.Parent.Themes.ThemeManager)

local customTheme = {
    BackgroundColor = Color3.fromRGB(20, 20, 20),
    TextColor = Color3.fromRGB(255, 255, 255),
    -- ... other colors
}

ThemeManager:RegisterTheme("Custom", customTheme)
ThemeManager:SetTheme("Custom")
```

---

## Configuration

### ConfigManager

#### `Save(key, value)`
Saves a configuration value.

**Parameters:**
- `key` (string): Configuration key
- `value` (any): Value to save

#### `Load(key, defaultValue)`
Loads a configuration value.

**Parameters:**
- `key` (string): Configuration key
- `defaultValue` (any): Default value if not found

**Returns:** Loaded value or default

**Example:**
```lua
local ConfigManager = require(script.Parent.Config.ConfigManager)

-- Save a setting
ConfigManager:Save("user_volume", 75)

-- Load a setting
local volume = ConfigManager:Load("user_volume", 50)
```

---

## Utilities

### Utility

#### `Clamp(value, min, max)`
Clamps a value between min and max.

#### `Lerp(a, b, t)`
Linear interpolation between two values.

#### `PointInBounds(point, min, max)`
Checks if a point is within bounds.

#### `DeepCopy(tbl)`
Creates a deep copy of a table.

#### `MergeTables(base, override)`
Merges two tables.

#### `Debounce(func, delay)`
Debounces a function.

#### `FormatNumber(num)`
Formats a number with commas.

### Input

#### `IsKeyPressed(keyCode)`
Checks if a key is currently pressed.

#### `IsMouseButtonPressed(mouseButton)`
Checks if a mouse button is pressed.

#### `GetMousePosition()`
Gets the current mouse position.

**Returns:** Vector2

#### `OnKeyPress(keyCode, callback)`
Connects to a key press event.

#### `OnKeyRelease(keyCode, callback)`
Connects to a key release event.

#### `OnMouseButtonPress(mouseButton, callback)`
Connects to a mouse button press event.

#### `OnMouseMove(callback)`
Connects to mouse movement.

**Example:**
```lua
local Input = require(script.Parent.Utils.Input)

Input:OnKeyPress(Enum.KeyCode.E, function()
    print("E key pressed!")
end)
```

---

## Complete Example

```lua
local UILibrary = require(script.UILibrary)

-- Create window
local UI = UILibrary:CreateWindow({
    Title = "My Application",
    Size = UDim2.new(0, 600, 0, 700),
    Theme = "Dark"
})

-- Home tab
local HomeTab = UI:CreateTab("Home")
local homeSection = HomeTab:CreateSection("Welcome")
homeSection:CreateLabel({ Text = "Welcome to my app!" })
homeSection:CreateButton({
    Name = "Start",
    Callback = function()
        print("Starting...")
    end
})

-- Settings tab
local SettingsTab = UI:CreateTab("Settings")
local settingsSection = SettingsTab:CreateSection("Preferences")

settingsSection:CreateToggle({
    Name = "Enable Audio",
    Default = true,
    Callback = function(value)
        print("Audio:", value)
    end
})

settingsSection:CreateSlider({
    Name = "Brightness",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Brightness:", value)
    end
})

settingsSection:CreateDropdown({
    Name = "Quality",
    Options = {"Low", "Medium", "High"},
    Default = "High",
    Callback = function(selected)
        print("Quality:", selected)
    end
})
```

---

## Best Practices

1. **Always store references** to components you need to modify later:
   ```lua
   local myButton = section:CreateButton({...})
   myButton:SetEnabled(false)
   ```

2. **Use callbacks** for reactive UI:
   ```lua
   toggle:CreateToggle({
       Callback = function(value)
           -- Handle value change
       end
   })
   ```

3. **Organize with sections** for better UI structure:
   ```lua
   local generalSection = tab:CreateSection("General")
   local advancedSection = tab:CreateSection("Advanced")
   ```

4. **Save important settings** using ConfigManager:
   ```lua
   ConfigManager:Save("last_selected", value)
   ```

5. **Create custom themes** for consistent branding:
   ```lua
   ThemeManager:RegisterTheme("MyBrand", customThemeConfig)
   ```
