# Firebase Integration Guide

## Overview

This guide explains how to integrate Firebase with the STAC Hybrid App Framework for cloud-based JSON storage and retrieval. Firebase provides a scalable, real-time database solution that allows you to update your app's UI without releasing new versions.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Firebase Setup](#firebase-setup)
3. [FlutterFire Configuration](#flutterfire-configuration)
4. [Firestore Data Structure](#firestore-data-structure)
5. [Security Rules](#security-rules)
6. [Using FirebaseApiService](#using-firebaseapiservice)
7. [Refresh Mechanism](#refresh-mechanism)
8. [Error Handling](#error-handling)
9. [Best Practices](#best-practices)
10. [Troubleshooting](#troubleshooting)

## Prerequisites

Before integrating Firebase, ensure you have:

- A Firebase account (free tier is sufficient for development)
- Flutter SDK installed and configured
- Basic understanding of Firestore database concepts
- Admin access to your Firebase project

## Firebase Setup

### Step 1: Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or select an existing project
3. Follow the setup wizard:
   - Enter a project name (e.g., "tobank-sdui")
   - Enable/disable Google Analytics (optional)
   - Accept terms and create project

### Step 2: Enable Firestore Database

1. In the Firebase Console, navigate to **Build > Firestore Database**
2. Click "Create database"
3. Choose a location (select the region closest to your users)
4. Start in **test mode** for development (we'll add security rules later)
5. Click "Enable"

### Step 3: Register Your App

#### For Android:
1. Click the Android icon in Project Overview
2. Enter your package name (e.g., `com.example.tobankSdui`)
3. Download `google-services.json`
4. Place it in `android/app/` directory

#### For iOS:
1. Click the iOS icon in Project Overview
2. Enter your bundle ID (e.g., `com.example.tobankSdui`)
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory

#### For Web:
1. Click the Web icon in Project Overview
2. Register your app
3. Copy the Firebase configuration (you'll use this in FlutterFire CLI)

## FlutterFire Configuration

### Step 1: Install FlutterFire CLI

```bash
# Install FlutterFire CLI globally
dart pub global activate flutterfire_cli
```

### Step 2: Configure Firebase for Your App

```bash
# Run the configuration command
flutterfire configure

# Follow the prompts:
# 1. Select your Firebase project
# 2. Select platforms (Android, iOS, Web, etc.)
# 3. The CLI will generate firebase_options.dart
```

This command will:
- Generate `lib/core/bootstrap/firebase_options.dart` with your project configuration
- Update platform-specific files (AndroidManifest.xml, Info.plist, etc.)
- Configure Firebase for all selected platforms

### Step 3: Verify Installation

The generated `firebase_options.dart` should look like this:

```dart
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      // ... other platforms
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    appId: 'YOUR_APP_ID',
    messagingSenderId: 'YOUR_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    // ... other config
  );
  
  // ... platform-specific configurations
}
```

## Firestore Data Structure

### Collections

The STAC framework uses the following Firestore collections:

#### 1. `stac_screens` Collection

Stores individual screen configurations.

**Document Structure:**
```json
{
  "version": 1,
  "updated_at": "2024-01-15T10:30:00Z",
  "description": "Home screen with featured products",
  "tags": ["home", "featured"],
  "json": {
    "type": "scaffold",
    "appBar": {
      "type": "appBar",
      "title": {
        "type": "text",
        "data": "Home"
      }
    },
    "body": {
      "type": "column",
      "children": [
        {
          "type": "text",
          "data": "Welcome to ToBank SDUI"
        }
      ]
    }
  }
}
```

**Required Fields:**
- `version` (int): Version number, incremented on each update
- `updated_at` (timestamp): Last update timestamp
- `json` (map): The STAC JSON configuration

**Optional Fields:**
- `description` (string): Human-readable description
- `tags` (array): Tags for categorization
- `created_at` (timestamp): Creation timestamp
- `created_by` (string): User who created the screen

#### 2. `stac_config` Collection

Stores app-wide configurations (navigation, theme, etc.).

**Document Structure:**
```json
{
  "updated_at": "2024-01-15T10:30:00Z",
  "json": {
    "routes": {
      "/": "home_screen",
      "/profile": "profile_screen",
      "/settings": "settings_screen"
    }
  }
}
```

#### 3. `stac_versions` Collection (Optional)

Stores version history for rollback capabilities.

**Document Structure:**
```json
{
  "screen_name": "home_screen",
  "version": 1,
  "timestamp": "2024-01-15T10:30:00Z",
  "json": { /* previous version JSON */ },
  "changed_by": "admin@example.com"
}
```

### Creating Sample Data

Use the Firebase Console to create sample data:

1. Go to **Firestore Database** in Firebase Console
2. Click "Start collection"
3. Collection ID: `stac_screens`
4. Add a document:
   - Document ID: `home_screen`
   - Add fields as shown in the structure above

## Security Rules

### Deploying Security Rules

The project includes a `firestore.rules` file with comprehensive security rules.

**Deploy the rules:**

```bash
# Install Firebase CLI if not already installed
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize Firebase in your project (if not done)
firebase init firestore

# Deploy security rules
firebase deploy --only firestore:rules
```

### Understanding the Security Rules

The security rules implement the following access control:

#### Read Access
- **Authenticated users** can read all screens and configurations
- This allows the app to fetch UI configurations

#### Write Access
- **Only admins** can create, update, or delete screens
- Admin status is determined by custom claims in Firebase Auth

#### Validation
- All writes are validated for correct structure
- Version numbers must be incremented sequentially
- Required fields must be present

### Setting Up Admin Users

To grant admin access to a user:

```javascript
// Use Firebase Admin SDK (Node.js)
const admin = require('firebase-admin');

admin.initializeApp();

// Set custom claims for admin user
admin.auth().setCustomUserClaims('USER_UID', { admin: true })
  .then(() => {
    console.log('Admin claims set successfully');
  });
```

## Using FirebaseApiService

### Step 1: Configure API Mode

Update your API configuration to use Firebase:

```dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tobank_sdui/core/api/providers/api_config_provider.dart';

// In your app initialization or settings screen
ref.read(apiConfigNotifierProvider.notifier).useFirebaseApi('your-project-id');
```

### Step 2: Fetch Screens

The `FirebaseApiService` is automatically used when Firebase mode is enabled:

```dart
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tobank_sdui/core/api/providers/stac_api_service_provider.dart';

class MyScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenAsync = ref.watch(fetchScreenProvider('home_screen'));
    
    return screenAsync.when(
      data: (screenData) {
        // Render the screen using STAC
        return StacService.fromJson(screenData, context);
      },
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

### Step 3: Using RefreshableStacScreen Widget

For screens with pull-to-refresh:

```dart
import 'package:tobank_sdui/core/api/widgets/refreshable_stac_screen.dart';

class MyRefreshableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshableStacScreen(
      screenName: 'home_screen',
      builder: (context, screenData) {
        return StacService.fromJson(screenData, context);
      },
      onRefresh: () {
        print('Screen refreshed!');
      },
    );
  }
}
```

## Refresh Mechanism

### Manual Refresh

Trigger a manual refresh of all cached data:

```dart
// Using the refresh notifier
await ref.read(apiRefreshNotifierProvider.notifier).refresh();

// Invalidate specific screen
ref.invalidate(fetchScreenProvider('home_screen'));
```

### Pull-to-Refresh

Use the `RefreshableStacScreen` widget (shown above) for automatic pull-to-refresh support.

### Clear Cache

Clear all cached data without refetching:

```dart
await ref.read(apiRefreshNotifierProvider.notifier).clearCache();
```

## Error Handling

### Common Errors

#### 1. Permission Denied

**Error:** `FirebaseException: permission-denied`

**Cause:** User doesn't have permission to read/write data

**Solution:**
- Ensure user is authenticated
- Check security rules
- Verify admin claims for write operations

#### 2. Screen Not Found

**Error:** `ScreenNotFoundException: Screen "xyz" was not found`

**Cause:** Document doesn't exist in Firestore

**Solution:**
- Verify the screen name is correct
- Check if the document exists in Firebase Console
- Create the document if missing

#### 3. Network Timeout

**Error:** `NetworkException: Request timed out`

**Cause:** Network connection is slow or unavailable

**Solution:**
- Check internet connection
- The service automatically returns stale cache if available
- Implement retry logic in your UI

#### 4. Invalid JSON Structure

**Error:** `JsonParsingException: Invalid JSON data type`

**Cause:** JSON data in Firestore is malformed

**Solution:**
- Validate JSON structure before uploading
- Use the CLI validation tool (coming in Task 13)
- Check the "json" field exists and is a map

### Error Recovery

The `FirebaseApiService` implements automatic error recovery:

1. **Stale Cache Fallback:** Returns expired cache data if network fails
2. **Timeout Handling:** 10-second timeout with automatic fallback
3. **Retry Logic:** Implement retry in your UI using the refresh mechanism

## Best Practices

### 1. Caching Strategy

```dart
// Configure cache expiry based on your needs
ref.read(apiConfigNotifierProvider.notifier).updateCachingSettings(
  enableCaching: true,
  cacheExpiry: Duration(minutes: 10), // Adjust based on update frequency
);
```

### 2. Offline Support

The service automatically provides offline support through caching:

- First load fetches from Firebase
- Subsequent loads use cache if valid
- Network errors return stale cache
- Manual refresh forces refetch

### 3. Version Management

Always increment version numbers when updating screens:

```javascript
// In Firebase Console or CLI
{
  "version": 2,  // Increment from 1
  "updated_at": FieldValue.serverTimestamp(),
  "json": { /* updated JSON */ }
}
```

### 4. Testing

Test with different network conditions:

```dart
// Use mock API for offline testing
ref.read(apiConfigNotifierProvider.notifier).useMockApi();

// Switch back to Firebase for online testing
ref.read(apiConfigNotifierProvider.notifier).useFirebaseApi('project-id');
```

### 5. Monitoring

Monitor Firebase usage in the Firebase Console:

- **Firestore Usage:** Check read/write counts
- **Performance:** Monitor query performance
- **Errors:** Review error logs in Firebase Console

## Troubleshooting

### Issue: Firebase not initializing

**Symptoms:** App crashes on startup with Firebase error

**Solutions:**
1. Verify `firebase_options.dart` is generated correctly
2. Check platform-specific configuration files
3. Ensure Firebase packages are in `pubspec.yaml`
4. Run `flutter clean` and rebuild

### Issue: Security rules blocking access

**Symptoms:** Permission denied errors

**Solutions:**
1. Check if user is authenticated
2. Verify security rules are deployed
3. Test with test mode rules temporarily
4. Check admin claims for write operations

### Issue: Slow performance

**Symptoms:** Screens take long to load

**Solutions:**
1. Enable caching with appropriate expiry
2. Optimize JSON structure (reduce nesting)
3. Use indexes for complex queries
4. Consider CDN for static assets

### Issue: Data not updating

**Symptoms:** Changes in Firebase not reflected in app

**Solutions:**
1. Clear cache: `ref.read(apiRefreshNotifierProvider.notifier).clearCache()`
2. Check cache expiry settings
3. Verify version number is incremented
4. Force refresh in the app

## Next Steps

- **Task 5:** Implement Custom API Service for production
- **Task 13:** Use Firebase CLI tool for managing JSON
- **Task 14:** Use Firebase CRUD web interface for easier management

## Additional Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firestore Security Rules](https://firebase.google.com/docs/firestore/security/get-started)
- [Firebase Console](https://console.firebase.google.com/)

## Support

For issues or questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review Firebase Console logs
3. Check the STAC logs in the debug panel
4. Refer to the main [STAC documentation](../stac/)
