# ISpect Integration Guide

## Overview

[ISpect](https://pub.dev/packages/ispect) is a comprehensive debugging and inspection toolkit for Flutter applications. It provides network monitoring, database logging, performance analysis, UI inspection, and more through a lightweight in-app panel.

## Architecture

ISpect is integrated at the **inner app level** (inside MaterialApp), independent of the debug panel. This allows ISpect to work both with and without the debug panel.

### Widget Hierarchy

```
DebugPanel (optional, in debug mode)
  └── MaterialApp
      └── ISpectBuilder (if enabled)
          └── App Content (HomeScreen, etc.)
```

This ensures:
- **ISpect works independently**: Can be enabled/disabled regardless of debug panel
- **ISpect shows on device preview**: Appears on the actual app content in the debug panel's device frame
- **Separation of concerns**: Debug panel handles device preview/layout, ISpect handles debugging tools

## Configuration

ISpect is controlled via `--dart-define` flags for security and tree-shaking:

```bash
# Enable ISpect in development
flutter run --dart-define=ENABLE_ISPECT=true

# Production build (ISpect disabled, tree-shaken)
flutter build apk
```

### Configuration File

Located at: `lib/core/config/ispect_config.dart`

- **`ISpectConfig.isEnabled`**: Controls if ISpect package should be active
- **`ISpectConfig.environment`**: Environment setting (development/staging/production)
- **`ISpectConfig.shouldInitialize`**: Determines if ISpect should be initialized (checks both flag and environment)

## Features

### Network Monitoring

ISpect automatically monitors all HTTP requests made through Dio:

- **Request/Response Inspection**: Full headers, bodies, and status codes
- **Error Tracking**: Detailed error information with stack traces
- **Timing Information**: Request duration and latency
- **Filtering**: Filter by status code, method, URL pattern

Configured in: `lib/data/providers/api_providers.dart`

The `ISpectDioInterceptor` is automatically added to Dio instances when ISpect is enabled.

### Logging System

ISpect includes a comprehensive logging system:

- **Categorized Logs**: Different log types (http, db, route, etc.)
- **Log Levels**: Debug, Info, Warning, Error
- **Filtering**: Filter logs by type and level
- **History**: Configurable log history size

### Performance Monitoring

- **Frame Rate**: Real-time FPS monitoring
- **Memory Usage**: Memory consumption tracking
- **Performance Metrics**: CPU usage and performance insights

### UI Inspector

- **Widget Tree**: Inspect widget hierarchy
- **Color Picker**: Extract colors from UI
- **Layout Analysis**: View widget properties and constraints

### Device Information

- **System Info**: Device model, OS version, screen size
- **App Metadata**: App version, build number, package info

## Usage

### Enabling ISpect

**Development:**
```bash
flutter run --dart-define=ENABLE_ISPECT=true
```

**Staging:**
```bash
flutter build apk --dart-define=ENABLE_ISPECT=true --dart-define=ENVIRONMENT=staging
```

**Production:**
```bash
# ISpect is automatically disabled (default: false)
flutter build apk
```

### Accessing ISpect Panel

When enabled, the ISpect panel can be accessed by:
- Swiping from the edge (mobile)
- Using the floating action button
- Keyboard shortcut (if configured)

### Logging to ISpect

```dart
// Access ISpect logger globally
ISpect.logger.info('User logged in');
ISpect.logger.error('Failed to fetch data', error);
ISpect.logger.debug('Debug information');
```

### Network Requests

All Dio HTTP requests are automatically logged when ISpect is enabled. No additional code needed!

## Security

### Important Security Guidelines

1. **Never enable in production**: ISpect should only be used in development/staging
2. **Tree-shaking works**: Code is automatically removed in production builds without the flag
3. **Sensitive data**: Use redaction for sensitive information in network requests
4. **Build verification**: Always verify production builds don't include ISpect

### Data Redaction

Configure redaction for sensitive data:

```dart
// In api_providers.dart, you can add redaction:
ISpectDioInterceptor(
  logger: ISpect.logger,
  settings: const ISpectDioInterceptorSettings(
    enableRedaction: true, // Enable automatic redaction
  ),
),
```

## Integration Details

### Files Modified

1. **`pubspec.yaml`**: Added `ispect` and `ispectify_dio` dependencies
2. **`lib/core/config/ispect_config.dart`**: Configuration for conditional initialization
3. **`lib/core/bootstrap/bootstrap.dart`**: ISpect initialization and `ISpect.run()` call
4. **`lib/core/bootstrap/app_root.dart`**: `ISpectBuilder` wrapper in MaterialApp builder
5. **`lib/data/providers/api_providers.dart`**: `ISpectDioInterceptor` integration

### Initialization Flow

1. **Bootstrap**: Checks `ISpectConfig.shouldInitialize`
2. **If enabled**: 
   - Creates `ISpectifyFlutter` logger
   - Calls `ISpect.run()` to wrap the app
3. **AppRoot**: Adds `ISpectBuilder` to MaterialApp builder
4. **Dio Provider**: Adds `ISpectDioInterceptor` if enabled

## Troubleshooting

### ISpect panel not showing

1. Check if flag is set: `--dart-define=ENABLE_ISPECT=true`
2. Verify environment: Should not be 'production'
3. Check logs: Look for ISpect initialization errors
4. Ensure MaterialApp builder includes ISpectBuilder

### Network requests not logged

1. Verify ISpect is initialized before Dio provider
2. Check if `ISpectDioInterceptor` is added to Dio interceptors
3. Ensure `ISpect.logger` is available (ISpect.run() must be called)

### Build size concerns

ISpect code is automatically tree-shaken in production builds when `ENABLE_ISPECT` is false (default). Verify:
```bash
# Build without flag (should be smaller)
flutter build apk --dart-define=ENABLE_ISPECT=false

# Build with flag (for comparison)
flutter build apk --dart-define=ENABLE_ISPECT=true
```

## Related Resources

- [ISpect Package](https://pub.dev/packages/ispect)
- [ISpect Documentation](https://github.com/K1yoshiSho/ispect)
- [ISpectify Dio Integration](https://pub.dev/packages/ispectify_dio)

## Debug Panel Integration

ISpect is deeply integrated into the custom debug panel, providing powerful debugging tools in organized tabs.

### Integrated Features

#### 1. Logs Tab Integration ✅
**File**: `lib/debug_panel/widgets/logs_tab.dart`

**Implementation**:
- Uses ISpect's `LogsScreen` widget directly via internal import
- Wraps with `ISpectBuilder`, localizations, and Navigator for proper context
- Custom wrapper hides AppBar back button while keeping search and settings
- Empty state when ISpect is disabled
- Error handling for missing context

**Features**:
- Comprehensive log viewer with categorization
- Filter by log types (http, db, route, etc.)
- Search functionality
- Log level filtering (Debug, Info, Warning, Error)
- Auto-scroll to latest logs

#### 2. Performance Tab Integration ✅
**File**: `lib/debug_panel/widgets/performance_tab.dart`

**Implementation**:
- Uses ISpect's `ISpectPerformanceOverlay` widget
- Real-time frame timing visualization
- Track/pause toggle control
- Material 3 theming integration

**Features**:
- Real-time FPS monitoring
- Frame timing breakdown (UI, Raster, High Latency)
- Performance metrics display
- Visual indicator for frames exceeding 60 FPS target

#### 3. Network Tab Integration ⚠️
**File**: `lib/debug_panel/widgets/network_tab.dart`

**Implementation**:
- Custom network simulator (not using ISpect network monitoring)
- Speed selection and failure probability controls
- Independent from ISpect network features

**Note**: Network tab uses custom implementation. ISpect's network monitoring is available through the ISpect panel itself.

### Integration Architecture

**Debug Panel + ISpect Stack**:
```
DebugPanel
  └── MaterialApp
      └── ISpectBuilder (if enabled)
          └── App Content
```

**Key Benefits**:
- ISpect works independently of debug panel
- Both can be enabled simultaneously
- ISpect's own panel available for additional tools
- Debug panel provides organized access to ISpect features
- Clean separation of concerns

### Using ISpect in Debug Panel

When the debug panel is enabled, access ISpect features:

1. **Logs**: Open Debug Panel → Logs tab → View comprehensive ISpect logs
2. **Performance**: Open Debug Panel → Performance tab → View frame timing
3. **Network**: Open Debug Panel → Network tab → Configure network simulator
4. **ISpect Panel**: Swipe or click to access full ISpect panel with additional tools

### Code Examples

#### Accessing ISpect Context
```dart
// In debug panel tabs, ISpect context is available
final ispectScope = ISpect.read(context);

// Access ISpect options
final options = ispectScope.options;
```

#### Logging from App Code
```dart
// Log to ISpect (accessible in Debug Panel Logs tab)
ISpect.logger.info('User action completed');
ISpect.logger.error('Error occurred', error);
```

## Notes

- ISpect works independently of the custom debug panel
- Both can be enabled simultaneously for comprehensive debugging
- ISpect appears on the actual app content (inside device preview frame)
- Debug panel handles device simulation and organized tool access
- ISpect provides powerful debugging tools integrated into debug panel tabs
- Network monitoring accessed via ISpect's own panel

---

**Last Updated**: January 2025  
**Status**: Fully Integrated ✅ - Logs, Performance, and Architecture Complete
