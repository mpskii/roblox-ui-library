# Roblox UI Library

A lightweight, reusable Roblox UI framework inspired by modern Roblox UI libraries like WindUI.

## Features

- **Clean, Modern Design**: Dark theme with professional styling
- **Fully Customizable**: Blank template for developers to build upon
- **Modular Architecture**: Organized into separate modules
- **Developer-Friendly API**: Simple, intuitive interface
- **Cross-Platform Support**: PC, Mobile, and Tablet compatible
- **Rich Component System**: Buttons, toggles, sliders, and more
- **Configuration System**: Built-in settings saving and loading
- **Smooth Animations**: Professional UI transitions

## Quick Start

```lua
local UILibrary = require(script.src.UILibrary)

local UI = UILibrary:CreateWindow({
    Title = "My UI",
    Size = UDim2.new(0, 500, 0, 600)
})

local Tab = UI:CreateTab("Home")

Tab:CreateButton({
    Name = "Example Button",
    Callback = function()
        print("Button clicked!")
    end
})
```

## Structure

```
├── src/
│   ├── UILibrary.lua          # Main entry point
│   ├── Core/
│   │   ├── Window.lua         # Window management
│   │   ├── Tab.lua            # Tab system
│   │   └── Section.lua        # Section grouping
│   ├── Components/
│   │   ├── Button.lua
│   │   ├── Toggle.lua
│   │   ├── Slider.lua
│   │   ├── Dropdown.lua
│   │   ├── TextBox.lua
│   │   ├── Label.lua
│   │   ├── Keybind.lua
│   │   ├── Notification.lua
│   │   └── Divider.lua
│   ├── Themes/
│   │   ├── Dark.lua           # Default dark theme
│   │   └── ThemeManager.lua   # Theme management
│   ├── Animation/
│   │   └── Animator.lua       # Animation utilities
│   ├── Config/
│   │   └── ConfigManager.lua  # Save/load settings
│   └── Utils/
│       ├── Utility.lua        # Helper functions
│       └── Input.lua          # Input handling
└── example.lua                 # Example usage
```

## Documentation

See individual module files for detailed API documentation.

## License

MIT
