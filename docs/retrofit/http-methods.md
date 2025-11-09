# HTTP Methods in Retrofit

Retrofit supports all standard HTTP methods through annotations. This guide covers how to use each method and their specific parameters.

## Supported HTTP Methods

### GET Requests

Used for retrieving data from the server.

```dart
@RestApi(baseUrl: 'https://api.example.com/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  // Simple GET request
  @GET('/users')
  Future<List<User>> getUsers();

  // GET with path parameter
  @GET('/users/{id}')
  Future<User> getUser(@Path('id') int id);

  // GET with query parameters
  @GET('/users')
  Future<List<User>> getUsersByRole(@Query('role') String role);

  // GET with multiple query parameters
  @GET('/users')
  Future<List<User>> searchUsers(
    @Query('name') String? name,
    @Query('email') String? email,
    @Query('page') int page,
    @Query('limit') int limit,
  );

  // GET with query map
  @GET('/users')
  Future<List<User>> getUsersWithQueries(@Queries() Map<String, dynamic> queries);

  // GET with headers
  @GET('/users')
  Future<List<User>> getUsersWithHeader(@Header('Authorization') String token);
}
```

### POST Requests

Used for creating new resources on the server.

```dart
// POST with JSON body
@POST('/users')
Future<User> createUser(@Body() User user);

// POST with form data
@POST('/users')
@FormUrlEncoded()
Future<User> createUserForm(
  @Field('name') String name,
  @Field('email') String email,
);

// POST with file upload
@POST('/users/{id}/avatar')
Future<void> uploadAvatar(
  @Path('id') int userId,
  @Part() File avatar,
);

// POST with multiple parts
@POST('/users')
Future<void> createUserWithAvatar(
  @Part('name') String name,
  @Part('email') String email,
  @Part() File avatar,
);
```

### PUT Requests

Used for updating entire resources.

```dart
@PUT('/users/{id}')
Future<User> updateUser(@Path('id') int id, @Body() User user);

@PUT('/users/{id}')
@FormUrlEncoded()
Future<User> updateUserForm(
  @Path('id') int id,
  @Field('name') String name,
  @Field('email') String email,
);
```

### PATCH Requests

Used for partial updates of resources.

```dart
@PATCH('/users/{id}')
Future<User> updateUserPartially(
  @Path('id') int id,
  @Body() Map<String, dynamic> updates,
);

@PATCH('/users/{id}')
Future<User> updateUserField(
  @Path('id') int id,
  @Field('name') String name,
);
```

### DELETE Requests

Used for removing resources from the server.

```dart
@DELETE('/users/{id}')
Future<void> deleteUser(@Path('id') int id);

@DELETE('/users/{id}')
Future<Map<String, dynamic>> deleteUserWithResponse(@Path('id') int id);
```

## Advanced HTTP Method Features

### Custom Headers

You can add custom headers to any request:

```dart
@GET('/users')
@Headers({
  'Content-Type': 'application/json',
  'Custom-Header': 'custom-value',
})
Future<List<User>> getUsersWithCustomHeaders();

@GET('/users')
Future<List<User>> getUsersWithDynamicHeader(@Header('X-API-Key') String apiKey);
```

### Response Wrappers

Get the full HTTP response instead of just the body:

```dart
@GET('/users/{id}')
Future<HttpResponse<User>> getUserWithResponse(@Path('id') int id);

@GET('/users')
Future<HttpResponse<List<User>>> getUsersWithResponse();
```

### Multiple Endpoints

Support multiple base URLs:

```dart
@RestApi(baseUrl: 'https://api.example.com/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET('/users')
  Future<List<User>> getUsers();
}

// Usage with different base URL
final apiClient = ApiClient(dio, baseUrl: 'https://staging-api.example.com/');
```

## Parameter Types

### Path Parameters

Use `@Path()` to inject values into the URL path:

```dart
@GET('/users/{id}/posts/{postId}')
Future<Post> getUserPost(
  @Path('id') int userId,
  @Path('postId') int postId,
);
```

### Query Parameters

Use `@Query()` for URL query parameters:

```dart
@GET('/users')
Future<List<User>> getUsers(
  @Query('page') int page,
  @Query('limit') int limit,
  @Query('sort') String? sort,
);
```

### Query Maps

Use `@Queries()` for dynamic query parameters:

```dart
@GET('/users')
Future<List<User>> searchUsers(@Queries() Map<String, dynamic> filters);
```

### Body Parameters

Use `@Body()` for request body:

```dart
@POST('/users')
Future<User> createUser(@Body() User user);

@PUT('/users/{id}')
Future<User> updateUser(@Path('id') int id, @Body() Map<String, dynamic> updates);
```

### Form Fields

Use `@Field()` for form-encoded data:

```dart
@POST('/users')
@FormUrlEncoded()
Future<User> createUserForm(
  @Field('name') String name,
  @Field('email') String email,
);
```

### File Parts

Use `@Part()` for file uploads:

```dart
@POST('/users/{id}/avatar')
Future<void> uploadAvatar(
  @Path('id') int userId,
  @Part() File avatar,
);
```

## Error Handling

Handle different types of errors:

```dart
try {
  final user = await apiClient.getUser(1);
  // Handle success
} on DioException catch (e) {
  switch (e.response?.statusCode) {
    case 404:
      // User not found
      break;
    case 500:
      // Server error
      break;
    default:
      // Other errors
      break;
  }
} catch (e) {
  // Other exceptions
}
```

## Best Practices

1. **Use appropriate HTTP methods** for your operations
2. **Handle errors** properly with try-catch blocks
3. **Use path parameters** for resource identification
4. **Use query parameters** for filtering and pagination
5. **Use body parameters** for complex data
6. **Add proper headers** for authentication and content type
7. **Use response wrappers** when you need HTTP status information

## Example: Complete API Client

```dart
@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class UserApiClient {
  factory UserApiClient(Dio dio, {String? baseUrl}) = _UserApiClient;

  // GET operations
  @GET('/users')
  Future<List<User>> getUsers();

  @GET('/users/{id}')
  Future<User> getUser(@Path('id') int id);

  @GET('/users')
  Future<List<User>> getUsersByEmail(@Query('email') String email);

  // POST operations
  @POST('/users')
  Future<User> createUser(@Body() User user);

  // PUT operations
  @PUT('/users/{id}')
  Future<User> updateUser(@Path('id') int id, @Body() User user);

  // PATCH operations
  @PATCH('/users/{id}')
  Future<User> updateUserPartially(
    @Path('id') int id,
    @Body() Map<String, dynamic> updates,
  );

  // DELETE operations
  @DELETE('/users/{id}')
  Future<void> deleteUser(@Path('id') int id);
}
```
