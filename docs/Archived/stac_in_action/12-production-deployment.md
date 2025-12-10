# Production Deployment Guide

This guide covers everything you need to know about deploying the STAC Hybrid App Framework to production environments.

## Table of Contents

1. [Pre-Deployment Checklist](#pre-deployment-checklist)
2. [Environment Configuration](#environment-configuration)
3. [Build Process](#build-process)
4. [Security Considerations](#security-considerations)
5. [Performance Optimization](#performance-optimization)
6. [Error Monitoring](#error-monitoring)
7. [Deployment Strategies](#deployment-strategies)
8. [Post-Deployment Verification](#post-deployment-verification)
9. [Rollback Procedures](#rollback-procedures)
10. [Troubleshooting](#troubleshooting)

## Pre-Deployment Checklist

Before deploying to production, ensure you have completed the following:

### Code Quality
- [ ] All tests pass (`flutter test`)
- [ ] Code analysis passes (`flutter analyze`)
- [ ] Custom lint rules pass (`dart run custom_lint`)
- [ ] No debug code or console logs in production code
- [ ] All TODOs and FIXMEs are resolved or documented

### Configuration
- [ ] Environment configuration is set to production
- [ ] Feature flags are configured correctly for production
- [ ] Debug features are disabled
- [ ] API endpoints point to production servers
- [ ] Firebase project is set to production
- [ ] API keys and secrets are stored securely

### Security
- [ ] All API calls use HTTPS
- [ ] Input validation is implemented
- [ ] Sensitive data is encrypted
- [ ] Firebase security rules are configured
- [ ] Authentication is properly implemented
- [ ] No hardcoded credentials in code

### Performance
- [ ] App startup time is acceptable (< 3 seconds)
- [ ] JSON parsing is optimized
- [ ] Images are optimized and compressed
- [ ] Caching is properly configured
- [ ] Memory leaks are fixed

### Documentation
- [ ] README is up to date
- [ ] API documentation is complete
- [ ] Deployment procedures are documented
- [ ] Known issues are documented
- [ ] Changelog is updated

### Testing
- [ ] Unit tests pass
- [ ] Widget tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed
- [ ] Performance testing completed
- [ ] Security testing completed

## Environment Configuration

### Setting Up Production Environment

1. **Create production configuration**

```dart
// lib/core/config/environment_config.dart
factory EnvironmentConfig.production() {
  return const EnvironmentConfig(
    environment: Environment.production,
    apiBaseUrl: 'https://api.tobank.com',
    firebaseProjectId: 'tobank-sdui-prod',
    enableDebugFeatures: false,
    enableLogging: true,
    logLevel: 'error',
    apiTimeoutSeconds: 30,
    cacheExpiryMinutes: 30,
    enableAnalytics: true,
    enableCrashReporting: true,
    appVersion: '1.0.0',
    buildNumber: 'prod',
  );
}
```

2. **Configure feature flags**

```dart
// lib/core/config/feature_flags.dart
factory FeatureFlags.production() {
  return const FeatureFlags(
    isDebugPanelEnabled: false,
    isPlaygroundEnabled: false,
    isVisualEditorEnabled: false,
    isStacLogsEnabled: false,
    isPerformanceMonitoringEnabled: false,
    isMockApiEnabled: false,
    isFirebaseApiEnabled: false,
    isCustomApiEnabled: true,
    // ... other flags
  );
}
```

3. **Verify configuration**

```dart
void main() {
  // Print configuration to verify
  BuildConfig.printConfig();
  
  // Ensure production environment
  assert(BuildConfig.environment.isProduction, 'Must be production environment');
  assert(!BuildConfig.features.isDebugPanelEnabled, 'Debug panel must be disabled');
  
  runApp(MyApp());
}
```

## Build Process

### Android Production Build

#### 1. Update Version Information

Edit `pubspec.yaml`:
```yaml
version: 1.0.0+1  # version+build_number
```

#### 2. Configure Signing

Create `android/key.properties`:
```properties
storePassword=<your-store-password>
keyPassword=<your-key-password>
keyAlias=<your-key-alias>
storeFile=<path-to-keystore>
```

Update `android/app/build.gradle`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

#### 3. Build APK

```bash
flutter build apk --release --dart-define=ENVIRONMENT=production
```

#### 4. Build App Bundle (Recommended for Play Store)

```bash
flutter build appbundle --release --dart-define=ENVIRONMENT=production
```

### iOS Production Build

#### 1. Update Version Information

Edit `pubspec.yaml` (same as Android).

#### 2. Configure Signing in Xcode

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select the Runner project
3. Go to Signing & Capabilities
4. Select your team and provisioning profile
5. Ensure "Automatically manage signing" is enabled

#### 3. Build for Release

```bash
flutter build ios --release --dart-define=ENVIRONMENT=production
```

#### 4. Archive and Upload

1. Open Xcode
2. Product → Archive
3. Upload to App Store Connect

### Web Production Build

```bash
flutter build web --release --dart-define=ENVIRONMENT=production
```

Deploy the `build/web` directory to your web server.

## Security Considerations

### 1. API Security

**Enforce HTTPS:**
```dart
class SecureApiService {
  SecureApiService() {
    // Force HTTPS
    if (!apiBaseUrl.startsWith('https://')) {
      throw Exception('API must use HTTPS in production');
    }
  }
}
```

**Implement Certificate Pinning (Optional):**
```dart
(_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = 
    (client) {
  client.badCertificateCallback = 
      (X509Certificate cert, String host, int port) {
    // Verify certificate
    return cert.sha1.toString() == expectedCertificateHash;
  };
  return client;
};
```

### 2. Data Protection

**Secure Storage:**
```dart
// Use flutter_secure_storage for sensitive data
final storage = FlutterSecureStorage();
await storage.write(key: 'api_key', value: apiKey);
```

**Input Validation:**
```dart
// Validate all user inputs
String sanitizeInput(String input) {
  return input
      .replaceAll(RegExp(r'[<>]'), '')
      .replaceAll(RegExp(r'javascript:', caseSensitive: false), '');
}
```

### 3. Firebase Security

**Firestore Rules:**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /stac_screens/{screen} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
                     request.auth.token.admin == true;
    }
  }
}
```

### 4. Code Obfuscation

Build with obfuscation:
```bash
flutter build apk --release --obfuscate --split-debug-info=build/debug-info
```

## Performance Optimization

### 1. Enable Caching

```dart
final cacheManager = CacheManager(
  cacheExpiryMinutes: 30,
  maxCacheSize: 50 * 1024 * 1024, // 50 MB
);
```

### 2. Optimize Images

- Use WebP format for images
- Compress images before bundling
- Use cached network images

### 3. Lazy Loading

```dart
// Load critical content first
final criticalContent = await apiService.fetchCriticalContent(screenName);

// Lazy load non-critical content
apiService.fetchNonCriticalContent(screenName).then((content) {
  // Update UI when ready
});
```

### 4. Code Splitting

Use deferred loading for large features:
```dart
import 'package:tobank_sdui/features/large_feature.dart' deferred as large_feature;

// Load when needed
await large_feature.loadLibrary();
```

## Error Monitoring

### 1. Initialize Error Logging

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize error logging
  await ProductionErrorLogger.initialize();
  
  runApp(MyApp());
}
```

### 2. Log Errors

```dart
try {
  // Your code
} catch (e, stackTrace) {
  ProductionErrorLogger.instance.logError(
    e,
    stackTrace: stackTrace,
    severity: ErrorSeverity.error,
    context: ErrorContext(
      screenName: 'HomeScreen',
      feature: 'user_profile',
    ),
  );
}
```

### 3. Set User Context

```dart
ProductionErrorLogger.instance.setUserContext(
  userId: user.id,
  email: user.email,
  username: user.username,
);
```

### 4. Add Breadcrumbs

```dart
ProductionErrorLogger.instance.addBreadcrumb(
  message: 'User navigated to profile',
  category: 'navigation',
  data: {'screen': 'profile'},
);
```

### 5. Integration with Monitoring Services

**Sentry Integration:**
```yaml
# pubspec.yaml
dependencies:
  sentry_flutter: ^7.0.0
```

```dart
import 'package:sentry_flutter/sentry_flutter.dart';

await SentryFlutter.init(
  (options) {
    options.dsn = 'your-sentry-dsn';
    options.environment = 'production';
    options.tracesSampleRate = 1.0;
  },
  appRunner: () => runApp(MyApp()),
);
```

**Firebase Crashlytics Integration:**
```yaml
# pubspec.yaml
dependencies:
  firebase_crashlytics: ^3.0.0
```

```dart
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
PlatformDispatcher.instance.onError = (error, stack) {
  FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  return true;
};
```

## Deployment Strategies

### 1. Blue-Green Deployment

Deploy new version alongside old version, then switch traffic:

1. Deploy new version to staging
2. Test thoroughly
3. Deploy to production (new environment)
4. Switch traffic to new environment
5. Monitor for issues
6. Keep old environment for quick rollback

### 2. Canary Deployment

Gradually roll out to users:

1. Deploy to 5% of users
2. Monitor metrics
3. Increase to 25% if stable
4. Increase to 50% if stable
5. Deploy to 100% if stable

### 3. Feature Flags

Use feature flags for gradual rollout:

```dart
if (FeatureFlags.current.isNewFeatureEnabled) {
  // Show new feature
} else {
  // Show old feature
}
```

### 4. App Store Deployment

**Google Play Store:**
1. Build app bundle
2. Upload to Play Console
3. Create release
4. Roll out to production track
5. Monitor crash reports

**Apple App Store:**
1. Build and archive in Xcode
2. Upload to App Store Connect
3. Submit for review
4. Release when approved

## Post-Deployment Verification

### 1. Smoke Tests

Run basic smoke tests after deployment:

- [ ] App launches successfully
- [ ] User can log in
- [ ] Main features work
- [ ] API calls succeed
- [ ] No critical errors in logs

### 2. Monitor Metrics

Track key metrics:

- **Performance:**
  - App startup time
  - API response time
  - Screen load time
  - Memory usage

- **Errors:**
  - Crash rate
  - Error rate
  - API failure rate

- **User Engagement:**
  - Active users
  - Session duration
  - Feature usage

### 3. User Feedback

Monitor user feedback:

- App store reviews
- In-app feedback
- Support tickets
- Social media

## Rollback Procedures

### 1. Immediate Rollback

If critical issues are detected:

**Mobile Apps:**
1. Revert to previous version in app stores
2. Force update users if necessary
3. Communicate with users

**Web:**
1. Redeploy previous version
2. Clear CDN cache
3. Verify rollback

### 2. Gradual Rollback

If issues affect some users:

1. Reduce rollout percentage
2. Investigate issues
3. Fix and redeploy
4. Resume rollout

### 3. Data Rollback

If data migration fails:

1. Stop all writes
2. Restore from backup
3. Verify data integrity
4. Resume operations

## Troubleshooting

### Common Issues

#### Issue: App crashes on startup

**Diagnosis:**
- Check crash logs
- Verify environment configuration
- Check API connectivity

**Solution:**
```dart
try {
  await initializeApp();
} catch (e, stackTrace) {
  // Log error
  ProductionErrorLogger.instance.logError(e, stackTrace: stackTrace);
  // Show error screen
  runApp(ErrorApp(error: e));
}
```

#### Issue: API calls fail

**Diagnosis:**
- Check network connectivity
- Verify API endpoint
- Check authentication

**Solution:**
```dart
try {
  final response = await apiService.fetchData();
} on NetworkException catch (e) {
  // Show offline message
  showOfflineMessage();
} on AuthException catch (e) {
  // Redirect to login
  navigateToLogin();
}
```

#### Issue: Performance degradation

**Diagnosis:**
- Profile app performance
- Check memory usage
- Analyze network calls

**Solution:**
- Enable caching
- Optimize images
- Reduce API calls
- Use lazy loading

#### Issue: High crash rate

**Diagnosis:**
- Review crash logs
- Identify common patterns
- Check specific devices/OS versions

**Solution:**
- Fix critical bugs
- Add error handling
- Test on affected devices
- Deploy hotfix

## Best Practices

### 1. Version Control

- Tag releases in Git
- Maintain changelog
- Document breaking changes

### 2. Testing

- Test on real devices
- Test different OS versions
- Test different screen sizes
- Test offline scenarios

### 3. Monitoring

- Set up alerts for critical metrics
- Monitor error rates
- Track performance metrics
- Review logs regularly

### 4. Communication

- Notify users of updates
- Communicate downtime
- Respond to feedback
- Document known issues

### 5. Continuous Improvement

- Review deployment process
- Learn from incidents
- Update documentation
- Automate where possible

## Deployment Checklist

Use this checklist for each production deployment:

### Pre-Deployment
- [ ] Code review completed
- [ ] All tests pass
- [ ] Security audit completed
- [ ] Performance testing completed
- [ ] Staging deployment successful
- [ ] Rollback plan prepared
- [ ] Team notified

### Deployment
- [ ] Build production artifacts
- [ ] Verify build configuration
- [ ] Deploy to production
- [ ] Verify deployment
- [ ] Run smoke tests
- [ ] Monitor metrics

### Post-Deployment
- [ ] Verify all features work
- [ ] Check error logs
- [ ] Monitor performance
- [ ] Review user feedback
- [ ] Update documentation
- [ ] Notify stakeholders

## Additional Resources

- [Build Variants Configuration](../../BUILD_VARIANTS.md)
- [Environment Configuration](../../lib/core/config/environment_config.dart)
- [Feature Flags](../../lib/core/config/feature_flags.dart)
- [Production Error Logger](../../lib/core/logging/production_error_logger.dart)
- [Flutter Deployment Documentation](https://docs.flutter.dev/deployment)
- [Firebase Documentation](https://firebase.google.com/docs)

## Support

For deployment issues or questions:

1. Check this documentation
2. Review error logs
3. Check known issues
4. Contact development team
5. Create incident report

---

**Last Updated:** 2025-01-11  
**Version:** 1.0.0
