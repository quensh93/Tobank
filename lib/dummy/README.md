# Retrofit + Riverpod Dummy Files

This folder contains comprehensive dummy files for testing Retrofit and Riverpod integration in your Flutter application.

## Files Structure

```
lib/dummy/
├── models/
│   └── user_model.dart          # Data models with JSON serialization
├── services/
│   └── api_service.dart         # Retrofit API client definition
├── providers/
│   ├── api_providers.dart       # Riverpod providers for API calls
│   └── user_state_providers.dart # State management providers
├── retrofit_riverpod_test_page.dart  # Full-featured test page
├── simple_api_test_page.dart    # Simple API test page
└── README.md                    # This file
```

## Setup Instructions

### 1. Generate Code

Before using these files, you need to generate the necessary code:

```bash
# Generate JSON serialization and Retrofit code
dart pub run build_runner build
```

### 2. Add to Main App

Add the test pages to your main app navigation:

```dart
// In your main.dart or navigation
import 'package:tobank_sdui/dummy/simple_api_test_page.dart';
import 'package:tobank_sdui/dummy/retrofit_riverpod_test_page.dart';

// Add routes or direct navigation
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const SimpleApiTestPage(),
  ),
);
```

## Features Demonstrated

### 1. Data Models (`models/user_model.dart`)

- **UserModel**: Complete user data structure
- **AddressModel**: Nested address information
- **GeoModel**: Geographic coordinates
- **CompanyModel**: Company information
- **PostModel**: Blog post structure
- **CommentModel**: Comment structure

**Key Features:**
- JSON serialization with `@JsonSerializable()`
- Nullable fields handling
- Nested object relationships
- Custom field mapping

### 2. API Service (`services/api_service.dart`)

- **Complete REST API client** using Retrofit
- **All HTTP methods**: GET, POST, PUT, PATCH, DELETE
- **Parameter types**: Path, Query, Body, Headers
- **Real API endpoints** using JSONPlaceholder

**Endpoints Covered:**
- `/users` - User management
- `/posts` - Post management
- `/comments` - Comment management
- Search functionality

### 3. Riverpod Providers (`providers/`)

#### API Providers (`api_providers.dart`)
- **Dio configuration** with interceptors
- **ApiService provider** for dependency injection
- **Data providers** for each endpoint
- **Search providers** with parameters

#### State Providers (`user_state_providers.dart`)
- **State management** with AsyncValue
- **CRUD operations** (Create, Read, Update, Delete)
- **Loading states** and error handling
- **Search functionality** with state management

### 4. Test Pages

#### Simple API Test Page (`simple_api_test_page.dart`)
- **Basic API testing** with simple UI
- **Error handling** demonstration
- **Loading states** with visual feedback
- **Result display** in dialogs

#### Full Test Page (`retrofit_riverpod_test_page.dart`)
- **Tabbed interface** for different data types
- **Complete CRUD operations**
- **Search functionality**
- **User selection** and interaction
- **Nested data display** (user posts, post comments)
- **Refresh capabilities**

## Usage Examples

### Basic API Call

```dart
// Using the provider directly
final users = await ref.read(usersProvider.future);

// Using state management
ref.read(userListStateProvider.notifier).loadUsers();
```

### Search Functionality

```dart
// Search users
final searchResults = await ref.read(searchUsersProvider('John').future);

// Search posts
final posts = await ref.read(searchPostsProvider(title: 'Flutter', userId: 1).future);
```

### Error Handling

```dart
final userListState = ref.watch(userListStateProvider);

userListState.when(
  data: (users) => ListView.builder(...),
  loading: () => CircularProgressIndicator(),
  error: (error, stack) => Text('Error: $error'),
);
```

## Testing the Integration

### 1. Run Code Generation

```bash
dart pub run build_runner build
```

### 2. Navigate to Test Pages

```dart
// Simple test
Navigator.push(context, MaterialPageRoute(
  builder: (context) => const SimpleApiTestPage(),
));

// Full test
Navigator.push(context, MaterialPageRoute(
  builder: (context) => const RetrofitRiverpodTestPage(),
));
```

### 3. Test Features

- **Load data** from different endpoints
- **Search functionality** with real-time results
- **Error handling** by disconnecting internet
- **Refresh data** using pull-to-refresh
- **User interactions** like selection and deletion

## Key Learning Points

### Retrofit Features
- **Type-safe API calls** with compile-time checking
- **Automatic serialization** with json_serializable
- **Parameter handling** for all HTTP methods
- **Error handling** with Dio exceptions

### Riverpod Features
- **State management** with providers
- **Dependency injection** for services
- **AsyncValue handling** for loading states
- **Code generation** with riverpod_annotation

### Integration Benefits
- **Separation of concerns** between API and UI
- **Reactive updates** when data changes
- **Error handling** at multiple levels
- **Testable architecture** with dependency injection

## Troubleshooting

### Common Issues

1. **Code generation errors**
   ```bash
   dart pub run build_runner clean
   dart pub run build_runner build --delete-conflicting-outputs
   ```

2. **Import errors**
   - Ensure all generated files are imported
   - Check part directives in model files

3. **API errors**
   - Check internet connection
   - Verify JSONPlaceholder API is accessible
   - Check Dio configuration

### Debug Tips

- **Enable logging** in Dio configuration
- **Use AsyncValue.when()** for proper state handling
- **Check provider dependencies** in Riverpod
- **Validate JSON structure** matches models

## Next Steps

1. **Customize models** for your API structure
2. **Add authentication** with interceptors
3. **Implement caching** with Riverpod
4. **Add offline support** with error handling
5. **Create unit tests** for providers
6. **Add more complex state management** patterns

This dummy implementation provides a solid foundation for understanding and implementing Retrofit + Riverpod integration in your Flutter applications.














