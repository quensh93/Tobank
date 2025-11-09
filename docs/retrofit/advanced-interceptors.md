# Advanced Interceptors with Retrofit

This guide covers advanced interceptor patterns for handling authentication, token refresh, and error handling in Retrofit with Dio.

## Table of Contents

- [Overview](#overview)
- [Auth Interceptor](#auth-interceptor)
- [Token Refresh Interceptor](#token-refresh-interceptor)
- [Error Interceptor](#error-interceptor)
- [Request Interceptor](#request-interceptor)
- [Complete Setup](#complete-setup)
- [Best Practices](#best-practices)

## Overview

Interceptors in Dio allow you to:
- Modify requests before they are sent
- Handle responses before they are returned
- Handle errors in a centralized way
- Implement automatic token refresh
- Add common headers
- Log requests and responses

## Auth Interceptor

Adds authentication tokens to all requests.

```dart
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final String? Function() getToken;

  AuthInterceptor({required this.getToken});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = getToken();
    
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    super.onRequest(options, handler);
  }
}
```

### Usage

```dart
dio.interceptors.add(
  AuthInterceptor(
    getToken: () => AppStorage().getAccessToken,
  ),
);
```

## Token Refresh Interceptor

Handles 401 errors and automatically refreshes tokens.

```dart
import 'package:dio/dio.dart';

class TokenRefreshInterceptor extends Interceptor {
  final Dio dio;
  final Future<String?> Function() refreshToken;
  final Future<void> Function() onTokenExpired;

  TokenRefreshInterceptor({
    required this.dio,
    required this.refreshToken,
    required this.onTokenExpired,
  });

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Check if the error is a 401 (Unauthorized)
    if (err.response?.statusCode == 401) {
      // Prevent infinite retry loops
      if (!err.requestOptions.extra.containsKey('tokenRetried')) {
        err.requestOptions.extra['tokenRetried'] = true;

        try {
          final newToken = await refreshToken();

          if (newToken != null && newToken.isNotEmpty) {
            // Update the header with the new token
            dio.options.headers['Authorization'] = 'Bearer $newToken';

            // Retry the original request
            final options = Options(
              method: err.requestOptions.method,
              headers: err.requestOptions.headers,
            );

            options.headers?['Authorization'] = 'Bearer $newToken';

            final response = await dio.fetch(
              err.requestOptions.copyWith(
                headers: options.headers,
              ),
            );
            
            return handler.resolve(response);
          } else {
            await onTokenExpired();
            return handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: 'Token refresh failed',
              ),
            );
          }
        } catch (e) {
          await onTokenExpired();
          return handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: 'Token refresh exception: $e',
            ),
          );
        }
      } else {
        await onTokenExpired();
      }
    }

    return handler.next(err);
  }
}
```

### Usage

```dart
dio.interceptors.add(
  TokenRefreshInterceptor(
    dio: dio,
    refreshToken: () async {
      // Call your refresh token API
      final response = await dio.post('/refresh-token');
      return response.data['token'];
    },
    onTokenExpired: () async {
      // Navigate to login or clear data
      AppStorage().clearData();
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/login',
        (route) => route.settings.name == '/',
      );
    },
  ),
);
```

## Error Interceptor

Handles various error scenarios and logging.

```dart
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        // Handle timeout
        break;

      case DioExceptionType.badResponse:
        switch (statusCode) {
          case 400:
            // Bad Request
            break;
          case 403:
            // Forbidden
            break;
          case 404:
            // Not Found
            break;
          case 500:
          case 502:
          case 503:
            // Server Error
            break;
        }
        break;

      case DioExceptionType.connectionError:
        // No internet
        break;

      case DioExceptionType.cancel:
        // Request cancelled
        break;
    }
    
    handler.next(err);
  }
}
```

## Request Interceptor

Adds common headers and modifies requests.

```dart
import 'dart:io';
import 'package:dio/dio.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    // Add platform-specific headers
    options.headers['API-REQUEST-FROM'] = Platform.isIOS ? 'iOS' : 'Android';
    
    // Add custom headers
    options.headers['X-App-Version'] = '1.0.0';
    
    super.onRequest(options, handler);
  }
}
```

## Complete Setup

Complete example with all interceptors:

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();

void setupDio() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.example.com/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Add interceptors in order
  dio.interceptors.add(
    RequestInterceptor(
      additionalHeaders: {
        'X-App-Version': '1.0.0',
      },
    ),
  );

  dio.interceptors.add(
    AuthInterceptor(
      getToken: () => AppStorage().getAccessToken,
    ),
  );

  dio.interceptors.add(
    TokenRefreshInterceptor(
      dio: dio,
      refreshToken: () async {
        final response = await dio.post('/refresh-token');
        final token = response.data['token'];
        AppStorage().setAccessToken(token);
        return token;
      },
      onTokenExpired: () async {
        AppStorage().clearData();
        globalNavigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/login',
          (route) => route.settings.name == '/',
        );
      },
    ),
  );

  dio.interceptors.add(ErrorInterceptor());

  // Add logging interceptor (should be last)
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
    ),
  );
}
```

## Best Practices

### 1. Interceptor Order

Add interceptors in the correct order:

```dart
// 1. Request modification (headers, etc.)
dio.interceptors.add(RequestInterceptor());

// 2. Authentication
dio.interceptors.add(AuthInterceptor());

// 3. Token refresh
dio.interceptors.add(TokenRefreshInterceptor());

// 4. Error handling
dio.interceptors.add(ErrorInterceptor());

// 5. Logging (should be last)
dio.interceptors.add(LogInterceptor());
```

### 2. Prevent Infinite Loops

Use request extras to prevent infinite retry loops:

```dart
if (!err.requestOptions.extra.containsKey('tokenRetried')) {
  err.requestOptions.extra['tokenRetried'] = true;
  // Proceed with token refresh
}
```

### 3. Centralized Error Handling

Handle errors in the error interceptor:

```dart
@override
void onError(DioException err, ErrorInterceptorHandler handler) {
  // Log error
  logger.e('API Error', err);
  
  // Handle specific errors
  if (err.type == DioExceptionType.connectionError) {
    // Show "No internet" message
  }
  
  handler.next(err);
}
```

### 4. Token Storage

Store tokens securely:

```dart
// Using flutter_secure_storage
final storage = FlutterSecureStorage();
await storage.write(key: 'accessToken', value: token);

// Retrieve
final token = await storage.read(key: 'accessToken');
```

### 5. Navigation Handling

Use a global navigator key for interceptors:

```dart
final globalNavigatorKey = GlobalKey<NavigatorState>();

// In MaterialApp
MaterialApp(
  navigatorKey: globalNavigatorKey,
  // ...
)

// In interceptor
globalNavigatorKey.currentState?.pushNamedAndRemoveUntil(
  '/login',
  (route) => false,
);
```

## Summary

Interceptors provide a powerful way to:
- Centralize authentication logic
- Handle token refresh automatically
- Implement global error handling
- Add common headers
- Log requests and responses

By using interceptors correctly, you can create a robust, maintainable network layer that handles common scenarios automatically.
