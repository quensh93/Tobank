# Theming & Styles

Stac provides comprehensive theming and styling capabilities that allow you to create consistent, beautiful UIs across your application. This guide covers how to use and customize themes, styles, and visual elements.

## Theme System

Stac's theme system is built on top of Flutter's Material Design theme system, providing:

- **Global theming** across your entire app
- **Component-specific styling** for individual widgets
- **Dynamic theme switching** (light/dark mode)
- **Custom color schemes** and typography
- **Responsive design** support

## Basic Theming

### App-Level Theme

Set a global theme for your Stac app:

```dart
void main() async {
  await Stac.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StacApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
```

### Dark Theme

Enable dark theme support:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StacApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system, // Follows system setting
      home: const MyHomePage(),
    );
  }
}
```

## JSON-Based Theming

### Theme Configuration in JSON

Define themes directly in your JSON:

```json
{
  "type": "scaffold",
  "theme": {
    "primaryColor": "#4D00E9",
    "secondaryColor": "#00E9A3",
    "backgroundColor": "#FFFFFF",
    "textColor": "#333333",
    "fontFamily": "Roboto",
    "fontSize": 16
  },
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Themed App"
    }
  },
  "body": {
    "type": "center",
    "child": {
      "type": "text",
      "data": "This app uses JSON theming"
    }
  }
}
```

### Component-Specific Styling

Style individual components:

```json
{
  "type": "container",
  "style": {
    "backgroundColor": "#F8F9FA",
    "borderRadius": 12,
    "padding": {
      "top": 16,
      "bottom": 16,
      "left": 20,
      "right": 20
    },
    "margin": {
      "top": 8,
      "bottom": 8,
      "left": 16,
      "right": 16
    },
    "boxShadow": [
      {
        "color": "#000000",
        "blurRadius": 8,
        "offset": {
          "x": 0,
          "y": 2
        }
      }
    ]
  },
  "child": {
    "type": "text",
    "data": "Styled Container",
    "style": {
      "fontSize": 18,
      "fontWeight": "bold",
      "color": "#2C3E50"
    }
  }
}
```

## Color System

### Color Definitions

Define colors in your JSON:

```json
{
  "colors": {
    "primary": "#4D00E9",
    "secondary": "#00E9A3",
    "accent": "#FF6B35",
    "background": "#FFFFFF",
    "surface": "#F8F9FA",
    "error": "#E74C3C",
    "warning": "#F39C12",
    "success": "#27AE60",
    "info": "#3498DB"
  }
}
```

### Color Usage

Use colors throughout your widgets:

```json
{
  "type": "elevatedButton",
  "style": {
    "backgroundColor": "{{colors.primary}}",
    "foregroundColor": "#FFFFFF"
  },
  "child": {
    "type": "text",
    "data": "Primary Button"
  }
}
```

### Dynamic Colors

Use dynamic colors based on conditions:

```json
{
  "type": "container",
  "style": {
    "backgroundColor": "{{user.isPremium ? colors.primary : colors.surface}}"
  }
}
```

## Typography

### Font Configuration

Define typography in your theme:

```json
{
  "typography": {
    "fontFamily": "Roboto",
    "headline1": {
      "fontSize": 32,
      "fontWeight": "bold",
      "color": "#2C3E50"
    },
    "headline2": {
      "fontSize": 28,
      "fontWeight": "bold",
      "color": "#2C3E50"
    },
    "body1": {
      "fontSize": 16,
      "fontWeight": "normal",
      "color": "#333333"
    },
    "body2": {
      "fontSize": 14,
      "fontWeight": "normal",
      "color": "#666666"
    }
  }
}
```

### Text Styling

Apply typography to text widgets:

```json
{
  "type": "text",
  "data": "Headline Text",
  "style": {
    "fontSize": 24,
    "fontWeight": "bold",
    "color": "#2C3E50",
    "fontFamily": "Roboto"
  }
}
```

## Layout and Spacing

### Spacing System

Define consistent spacing:

```json
{
  "spacing": {
    "xs": 4,
    "sm": 8,
    "md": 16,
    "lg": 24,
    "xl": 32,
    "xxl": 48
  }
}
```

### Padding and Margins

Use spacing in your layouts:

```json
{
  "type": "container",
  "padding": {
    "top": "{{spacing.md}}",
    "bottom": "{{spacing.md}}",
    "left": "{{spacing.lg}}",
    "right": "{{spacing.lg}}"
  },
  "margin": {
    "top": "{{spacing.sm}}",
    "bottom": "{{spacing.sm}}"
  }
}
```

### Grid System

Implement a grid system:

```json
{
  "grid": {
    "columns": 12,
    "gutter": 16,
    "breakpoints": {
      "mobile": 768,
      "tablet": 1024,
      "desktop": 1200
    }
  }
}
```

## Component Themes

### Button Themes

Style buttons consistently:

```json
{
  "buttonThemes": {
    "primary": {
      "backgroundColor": "#4D00E9",
      "foregroundColor": "#FFFFFF",
      "borderRadius": 8,
      "padding": {
        "top": 12,
        "bottom": 12,
        "left": 24,
        "right": 24
      }
    },
    "secondary": {
      "backgroundColor": "transparent",
      "foregroundColor": "#4D00E9",
      "borderRadius": 8,
      "border": {
        "width": 1,
        "color": "#4D00E9"
      }
    }
  }
}
```

### Card Themes

Style cards consistently:

```json
{
  "cardThemes": {
    "default": {
      "backgroundColor": "#FFFFFF",
      "borderRadius": 12,
      "padding": {
        "top": 16,
        "bottom": 16,
        "left": 20,
        "right": 20
      },
      "boxShadow": [
        {
          "color": "#000000",
          "blurRadius": 8,
          "offset": {
            "x": 0,
            "y": 2
          }
        }
      ]
    }
  }
}
```

## Responsive Design

### Breakpoint System

Define responsive breakpoints:

```json
{
  "breakpoints": {
    "mobile": 768,
    "tablet": 1024,
    "desktop": 1200
  }
}
```

### Responsive Layouts

Create responsive layouts:

```json
{
  "type": "conditional",
  "condition": "{{screenWidth < 768}}",
  "trueChild": {
    "type": "column",
    "children": [
      {
        "type": "text",
        "data": "Mobile Layout"
      }
    ]
  },
  "falseChild": {
    "type": "row",
    "children": [
      {
        "type": "text",
        "data": "Desktop Layout"
      }
    ]
  }
}
```

### Responsive Typography

Adjust typography for different screen sizes:

```json
{
  "type": "text",
  "data": "Responsive Text",
  "style": {
    "fontSize": "{{screenWidth < 768 ? 16 : 20}}",
    "fontWeight": "bold"
  }
}
```

## Animation and Transitions

### Animation Configuration

Define animations in your theme:

```json
{
  "animations": {
    "duration": {
      "fast": 200,
      "normal": 300,
      "slow": 500
    },
    "curves": {
      "easeIn": "easeIn",
      "easeOut": "easeOut",
      "easeInOut": "easeInOut"
    }
  }
}
```

### Animated Widgets

Use animations in your widgets:

```json
{
  "type": "container",
  "style": {
    "backgroundColor": "#4D00E9",
    "borderRadius": 8
  },
  "animation": {
    "type": "fadeIn",
    "duration": 300,
    "curve": "easeOut"
  }
}
```

## Custom Themes

### Creating Custom Themes

Define custom themes for specific use cases:

```json
{
  "customThemes": {
    "dashboard": {
      "primaryColor": "#2C3E50",
      "secondaryColor": "#3498DB",
      "backgroundColor": "#ECF0F1",
      "cardStyle": {
        "backgroundColor": "#FFFFFF",
        "borderRadius": 12,
        "boxShadow": [
          {
            "color": "#000000",
            "blurRadius": 4,
            "offset": {
              "x": 0,
              "y": 2
            }
          }
        ]
      }
    },
    "onboarding": {
      "primaryColor": "#E74C3C",
      "secondaryColor": "#F39C12",
      "backgroundColor": "#FFFFFF",
      "textStyle": {
        "fontFamily": "Poppins",
        "fontSize": 18
      }
    }
  }
}
```

### Theme Switching

Switch between themes dynamically:

```json
{
  "type": "elevatedButton",
  "child": {
    "type": "text",
    "data": "Switch Theme"
  },
  "onPressed": {
    "actionType": "setValue",
    "key": "currentTheme",
    "value": "{{currentTheme === 'light' ? 'dark' : 'light'}}"
  }
}
```

## Accessibility

### Accessibility Themes

Ensure your themes are accessible:

```json
{
  "accessibility": {
    "minimumContrastRatio": 4.5,
    "focusColor": "#4D00E9",
    "hoverColor": "#3B00B8",
    "disabledColor": "#CCCCCC"
  }
}
```

### High Contrast Mode

Support high contrast mode:

```json
{
  "type": "container",
  "style": {
    "backgroundColor": "{{isHighContrast ? '#000000' : '#FFFFFF'}}",
    "border": {
      "width": "{{isHighContrast ? 2 : 0}}",
      "color": "{{isHighContrast ? '#FFFFFF' : 'transparent'}}"
    }
  }
}
```

## Best Practices

### 1. Consistent Color Palette

- Use a limited set of colors
- Define semantic color names
- Ensure sufficient contrast ratios
- Test with colorblind users

### 2. Typography Hierarchy

- Use consistent font sizes
- Establish clear hierarchy
- Choose readable fonts
- Consider line height and spacing

### 3. Responsive Design

- Design mobile-first
- Use flexible layouts
- Test on different screen sizes
- Consider touch targets

### 4. Performance

- Minimize theme complexity
- Use efficient color formats
- Cache theme calculations
- Avoid excessive animations

### 5. Accessibility

- Ensure sufficient contrast
- Support screen readers
- Provide alternative text
- Test with assistive technologies

## Theme Examples

### Material Design Theme

```json
{
  "theme": {
    "primaryColor": "#2196F3",
    "secondaryColor": "#FF9800",
    "backgroundColor": "#FAFAFA",
    "surfaceColor": "#FFFFFF",
    "errorColor": "#F44336",
    "textColor": "#212121",
    "secondaryTextColor": "#757575"
  }
}
```

### Dark Theme

```json
{
  "theme": {
    "primaryColor": "#BB86FC",
    "secondaryColor": "#03DAC6",
    "backgroundColor": "#121212",
    "surfaceColor": "#1E1E1E",
    "errorColor": "#CF6679",
    "textColor": "#FFFFFF",
    "secondaryTextColor": "#B3FFFFFF"
  }
}
```

### Custom Brand Theme

```json
{
  "theme": {
    "primaryColor": "#E91E63",
    "secondaryColor": "#9C27B0",
    "accentColor": "#FF5722",
    "backgroundColor": "#FCE4EC",
    "surfaceColor": "#FFFFFF",
    "textColor": "#2E2E2E",
    "fontFamily": "Montserrat"
  }
}
```

## Next Steps

- [Examples](./11-examples.md) - See complete themed examples
- [API Reference](./12-api-reference.md) - Detailed API documentation
- [Contributing](./13-contributing.md) - Contribute to Stac
