# fpdart + Retrofit Integration Guide

This guide shows you how to integrate **fpdart** with **Retrofit** to create type-safe, functional HTTP clients with proper error handling.

## Table of Contents

- [Overview](#overview)
- [Why Use fpdart with Retrofit?](#why-use-fpdart-with-retrofit)
- [Setup](#setup)
- [Basic Integration](#basic-integration)
- [Error Handling with TaskEither](#error-handling-with-taskeither)
- [API Service Example](#api-service-example)
- [Providers with Riverpod](#providers-with-riverpod)
- [Complete Example](#complete-example)
- [Best Practices](#best-practices)

## Overview

**fpdart** provides functional programming types for Dart, while **Retrofit** generates type-safe HTTP clients. Together, they enable:

- ✅ Type-safe API calls
- ✅ Functional error handling (instead of Exceptions)
- ✅ Composable async operations
- ✅ Null-safe operations with Option
- ✅ Chain operations with Either and TaskEither

## Why Use fpdart with Retrofit?

### Without fpdart:
```dart
try {
  final response = await apiService.getUser(userId);
  return response.data;
} catch (e) {
  // Handle exception
  return null;
}
```

### With fpdart:
```dart
TaskEither<String, User> getUser(int userId) {
  return TaskEither.tryCatch(
    () async => await apiService.getUser(userId).data,
    (error, stackTrace) => 'Failed to fetch user: $error',
  );
}

// Chain operations easily
final result = getUser(1)
  .flatMap((user) => getUserPosts(user.id))
  .flatMap((posts) => TaskEither.of(posts.first));
```

## Setup

### 1. Add Dependencies

```yaml
dependencies:
  fpdart: ^1.1.1
  retrofit: ^4.7.3
  dio: ^5.7.0
  
dev_dependencies:
  retrofit_generator: ^10.0.0
  build_runner: ^2.4.0
```

### 2. Install Dependencies

```bash
flutter pub get
```

## Basic Integration

### Create Your API Service

```dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://api.example.com/')
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @GET('/users/{id}')
  Future<HttpResponse<User>> getUser(@Path('id') int id);

  @GET('/users')
  Future<HttpResponse<List<User>>> getUsers();

  @POST('/users')
  Future<HttpResponse<User>> createUser(@Body() Map<String, dynamic> user);
}
```

### Generate the API Client

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Error Handling with TaskEither

### Convert Retrofit Responses to TaskEither

```dart
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'api_service.dart';

// Helper function to convert API calls to TaskEither
TaskEither<String, T> safeApiCall<T>(
  Future<T> Function() apiCall, {
  String Function(Object error, StackTrace stackTrace)? onError,
}) {
  return TaskEither.tryCatch(
    () async => await apiCall(),
    onError ?? (error, stackTrace) => error.toString(),
  );
}

// Usage
TaskEither<String, User> getUser(int userId) {
  return safeApiCall(
    () async => await apiService.getUser(userId).data,
    onError: (error, stackTrace) {
      if (error is DioException) {
        return 'Network error: ${error.message}';
      }
      return 'Failed to fetch user: $error';
    },
  );
}
```

### Better Error Handling with Specific Error Types

```dart
// Define error types
sealed class ApiError {}
class NetworkError extends ApiError {
  final String message;
  NetworkError(this.message);
}
class NotFoundError extends ApiError {
  final String message;
  NotFoundError(this.message);
}
class ValidationError extends ApiError {
  final String message;
  ValidationError(this.message);
}

// Handle different error types
TaskEither<ApiError, T> safeApiCall<T>(
  Future<T> Function() apiCall,
) {
  return TaskEither.tryCatch(
    () async => await apiCall(),
    (error, stackTrace) {
      if (error is DioException) {
        switch (error.response?.statusCode) {
          case 404:
            return NotFoundError('Resource not found');
          case 400:
          case 422:
            return ValidationError('Invalid data: ${error.message}');
          case 500:
          case 502:
          case 503:
            return NetworkError('Server error');
          default:
            return NetworkError('Network error: ${error.message}');
        }
      }
      return NetworkError('Unknown error: $error');
    },
  );
}
```

## API Service Example

### Complete API Service with fpdart

```dart
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'api_service.dart';

class UserApi {
  final ApiService _apiService;

  UserApi(this._apiService);

  // Get user by ID
  TaskEither<ApiError, User> getUser(int id) {
    return safeApiCall(
      () async => await _apiService.getUser(id).data,
    );
  }

  // Get all users
  TaskEither<ApiError, List<User>> getUsers() {
    return safeApiCall(
      () async => await _apiService.getUsers().data,
    );
  }

  // Create user
  TaskEither<ApiError, User> createUser({
    required String name,
    required String email,
  }) {
    return safeApiCall(
      () async => await _apiService.createUser({
        'name': name,
        'email': email,
      }).data,
    );
  }

  // Get user with posts
  TaskEither<ApiError, UserWithPosts> getUserWithPosts(int userId) {
    return getUser(userId).flatMap((user) async {
      final posts = await safeApiCall(
        () async => await _apiService.getUserPosts(userId).data,
      ).run();

      return posts.fold(
        (error) => TaskEither.left(error),
        (posts) => TaskEither.right(UserWithPosts(
          user: user,
          posts: posts,
        )),
      );
    });
  }
}
```

## Providers with Riverpod

### Setup Dio Provider

```dart
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';

part 'providers.g.dart';

@riverpod
Dio dio(Ref ref) {
  final dio = Dio();
  dio.options.headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));
  return dio;
}

@riverpod
ApiService apiService(Ref ref) {
  return ApiService(ref.read(dioProvider));
}

@riverpod
UserApi userApi(Ref ref) {
  return UserApi(ref.read(apiServiceProvider));
}
```

### Usage in Widgets

```dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fpdart/fpdart.dart';

class UserPage extends ConsumerWidget {
  final int userId;

  const UserPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(
      userApiProvider.getUser(userId).run(),
    );

    return userAsync.when(
      data: (either) => either.fold(
        (error) => ErrorWidget(error.toString()),
        (user) => UserView(user: user),
      ),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorWidget(error.toString()),
    );
  }
}
```

### Better Way with AsyncValue Extension

```dart
extension TaskEitherAsyncValue on TaskEither<ApiError, dynamic> {
  TaskEither<String, T> mapErrorToString<T>() {
    return TaskEither.flatMap(
      (error) async {
        return switch (error) {
          NetworkError(:final message) => TaskEither.left(message),
          NotFoundError(:final message) => TaskEither.left(message),
          ValidationError(:final message) => TaskEither.left(message),
        };
      },
    );
  }
}

// Usage in widget
final userAsync = ref.watch(
  userApiProvider.getUser(1)
    .mapErrorToString<User>()
    .run(),
);

return userAsync.when(
  data: (either) => either.match(
    left: (error) => Text('Error: $error'),
    right: (user) => UserView(user: user),
  ),
  loading: () => CircularProgressIndicator(),
  error: (error, stack) => ErrorWidget(error),
);
```

## Complete Example

### Full Implementation

```dart
// lib/api/user_api.dart
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'api_service.dart';

sealed class ApiError {
  final String message;
  ApiError(this.message);
}

class NetworkError extends ApiError {
  NetworkError(super.message);
}

class NotFoundError extends ApiError {
  NotFoundError(super.message);
}

class UserApi {
  final ApiService _apiService;

  UserApi(this._apiService);

  // Helper to convert API calls to TaskEither
  TaskEither<ApiError, T> _safeApiCall<T>(
    Future<T> Function() call,
  ) {
    return TaskEither.tryCatch(
      call,
      (error, stackTrace) {
        if (error is DioException) {
          switch (error.response?.statusCode) {
            case 404:
              return NotFoundError('User not found');
            case 400:
            case 422:
              return NetworkError('Invalid request');
            case 500:
            case 502:
            case 503:
              return NetworkError('Server error');
            default:
              return NetworkError('Network error: ${error.message}');
          }
        }
        return NetworkError('Unknown error: $error');
      },
    );
  }

  TaskEither<ApiError, User> getUser(int id) {
    return _safeApiCall(
      () async => await _apiService.getUser(id).data,
    );
  }

  TaskEither<ApiError, List<User>> getUsers() {
    return _safeApiCall(
      () async => await _apiService.getUsers().data,
    );
  }

  TaskEither<ApiError, User> createUser({
    required String name,
    required String email,
  }) {
    return _safeApiCall(
      () async => await _apiService.createUser({
        'name': name,
        'email': email,
      }).data,
    );
  }

  // Chain multiple operations
  TaskEither<ApiError, UserWithPosts> getUserWithPosts(int userId) {
    return getUser(userId).flatMap(
      (user) => getUserPosts(user.id).map(
        (posts) => UserWithPosts(user: user, posts: posts),
      ),
    );
  }

  TaskEither<ApiError, List<Post>> getUserPosts(int userId) {
    return _safeApiCall(
      () async => await _apiService.getUserPosts(userId).data,
    );
  }
}

// lib/providers/user_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';
import '../api/user_api.dart';
import '../api/api_service.dart';

part 'user_providers.g.dart';

@riverpod
UserApi userApi(Ref ref) {
  return UserApi(ref.read(apiServiceProvider));
}

// Get user by ID
@riverpod
Future<User> userById(Ref ref, int id) async {
  final result = await ref.read(userApiProvider).getUser(id).run();
  return result.match(
    left: (error) => throw Exception(error.message),
    right: (user) => user,
  );
}

// Get user with posts
@riverpod
Future<UserWithPosts> userWithPosts(Ref ref, int userId) async {
  final result = await ref.read(userApiProvider)
    .getUserWithPosts(userId)
    .run();
  return result.match(
    left: (error) => throw Exception(error.message),
    right: (data) => data,
  );
}
```

## Best Practices

### 1. Always Use TaskEither for Async Operations

```dart
// ✅ Good
TaskEither<ApiError, User> getUser(int id);

// ❌ Bad
Future<User?> getUser(int id); // Returns nullable
Future<User> getUser(int id); // Throws exceptions
```

### 2. Handle Errors at the Right Level

```dart
// ✅ Good: Handle in the widget
final result = await userApi.getUser(id).run();
result.fold(
  (error) => showErrorDialog(error.message),
  (user) => showUser(user),
);

// ❌ Bad: Handle in the API layer
TaskEither<String, User> getUser(int id) {
  // Don't handle UI concerns here
  return _safeApiCall(() async => ...);
}
```

### 3. Compose Operations with flatMap

```dart
// ✅ Good: Compose operations
TaskEither<ApiError, Report> generateReport(int userId) {
  return getUser(userId)
    .flatMap((user) => getUserPosts(user.id))
    .flatMap((posts) => analyzePosts(posts))
    .map((analysis) => Report(user: user, analysis: analysis));
}

// ❌ Bad: Nested try-catch
Future<Report> generateReport(int userId) async {
  try {
    final user = await getUser(userId);
    final posts = await getUserPosts(user.id);
    final analysis = await analyzePosts(posts);
    return Report(user: user, analysis: analysis);
  } catch (e) {
    // Handle error
  }
}
```

### 4. Use Option for Nullable Values

```dart
// ✅ Good: Use Option
TaskEither<ApiError, Option<User>> findUserByEmail(String email);

// Usage
final result = await findUserByEmail(email).run();
result.fold(
  (error) => showError(error),
  (userOption) => userOption.match(
    () => showNotFound(),
    (user) => showUser(user),
  ),
);
```

### 5. Pattern Matching for Errors

```dart
// ✅ Good: Use pattern matching
final result = await userApi.getUser(id).run();
result.fold(
  (error) => switch (error) {
    NetworkError(:final message) => Text('Network: $message'),
    NotFoundError(:final message) => Text('Not found: $message'),
    ValidationError(:final message) => Text('Invalid: $message'),
  },
  (user) => UserView(user: user),
);
```

## Summary

Using **fpdart** with **Retrofit** provides:

1. **Type-safe error handling** - Use `Either` instead of exceptions
2. **Composable operations** - Chain operations with `flatMap`
3. **Null safety** - Use `Option` for nullable values
4. **Better testing** - Easier to test pure functions
5. **Functional style** - More predictable and maintainable code

By following this guide, you can create robust, type-safe API clients with excellent error handling in your Flutter applications.
