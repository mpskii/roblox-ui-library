# Roblox UI Library

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Status](https://img.shields.io/badge/status-stable-brightgreen)

A lightweight, reusable, and fully customizable UI framework for Roblox. Build professional-looking user interfaces without any game-specific features or bloat.

## ✨ Features

- 🎨 **Clean, Modern Design** - Dark theme with professional styling
- 👨‍💻 **Developer-Friendly API** - Simple, intuitive interface for rapid development
- 🧩 **Fully Modular** - Organized into separate, independent modules
- 📱 **Cross-Platform** - Works seamlessly on PC, Mobile, and Tablet
- 🎭 **Customizable Components** - 13+ UI components with full customization
- 🌈 **Theme System** - Built-in theme management with easy custom themes
- ⚡ **High Performance** - Optimized rendering and event handling
- 📦 **Lightweight** - Minimal dependencies, fast loading
- 🔧 **Configuration Management** - Save and load user settings
- ✍️ **Well Documented** - Comprehensive guides and API docs

## 🚀 Quick Start

### Installation

1. Download the `src` folder
2. Place it in your Roblox script
3. Require the UILibrary module

```lua
local UILibrary = require(script.src.UILibrary)
```

### Basic Example

```lua
local UILibrary = require(script.src.UILibrary)

-- Create a window
local UI = UILibrary:CreateWindow({
    Title = "My App",
    Size = UDim2.new(0, 500, 0, 600)
})

-- Create a tab
local HomeTab = UI:CreateTab("Home")

-- Add components
local section = HomeTab:CreateSection("Welcome")

section:CreateLabel({
    Text = "Welcome to my app!"
})

section:CreateButton({
    Name = "Click Me",
    Callback = function()
        print("Button clicked!")
    end
})
```

## 📚 Documentation

- **[Getting Started Guide](GUIDE.md)** - Learn the basics
- **[API Documentation](API.md)** - Complete API reference
- **[Troubleshooting Guide](TROUBLESHOOTING.md)** - Solutions to common issues
- **[Changelog](CHANGELOG.md)** - Version history and updates
- **[Example Script](example.lua)** - Full working example

## 🎨 Components

### Core
- **Window** - Main container with dragging and resizing
- **Tab** - Organize content into tabs
- **Section** - Group related components

### Input Components
- **Button** - Clickable action button
- **Toggle** - On/off switch
- **Slider** - Numeric value selection
- **Dropdown** - Select from options
- **TextBox** - Text input field
- **Keybind** - Key binding selector
- **ColorPicker** - Color selection
- **SearchBox** - Search functionality

### Display Components
- **Label** - Text display
- **Divider** - Visual separator
- **ProgressBar** - Progress indication
- **Notification** - Temporary messages
- **TabGroup** - Advanced tab management

## 🎨 Theming

```lua
local ThemeManager = require(script.src.Themes.ThemeManager)

-- Create custom theme
local customTheme = {
    BackgroundColor = Color3.fromRGB(20, 20, 20),
    TextColor = Color3.fromRGB(255, 255, 255),
    ButtonBackground = Color3.fromRGB(35, 35, 35),
    -- ... more colors
}

-- Register and use
ThemeManager:RegisterTheme("Custom", customTheme)
ThemeManager:SetTheme("Custom")
```

## 📱 Mobile Support

```lua
local MobileSupport = require(script.src.Utils.MobileSupport)

-- Check device type
if MobileSupport:IsMobile() then
    print("Running on mobile")
end

-- Get responsive size
local size = MobileSupport:GetResponsiveSize(500, 600)
```

## ⚡ Performance

```lua
local Performance = require(script.src.Utils.Performance)

-- Debounce function
local debounced = Performance:Debounce(function()
    print("Debounced!")
end, 0.5)

-- Throttle function
local throttled = Performance:Throttle(function()
    print("Throttled!")
end, 1)
```

## 💾 Configuration

```lua
local ConfigManager = require(script.src.Config.ConfigManager)

-- Save setting
ConfigManager:Save("user_theme", "Dark")

-- Load setting
local theme = ConfigManager:Load("user_theme", "Dark")
```

## 🏗️ Architecture

```
src/
├── UILibrary.lua              # Entry point
├── Core/
│   ├── Window.lua
│   ├── Tab.lua
│   └── Section.lua
├── Components/                # 13+ UI components
├── Themes/                    # Theme system
├── Animation/                 # Smooth animations
├── Config/                    # Settings management
└── Utils/                     # Utilities & helpers
```

## 🏫 Learning Path

1. Read [GUIDE.md](GUIDE.md) for basics
2. Review [example.lua](example.lua)
3. Check [API.md](API.md) for detailed reference
4. Use [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for issues

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 📋 Requirements

- Roblox Studio
- Lua 5.1+
- Access to CoreGui (for most features)

## ✅ What's Included

- ✅ 13+ reusable components
- ✅ Complete theme system
- ✅ Animation utilities
- ✅ Configuration management
- ✅ Mobile/tablet support
- ✅ Performance optimization
- ✅ Input handling
- ✅ Utility functions
- ✅ Comprehensive documentation
- ✅ Working examples

## ❌ What's NOT Included

- ❌ Game-specific features
- ❌ Exploit functionality
- ❌ Pre-made scripts
- ❌ Command systems
- ❌ External dependencies

## 👨‍💼 Best Practices

1. **Organize with Sections** - Group related components
2. **Use Callbacks** - React to user input
3. **Store References** - Modify components later
4. **Save Settings** - Use ConfigManager
5. **Custom Themes** - Match your branding

## 📞 Support

- Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- Review [API.md](API.md)
- Open an issue with details

## 📄 License

MIT License - See [LICENSE](LICENSE) for details

## 🙏 Credits

Inspired by modern Roblox UI frameworks like WindUI.

---

**Made with ❤️ for Roblox developers**

---

## 📊 Repository Stats

- **Components**: 13+
- **Utilities**: 5+
- **Themes**: 1 (easily extensible)
- **Code Files**: 20+
- **Documentation Pages**: 5
- **Total Lines of Code**: 2000+

## 🚀 Getting Started

1. [Download](https://github.com/mpskii/roblox-ui-library) or clone the repository
2. Copy the `src` folder to your project
3. Require `UILibrary` in your script
4. Follow [GUIDE.md](GUIDE.md)
5. Build amazing UIs!

---

**Version**: 1.0.0
**Last Updated**: 2026-07-07
**License**: MIT
