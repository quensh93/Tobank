# Debug Panel Design Specifications

## 🎨 Visual Design System

This document outlines the visual design specifications for the Modern Debug Panel, ensuring consistency with Material Design 3 and optimal user experience.

## 🎯 Design Goals

### Primary Goals
- **Modern Aesthetic**: Clean, professional appearance following Material Design 3
- **Intuitive Navigation**: Easy-to-use interface with minimal learning curve
- **Visual Hierarchy**: Clear organization of tools and information
- **Consistent Theming**: Seamless integration with app's design system

### Secondary Goals
- **Accessibility**: Full accessibility compliance (WCAG 2.1 AA)
- **Responsive Design**: Optimal experience across all screen sizes
- **Performance**: Smooth animations and interactions
- **Extensibility**: Support for custom themes and plugins

## 🎨 Color System

### Primary Colors
```dart
class DebugPanelColors {
  // Primary debug colors
  static const Color primary = Color(0xFF6750A4);      // Material Purple
  static const Color onPrimary = Color(0xFFFFFFFF);    // White
  static const Color primaryContainer = Color(0xFFEADDFF); // Light Purple
  static const Color onPrimaryContainer = Color(0xFF21005D); // Dark Purple
  
  // Secondary colors
  static const Color secondary = Color(0xFF625B71);    // Material Purple Grey
  static const Color onSecondary = Color(0xFFFFFFFF);  // White
  static const Color secondaryContainer = Color(0xFFE8DEF8); // Light Purple Grey
  static const Color onSecondaryContainer = Color(0xFF1D192B); // Dark Purple Grey
  
  // Surface colors
  static const Color surface = Color(0xFFFFFBFE);      // White
  static const Color onSurface = Color(0xFF1C1B1F);     // Dark Grey
  static const Color surfaceVariant = Color(0xFFE7E0EC); // Light Grey
  static const Color onSurfaceVariant = Color(0xFF49454F); // Medium Grey
  
  // Background colors
  static const Color background = Color(0xFFFFFBFE);   // White
  static const Color onBackground = Color(0xFF1C1B1F);  // Dark Grey
  
  // Error colors
  static const Color error = Color(0xFFBA1A1A);        // Red
  static const Color onError = Color(0xFFFFFFFF);      // White
  static const Color errorContainer = Color(0xFFFFDAD6); // Light Red
  static const Color onErrorContainer = Color(0xFF410002); // Dark Red
}
```

### Dark Theme Colors
```dart
class DebugPanelDarkColors {
  // Primary debug colors (dark)
  static const Color primary = Color(0xFFD0BCFF);      // Light Purple
  static const Color onPrimary = Color(0xFF381E72);    // Dark Purple
  static const Color primaryContainer = Color(0xFF4F378B); // Medium Purple
  static const Color onPrimaryContainer = Color(0xFFEADDFF); // Light Purple
  
  // Surface colors (dark)
  static const Color surface = Color(0xFF1C1B1F);      // Dark Grey
  static const Color onSurface = Color(0xFFE6E1E5);   // Light Grey
  static const Color surfaceVariant = Color(0xFF49454F); // Medium Grey
  static const Color onSurfaceVariant = Color(0xFFCAC4D0); // Light Grey
  
  // Background colors (dark)
  static const Color background = Color(0xFF1C1B1F);  // Dark Grey
  static const Color onBackground = Color(0xFFE6E1E5); // Light Grey
}
```

### Semantic Colors
```dart
class DebugPanelSemanticColors {
  // Log level colors
  static const Color logInfo = Color(0xFF2196F3);     // Blue
  static const Color logWarning = Color(0xFFFF9800);   // Orange
  static const Color logError = Color(0xFFF44336);     // Red
  static const Color logDebug = Color(0xFF9C27B0);     // Purple
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);     // Green
  static const Color warning = Color(0xFFFF9800);     // Orange
  static const Color error = Color(0xFFF44336);        // Red
  static const Color info = Color(0xFF2196F3);         // Blue
  
  // Interactive colors
  static const Color hover = Color(0x0A000000);        // 4% Black
  static const Color pressed = Color(0x14000000);      // 8% Black
  static const Color focus = Color(0x1F6750A4);        // 12% Primary
  static const Color selected = Color(0x1F6750A4);      // 12% Primary
}
```

## 📏 Spacing System

### Spacing Scale (8dp Grid)
```dart
class DebugPanelSpacing {
  // Base spacing units
  static const double xs = 4.0;    // 0.5x base
  static const double sm = 8.0;    // 1x base
  static const double md = 16.0;   // 2x base
  static const double lg = 24.0;   // 3x base
  static const double xl = 32.0;   // 4x base
  static const double xxl = 48.0; // 6x base
  
  // Component-specific spacing
  static const double panelPadding = 16.0;
  static const double tabSpacing = 8.0;
  static const double toolSpacing = 12.0;
  static const double sectionSpacing = 24.0;
}
```

### Layout Spacing
```dart
class DebugPanelLayout {
  // Panel dimensions
  static const double minPanelWidth = 300.0;
  static const double maxPanelWidth = 600.0;
  static const double defaultPanelWidth = 400.0;
  
  // Tab dimensions
  static const double tabHeight = 48.0;
  static const double tabPadding = 16.0;
  
  // App frame dimensions
  static const double minFrameWidth = 200.0;
  static const double minFrameHeight = 300.0;
  static const double framePadding = 16.0;
}
```

## 🔤 Typography

### Text Styles
```dart
class DebugPanelTextStyles {
  // Headlines
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.25,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.29,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.33,
  );
  
  // Titles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.0,
    height: 1.27,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.50,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  // Body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.50,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );
  
  // Labels
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
  );
}
```

### Font Usage Guidelines
- **Headlines**: Use for main section titles and important headings
- **Titles**: Use for tool names, tab labels, and secondary headings
- **Body**: Use for descriptions, content, and general text
- **Labels**: Use for buttons, form labels, and small text

## 🔲 Shape System

### Border Radius
```dart
class DebugPanelShapes {
  // Component border radius
  static const double xs = 4.0;   // Small components
  static const double sm = 8.0;    // Medium components
  static const double md = 12.0;   // Large components
  static const double lg = 16.0;   // Extra large components
  static const double xl = 24.0;   // Panels and containers
  
  // Specific component radius
  static const double button = 8.0;
  static const double card = 12.0;
  static const double panel = 16.0;
  static const double tab = 8.0;
  static const double tool = 12.0;
}
```

### Elevation System
```dart
class DebugPanelElevation {
  // Elevation levels
  static const double level0 = 0.0;   // Flat
  static const double level1 = 1.0;   // Subtle
  static const double level2 = 3.0;   // Low
  static const double level3 = 6.0;   // Medium
  static const double level4 = 8.0;   // High
  static const double level5 = 12.0;  // Very high
  
  // Component elevations
  static const double panel = 8.0;
  static const double tab = 2.0;
  static const double tool = 4.0;
  static const double button = 2.0;
  static const double dialog = 24.0;
}
```

## 🎭 Animation System

### Duration
```dart
class DebugPanelDuration {
  // Animation durations
  static const Duration short1 = Duration(milliseconds: 50);
  static const Duration short2 = Duration(milliseconds: 100);
  static const Duration short3 = Duration(milliseconds: 150);
  static const Duration short4 = Duration(milliseconds: 200);
  static const Duration medium1 = Duration(milliseconds: 250);
  static const Duration medium2 = Duration(milliseconds: 300);
  static const Duration medium3 = Duration(milliseconds: 350);
  static const Duration medium4 = Duration(milliseconds: 400);
  static const Duration long1 = Duration(milliseconds: 450);
  static const Duration long2 = Duration(milliseconds: 500);
  static const Duration long3 = Duration(milliseconds: 550);
  static const Duration long4 = Duration(milliseconds: 600);
}
```

### Easing Curves
```dart
class DebugPanelEasing {
  // Standard easing curves
  static const Curve standard = Curves.easeInOut;
  static const Curve decelerate = Curves.easeOut;
  static const Curve accelerate = Curves.easeIn;
  static const Curve sharp = Curves.easeInOutCubic;
  
  // Custom easing curves
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve emphasizedDecelerate = Curves.easeOutCubic;
  static const Curve emphasizedAccelerate = Curves.easeInCubic;
}
```

### Animation Types
- **Panel Transitions**: 300ms easeInOut
- **Tab Switching**: 200ms easeInOut
- **Tool Loading**: 150ms easeOut
- **Hover Effects**: 100ms easeOut
- **Focus Effects**: 150ms easeInOut

## 📱 Responsive Design

### Breakpoints
```dart
class DebugPanelBreakpoints {
  // Screen size breakpoints
  static const double mobile = 600.0;   // Mobile devices
  static const double tablet = 900.0;    // Tablet devices
  static const double desktop = 1200.0;  // Desktop devices
  
  // Panel size breakpoints
  static const double compact = 300.0;  // Compact panel
  static const double comfortable = 400.0; // Comfortable panel
  static const double spacious = 500.0;  // Spacious panel
}
```

### Layout Modes
- **Mobile (< 600dp)**: Bottom panel with vertical tabs
- **Tablet (600-900dp)**: Side panel with horizontal tabs
- **Desktop (> 900dp)**: Side panel with vertical tabs

### Responsive Behaviors
- **Panel Positioning**: Adaptive positioning based on screen size
- **Tab Orientation**: Vertical on desktop, horizontal on mobile
- **Content Density**: Adjustable based on available space
- **Touch Targets**: Minimum 44dp touch targets on mobile

## 🎨 Component Specifications

### Debug Panel Container
```dart
class DebugPanelContainer {
  // Dimensions
  static const double minWidth = 300.0;
  static const double maxWidth = 600.0;
  static const double defaultWidth = 400.0;
  
  // Styling
  static const double borderRadius = 16.0;
  static const double elevation = 8.0;
  static const EdgeInsets padding = EdgeInsets.all(16.0);
  
  // Colors
  static const Color backgroundColor = Colors.white;
  static const Color borderColor = Color(0xFFE0E0E0);
}
```

### Tab System
```dart
class DebugPanelTabs {
  // Dimensions
  static const double height = 48.0;
  static const double borderRadius = 8.0;
  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 16.0);
  
  // Styling
  static const Color activeColor = Color(0xFF6750A4);
  static const Color inactiveColor = Color(0xFF49454F);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  
  // Typography
  static const TextStyle activeTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Color(0xFF6750A4),
  );
  
  static const TextStyle inactiveTextStyle = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Color(0xFF49454F),
  );
}
```

### Tool Content Area
```dart
class DebugPanelToolContent {
  // Dimensions
  static const EdgeInsets padding = EdgeInsets.all(16.0);
  static const double borderRadius = 12.0;
  
  // Styling
  static const Color backgroundColor = Colors.white;
  static const Color borderColor = Color(0xFFE0E0E0);
  
  // Spacing
  static const double sectionSpacing = 24.0;
  static const double itemSpacing = 12.0;
}
```

## 🎯 Accessibility Guidelines

### Color Contrast
- **Normal Text**: Minimum 4.5:1 contrast ratio
- **Large Text**: Minimum 3:1 contrast ratio
- **UI Components**: Minimum 3:1 contrast ratio

### Touch Targets
- **Minimum Size**: 44dp x 44dp
- **Recommended Size**: 48dp x 48dp
- **Spacing**: Minimum 8dp between touch targets

### Focus Indicators
- **Visible Focus**: Clear focus indicators for keyboard navigation
- **Focus Order**: Logical tab order
- **Focus Management**: Proper focus management in modals

### Screen Reader Support
- **Semantic Labels**: Proper semantic labels for all interactive elements
- **Live Regions**: Announce dynamic content changes
- **Heading Structure**: Proper heading hierarchy

## 🎨 Dark Theme Specifications

### Dark Theme Colors
```dart
class DebugPanelDarkTheme {
  // Surface colors
  static const Color surface = Color(0xFF1C1B1F);
  static const Color onSurface = Color(0xFFE6E1E5);
  static const Color surfaceVariant = Color(0xFF49454F);
  static const Color onSurfaceVariant = Color(0xFFCAC4D0);
  
  // Background colors
  static const Color background = Color(0xFF1C1B1F);
  static const Color onBackground = Color(0xFFE6E1E5);
  
  // Primary colors
  static const Color primary = Color(0xFFD0BCFF);
  static const Color onPrimary = Color(0xFF381E72);
  static const Color primaryContainer = Color(0xFF4F378B);
  static const Color onPrimaryContainer = Color(0xFFEADDFF);
}
```

### Dark Theme Adjustments
- **Elevation**: Increased elevation for better contrast
- **Opacity**: Adjusted opacity values for dark backgrounds
- **Borders**: Subtle borders for better definition
- **Shadows**: Enhanced shadows for depth perception

## 📊 Design Tokens

### Complete Design Token System
```dart
class DebugPanelDesignTokens {
  // Colors
  static const Map<String, Color> colors = {
    'primary': Color(0xFF6750A4),
    'onPrimary': Color(0xFFFFFFFF),
    'primaryContainer': Color(0xFFEADDFF),
    'onPrimaryContainer': Color(0xFF21005D),
    // ... more colors
  };
  
  // Spacing
  static const Map<String, double> spacing = {
    'xs': 4.0,
    'sm': 8.0,
    'md': 16.0,
    'lg': 24.0,
    'xl': 32.0,
    // ... more spacing
  };
  
  // Typography
  static const Map<String, TextStyle> typography = {
    'headlineLarge': TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
    'headlineMedium': TextStyle(fontSize: 28.0, fontWeight: FontWeight.w400),
    // ... more typography
  };
  
  // Shapes
  static const Map<String, double> shapes = {
    'xs': 4.0,
    'sm': 8.0,
    'md': 12.0,
    'lg': 16.0,
    'xl': 24.0,
    // ... more shapes
  };
}
```

---

**Last Updated**: January 2025  
**Version**: 1.0  
**Status**: Draft
