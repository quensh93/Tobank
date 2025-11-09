# Core Package

This package contains the core functionality and utilities used throughout the application.

## Structure

```
lib/core/
├── constants/          # App-wide constants
├── errors/             # Error handling classes
├── extensions/         # Dart extensions
├── helpers/            # Helper utility classes
├── network/            # Network-related classes
├── usecases/           # Base usecase classes
├── widgets/            # Reusable core widgets
├── core.dart           # Main export file
└── README.md           # This file
```

## Usage

Import the entire core package:

```dart
import 'package:your_app/core/core.dart';
```

Or import specific modules:

```dart
import 'package:your_app/core/constants/app_constants.dart';
import 'package:your_app/core/extensions/context_extensions.dart';
```

## Components

### Constants

`app_constants.dart` - App-wide constants like API URLs, storage keys, timeouts, etc.

```dart
import 'package:your_app/core/constants/app_constants.dart';

final token = await storage.read(key: AppConstants.authTokenKey);
```

### Errors

`failures.dart` - Base failure classes for error handling

```dart
import 'package:your_app/core/errors/failures.dart';

// Use with fpdart Either
Either<Failure, Data> result = await getData();
```

### Extensions

`context_extensions.dart` - BuildContext extensions

```dart
import 'package:your_app/core/extensions/context_extensions.dart';

// Use extensions
context.showSnackBar('Hello');
context.showError('Error message');
context.pop();
```

`string_extensions.dart` - String utility extensions

```dart
import 'package:your_app/core/extensions/string_extensions.dart';

// Use extensions
if (email.isValidEmail) { ... }
final masked = phone.maskPhone;
```

### Helpers

`logger.dart` - Centralized logging

```dart
import 'package:your_app/core/helpers/logger.dart';

AppLogger.d('Debug message');
AppLogger.e('Error', error, stackTrace);
```

`date_helper.dart` - Date utilities

```dart
import 'package:your_app/core/helpers/date_helper.dart';

final formatted = DateHelper.format(DateTime.now());
final relative = DateHelper.getRelativeTime(date);
```

### Network

`network_info.dart` - Network connectivity checking

```dart
import 'package:your_app/core/network/network_info.dart';

final hasConnection = await networkInfo.hasConnection;
```

### Usecases

`usecase.dart` - Base usecase interfaces

```dart
import 'package:your_app/core/usecases/usecase.dart';

class GetUserUseCase implements UseCase<User, String> {
  @override
  Future<Either<Failure, User>> call(String params) async {
    // Implementation
  }
}
```

### Widgets

`error_widget.dart` - Error display widget

```dart
import 'package:your_app/core/widgets/error_widget.dart';

CustomErrorWidget(
  message: 'Failed to load data',
  onRetry: () => _loadData(),
)
```

`loading_widget.dart` - Loading state widgets

```dart
import 'package:your_app/core/widgets/loading_widget.dart';

LoadingWidget(message: 'Loading...')
LoadingOverlay(isLoading: isLoading, child: content)
```

## Best Practices

1. **Import selectively**: Only import what you need to reduce bundle size
2. **Use extensions**: Extensions make code more readable and maintainable
3. **Centralize constants**: Put all app-wide constants in `app_constants.dart`
4. **Handle errors properly**: Use Failure classes for type-safe error handling
5. **Use helpers**: Leverage helper classes for common operations

## Integration

This core package integrates with:

- **Riverpod**: For state management
- **fpdart**: For functional programming (Either, TaskEither)
- **Retrofit**: For API calls
- **Dio**: For HTTP requests
- **Flutter Secure Storage**: For secure data storage
- **Logger**: For logging

## Examples

See the main app implementation for complete usage examples.
