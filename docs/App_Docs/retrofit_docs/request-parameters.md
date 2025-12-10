# Request Parameters in Retrofit

This guide covers all the different types of parameters you can use in Retrofit API methods, including path parameters, query parameters, body parameters, headers, and more.

## Path Parameters

Path parameters are used to inject values directly into the URL path.

### Basic Path Parameters

```dart
@GET('/users/{id}')
Future<User> getUser(@Path('id') int id);

@GET('/users/{userId}/posts/{postId}')
Future<Post> getUserPost(
  @Path('userId') int userId,
  @Path('postId') int postId,
);
```

### Path Parameters with Different Types

```dart
@GET('/users/{id}')
Future<User> getUser(@Path('id') String id);

@GET('/posts/{slug}')
Future<Post> getPostBySlug(@Path('slug') String slug);

@GET('/categories/{categoryId}')
Future<Category> getCategory(@Path('categoryId') int categoryId);
```

### Path Parameters with Enums

```dart
enum UserStatus { active, inactive, pending }

@GET('/users/status/{status}')
Future<List<User>> getUsersByStatus(@Path('status') UserStatus status);

// Override toString() for custom enum values
enum ApiVersion { v1, v2, v3 }

extension ApiVersionExtension on ApiVersion {
  @override
  String toString() {
    switch (this) {
      case ApiVersion.v1:
        return 'v1';
      case ApiVersion.v2:
        return 'v2';
      case ApiVersion.v3:
        return 'v3';
    }
  }
}

@GET('/api/{version}/users')
Future<List<User>> getUsers(@Path('version') ApiVersion version);
```

## Query Parameters

Query parameters are added to the URL as key-value pairs after a `?`.

### Single Query Parameters

```dart
@GET('/users')
Future<List<User>> getUsers(@Query('page') int page);

@GET('/users')
Future<List<User>> getUsersByRole(@Query('role') String role);

@GET('/users')
Future<List<User>> getActiveUsers(@Query('active') bool active);
```

### Multiple Query Parameters

```dart
@GET('/users')
Future<List<User>> searchUsers(
  @Query('name') String? name,
  @Query('email') String? email,
  @Query('page') int page,
  @Query('limit') int limit,
);

@GET('/posts')
Future<List<Post>> getPosts(
  @Query('author') String? author,
  @Query('category') String? category,
  @Query('published') bool? published,
  @Query('sort') String? sort,
  @Query('order') String? order,
);
```

### Query Maps

Use `@Queries()` for dynamic query parameters:

```dart
@GET('/users')
Future<List<User>> searchUsers(@Queries() Map<String, dynamic> filters);

@GET('/posts')
Future<List<Post>> getPosts(@Queries() Map<String, dynamic> searchParams);

// Usage
final filters = {
  'name': 'John',
  'role': 'admin',
  'active': true,
  'page': 1,
  'limit': 10,
};
final users = await apiClient.searchUsers(filters);
```

### Query Parameters with Lists

```dart
@GET('/users')
Future<List<User>> getUsersByIds(@Query('ids') List<int> ids);

@GET('/posts')
Future<List<Post>> getPostsByTags(@Query('tags') List<String> tags);
```

## Body Parameters

Body parameters are used to send data in the request body, typically for POST and PUT requests.

### JSON Body

```dart
@POST('/users')
Future<User> createUser(@Body() User user);

@PUT('/users/{id}')
Future<User> updateUser(@Path('id') int id, @Body() User user);

@PATCH('/users/{id}')
Future<User> updateUserPartially(
  @Path('id') int id,
  @Body() Map<String, dynamic> updates,
);
```

### Form Data Body

```dart
@POST('/users')
@FormUrlEncoded()
Future<User> createUserForm(
  @Field('name') String name,
  @Field('email') String email,
  @Field('age') int age,
);

@PUT('/users/{id}')
@FormUrlEncoded()
Future<User> updateUserForm(
  @Path('id') int id,
  @Field('name') String name,
  @Field('email') String email,
);
```

### Multipart Body

```dart
@POST('/users/{id}/avatar')
Future<void> uploadAvatar(
  @Path('id') int userId,
  @Part() File avatar,
);

@POST('/users')
Future<User> createUserWithAvatar(
  @Part('name') String name,
  @Part('email') String email,
  @Part() File avatar,
);

@POST('/posts')
Future<Post> createPostWithImages(
  @Part('title') String title,
  @Part('content') String content,
  @Part() List<File> images,
);
```

## Header Parameters

Headers can be added dynamically or statically to requests.

### Dynamic Headers

```dart
@GET('/users')
Future<List<User>> getUsers(@Header('Authorization') String token);

@GET('/users')
Future<List<User>> getUsersWithApiKey(@Header('X-API-Key') String apiKey);

@POST('/users')
Future<User> createUser(
  @Body() User user,
  @Header('Content-Type') String contentType,
);
```

### Static Headers

```dart
@GET('/users')
@Headers({
  'Content-Type': 'application/json',
  'Accept': 'application/json',
})
Future<List<User>> getUsers();

@POST('/users')
@Headers({
  'Content-Type': 'application/json',
  'X-Custom-Header': 'custom-value',
})
Future<User> createUser(@Body() User user);
```

### Mixed Headers

```dart
@GET('/users')
@Headers({
  'Content-Type': 'application/json',
  'Accept': 'application/json',
})
Future<List<User>> getUsers(@Header('Authorization') String token);
```

## Advanced Parameter Types

### Typed Extras

Use typed extras for static metadata:

```dart
class MetaData extends TypedExtras {
  final String id;
  final String region;

  const MetaData({required this.id, required this.region});
}

@MetaData(id: '1234', region: 'us')
@GET('/users')
Future<List<User>> getUsers();
```

### Custom Parameter Types

```dart
class DateRange {
  final DateTime start;
  final DateTime end;

  const DateRange({required this.start, required this.end});

  @override
  String toString() {
    return '${start.toIso8601String()},${end.toIso8601String()}';
  }
}

@GET('/events')
Future<List<Event>> getEvents(@Query('dateRange') DateRange dateRange);
```

## Parameter Validation

### Nullable Parameters

```dart
@GET('/users')
Future<List<User>> searchUsers(
  @Query('name') String? name,        // Optional query parameter
  @Query('email') String? email,      // Optional query parameter
  @Query('page') int page,            // Required query parameter
);
```

### Default Values

```dart
@GET('/users')
Future<List<User>> getUsers(
  @Query('page') int page = 1,
  @Query('limit') int limit = 10,
  @Query('sort') String sort = 'name',
);
```

## Complex Examples

### Complete API Client with All Parameter Types

```dart
@RestApi(baseUrl: 'https://api.example.com/')
abstract class CompleteApiClient {
  factory CompleteApiClient(Dio dio, {String? baseUrl}) = _CompleteApiClient;

  // GET with path and query parameters
  @GET('/users/{id}/posts')
  Future<List<Post>> getUserPosts(
    @Path('id') int userId,
    @Query('page') int page,
    @Query('limit') int limit,
    @Query('published') bool? published,
  );

  // POST with body and headers
  @POST('/users')
  @Headers({'Content-Type': 'application/json'})
  Future<User> createUser(
    @Body() User user,
    @Header('Authorization') String token,
  );

  // PUT with path, body, and query parameters
  @PUT('/users/{id}')
  Future<User> updateUser(
    @Path('id') int id,
    @Body() User user,
    @Query('notify') bool notify = true,
  );

  // DELETE with path and headers
  @DELETE('/users/{id}')
  Future<void> deleteUser(
    @Path('id') int id,
    @Header('Authorization') String token,
  );

  // Complex search with query map
  @GET('/users/search')
  Future<List<User>> searchUsers(
    @Queries() Map<String, dynamic> searchCriteria,
    @Header('X-Search-Version') String version,
  );

  // File upload with multiple parts
  @POST('/users/{id}/documents')
  Future<void> uploadDocuments(
    @Path('id') int userId,
    @Part('title') String title,
    @Part('description') String description,
    @Part() List<File> documents,
    @Header('Authorization') String token,
  );
}
```

## Best Practices

1. **Use descriptive parameter names** that match your API documentation
2. **Handle nullable parameters** appropriately
3. **Use enums for fixed values** like status, types, etc.
4. **Group related parameters** using query maps when appropriate
5. **Add proper validation** for required parameters
6. **Use appropriate parameter types** for different data
7. **Document parameter requirements** in your API client comments

## Common Issues

### Path Parameter Mismatch

```dart
// ❌ Wrong - parameter name doesn't match path
@GET('/users/{id}')
Future<User> getUser(@Path('userId') int id);

// ✅ Correct - parameter name matches path
@GET('/users/{id}')
Future<User> getUser(@Path('id') int id);
```

### Missing Required Parameters

```dart
// ❌ Wrong - missing required path parameter
@GET('/users/{id}')
Future<User> getUser();

// ✅ Correct - all path parameters provided
@GET('/users/{id}')
Future<User> getUser(@Path('id') int id);
```

### Incorrect Parameter Types

```dart
// ❌ Wrong - using @Body for simple values
@POST('/users')
Future<User> createUser(@Body() String name);

// ✅ Correct - using @Field for form data
@POST('/users')
@FormUrlEncoded()
Future<User> createUser(@Field('name') String name);
```
