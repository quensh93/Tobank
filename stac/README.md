# Custom STAC Components

This folder contains custom widgets and actions for the ToBank SDUI project, built on top of the STAC (Server-Driven UI) framework.

## 📁 Folder Structure

```
stac/
├── widgets/          # Custom STAC widgets
├── actions/          # Custom STAC actions
├── examples/         # Usage examples and demos
└── README.md         # This file
```

## 🎯 Purpose

This folder is designed to extend the core STAC framework with project-specific components that can be used in your Server-Driven UI JSON configurations. Unlike the `.stac` folder (which contains the core STAC framework reference), this `stac` folder is for:

- **Custom Widgets**: Project-specific UI components that extend STAC's built-in widgets
- **Custom Actions**: Project-specific actions that handle business logic, API calls, and user interactions
- **Examples**: Demonstrations of how to use custom components in JSON configurations

## 🧩 Custom Widgets

Place your custom STAC widgets in the `widgets/` folder. These widgets should:

- Extend STAC's widget system
- Be configurable via JSON
- Follow STAC's widget naming conventions
- Include proper documentation and examples

### Example Custom Widget Structure:
```dart
// widgets/custom_card.dart
class CustomCard extends StacWidget {
  // Implementation
}
```

## ⚡ Custom Actions

Place your custom STAC actions in the `actions/` folder. These actions should:

- Extend STAC's action system
- Handle project-specific business logic
- Support JSON configuration
- Include proper error handling

### Example Custom Action Structure:
```dart
// actions/custom_api_action.dart
class CustomApiAction extends StacAction {
  // Implementation
}
```

## 📚 Usage in JSON

Once implemented, your custom components can be used in STAC JSON configurations:

### Custom Widget Usage:
```json
{
  "type": "custom_card",
  "title": "My Custom Card",
  "content": {
    "type": "text",
    "data": "This is a custom card widget"
  }
}
```

### Custom Action Usage:
```json
{
  "type": "elevatedButton",
  "child": {
    "type": "text",
    "data": "Submit"
  },
  "onPressed": {
    "actionType": "custom_api_action",
    "endpoint": "/api/submit",
    "method": "POST"
  }
}
```

## 🔧 Development Guidelines

1. **Naming Convention**: Use descriptive, snake_case names for files and classes
2. **Documentation**: Include comprehensive documentation for each component
3. **Examples**: Provide JSON examples in the `examples/` folder
4. **Testing**: Test components thoroughly before integration
5. **Compatibility**: Ensure compatibility with STAC framework versions

## 📖 STAC Framework Reference

- **Core Framework**: `.stac/packages/stac/` (reference only - do not modify)
- **Documentation**: `.stac/website/docs/` (STAC official documentation)
- **Examples**: `.stac/examples/` (STAC framework examples)

## 🚀 Getting Started

1. **Create a Custom Widget**:
   - Add your widget file to `widgets/`
   - Follow STAC widget patterns
   - Add documentation and examples

2. **Create a Custom Action**:
   - Add your action file to `actions/`
   - Implement STAC action interface
   - Add error handling and logging

3. **Test Your Components**:
   - Create examples in `examples/`
   - Test with real JSON configurations
   - Verify integration with STAC framework

## 📝 Notes

- This folder is tracked in git and can be modified as needed
- The `.stac` folder contains the core STAC framework and should not be modified
- Always refer to STAC documentation for proper implementation patterns
- Keep custom components focused on project-specific needs

---

**Happy coding with STAC! 🎉**
