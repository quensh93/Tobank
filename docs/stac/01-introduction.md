# Introduction to Stac

## What is Stac?

**Stac** is a **Server-Driven UI (SDUI) framework for Flutter** that allows you to build, update, and deliver dynamic user interfaces without redeploying your app. Instead of hard-coding every widget in Flutter, you define your UI as **Stac Widgets** that render at runtime from JSON.

This approach separates your app's presentation layer from its business logic, enabling teams to:

- **Ship updates instantly.** Just update your StacWidgets and push them to Stac Cloud.
- **Feature Experimentation** (A/B testing, personalization, etc.) without new releases.
- **Maintain consistency** across platforms using a unified schema.
- **Empower non-developers** (like designers or PMs) to manage layout and content.

## Key Features

### 🚀 Instant Updates
Ship UI changes without app store releases. Update your StacWidgets and push them to Stac Cloud for instant deployment.

### 🧩 JSON-Driven UI
Define widgets in JSON and render them natively in Flutter. This approach provides flexibility and dynamic content delivery.

### 📦 Dart to JSON
Write Stac widgets in Dart and deploy them to Stac Cloud, combining the power of Flutter development with server-driven flexibility.

### 🎛 Actions & Navigation
Control routes and API calls from the backend, enabling dynamic navigation and interaction patterns.

### 📝 Forms & Validation
Built-in form state management and validation rules, making it easy to create dynamic forms.

### 🎨 Theming
Brand and layout control via JSON with Stac Theme, enabling dynamic theming and styling.

### 🔌 Extensible
Add custom widgets, actions, and native integrations to extend Stac's capabilities.

## How Stac Works

### Traditional Flutter Development
```dart
// Traditional approach - UI is hardcoded
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Column(
        children: [
          Text('Hello World'),
          ElevatedButton(
            onPressed: () => print('Button pressed'),
            child: Text('Click me'),
          ),
        ],
      ),
    );
  }
}
```

### Stac Development
```dart
// Stac approach - UI is defined in JSON
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StacApp(
      title: 'My App',
      home: Stac.fromNetwork(
        StacNetworkRequest(
          url: 'https://api.example.com/ui.json',
        ),
      ),
    );
  }
}
```

```json
// UI defined in JSON (ui.json)
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "My App"
    }
  },
  "body": {
    "type": "column",
    "children": [
      {
        "type": "text",
        "data": "Hello World"
      },
      {
        "type": "elevatedButton",
        "child": {
          "type": "text",
          "data": "Click me"
        },
        "onPressed": {
          "actionType": "print",
          "message": "Button pressed"
        }
      }
    ]
  }
}
```

## Benefits of Server-Driven UI

### 1. **Instant Updates**
- No need to wait for app store approval
- Deploy UI changes in real-time
- Fix bugs and issues immediately

### 2. **Cross-Platform Consistency**
- Single JSON definition works across all platforms
- Consistent user experience on iOS, Android, and Web
- Unified design system

### 3. **A/B Testing & Experimentation**
- Test different UI variations without app releases
- Personalize experiences based on user data
- Optimize conversion rates through experimentation

### 4. **Non-Developer Friendly**
- Designers can modify UI without code changes
- Product managers can update content directly
- Marketing teams can create campaigns dynamically

### 5. **Reduced Development Time**
- Faster iteration cycles
- Less platform-specific development
- Simplified maintenance

## Use Cases

### E-commerce Applications
- Dynamic product catalogs
- Personalized shopping experiences
- Real-time pricing updates
- A/B testing for conversion optimization

### Content Management
- Dynamic article layouts
- Real-time content updates
- Personalized content delivery
- Multi-language support

### Financial Applications
- Dynamic dashboard layouts
- Real-time market data visualization
- Personalized investment recommendations
- Compliance-driven UI changes

### Social Media Platforms
- Dynamic feed layouts
- Personalized content algorithms
- Real-time feature rollouts
- User-specific interface customization

## Getting Started

Ready to start building with Stac? Check out our [Quick Start Guide](./04-quickstart.md) to get up and running in minutes.

## Next Steps

- [Why Stac?](./02-why-stac.md) - Learn about the problems Stac solves
- [Installation & Setup](./03-installation-setup.md) - Set up your development environment
- [Quick Start Guide](./04-quickstart.md) - Build your first Stac app
