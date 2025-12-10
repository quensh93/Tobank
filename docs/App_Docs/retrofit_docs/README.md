# Retrofit Documentation

This folder contains comprehensive documentation for using Retrofit in Flutter applications.

## Overview

Retrofit is a type-safe HTTP client generator for Dart/Flutter that uses source code generation to create API clients from annotations. It's inspired by the popular Retrofit library for Android and works seamlessly with Dio.

## Documentation Structure

- [Getting Started](getting-started.md) - Basic setup and first API client
- [API Client Definition](api-client-definition.md) - How to define REST API clients
- [HTTP Methods](http-methods.md) - Supported HTTP methods and annotations
- [Request Parameters](request-parameters.md) - Path, query, body, and header parameters
- [Response Handling](response-handling.md) - Handling responses and errors
- [JSON Serialization](json-serialization.md) - Working with JSON data
- [Advanced Interceptors](advanced-interceptors.md) - Authentication, token refresh, and error handling
- [Advanced Features](advanced-features.md) - Call adapters, multithreading, and more
- [Best Practices](best-practices.md) - Recommended patterns and tips
- [Troubleshooting](troubleshooting.md) - Common issues and solutions

## Quick Start

1. Add dependencies to `pubspec.yaml`:
```yaml
dependencies:
  retrofit: ^4.7.3
  dio: ^5.7.0
  json_annotation: ^4.9.0
  logger: ^2.6.0

dev_dependencies:
  retrofit_generator: ^10.0.1
  build_runner: ^2.6.0
  json_serializable: ^6.10.0
```

2. Define your API client:
```dart
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://api.example.com/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET('/users')
  Future<List<User>> getUsers();

  @POST('/users')
  Future<User> createUser(@Body() User user);
}
```

3. Run code generation:
```bash
dart pub run build_runner build
```

4. Use your API client:
```dart
final dio = Dio();
final client = ApiClient(dio);
final users = await client.getUsers();
```

## Key Features

- **Type Safety**: Compile-time checking of API calls
- **Code Generation**: Automatic client generation from annotations
- **Dio Integration**: Built on top of the powerful Dio HTTP client
- **JSON Support**: Seamless integration with json_serializable
- **Multiple HTTP Methods**: GET, POST, PUT, PATCH, DELETE support
- **Flexible Parameters**: Path, query, body, and header parameters
- **Error Handling**: Comprehensive error handling with Dio
- **Custom Adapters**: Support for custom response adapters

## Dependencies

- **retrofit**: Main package for API client generation
- **dio**: HTTP client library
- **json_annotation**: JSON serialization annotations
- **logger**: Logging utility (optional)
- **retrofit_generator**: Code generation for Retrofit
- **build_runner**: Build system for code generation
- **json_serializable**: JSON serialization code generation

## Resources

- [Official Package](https://pub.dev/packages/retrofit)
- [GitHub Repository](https://github.com/trevorwang/retrofit.dart)
- [Dio Documentation](https://pub.dev/packages/dio)
- [JSON Serializable](https://pub.dev/packages/json_serializable)
