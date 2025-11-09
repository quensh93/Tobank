# Getting Started with Retrofit

This guide will walk you through setting up Retrofit in your Flutter project and creating your first API client.

## Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.7.0 or higher
- Basic understanding of HTTP APIs and JSON

## Installation

### 1. Add Dependencies

Add the following dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  retrofit: ^4.7.3
  dio: ^5.7.0
  json_annotation: ^4.9.0
  logger: ^2.6.0  # Optional, for logging

dev_dependencies:
  retrofit_generator: ^10.0.1
  build_runner: ^2.6.0
  json_serializable: ^6.10.0
```

### 2. Install Dependencies

Run the following command to install the dependencies:

```bash
flutter pub get
```

## Creating Your First API Client

### 1. Create a Data Model

First, let's create a simple data model for our API:

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
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String email;
  final String? avatar;
  final DateTime? createdAt;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### 2. Create the API Client

Now, let's create your first API client:

```dart
// lib/services/api_client.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET('/users')
  Future<List<User>> getUsers();

  @GET('/users/{id}')
  Future<User> getUser(@Path('id') int id);

  @POST('/users')
  Future<User> createUser(@Body() User user);

  @PUT('/users/{id}')
  Future<User> updateUser(@Path('id') int id, @Body() User user);

  @DELETE('/users/{id}')
  Future<void> deleteUser(@Path('id') int id);
}
```

### 3. Generate Code

Run the build runner to generate the necessary code:

```bash
dart pub run build_runner build
```

This will generate:
- `user.g.dart` - JSON serialization code for the User model
- `api_client.g.dart` - Retrofit API client implementation

### 4. Use Your API Client

Now you can use your API client in your application:

```dart
// lib/main.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'services/api_client.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrofit Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dio _dio = Dio();
  late final ApiClient _apiClient;
  List<User> _users = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _apiClient = ApiClient(_dio);
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final users = await _apiClient.getUsers();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading users: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _loadUsers,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(user.name[0]),
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            ),
    );
  }
}
```

## Configuration Options

### Dio Configuration

You can configure Dio with various options:

```dart
final dio = Dio();

// Set base URL
dio.options.baseUrl = 'https://api.example.com/';

// Set default headers
dio.options.headers = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer your-token',
};

// Set timeout
dio.options.connectTimeout = Duration(seconds: 5);
dio.options.receiveTimeout = Duration(seconds: 3);

// Add interceptors
dio.interceptors.add(LogInterceptor());
dio.interceptors.add(AuthInterceptor());

final apiClient = ApiClient(dio);
```

### API Client Configuration

You can also configure the API client with different base URLs:

```dart
// Use different base URL
final apiClient = ApiClient(dio, baseUrl: 'https://staging-api.example.com/');

// Use relative URLs in annotations
@RestApi(baseUrl: '/api/v1/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;
  
  @GET('users')  // Will use dio.options.baseUrl + 'users'
  Future<List<User>> getUsers();
}
```

## Next Steps

Now that you have a basic API client working, you can:

1. Learn about [HTTP Methods](http-methods.md) and their annotations
2. Explore [Request Parameters](request-parameters.md) for more complex API calls
3. Set up [Error Handling](response-handling.md) for robust applications
4. Implement [JSON Serialization](json-serialization.md) for complex data models

## Common Issues

### Build Runner Issues

If you encounter issues with build runner:

```bash
# Clean and rebuild
dart pub run build_runner clean
dart pub run build_runner build --delete-conflicting-outputs
```

### Import Issues

Make sure to import the generated files:

```dart
import 'api_client.g.dart';  // Generated API client
import 'user.g.dart';       // Generated JSON serialization
```

### Dio Configuration

Ensure Dio is properly configured before creating the API client:

```dart
final dio = Dio();
// Configure dio here
final apiClient = ApiClient(dio);
```
