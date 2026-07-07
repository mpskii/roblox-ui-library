# Contributing

Contributions are welcome! Here's how you can help improve the Roblox UI Library.

## Getting Started

1. Fork the repository
2. Create a new branch for your feature (`git checkout -b feature/AmazingFeature`)
3. Make your changes
4. Test thoroughly
5. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
6. Push to the branch (`git push origin feature/AmazingFeature`)
7. Open a Pull Request

## Development Guidelines

### Code Style

- Use Lua style conventions
- Add comments for complex logic
- Keep functions focused and single-purpose
- Use meaningful variable names
- Add type hints in comments

### Adding New Components

1. Create a new file in `src/Components/`
2. Follow the existing component structure
3. Include:
   - `new()` constructor
   - `CreateUI()` method
   - Public methods for interaction
   - Callback support
   - Theme integration
4. Add documentation
5. Add example usage

### Adding New Themes

1. Create a new file in `src/Themes/`
2. Define all required color values
3. Register with ThemeManager
4. Test with all components
5. Document the theme

### Testing

- Test all components
- Test on PC, Mobile, and Tablet
- Test with different themes
- Test callbacks and events
- Check for memory leaks

## Reporting Issues

When reporting issues, please include:

- Description of the bug
- Steps to reproduce
- Expected behavior
- Actual behavior
- Roblox Studio version
- Example code

## Feature Requests

Feature requests are welcome! Please include:

- Description of the feature
- Why it would be useful
- Possible implementation approach
- Example use case

## Questions?

Feel free to open an issue with your question. We're here to help!

## Code of Conduct

- Be respectful
- Be constructive
- Help others learn
- Report issues professionally

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
