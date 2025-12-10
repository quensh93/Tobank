# Build Variants Configuration

This document describes how to build the ToBank SDUI application for different environments and configurations.

## Overview

The application supports three environments:
- **Development**: For local development with all debug features enabled
- **Staging**: For testing with production-like settings but debug features available
- **Production**: For production deployment with all debug features disabled

## Environment Configuration

Environments are configured using `--dart-define` flags at build time. The main environment variable is `ENVIRONMENT`.

### Available Environments

| Environment | API Base URL | Debug Features | Analytics | Crash Reporting |
|------------|--------------|----------------|-----------|-----------------|
| development | http://localhost:8080 | ✅ Enabled | ❌ Disabled | ❌ Disabled |
| staging | https://staging-api.tobank.com | ✅ Enabled | ✅ Enabled | ✅ Enabled |
| production | https://api.tobank.com | ❌ Disabled | ✅ Enabled | ✅ Enabled |

## Build Commands

### Development Builds

#### Run in Development Mode
```bash
flutter run --dart-define=ENVIRONMENT=development
```

#### Build APK (Android)
```bash
flutter build apk --debug --dart-define=ENVIRONMENT=development
```

#### Build iOS
```bash
flutter build ios --debug --dart-define=ENVIRONMENT=development
```

#### Build Web
```bash
flutter build web --dart-define=ENVIRONMENT=development
```

### Staging Builds

#### Run in Staging Mode
```bash
flutter run --dart-define=ENVIRONMENT=staging
```

#### Build APK (Android)
```bash
flutter build apk --release --dart-define=ENVIRONMENT=staging
```

#### Build App Bundle (Android)
```bash
flutter build appbundle --release --dart-define=ENVIRONMENT=staging
```

#### Build iOS
```bash
flutter build ios --release --dart-define=ENVIRONMENT=staging
```

#### Build Web
```bash
flutter build web --dart-define=ENVIRONMENT=staging
```

### Production Builds

#### Build APK (Android)
```bash
flutter build apk --release --dart-define=ENVIRONMENT=production
```

#### Build App Bundle (Android)
```bash
flutter build appbundle --release --dart-define=ENVIRONMENT=production
```

#### Build iOS
```bash
flutter build ios --release --dart-define=ENVIRONMENT=production
```

#### Build Web
```bash
flutter build web --dart-define=ENVIRONMENT=production
```

## Feature Flag Overrides

Individual feature flags can be overridden at build time using additional `--dart-define` flags:

```bash
# Enable debug panel in production (for testing)
flutter build apk --release \
  --dart-define=ENVIRONMENT=production \
  --dart-define=DEBUG_PANEL=true

# Disable playground in development
flutter run \
  --dart-define=ENVIRONMENT=development \
  --dart-define=PLAYGROUND=false

# Enable mock API in staging
flutter build apk --release \
  --dart-define=ENVIRONMENT=staging \
  --dart-define=MOCK_API=true
```

### Available Feature Flag Overrides

| Flag | Description | Default (Dev) | Default (Staging) | Default (Prod) |
|------|-------------|---------------|-------------------|----------------|
| DEBUG_PANEL | Enable debug panel | true | true | false |
| PLAYGROUND | Enable JSON playground | true | true | false |
| VISUAL_EDITOR | Enable visual JSON editor | true | false | false |
| STAC_LOGS | Enable STAC logs tab | true | true | false |
| PERFORMANCE_MONITORING | Enable performance monitoring | true | true | false |
| MOCK_API | Enable mock API mode | true | false | false |
| FIREBASE_API | Enable Firebase API mode | true | true | false |
| CUSTOM_API | Enable custom API mode | true | true | true |
| HOT_RELOAD | Enable hot reload for mock data | true | false | false |
| JSON_VALIDATION | Enable JSON validation | true | true | true |
| CACHING | Enable caching | true | true | true |
| OFFLINE_MODE | Enable offline mode | true | true | true |
| ANALYTICS | Enable analytics | false | true | true |
| CRASH_REPORTING | Enable crash reporting | false | true | true |
| EXPERIMENTAL_FEATURES | Enable experimental features | true | false | false |
| VERBOSE_LOGGING | Enable verbose logging | true | false | false |
| NETWORK_SIMULATION | Enable network simulation | true | false | false |
| FIREBASE_CLI | Enable Firebase CLI tools | true | true | false |
| FIREBASE_CRUD | Enable Firebase CRUD interface | true | true | false |

## Custom Configuration

You can also override other configuration values:

```bash
# Custom app name
flutter build apk --release \
  --dart-define=ENVIRONMENT=production \
  --dart-define=APP_NAME="ToBank Custom"

# Custom bundle ID
flutter build apk --release \
  --dart-define=ENVIRONMENT=production \
  --dart-define=BUNDLE_ID=com.tobank.custom
```

## Build Scripts

For convenience, you can create build scripts for common configurations:

### build_dev.sh (Linux/Mac)
```bash
#!/bin/bash
flutter build apk --debug --dart-define=ENVIRONMENT=development
```

### build_staging.sh (Linux/Mac)
```bash
#!/bin/bash
flutter build apk --release --dart-define=ENVIRONMENT=staging
```

### build_prod.sh (Linux/Mac)
```bash
#!/bin/bash
flutter build apk --release --dart-define=ENVIRONMENT=production
```

### build_dev.bat (Windows)
```batch
@echo off
flutter build apk --debug --dart-define=ENVIRONMENT=development
```

### build_staging.bat (Windows)
```batch
@echo off
flutter build apk --release --dart-define=ENVIRONMENT=staging
```

### build_prod.bat (Windows)
```batch
@echo off
flutter build apk --release --dart-define=ENVIRONMENT=production
```

## Verifying Build Configuration

To verify the build configuration at runtime, you can use the `BuildConfig` class:

```dart
import 'package:tobank_sdui/core/config/build_config.dart';

void main() {
  // Print configuration
  BuildConfig.printConfig();
  
  // Access configuration
  print('Environment: ${BuildConfig.environment.environment.name}');
  print('Debug Panel Enabled: ${BuildConfig.features.isDebugPanelEnabled}');
  
  runApp(MyApp());
}
```

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Build and Deploy

on:
  push:
    branches: [main, develop, staging]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.9.0'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Build Development APK
        if: github.ref == 'refs/heads/develop'
        run: flutter build apk --debug --dart-define=ENVIRONMENT=development
      
      - name: Build Staging APK
        if: github.ref == 'refs/heads/staging'
        run: flutter build apk --release --dart-define=ENVIRONMENT=staging
      
      - name: Build Production APK
        if: github.ref == 'refs/heads/main'
        run: flutter build apk --release --dart-define=ENVIRONMENT=production
```

### GitLab CI Example

```yaml
stages:
  - build

build_dev:
  stage: build
  script:
    - flutter pub get
    - flutter build apk --debug --dart-define=ENVIRONMENT=development
  only:
    - develop

build_staging:
  stage: build
  script:
    - flutter pub get
    - flutter build apk --release --dart-define=ENVIRONMENT=staging
  only:
    - staging

build_prod:
  stage: build
  script:
    - flutter pub get
    - flutter build apk --release --dart-define=ENVIRONMENT=production
  only:
    - main
```

## Platform-Specific Configuration

### Android

For Android-specific configuration, you can modify `android/app/build.gradle`:

```gradle
android {
    defaultConfig {
        // ...
    }
    
    buildTypes {
        debug {
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
        }
        release {
            // Production configuration
        }
    }
    
    flavorDimensions "environment"
    productFlavors {
        development {
            dimension "environment"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
        }
        staging {
            dimension "environment"
            applicationIdSuffix ".staging"
            versionNameSuffix "-staging"
        }
        production {
            dimension "environment"
        }
    }
}
```

### iOS

For iOS-specific configuration, you can create different schemes in Xcode or use different configurations in `ios/Runner.xcodeproj`.

## Troubleshooting

### Issue: Environment not detected correctly

**Solution**: Make sure you're using the correct `--dart-define` syntax:
```bash
# Correct
flutter run --dart-define=ENVIRONMENT=development

# Incorrect
flutter run --dart-define ENVIRONMENT=development
```

### Issue: Feature flags not working

**Solution**: Verify that you're using `FeatureFlags.currentWithOverrides` instead of `FeatureFlags.current` to get overridden values.

### Issue: Build fails with environment errors

**Solution**: Ensure all required environment variables are set. Check `EnvironmentConfig` and `FeatureFlags` classes for required values.

## Best Practices

1. **Always specify environment**: Never rely on default environment for production builds
2. **Use build scripts**: Create reusable build scripts for common configurations
3. **Test before deploying**: Always test staging builds before deploying to production
4. **Document custom flags**: If you add custom feature flags, document them in this file
5. **Version control**: Keep build scripts in version control
6. **CI/CD automation**: Automate builds using CI/CD pipelines
7. **Verify configuration**: Always verify build configuration before deployment

## Additional Resources

- [Environment Configuration](lib/core/config/environment_config.dart)
- [Feature Flags](lib/core/config/feature_flags.dart)
- [Build Config](lib/core/config/build_config.dart)
- [Flutter Build Documentation](https://docs.flutter.dev/deployment)
