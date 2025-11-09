# Quick Start Guide

This guide will help you build your first Stac app in minutes. We'll create a simple form application that demonstrates the core concepts of Server-Driven UI.

## What We'll Build

We'll create a user registration form with:
- Text input fields for name, email, and password
- Form validation
- Submit button with action
- Dynamic UI updates

## Step 1: Project Setup

### Create a New Flutter Project

```bash
flutter create stac_quickstart
cd stac_quickstart
```

### Add Stac Dependency

```bash
flutter pub add stac
```

### Update pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter
  stac: ^<latest-version>

flutter:
  assets:
    - assets/
```

## Step 2: Create the JSON UI

Create a new file `assets/form.json`:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "User Registration",
      "style": {
        "color": "#ffffff",
        "fontSize": 21
      }
    },
    "backgroundColor": "#4D00E9"
  },
  "backgroundColor": "#ffffff",
  "body": {
    "type": "singleChildScrollView",
    "child": {
      "type": "container",
      "padding": {
        "left": 16,
        "right": 16,
        "top": 16,
        "bottom": 16
      },
      "child": {
        "type": "column",
        "mainAxisAlignment": "start",
        "crossAxisAlignment": "stretch",
        "children": [
          {
            "type": "sizedBox",
            "height": 24
          },
          {
            "type": "text",
            "data": "Create Your Account",
            "style": {
              "fontSize": 28,
              "fontWeight": "bold",
              "color": "#333333"
            }
          },
          {
            "type": "sizedBox",
            "height": 8
          },
          {
            "type": "text",
            "data": "Fill in your details to get started",
            "style": {
              "fontSize": 16,
              "color": "#666666"
            }
          },
          {
            "type": "sizedBox",
            "height": 32
          },
          {
            "type": "form",
            "key": "registrationForm",
            "child": {
              "type": "column",
              "children": [
                {
                  "type": "textFormField",
                  "key": "name",
                  "decoration": {
                    "labelText": "Full Name",
                    "hintText": "Enter your full name",
                    "prefixIcon": {
                      "type": "icon",
                      "iconType": "material",
                      "icon": "person"
                    }
                  },
                  "validator": {
                    "required": true,
                    "minLength": 2
                  }
                },
                {
                  "type": "sizedBox",
                  "height": 16
                },
                {
                  "type": "textFormField",
                  "key": "email",
                  "keyboardType": "emailAddress",
                  "decoration": {
                    "labelText": "Email Address",
                    "hintText": "Enter your email",
                    "prefixIcon": {
                      "type": "icon",
                      "iconType": "material",
                      "icon": "email"
                    }
                  },
                  "validator": {
                    "required": true,
                    "email": true
                  }
                },
                {
                  "type": "sizedBox",
                  "height": 16
                },
                {
                  "type": "textFormField",
                  "key": "password",
                  "obscureText": true,
                  "decoration": {
                    "labelText": "Password",
                    "hintText": "Enter your password",
                    "prefixIcon": {
                      "type": "icon",
                      "iconType": "material",
                      "icon": "lock"
                    }
                  },
                  "validator": {
                    "required": true,
                    "minLength": 6
                  }
                },
                {
                  "type": "sizedBox",
                  "height": 16
                },
                {
                  "type": "textFormField",
                  "key": "confirmPassword",
                  "obscureText": true,
                  "decoration": {
                    "labelText": "Confirm Password",
                    "hintText": "Confirm your password",
                    "prefixIcon": {
                      "type": "icon",
                      "iconType": "material",
                      "icon": "lock"
                    }
                  },
                  "validator": {
                    "required": true,
                    "minLength": 6
                  }
                },
                {
                  "type": "sizedBox",
                  "height": 32
                },
                {
                  "type": "elevatedButton",
                  "child": {
                    "type": "text",
                    "data": "Create Account",
                    "style": {
                      "color": "#ffffff",
                      "fontSize": 16,
                      "fontWeight": "bold"
                    }
                  },
                  "style": {
                    "backgroundColor": "#4D00E9",
                    "padding": {
                      "top": 16,
                      "bottom": 16
                    }
                  },
                  "onPressed": {
                    "actionType": "multi",
                    "actions": [
                      {
                        "actionType": "formValidate",
                        "formKey": "registrationForm"
                      },
                      {
                        "actionType": "getFormValue",
                        "formKey": "registrationForm",
                        "onSuccess": {
                          "actionType": "snackBar",
                          "message": "Account created successfully!"
                        },
                        "onError": {
                          "actionType": "snackBar",
                          "message": "Please fill in all required fields"
                        }
                      }
                    ]
                  }
                },
                {
                  "type": "sizedBox",
                  "height": 16
                },
                {
                  "type": "textButton",
                  "child": {
                    "type": "text",
                    "data": "Already have an account? Sign In",
                    "style": {
                      "color": "#4D00E9"
                    }
                  },
                  "onPressed": {
                    "actionType": "navigate",
                    "route": "/login"
                  }
                }
              ]
            }
          }
        ]
      }
    }
  }
}
```

## Step 3: Create the Main App

Update your `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Stac
  await Stac.initialize();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StacApp(
      title: 'Stac Quickstart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stac.fromAsset('assets/form.json', context);
  }
}
```

## Step 4: Run the App

```bash
flutter run
```

You should see a beautiful registration form with:
- A purple app bar with white title
- Form fields for name, email, and password
- Validation on form submission
- Success/error messages via snack bars

## Step 5: Understanding the JSON Structure

Let's break down the key parts of our JSON:

### Scaffold Structure
```json
{
  "type": "scaffold",
  "appBar": { ... },
  "body": { ... }
}
```

### Form with Validation
```json
{
  "type": "form",
  "key": "registrationForm",
  "child": { ... }
}
```

### Text Input with Validation
```json
{
  "type": "textFormField",
  "key": "email",
  "decoration": { ... },
  "validator": {
    "required": true,
    "email": true
  }
}
```

### Button with Actions
```json
{
  "type": "elevatedButton",
  "onPressed": {
    "actionType": "multi",
    "actions": [
      {
        "actionType": "formValidate",
        "formKey": "registrationForm"
      },
      {
        "actionType": "getFormValue",
        "formKey": "registrationForm"
      }
    ]
  }
}
```

## Step 6: Adding More Features

### Custom Validation

Let's add a custom validator for password confirmation:

```json
{
  "type": "textFormField",
  "key": "confirmPassword",
  "validator": {
    "required": true,
    "minLength": 6,
    "custom": "passwordMatch"
  }
}
```

### Loading State

Add a loading indicator during form submission:

```json
{
  "type": "elevatedButton",
  "child": {
    "type": "conditional",
    "condition": "isLoading",
    "trueChild": {
      "type": "circularProgressIndicator",
      "color": "#ffffff"
    },
    "falseChild": {
      "type": "text",
      "data": "Create Account"
    }
  }
}
```

### Navigation

Add navigation to a success screen:

```json
{
  "actionType": "navigate",
  "route": "/success",
  "arguments": {
    "userEmail": "{{form.email}}"
  }
}
```

## Step 7: Dynamic Content

### Loading from Network

Instead of loading from assets, load from a server:

```dart
class RegistrationForm extends StatelessWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stac.fromNetwork(
      StacNetworkRequest(
        url: 'https://api.example.com/forms/registration.json',
        method: Method.get,
      ),
      context,
    );
  }
}
```

### Conditional Rendering

Show different content based on conditions:

```json
{
  "type": "conditional",
  "condition": "user.isLoggedIn",
  "trueChild": {
    "type": "text",
    "data": "Welcome back!"
  },
  "falseChild": {
    "type": "text",
    "data": "Please sign in"
  }
}
```

## Step 8: Testing Your App

### Form Validation Test
1. Try submitting the form without filling fields
2. Enter invalid email format
3. Enter passwords that don't match
4. Verify error messages appear

### Success Flow Test
1. Fill in all fields correctly
2. Submit the form
3. Verify success message appears
4. Check form data is captured

## Next Steps

Congratulations! You've built your first Stac app. Here's what you can do next:

### Explore More Widgets
- [Widgets Documentation](./06-widgets.md) - Learn about all available widgets
- [Actions Documentation](./07-actions.md) - Discover different action types

### Advanced Features
- [Custom Parsers](./08-parsers.md) - Create your own widgets and actions
- [Theming](./09-theming-styles.md) - Customize the look and feel
- [Stac CLI](./10-stac-cli.md) - Use command-line tools

### Real-World Examples
- [Examples](./11-examples.md) - See complete applications
- [API Reference](./12-api-reference.md) - Detailed API documentation

## Common Patterns

### Form Handling
```json
{
  "type": "form",
  "key": "myForm",
  "child": {
    "type": "column",
    "children": [
      {
        "type": "textFormField",
        "key": "field1",
        "validator": { "required": true }
      }
    ]
  }
}
```

### Navigation
```json
{
  "actionType": "navigate",
  "route": "/next-screen",
  "arguments": { "data": "value" }
}
```

### API Calls
```json
{
  "actionType": "networkRequest",
  "url": "https://api.example.com/data",
  "method": "POST",
  "body": { "key": "value" }
}
```

## Troubleshooting

### Common Issues

1. **JSON Parse Error**: Check your JSON syntax using a JSON validator
2. **Widget Not Found**: Ensure the widget type is supported by Stac
3. **Action Not Working**: Verify the action type is correct
4. **Form Validation**: Check that form keys match between fields and actions

### Debug Tips

1. Enable debug mode in Stac initialization
2. Use console logs to track form data
3. Test individual widgets in isolation
4. Validate JSON structure before implementing

## Resources

- [Stac Gallery](https://github.com/StacDev/stac/tree/dev/examples/stac_gallery) - Complete widget examples
- [Discord Community](https://discord.com/invite/vTGsVRK86V) - Get help and share ideas
- [GitHub Repository](https://github.com/StacDev/stac) - Source code and issues
