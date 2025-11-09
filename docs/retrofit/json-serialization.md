# JSON Serialization with Retrofit

This guide covers how to work with JSON data in Retrofit, including serialization, deserialization, and handling complex data structures.

## Overview

Retrofit works seamlessly with `json_serializable` to automatically convert between Dart objects and JSON. This provides type-safe JSON handling with minimal boilerplate code.

## Basic Setup

### 1. Add Dependencies

```yaml
dependencies:
  json_annotation: ^4.9.0

dev_dependencies:
  json_serializable: ^6.10.0
  build_runner: ^2.6.0
```

### 2. Create a Model Class

```dart
// lib/models/user.dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.createdAt,
    this.isActive = true,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String email;
  final String? avatar;
  final DateTime? createdAt;
  final bool isActive;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### 3. Generate Code

```bash
dart pub run build_runner build
```

## Advanced JSON Serialization

### Custom Field Names

```dart
@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @JsonKey(name: 'user_id')
  final int id;

  @JsonKey(name: 'full_name')
  final String name;

  @JsonKey(name: 'email_address')
  final String email;

  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### Custom Serialization Logic

```dart
@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String email;

  @JsonKey(
    name: 'created_at',
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )
  final DateTime? createdAt;

  static DateTime? _dateTimeFromJson(String? dateString) {
    if (dateString == null) return null;
    return DateTime.parse(dateString);
  }

  static String? _dateTimeToJson(DateTime? dateTime) {
    return dateTime?.toIso8601String();
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### Nested Objects

```dart
@JsonSerializable()
class Address {
  const Address({
    required this.street,
    required this.city,
    required this.country,
    this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  final String street;
  final String city;
  final String country;
  final String? zipCode;

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String email;
  final Address? address;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### Lists and Collections

```dart
@JsonSerializable()
class Post {
  const Post({
    required this.id,
    required this.title,
    required this.content,
    this.tags = const [],
    this.comments = const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  final int id;
  final String title;
  final String content;
  final List<String> tags;
  final List<Comment> comments;

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class Comment {
  const Comment({
    required this.id,
    required this.content,
    required this.author,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  final int id;
  final String content;
  final String author;

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
```

### Enums

```dart
enum UserRole {
  admin,
  user,
  moderator;

  @override
  String toString() => name;
}

enum UserStatus {
  active,
  inactive,
  pending;

  @override
  String toString() => name;
}

@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String email;
  final UserRole role;
  final UserStatus status;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### Custom Enum Serialization

```dart
enum Priority {
  low,
  medium,
  high;

  @override
  String toString() {
    switch (this) {
      case Priority.low:
        return 'low';
      case Priority.medium:
        return 'medium';
      case Priority.high:
        return 'high';
    }
  }
}

@JsonSerializable()
class Task {
  const Task({
    required this.id,
    required this.title,
    required this.priority,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  final int id;
  final String title;

  @JsonKey(
    fromJson: _priorityFromJson,
    toJson: _priorityToJson,
  )
  final Priority priority;

  static Priority _priorityFromJson(String value) {
    switch (value) {
      case 'low':
        return Priority.low;
      case 'medium':
        return Priority.medium;
      case 'high':
        return Priority.high;
      default:
        return Priority.low;
    }
  }

  static String _priorityToJson(Priority priority) {
    return priority.toString();
  }

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
```

## API Client Integration

### Basic API Client

```dart
@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String? baseUrl}) = _UserApiClient;

  @GET('/users')
  Future<List<User>> getUsers();

  @GET('/users/{id}')
  Future<User> getUser(@Path('id') int id);

  @POST('/users')
  Future<User> createUser(@Body() User user);

  @PUT('/users/{id}')
  Future<User> updateUser(@Path('id') int id, @Body() User user);
}
```

### Complex API Client

```dart
@RestApi(baseUrl: 'https://api.example.com/')
abstract class BlogApiClient {
  factory BlogApiClient(Dio dio, {String? baseUrl}) = _BlogApiClient;

  // Get posts with nested comments
  @GET('/posts')
  Future<List<Post>> getPosts();

  @GET('/posts/{id}')
  Future<Post> getPost(@Path('id') int id);

  // Create post with tags
  @POST('/posts')
  Future<Post> createPost(@Body() Post post);

  // Update post with partial data
  @PATCH('/posts/{id}')
  Future<Post> updatePost(
    @Path('id') int id,
    @Body() Map<String, dynamic> updates,
  );

  // Get users with addresses
  @GET('/users')
  Future<List<User>> getUsers();

  @GET('/users/{id}')
  Future<User> getUser(@Path('id') int id);

  // Create user with address
  @POST('/users')
  Future<User> createUser(@Body() User user);
}
```

## Error Handling with JSON

### Custom Error Models

```dart
@JsonSerializable()
class ApiError {
  const ApiError({
    required this.code,
    required this.message,
    this.details,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) => _$ApiErrorFromJson(json);

  final String code;
  final String message;
  final Map<String, dynamic>? details;

  Map<String, dynamic> toJson() => _$ApiErrorToJson(this);
}

@JsonSerializable()
class ValidationError {
  const ValidationError({
    required this.field,
    required this.message,
  });

  factory ValidationError.fromJson(Map<String, dynamic> json) => _$ValidationErrorFromJson(json);

  final String field;
  final String message;

  Map<String, dynamic> toJson() => _$ValidationErrorToJson(this);
}
```

### Error Handling in API Client

```dart
class ApiService {
  final UserApiClient _apiClient;

  ApiService(this._apiClient);

  Future<User> getUser(int id) async {
    try {
      return await _apiClient.getUser(id);
    } on DioException catch (e) {
      if (e.response?.data != null) {
        final error = ApiError.fromJson(e.response!.data);
        throw ApiException(error.message);
      }
      throw ApiException('Failed to get user');
    }
  }

  Future<User> createUser(User user) async {
    try {
      return await _apiClient.createUser(user);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        // Validation error
        final errors = (e.response!.data['errors'] as List)
            .map((e) => ValidationError.fromJson(e))
            .toList();
        throw ValidationException(errors);
      }
      throw ApiException('Failed to create user');
    }
  }
}
```

## Best Practices

### 1. Use Immutable Models

```dart
@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String email;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### 2. Handle Nullable Fields

```dart
@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String email;
  final String? avatar;        // Nullable
  final DateTime? createdAt;   // Nullable

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### 3. Use Default Values

```dart
@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.isActive = true,      // Default value
    this.role = UserRole.user,  // Default enum value
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String email;
  final bool isActive;
  final UserRole role;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### 4. Validate Required Fields

```dart
@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Validate required fields
    if (json['id'] == null) throw ArgumentError('id is required');
    if (json['name'] == null) throw ArgumentError('name is required');
    if (json['email'] == null) throw ArgumentError('email is required');
    
    return _$UserFromJson(json);
  }

  final int id;
  final String name;
  final String email;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

## Common Issues

### 1. Missing Generated Files

```bash
# Clean and rebuild
dart pub run build_runner clean
dart pub run build_runner build --delete-conflicting-outputs
```

### 2. Import Issues

```dart
// Make sure to import generated files
import 'user.g.dart';
import 'api_client.g.dart';
```

### 3. Type Mismatches

```dart
// ❌ Wrong - type mismatch
@JsonSerializable()
class User {
  final String id;  // API returns int, but using String
}

// ✅ Correct - matching types
@JsonSerializable()
class User {
  final int id;  // Matches API response
}
```

### 4. Null Safety Issues

```dart
// ❌ Wrong - non-nullable field with null value
@JsonSerializable()
class User {
  final String avatar;  // API might return null
}

// ✅ Correct - nullable field
@JsonSerializable()
class User {
  final String? avatar;  // Handles null values
}
```
