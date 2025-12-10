# Security Implementation Guide

## Overview

This guide covers the security features implemented in the STAC Hybrid App Framework, including secure API communication, input validation, secure storage, and Firebase authentication.

## Table of Contents

1. [Secure API Communication](#secure-api-communication)
2. [Input Validation](#input-validation)
3. [Secure Storage](#secure-storage)
4. [Firebase Authentication](#firebase-authentication)
5. [Security Best Practices](#security-best-practices)

---

## Secure API Communication

### Overview

The `SecureHttpClient` class enforces HTTPS-only communication, adds security headers, and optionally implements certificate pinning.

### Location

`lib/core/security/secure_http_client.dart`

### Features

- **HTTPS Enforcement**: All API calls must use HTTPS protocol
- **Security Headers**: Automatically adds security headers to requests
- **Certificate Pinning**: Optional certificate pinning for enhanced security
- **Certificate Validation**: Rejects invalid SSL/TLS certificates

### Usage

#### Basic Secure Client

```dart
import 'package:tobank_sdui/core/security/secure_http_client.dart';

// Create a secure Dio client
final dio = SecureHttpClient.createSecureClient(
  baseUrl: 'https://api.example.com',
  timeout: Duration(seconds: 30),
  headers: {
    'X-Custom-Header': 'value',
  },
);

// Use the client for API calls
final response = await dio.get('/screens/home_screen');
```

#### With Certificate Pinning

```dart
// Create client with certificate pinning
final dio = SecureHttpClient.createSecureClient(
  baseUrl: 'https://api.example.com',
  enableCertificatePinning: true,
  pinnedCertificates: [
    'AA:BB:CC:DD:EE:FF:00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD',
  ],
);
```

#### Add Security Interceptor

```dart
// Add security interceptor to existing Dio instance
SecureHttpClient.addSecurityInterceptor(dio);
```

### Security Headers

The following security headers are automatically added:

- `X-Content-Type-Options: nosniff` - Prevents MIME type sniffing
- `X-Frame-Options: DENY` - Prevents clickjacking
- `X-XSS-Protection: 1; mode=block` - Enables XSS protection
- `Strict-Transport-Security: max-age=31536000; includeSubDomains` - Enforces HTTPS

### Certificate Pinning

Certificate pinning helps prevent man-in-the-middle attacks by validating that the server's certificate matches a known fingerprint.

**To get certificate fingerprint:**

```bash
# Using OpenSSL
openssl s_client -connect api.example.com:443 < /dev/null | openssl x509 -fingerprint -noout -sha256
```

---

## Input Validation

### Overview

The `InputValidator` class provides comprehensive validation and sanitization methods to prevent injection attacks and ensure data integrity.

### Location

`lib/core/security/input_validator.dart`

### Features

- **JSON Structure Validation**: Validates JSON format and structure
- **Input Sanitization**: Removes dangerous characters and patterns
- **SQL Injection Prevention**: Detects SQL injection patterns
- **XSS Prevention**: Detects cross-site scripting patterns
- **URL Sanitization**: Validates and sanitizes URLs
- **Email/Phone Validation**: Validates common input formats

### Usage

#### Validate JSON Structure

```dart
import 'package:tobank_sdui/core/security/input_validator.dart';

try {
  final isValid = InputValidator.validateJsonStructure(jsonString);
  print('JSON is valid: $isValid');
} on ValidationException catch (e) {
  print('Validation failed: ${e.message}');
}
```

#### Sanitize User Input

```dart
// Sanitize text input
final userInput = '<script>alert("XSS")</script>Hello';
final sanitized = InputValidator.sanitizeInput(userInput);
print(sanitized); // Output: Hello

// Sanitize URL
final url = 'javascript:alert("XSS")';
final sanitizedUrl = InputValidator.sanitizeUrl(url);
print(sanitizedUrl); // Output: null (invalid URL)
```

#### Validate Email and Phone

```dart
// Validate email
final isValidEmail = InputValidator.isValidEmail('user@example.com');
print(isValidEmail); // true

// Validate phone number
final isValidPhone = InputValidator.isValidPhoneNumber('+1-234-567-8900');
print(isValidPhone); // true
```

#### Check for Injection Attacks

```dart
// Check for SQL injection
final hasSqlInjection = InputValidator.containsSqlInjection(
  "SELECT * FROM users WHERE id = 1 OR 1=1"
);
print(hasSqlInjection); // true

// Check for XSS
final hasXss = InputValidator.containsXss(
  '<script>alert("XSS")</script>'
);
print(hasXss); // true
```

#### Validate JSON Map

```dart
// Validate JSON structure with constraints
try {
  final json = {'type': 'text', 'data': 'Hello'};
  
  InputValidator.validateJsonMap(
    json,
    requiredFields: ['type', 'data'],
    fieldTypes: {
      'type': String,
      'data': String,
    },
    maxSize: 1024 * 1024, // 1MB max
  );
  
  print('JSON map is valid');
} on ValidationException catch (e) {
  print('Validation failed: ${e.message}');
}
```

#### Sanitize JSON Map

```dart
// Recursively sanitize all strings in JSON
final json = {
  'title': '<script>alert("XSS")</script>Title',
  'items': [
    {'name': '<b>Item 1</b>'},
    {'name': 'Item 2'},
  ],
};

final sanitized = InputValidator.sanitizeJsonMap(json);
// All HTML tags and scripts are removed
```

### Validation Methods

| Method | Description |
|--------|-------------|
| `validateJsonStructure()` | Validates JSON format and nesting depth |
| `sanitizeInput()` | Removes HTML tags, scripts, and dangerous patterns |
| `sanitizeUrl()` | Validates and sanitizes URLs |
| `isValidEmail()` | Checks email format |
| `isValidPhoneNumber()` | Checks phone number format |
| `validateLength()` | Validates string length bounds |
| `isAlphanumeric()` | Checks for alphanumeric characters only |
| `containsSqlInjection()` | Detects SQL injection patterns |
| `containsXss()` | Detects XSS patterns |
| `validateJsonMap()` | Validates JSON map structure |
| `escapeHtml()` | Escapes HTML special characters |
| `isValidFilePath()` | Validates file paths (prevents directory traversal) |
| `isValidApiKey()` | Validates API key format |
| `sanitizeJsonMap()` | Recursively sanitizes JSON map |

---

## Secure Storage

### Overview

The `SecureConfigStorage` class provides secure storage for sensitive configuration data using `flutter_secure_storage`.

### Location

`lib/core/security/secure_config_storage.dart`

### Features

- **Encrypted Storage**: All data is encrypted at rest
- **API Key Management**: Securely store API keys
- **Token Management**: Store authentication and refresh tokens
- **Firebase Config**: Store Firebase configuration securely
- **Custom API URL**: Store custom API endpoints
- **User Credentials**: Optionally store user credentials (use with caution)

### Usage

#### Initialize Storage

```dart
import 'package:tobank_sdui/core/security/secure_config_storage.dart';

// Initialize during app startup
await SecureConfigStorage.instance.initialize();
```

#### Store and Retrieve API Key

```dart
final storage = SecureConfigStorage.instance;

// Save API key
await storage.saveApiKey('your-api-key-here');

// Retrieve API key
final apiKey = await storage.getApiKey();
print('API Key: $apiKey');

// Check if API key exists
final hasKey = await storage.hasApiKey();
print('Has API key: $hasKey');

// Delete API key
await storage.deleteApiKey();
```

#### Manage Authentication Tokens

```dart
// Save auth token
await storage.saveAuthToken('eyJhbGciOiJIUzI1NiIs...');

// Save refresh token
await storage.saveRefreshToken('refresh-token-here');

// Retrieve tokens
final authToken = await storage.getAuthToken();
final refreshToken = await storage.getRefreshToken();

// Clear all tokens
await storage.clearAuthTokens();
```

#### Store Firebase Configuration

```dart
// Save Firebase config
await storage.saveFirebaseConfig({
  'projectId': 'my-project-id',
  'apiKey': 'firebase-api-key',
  'appId': 'firebase-app-id',
});

// Retrieve Firebase config
final config = await storage.getFirebaseConfig();
print('Firebase Project: ${config?['projectId']}');

// Check if config exists
final hasConfig = await storage.hasFirebaseConfig();
```

#### Store Custom API URL

```dart
// Save custom API URL (must be HTTPS)
await storage.saveCustomApiUrl('https://api.example.com');

// Retrieve custom API URL
final apiUrl = await storage.getCustomApiUrl();
print('API URL: $apiUrl');
```

#### Generic Secure Storage

```dart
// Store any secure value
await storage.saveSecureValue('custom_key', 'sensitive_value');

// Retrieve secure value
final value = await storage.getSecureValue('custom_key');

// Delete secure value
await storage.deleteSecureValue('custom_key');
```

#### Storage Management

```dart
// Get storage statistics
final stats = await storage.getStorageStats();
print('Total items: ${stats['total_items']}');
print('Has API key: ${stats['has_api_key']}');

// Export configuration (non-sensitive data only)
final config = await storage.exportConfig();
print('Config: $config');

// Clear all stored data (use with caution!)
await storage.clearAll();
```

### Security Notes

- All data is encrypted using platform-specific secure storage (Keychain on iOS, KeyStore on Android)
- Never log or expose sensitive data in production
- Use token-based authentication instead of storing passwords when possible
- Regularly rotate API keys and tokens
- Clear sensitive data when user logs out

---

## Firebase Authentication

### Overview

The `FirebaseAuthManager` class handles Firebase Authentication and admin role management for secure access to STAC JSON configurations.

### Location

`lib/core/security/firebase_auth_manager.dart`

### Features

- **Email/Password Authentication**: Sign in and sign up with email
- **Token Management**: Automatic token refresh and storage
- **Admin Role Management**: Check and manage admin privileges
- **Password Reset**: Send password reset emails
- **Email Verification**: Verify user email addresses

### Prerequisites

Add Firebase Auth to `pubspec.yaml`:

```yaml
dependencies:
  firebase_auth: ^5.0.0
```

### Usage

#### Sign In

```dart
import 'package:tobank_sdui/core/security/firebase_auth_manager.dart';

final authManager = FirebaseAuthManager.instance;

try {
  final user = await authManager.signInWithEmailAndPassword(
    email: 'user@example.com',
    password: 'password123',
  );
  
  print('Signed in: ${user.email}');
} on AuthException catch (e) {
  print('Sign in failed: ${e.message}');
}
```

#### Sign Up

```dart
try {
  final user = await authManager.signUpWithEmailAndPassword(
    email: 'newuser@example.com',
    password: 'password123',
    displayName: 'New User',
  );
  
  print('Account created: ${user.email}');
} on AuthException catch (e) {
  print('Sign up failed: ${e.message}');
}
```

#### Check Authentication Status

```dart
// Check if user is authenticated
if (authManager.isAuthenticated) {
  print('User is signed in');
  print('Email: ${authManager.email}');
  print('User ID: ${authManager.userId}');
}

// Listen to auth state changes
authManager.authStateChanges.listen((user) {
  if (user != null) {
    print('User signed in: ${user.email}');
  } else {
    print('User signed out');
  }
});
```

#### Admin Role Management

```dart
// Check if current user is admin
final isAdmin = await authManager.isAdmin();
print('Is admin: $isAdmin');

// Require admin access (throws exception if not admin)
try {
  await authManager.requireAdmin();
  print('User has admin access');
} on UnauthorizedException catch (e) {
  print('Access denied: ${e.message}');
}

// Set user admin role (only admins can do this)
await authManager.setUserAdmin('user-id-here', true);

// Get user role information
final role = await authManager.getUserRole('user-id-here');
print('User role: $role');
```

#### Token Management

```dart
// Get current ID token
final token = await authManager.getIdToken();
print('Token: $token');

// Refresh token
final newToken = await authManager.refreshToken();
print('Refreshed token: $newToken');
```

#### Password Reset

```dart
try {
  await authManager.sendPasswordResetEmail('user@example.com');
  print('Password reset email sent');
} on AuthException catch (e) {
  print('Failed to send reset email: ${e.message}');
}
```

#### Sign Out

```dart
await authManager.signOut();
print('User signed out');
```

### Firebase Security Rules

The Firebase security rules have been updated to enforce authentication and admin checks:

```javascript
// Check if user is authenticated
function isAuthenticated() {
  return request.auth != null;
}

// Check if user has admin role
function isAdmin() {
  return isAuthenticated() && (
    // Check custom claims first
    request.auth.token.get('admin', false) == true ||
    // Fallback to user_roles collection
    exists(/databases/$(database)/documents/user_roles/$(request.auth.uid)) &&
    get(/databases/$(database)/documents/user_roles/$(request.auth.uid)).data.admin == true
  );
}
```

**Rules Summary:**

- **STAC Screens**: Read access for authenticated users, write access for admins only
- **STAC Config**: Read access for authenticated users, write access for admins only
- **User Roles**: Users can read their own role, admins can manage all roles
- **Version History**: Read-only for authenticated users, created by admins

### Setting Up Admin Users

#### Option 1: Using Firebase Console

1. Go to Firebase Console → Authentication
2. Select a user
3. Set custom claims using Firebase Admin SDK

#### Option 2: Using Firestore

1. Create a document in `user_roles` collection
2. Set `admin: true` for the user

```dart
// Example: Make first user admin
final firstUser = await authManager.currentUser;
if (firstUser != null) {
  await FirebaseFirestore.instance
      .collection('user_roles')
      .doc(firstUser.uid)
      .set({'admin': true});
}
```

---

## Security Best Practices

### 1. API Communication

- ✅ Always use HTTPS for API calls
- ✅ Implement certificate pinning for production
- ✅ Add security headers to all requests
- ✅ Validate SSL/TLS certificates
- ✅ Use timeout values to prevent hanging requests
- ❌ Never use HTTP in production
- ❌ Never disable certificate validation

### 2. Input Validation

- ✅ Validate all user inputs before processing
- ✅ Sanitize inputs before displaying
- ✅ Check for injection patterns (SQL, XSS)
- ✅ Validate JSON structure and size limits
- ✅ Use type-safe parsing
- ❌ Never trust user input
- ❌ Never execute user-provided code

### 3. Secure Storage

- ✅ Use secure storage for sensitive data
- ✅ Encrypt data at rest
- ✅ Clear sensitive data on logout
- ✅ Rotate API keys and tokens regularly
- ✅ Use token-based authentication
- ❌ Never store passwords in plain text
- ❌ Never log sensitive data
- ❌ Never commit API keys to version control

### 4. Authentication

- ✅ Implement proper authentication
- ✅ Use strong password requirements
- ✅ Implement token refresh mechanism
- ✅ Verify email addresses
- ✅ Implement role-based access control
- ❌ Never store passwords on client
- ❌ Never expose admin credentials
- ❌ Never skip authentication checks

### 5. Firebase Security

- ✅ Use Firebase security rules
- ✅ Implement admin role checks
- ✅ Validate data structure in rules
- ✅ Use authentication for all operations
- ✅ Audit security rules regularly
- ❌ Never allow public write access
- ❌ Never trust client-side validation only
- ❌ Never expose sensitive data in rules

### 6. Error Handling

- ✅ Handle errors gracefully
- ✅ Log errors for debugging
- ✅ Show user-friendly error messages
- ✅ Implement retry logic for transient errors
- ❌ Never expose stack traces to users
- ❌ Never reveal system information in errors
- ❌ Never ignore security exceptions

### 7. Code Security

- ✅ Keep dependencies up to date
- ✅ Use code analysis tools
- ✅ Review security-related code changes
- ✅ Follow secure coding guidelines
- ✅ Implement proper error handling
- ❌ Never use deprecated security features
- ❌ Never disable security warnings
- ❌ Never hardcode secrets in code

---

## Testing Security Features

### Test Secure HTTP Client

```dart
test('should enforce HTTPS', () {
  expect(
    () => SecureHttpClient.createSecureClient(
      baseUrl: 'http://api.example.com', // HTTP not allowed
    ),
    throwsArgumentError,
  );
});

test('should validate URL is HTTPS', () {
  expect(SecureHttpClient.isSecureUrl('https://api.example.com'), true);
  expect(SecureHttpClient.isSecureUrl('http://api.example.com'), false);
});
```

### Test Input Validator

```dart
test('should detect SQL injection', () {
  final input = "SELECT * FROM users WHERE id = 1 OR 1=1";
  expect(InputValidator.containsSqlInjection(input), true);
});

test('should detect XSS', () {
  final input = '<script>alert("XSS")</script>';
  expect(InputValidator.containsXss(input), true);
});

test('should sanitize input', () {
  final input = '<script>alert("XSS")</script>Hello';
  final sanitized = InputValidator.sanitizeInput(input);
  expect(sanitized, 'Hello');
});
```

### Test Secure Storage

```dart
test('should store and retrieve API key', () async {
  final storage = SecureConfigStorage.instance;
  await storage.initialize();
  
  await storage.saveApiKey('test-api-key');
  final apiKey = await storage.getApiKey();
  
  expect(apiKey, 'test-api-key');
});

test('should enforce HTTPS for API URL', () async {
  final storage = SecureConfigStorage.instance;
  await storage.initialize();
  
  expect(
    () => storage.saveCustomApiUrl('http://api.example.com'),
    throwsArgumentError,
  );
});
```

---

## Troubleshooting

### Issue: Certificate Pinning Fails

**Solution**: Verify certificate fingerprint matches server certificate

```bash
# Get certificate fingerprint
openssl s_client -connect api.example.com:443 < /dev/null | openssl x509 -fingerprint -noout -sha256
```

### Issue: Secure Storage Not Initialized

**Solution**: Call `initialize()` before using secure storage

```dart
await SecureConfigStorage.instance.initialize();
```

### Issue: Firebase Auth Not Working

**Solution**: Ensure Firebase is properly configured

1. Add `firebase_auth` to `pubspec.yaml`
2. Run `flutter pub get`
3. Configure Firebase in your app
4. Update security rules in Firebase Console

### Issue: Input Validation Too Strict

**Solution**: Adjust validation rules or use custom validation

```dart
// Custom validation for specific use case
bool isValidCustomInput(String input) {
  // Your custom validation logic
  return true;
}
```

---

## Summary

The security implementation provides:

1. **Secure API Communication** - HTTPS enforcement and certificate pinning
2. **Input Validation** - Comprehensive validation and sanitization
3. **Secure Storage** - Encrypted storage for sensitive data
4. **Firebase Authentication** - User authentication and admin role management

All security features work together to protect your STAC application from common security threats while maintaining ease of use for developers.

For more information, see:
- [API Layer Guide](05-api-layer-guide.md)
- [Firebase Integration](07-firebase-integration.md)
- [Production Deployment](12-production-deployment.md)
