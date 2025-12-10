# API Layer Guide

## Overview

The STAC Hybrid App Framework provides a flexible API layer that supports multiple backend implementations:

- **Mock API**: Loads JSON from local assets for development and testing
- **Firebase API**: Fetches JSON from Firebase Firestore for cloud-based storage
- **Custom API**: Connects to a custom REST API backend for production use

This guide covers how to configure, use, and switch between different API modes.

## Table of Contents

1. [API Architecture](#api-architecture)
2. [Configuration](#configuration)
3. [Mock API](#mock-api)
4. [Firebase API](#firebase-api)
5. [Custom API](#custom-api)
6. [Authentication](#authentication)
7. [Offline Support](#offline-support)
8. [Caching Strategy](#caching-strategy)
9. [Error Handling](#error-handling)
10. [Best Practices](#best-practices)

## API Architecture

### Interface Design

All API implementations follow the `StacApiService` interface:

```dart
abstract class StacApiService {
  Future<Map<String, dynamic>> fetchScreen(String screenName);
  Future<Map<String, dynamic>> fetchRoute(String route);
  Future<void> refresh();
  Future<void> clearCache();
  bool isCached(String key);
  Map<String, dynamic>? getCached(String key);
}
```

### Implementation Classes

- `MockApiService`: Development and testing
- `FirebaseApiService`: Cloud-based JSON storage
- `CustomApiService`: Production REST API

## Configuration

### API Configuration Model

```dart
class ApiConfig {
  final ApiMode mode;              // mock, firebase, custom
  final String? firebaseProject;   // Firebase project ID
  final String? customApiUrl;      // Custom API base URL
  final bool enableCaching;        // Enable response caching
  final Duration cacheExpiry;      // Cache expiration time
  final Map<String, String> headers; // Additional HTTP headers
  final String? authToken;         // Authentication token
}
```

### Creating Configurations

#### Mock Configuration

```dart
final mockConfig = ApiConfig.mock(
  enableCaching: true,
  cacheExpiry: Duration(minutes: 5),
);
```

#### Firebase Configuration

```dart
final firebaseConfig = ApiConfig.firebase(
  'your-firebase-project-id',
  enableCaching: true,
  cacheExpiry: Duration(minutes: 10),
);
```

#### Custom API Configuration

```dart
final customConfig = ApiConfig.custom(
  'https://api.yourapp.com',
  enableCaching: true,
  cacheExpiry: Duration(minutes: 5),
  headers: {
    'X-API-Key': 'your-api-key',
    'X-App-Version': '1.0.0',
  },
);
```

## Mock API

### Purpose

The Mock API is ideal for:
- Development without backend dependencies
- Testing UI components
- Rapid prototyping
- Offline development

### Setup

1. Create mock data directory structure:

```
assets/mock_data/
├── screens/
│   ├── home_screen.json
│   ├── profile_screen.json
│   └── settings_screen.json
└── config/
    ├── navigation_config.json
    └── theme_config.json
```

2. Add assets to `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/mock_data/screens/
    - assets/mock_data/config/
```

### Usage

```dart
final mockApi = MockApiService(
  config: ApiConfig.mock(),
  networkDelay: Duration(milliseconds: 300), // Simulate network delay
  simulateDelay: true,
);

// Fetch a screen
final screenData = await mockApi.fetchScreen('home_screen');

// Fetch configuration
final navConfig = await mockApi.fetchConfig('navigation_config');

// Hot reload mock data
await mockApi.reloadMockData();
```

### Example Mock Data

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Home Screen"
    }
  },
  "body": {
    "type": "column",
    "children": [
      {
        "type": "text",
        "data": "Welcome to STAC!",
        "style": {
          "fontSize": 24,
          "fontWeight": "bold"
        }
      }
    ]
  }
}
```

## Firebase API

### Setup

1. Add Firebase dependencies to `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^latest
  cloud_firestore: ^latest
```

2. Initialize Firebase in your app:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

3. Configure Firestore structure:

```
Collection: stac_screens
├── home_screen
│   ├── version: 1
│   ├── updated_at: timestamp
│   └── json: { ... }
└── profile_screen
    └── ...

Collection: stac_config
├── navigation
│   └── json: { ... }
└── theme
    └── json: { ... }
```

### Usage

```dart
final firebaseApi = FirebaseApiService(
  config: ApiConfig.firebase('your-project-id'),
);

// Fetch a screen
final screenData = await firebaseApi.fetchScreen('home_screen');

// Refresh data
await firebaseApi.refresh();
```

### Security Rules

See [Firebase Integration Guide](07-firebase-integration.md) for detailed security rules.

## Custom API

### Purpose

The Custom API is designed for production use with:
- Custom REST API backends
- Token-based authentication
- Retry logic with exponential backoff
- Offline support with disk caching
- Network connectivity detection

### Setup

```dart
// Create authentication manager (optional)
final authManager = AuthManager(
  onTokenRefresh: (refreshToken) async {
    // Call your token refresh endpoint
    final response = await dio.post('/auth/refresh', data: {
      'refresh_token': refreshToken,
    });
    
    return TokenPair.fromJson(response.data);
  },
  onTokenExpired: () {
    // Handle token expiration (e.g., navigate to login)
  },
);

// Initialize auth manager
await authManager.initialize();

// Create custom API service
final customApi = CustomApiService(
  config: ApiConfig.custom(
    'https://api.yourapp.com',
    headers: {
      'X-API-Key': 'your-api-key',
    },
  ),
  authManager: authManager,
  enableOfflineSupport: true,
  maxRetries: 3,
  timeout: Duration(seconds: 30),
);
```

### API Endpoints

The Custom API expects the following endpoints:

#### Fetch Screen
```
GET /screens/{screenName}
Response: { "type": "scaffold", ... }
```

#### Fetch Route
```
GET /routes?path=/profile
Response: { "type": "scaffold", ... }
```

#### Fetch Configuration
```
GET /config/{configName}
Response: { ... }
```

### Usage

```dart
// Fetch a screen
final screenData = await customApi.fetchScreen('home_screen');

// Fetch by route
final routeData = await customApi.fetchRoute('/profile');

// Check connectivity
final isOnline = await customApi.isOnline();

// Prefetch for offline use
await customApi.prefetchForOffline([
  'home_screen',
  'profile_screen',
  'settings_screen',
]);

// Get cache statistics
final stats = await customApi.getCacheStats();
print('Memory cache: ${stats['memory_cache']['total_cached']} items');
print('Disk cache: ${stats['disk_cache']['size_mb']} MB');
```

## Authentication

### Token-Based Authentication

The Custom API supports token-based authentication with automatic token refresh.

### Setup Authentication

```dart
// Initialize AuthManager
final authManager = AuthManager(
  onTokenRefresh: (refreshToken) async {
    // Implement your token refresh logic
    final dio = Dio();
    final response = await dio.post(
      'https://api.yourapp.com/auth/refresh',
      data: {'refresh_token': refreshToken},
    );
    
    return TokenPair(
      accessToken: response.data['access_token'],
      refreshToken: response.data['refresh_token'],
      expiresAt: DateTime.now().add(
        Duration(seconds: response.data['expires_in']),
      ),
    );
  },
  onTokenExpired: () {
    // Navigate to login screen
    navigatorKey.currentState?.pushReplacementNamed('/login');
  },
);

await authManager.initialize();
```

### Login Flow

```dart
// After successful login
await authManager.saveTokens(
  accessToken: loginResponse.accessToken,
  refreshToken: loginResponse.refreshToken,
  expiresAt: DateTime.now().add(Duration(hours: 1)),
);
```

### Logout Flow

```dart
// Clear tokens on logout
await authManager.clearTokens();
```

### Checking Authentication

```dart
final isAuthenticated = await authManager.isAuthenticated();
if (!isAuthenticated) {
  // Navigate to login
}
```

## Offline Support

### How It Works

The Custom API provides offline support through:

1. **Connectivity Detection**: Checks internet availability before making requests
2. **Disk Caching**: Stores responses persistently for offline access
3. **Automatic Fallback**: Serves cached data when offline
4. **Prefetching**: Downloads screens in advance for offline use

### Enabling Offline Support

```dart
final customApi = CustomApiService(
  config: ApiConfig.custom('https://api.yourapp.com'),
  enableOfflineSupport: true, // Enable offline support
);
```

### Prefetching Content

```dart
// Prefetch critical screens for offline use
await customApi.prefetchForOffline([
  'home_screen',
  'profile_screen',
  'settings_screen',
]);
```

### Checking Offline Availability

```dart
final availability = await customApi.getOfflineAvailability([
  'home_screen',
  'profile_screen',
]);

print('Home screen available offline: ${availability['home_screen']}');
```

### Handling Offline State

```dart
try {
  final screenData = await customApi.fetchScreen('home_screen');
  // Use screen data
} on NetworkException catch (e) {
  if (e.errorType == NetworkErrorType.connection) {
    // Show offline message
    showSnackBar('You are offline. Showing cached content.');
  }
}
```

## Caching Strategy

### Two-Level Caching

The API layer uses a two-level caching strategy:

1. **Memory Cache**: Fast in-memory cache for immediate access
2. **Disk Cache**: Persistent storage for offline access

### Cache Configuration

```dart
final config = ApiConfig.custom(
  'https://api.yourapp.com',
  enableCaching: true,
  cacheExpiry: Duration(minutes: 5), // Memory cache expiry
);
```

### Cache Management

```dart
// Check if data is cached
final isCached = customApi.isCached('home_screen');

// Get cached data
final cachedData = customApi.getCached('home_screen');

// Clear all caches
await customApi.clearCache();

// Refresh data (clears cache and refetches)
await customApi.refresh();
```

### Cache Statistics

```dart
final stats = await customApi.getCacheStats();

// Memory cache stats
print('Memory cache items: ${stats['memory_cache']['total_cached']}');
print('Valid items: ${stats['memory_cache']['valid_cached']}');

// Disk cache stats
print('Disk cache size: ${stats['disk_cache']['size_mb']} MB');
print('Disk cache items: ${stats['disk_cache']['count']}');
```

## Error Handling

### Exception Types

The API layer throws specific exceptions for different error scenarios:

```dart
// Screen not found (404)
ScreenNotFoundException

// Network errors (timeout, connection, server errors)
NetworkException

// JSON parsing errors
JsonParsingException

// Cache errors
CacheException

// Generic API errors
ApiException
```

### Handling Errors

```dart
try {
  final screenData = await customApi.fetchScreen('home_screen');
} on ScreenNotFoundException catch (e) {
  print('Screen not found: ${e.screenName}');
  // Show 404 screen
} on NetworkException catch (e) {
  if (e.errorType == NetworkErrorType.timeout) {
    print('Request timed out');
    // Show retry button
  } else if (e.errorType == NetworkErrorType.connection) {
    print('No internet connection');
    // Show offline message
  } else if (e.errorType == NetworkErrorType.unauthorized) {
    print('Unauthorized');
    // Navigate to login
  }
} on JsonParsingException catch (e) {
  print('Invalid JSON: ${e.message}');
  // Show error message
} on ApiException catch (e) {
  print('API error: ${e.message}');
  // Show generic error
}
```

### Retry Logic

The Custom API automatically retries failed requests with exponential backoff:

```dart
final customApi = CustomApiService(
  config: ApiConfig.custom('https://api.yourapp.com'),
  maxRetries: 3, // Maximum retry attempts
  initialRetryDelay: Duration(milliseconds: 500), // Initial delay
);
```

Retry behavior:
- Attempt 1: Immediate
- Attempt 2: 500ms delay
- Attempt 3: 1000ms delay
- Attempt 4: 2000ms delay

Retries are triggered for:
- Connection timeouts
- Send/receive timeouts
- Connection errors
- 5xx server errors

## Switching Between API Modes

### Environment-Based Configuration

```dart
enum Environment { development, staging, production }

ApiConfig getApiConfig(Environment env) {
  switch (env) {
    case Environment.development:
      return ApiConfig.mock();
    
    case Environment.staging:
      return ApiConfig.firebase('staging-project-id');
    
    case Environment.production:
      return ApiConfig.custom('https://api.yourapp.com');
  }
}

// Usage
const environment = Environment.development; // Change as needed
final config = getApiConfig(environment);
final apiService = _createApiService(config);
```

### Runtime Switching

```dart
class ApiServiceProvider {
  StacApiService _apiService;
  
  ApiServiceProvider(ApiConfig config) 
      : _apiService = _createApiService(config);
  
  void switchMode(ApiConfig newConfig) {
    _apiService = _createApiService(newConfig);
  }
  
  StacApiService get service => _apiService;
}

// Switch from mock to custom API
apiProvider.switchMode(ApiConfig.custom('https://api.yourapp.com'));
```

### Factory Method

```dart
StacApiService _createApiService(ApiConfig config) {
  switch (config.mode) {
    case ApiMode.mock:
      return MockApiService(config: config);
    
    case ApiMode.firebase:
      return FirebaseApiService(config: config);
    
    case ApiMode.custom:
      return CustomApiService(
        config: config,
        authManager: authManager,
        enableOfflineSupport: true,
      );
  }
}
```

## Best Practices

### 1. Use Mock API for Development

Start with Mock API for rapid development:

```dart
final apiService = MockApiService(
  config: ApiConfig.mock(),
  simulateDelay: true, // Simulate realistic network delays
);
```

### 2. Enable Caching

Always enable caching for better performance:

```dart
final config = ApiConfig.custom(
  'https://api.yourapp.com',
  enableCaching: true,
  cacheExpiry: Duration(minutes: 5),
);
```

### 3. Implement Offline Support

Enable offline support for better user experience:

```dart
final customApi = CustomApiService(
  config: config,
  enableOfflineSupport: true,
);

// Prefetch critical screens
await customApi.prefetchForOffline(['home_screen', 'profile_screen']);
```

### 4. Handle Errors Gracefully

Always handle API errors appropriately:

```dart
try {
  final data = await apiService.fetchScreen('home_screen');
  return StacScreen(data: data);
} on NetworkException catch (e) {
  if (e.errorType == NetworkErrorType.connection) {
    return OfflineScreen();
  }
  return ErrorScreen(message: e.message);
} catch (e) {
  return ErrorScreen(message: 'An unexpected error occurred');
}
```

### 5. Use Authentication Manager

For production apps, use AuthManager for token management:

```dart
final authManager = AuthManager(
  onTokenRefresh: refreshTokenCallback,
  onTokenExpired: handleTokenExpiration,
);

final customApi = CustomApiService(
  config: config,
  authManager: authManager,
);
```

### 6. Monitor Cache Size

Periodically check and clean cache:

```dart
final stats = await customApi.getCacheStats();
final diskSizeMB = double.parse(stats['disk_cache']['size_mb']);

if (diskSizeMB > 50) {
  // Cache is getting large, consider clearing old data
  await diskCacheManager.cleanExpired();
}
```

### 7. Test with Different Network Conditions

Test your app with:
- No internet connection
- Slow network (use Mock API with longer delays)
- Intermittent connectivity

### 8. Use Proper Timeouts

Configure appropriate timeouts based on your use case:

```dart
final customApi = CustomApiService(
  config: config,
  timeout: Duration(seconds: 30), // Adjust based on your needs
);
```

## Troubleshooting

### Issue: Screens not loading

**Solution**: Check connectivity and cache:

```dart
final isOnline = await customApi.isOnline();
print('Online: $isOnline');

final isCached = customApi.isCached('home_screen');
print('Cached: $isCached');
```

### Issue: Authentication failures

**Solution**: Verify token validity:

```dart
final isAuthenticated = await authManager.isAuthenticated();
if (!isAuthenticated) {
  await authManager.refreshToken();
}
```

### Issue: Cache not working

**Solution**: Ensure caching is enabled:

```dart
final config = ApiConfig.custom(
  'https://api.yourapp.com',
  enableCaching: true, // Must be true
);
```

### Issue: Offline mode not working

**Solution**: Check offline support is enabled and data is prefetched:

```dart
final customApi = CustomApiService(
  config: config,
  enableOfflineSupport: true, // Must be true
);

await customApi.prefetchForOffline(['home_screen']);
```

## Next Steps

- [Mock Data Guide](06-mock-data-guide.md) - Learn how to create mock data
- [Firebase Integration](07-firebase-integration.md) - Set up Firebase backend
- [Debug Panel Guide](08-debug-panel-guide.md) - Use debug tools for API monitoring
- [Testing Guide](04-testing-guide.md) - Test your API integration

## Summary

The API layer provides a flexible, production-ready solution for fetching STAC JSON configurations. Key features include:

- Multiple backend support (Mock, Firebase, Custom)
- Token-based authentication with automatic refresh
- Offline support with disk caching
- Retry logic with exponential backoff
- Comprehensive error handling
- Easy switching between API modes

Choose the appropriate API mode for your development stage and configure it according to your needs.
