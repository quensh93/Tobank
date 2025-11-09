# Architecture Reference: Flutter Riverpod Clean Architecture

## 📋 Overview

This document provides a reference to the [Flutter Riverpod Clean Architecture Template](https://github.com/ssoad/flutter_riverpod_clean_architecture) that has been cloned locally as `.flutter_riverpod_clean_architecture_template/` for reference purposes.

## 🎯 Purpose

This reference template demonstrates:
- **Clean Architecture** with clear separation of concerns
- **Riverpod** for state management
- **Feature-first organization**
- **Scalable folder structure**
- **Production-ready patterns**

## 📁 Template Structure

### Core Organization

```
lib/
├── core/              # Shared utilities and services
│   ├── accessibility/  # Accessibility features
│   ├── analytics/      # Analytics integration
│   ├── auth/           # Biometric authentication
│   ├── images/         # Image handling
│   ├── localization/   # Internationalization
│   ├── network/        # Network layer
│   ├── notifications/  # Push notifications
│   ├── storage/        # Local storage & caching
│   ├── theme/          # Theming system
│   └── ui/             # Reusable UI components
│
├── features/           # Feature modules
│   ├── auth/           # Example: Auth feature
│   │   ├── data/       # Data layer
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/     # Domain layer
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/ # Presentation layer
│   │       ├── providers/
│   │       └── screens/
│   ├── home/           # Home feature
│   └── settings/       # Settings feature
│
└── l10n/               # Localization files
    └── arb/
```

## 🏗️ Key Architectural Patterns

### 1. Clean Architecture Layers

#### Domain Layer
- **Entities**: Core business models
- **Repositories**: Abstract interfaces
- **Use Cases**: Business logic

#### Data Layer
- **Data Sources**: Remote/Local data providers
- **Models**: DTOs with JSON serialization
- **Repository Implementations**: Concrete data access

#### Presentation Layer
- **Providers**: Riverpod state management
- **Screens**: UI widgets
- **Widgets**: Reusable components

### 2. Riverpod State Management

```dart
// Feature-specific provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read);
});

// Core providers (shared across app)
final storageProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});
```

### 3. Feature-First Organization

Each feature is self-contained:
- **Data Layer**: API calls, caching, data transformation
- **Domain Layer**: Business logic, use cases
- **Presentation Layer**: UI, state management

## 📚 Key Components

### 1. Core Services

#### Storage Service
```dart
abstract class LocalStorageService {
  Future<void> save(String key, dynamic value);
  Future<dynamic> get(String key);
  Future<void> delete(String key);
}
```

#### Image Service
```dart
class ImageProcessor {
  Future<File?> processImage(File image);
  Widget buildImage(String url, {Widget? placeholder});
}
```

#### Analytics Service
```dart
abstract class AnalyticsService {
  void logEvent(String name, Map<String, dynamic>? params);
  void setUserProperty(String name, String value);
}
```

### 2. Feature Structure Example

```
features/auth/
├── data/
│   ├── datasources/
│   │   └── auth_remote_data_source.dart
│   ├── models/
│   │   └── user_model.dart
│   └── repositories/
│       └── auth_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── user_entity.dart
│   ├── repositories/
│   │   └── auth_repository.dart
│   └── usecases/
│       ├── login_use_case.dart
│       └── logout_use_case.dart
└── presentation/
    ├── providers/
    │   └── auth_provider.dart
    └── screens/
        └── login_screen.dart
```

### 3. Reusable UI Components

Located in `core/ui/`:
- `app_button.dart` - Standardized buttons
- `app_text_field.dart` - Form inputs
- `app_card.dart` - Card widgets
- `app_dialog.dart` - Dialog components
- `app_snackbar.dart` - Feedback messages

## 🔄 Integration with SDUI

### How to Adapt for Server-Driven UI

#### 1. Widget Layer
```dart
// core/ui/stac/
├── stac_widget_builder.dart  // Parses JSON to widgets
├── stac_widget_renderer.dart // Renders STAC components
└── stac_config_provider.dart // Manages STAC configs
```

#### 2. Data Layer Integration
```dart
// core/network/
├── stac_api_client.dart      // Fetches JSON configs
└── stac_cache_service.dart   // Caches UI configs
```

#### 3. State Management
```dart
// Combine Riverpod with STAC
final stacScreenProvider = FutureProvider.family<StacWidget, String>(
  (ref, screenId) async {
    final json = await fetchScreenConfig(screenId);
    return parseStacWidget(json);
  },
);
```

## 📖 Documentation References

The template includes comprehensive documentation:

### Main Docs (`.flutter_riverpod_clean_architecture_template/docs/`)

1. **ARCHITECTURE.md** - Overall architecture overview
2. **ARCHITECTURE_GUIDE.md** - Detailed architecture guide
3. **FEATURES.md** - Feature documentation
4. **LOCALIZATION_GUIDE.md** - i18n implementation
5. **BIOMETRIC_AUTH_GUIDE.md** - Authentication setup
6. **ANALYTICS_GUIDE.md** - Analytics integration
7. **OFFLINE_ARCHITECTURE_GUIDE.md** - Offline support
8. **IMAGE_HANDLING_GUIDE.md** - Image management
9. **FEATURE_FLAGS_GUIDE.md** - Feature toggling
10. **ACCESSIBILITY_GUIDE.md** - Accessibility features
11. **CICD_GUIDE.md** - CI/CD setup

### Key Patterns to Adopt

#### 1. Dependency Injection with Riverpod
```dart
final dataSourceProvider = Provider<RemoteDataSource>((ref) {
  return RemoteDataSourceImpl(client: ref.read(httpClientProvider));
});
```

#### 2. Repository Pattern
```dart
abstract class Repository {
  Future<Result<Data>> fetch();
}

class RepositoryImpl implements Repository {
  final DataSource remote;
  final DataSource local;
  
  @override
  Future<Result<Data>> fetch() async {
    try {
      final data = await remote.fetch();
      await local.save(data);
      return Success(data);
    } catch (e) {
      return local.fetch();
    }
  }
}
```

#### 3. Use Case Pattern
```dart
class LoginUseCase {
  final AuthRepository repository;
  
  LoginUseCase(this.repository);
  
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(params);
  }
}
```

## 🎨 UI Component Patterns

### Theme System
```dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    // ... additional theme config
  );
  
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    // ... additional theme config
  );
}
```

### Reusable Components
```dart
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonType type;
  
  const AppButton({
    required this.label,
    this.onPressed,
    this.type = ButtonType.primary,
  });
}
```

## 🚀 Migration Strategy

### Phase 1: Core Services
1. Integrate core services (storage, network, analytics)
2. Set up Riverpod providers
3. Create reusable UI components

### Phase 2: Feature Adoption
1. Migrate one feature at a time
2. Follow Clean Architecture layers
3. Implement proper error handling

### Phase 3: STAC Integration
1. Create STAC-specific providers
2. Build JSON-to-Widget bridge
3. Integrate with existing features

## 📝 Best Practices from Template

### 1. Error Handling
```dart
abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}
```

### 2. Result Pattern
```dart
sealed class Result<T> {}
class Success<T> extends Result<T> {
  final T data;
  Success(this.data);
}
class Error<T> extends Result<T> {
  final Failure failure;
  Error(this.failure);
}
```

### 3. Repository Caching
```dart
class CachedRepository {
  Future<Data> fetch() async {
    // Check cache first
    final cached = await cache.get();
    if (cached != null) return cached;
    
    // Fetch from network
    final data = await network.fetch();
    
    // Update cache
    await cache.set(data);
    return data;
  }
}
```

## 🔗 Related Documentation

- [Clean Architecture Guide](.flutter_riverpod_clean_architecture_template/docs/ARCHITECTURE_GUIDE.md)
- [Riverpod Documentation](https://riverpod.dev)
- [STAC Core Documentation](./stac_core/README.md)

## 📌 Summary

This template provides a solid foundation for:
- ✅ Clean Architecture implementation
- ✅ Scalable state management
- ✅ Feature-based organization
- ✅ Production-ready patterns
- ✅ Comprehensive documentation

Use this reference to guide architectural decisions and maintain consistency across the SDUI project.
