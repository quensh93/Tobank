# Data Layer - Network Architecture

This directory contains the complete network layer implementation using **Retrofit**, **Dio**, **Riverpod**, and **fpdart** following Clean Architecture principles.

## Architecture

```
lib/data/
├── models/              # Data models with JSON serialization
├── datasources/         # API service definitions (Retrofit)
├── repositories/        # Repository pattern with fpdart
├── providers/           # Riverpod providers
└── README.md           # This file
```

## Components

### 1. Models (`models/`)

Data models with JSON serialization using `json_annotation`.

**Example:**
```dart
@JsonSerializable()
class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  
  final int id;
  final String name;
  final String email;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
```

### 2. Data Sources (`datasources/`)

Retrofit API service definitions with type-safe HTTP clients.

**Example:**
```dart
@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @GET('/users/{id}')
  Future<UserModel> getUser(@Path('id') int id);

  @POST('/users')
  Future<UserModel> createUser(@Body() UserModel user);
}
```

### 3. Repositories (`repositories/`)

Repository pattern with fpdart's `TaskEither` for functional error handling.

**Features:**
- **Sealed error types** for type-safe error handling
- **TaskEither** for composable async operations
- **Logger integration** for debugging
- **Automatic error mapping** from DioException

**Example:**
```dart
class UserRepository {
  final ApiService _apiService;

  TaskEither<ApiError, UserModel> getUser(int id) {
    return safeApiCall(
      () async => await _apiService.getUser(id),
    );
  }
}
```

### 4. Providers (`providers/`)

Riverpod providers for dependency injection and state management.

**Example:**
```dart
@riverpod
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
    headers: {'Content-Type': 'application/json'},
  ));
  
  dio.interceptors.add(LogInterceptor());
  return dio;
}

@riverpod
ApiService apiService(Ref ref) {
  return ApiService(ref.read(dioProvider));
}

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository(ref.read(apiServiceProvider));
}
```

## Usage

### In Widgets

```dart
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserPage extends ConsumerWidget {
  final int userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider(userId));

    return userAsync.when(
      data: (user) => UserView(user: user),
      loading: () => LoadingWidget(),
      error: (error, stack) => ErrorWidget(error: error),
    );
  }
}
```

### Direct Repository Usage

```dart
// Using TaskEither directly
final repository = ref.read(userRepositoryProvider);
final result = await repository.getUser(userId).run();

result.fold(
  (error) => print('Error: ${error.message}'),
  (user) => print('User: ${user.name}'),
);

// Chain operations
final userWithPosts = await repository.getUser(userId)
  .flatMap((user) => repository.getUserPosts(user.id))
  .map((posts) => UserWithPosts(user: user, posts: posts))
  .run();
```

## Error Handling

### Error Types

The repository uses sealed error types for type-safe error handling:

```dart
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

class ValidationError extends ApiError {
  ValidationError(super.message);
}

class ServerError extends ApiError {
  ServerError(super.message);
}
```

### Automatic Error Mapping

Errors are automatically mapped from Dio exceptions:

```dart
TaskEither<ApiError, T> safeApiCall<T>(
  Future<T> Function() call,
) {
  return TaskEither.tryCatch(
    call,
    (error, stackTrace) {
      if (error is DioException) {
        switch (error.response?.statusCode) {
          case 404: return NotFoundError('Resource not found');
          case 400:
          case 422: return ValidationError('Invalid data');
          case 500:
          case 502:
          case 503: return ServerError('Server error');
          default: return NetworkError('Network error');
        }
      }
      return NetworkError('Unknown error');
    },
  );
}
```

## Best Practices

### 1. Use TaskEither for Async Operations

```dart
// ✅ Good
TaskEither<ApiError, UserModel> getUser(int id);

// ❌ Bad
Future<UserModel?> getUser(int id);
Future<UserModel> getUser(int id);
```

### 2. Compose Operations with flatMap

```dart
// ✅ Good: Chain operations
TaskEither<ApiError, UserProfile> getUserProfile(int userId) {
  return getUser(userId)
    .flatMap((user) => getUserPosts(user.id))
    .map((posts) => UserProfile(user: user, posts: posts));
}

// ❌ Bad: Nested try-catch
```

### 3. Handle Errors at the Widget Level

```dart
// ✅ Good: Handle in widget
final result = await repository.getUser(id).run();
result.fold(
  (error) => showError(error.message),
  (user) => showUser(user),
);

// ❌ Bad: Handle in repository
```

### 4. Use Pattern Matching for Errors

```dart
// ✅ Good: Use pattern matching
result.fold(
  (error) => switch (error) {
    NetworkError(:final message) => Text('Network: $message'),
    NotFoundError(:final message) => Text('Not found: $message'),
    ValidationError(:final message) => Text('Invalid: $message'),
    ServerError(:final message) => Text('Server: $message'),
  },
  (data) => ShowData(data),
);
```

## Code Generation

After modifying models or API services, run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

This generates:
- `.g.dart` files for models (JSON serialization)
- `.g.dart` files for API services (Retrofit client)
- `.g.dart` files for providers (Riverpod)

## Integration with Core

The data layer integrates with:

- **Core Constants** - API URLs, timeouts
- **Core Errors** - Failure types
- **Core Helpers** - Logger for error tracking
- **Core Extensions** - Context extensions for UI

## Testing

Example test for repository:

```dart
test('getUser returns user on success', () async {
  when(mockApiService.getUser(1)).thenAnswer((_) async => mockUser);
  
  final result = await repository.getUser(1).run();
  
  expect(result.isRight(), true);
  result.fold(
    (error) => fail('Should not return error'),
    (user) => expect(user, mockUser),
  );
});
```

## Resources

- [Retrofit Documentation](../../docs/retrofit/)
- [Riverpod Documentation](../../docs/riverpod/)
- [fpdart Documentation](../../docs/fpdart/)
- [fpdart + Retrofit Integration](../../docs/fpdart/retrofit-integration.md)

## Summary

This network layer provides:

✅ **Type-safe API calls** with Retrofit  
✅ **Functional error handling** with fpdart  
✅ **Dependency injection** with Riverpod  
✅ **Clean architecture** separation  
✅ **Composable operations** with TaskEither  
✅ **Automatic error mapping** from HTTP status codes  

All components work together seamlessly to provide a robust, maintainable network layer.
