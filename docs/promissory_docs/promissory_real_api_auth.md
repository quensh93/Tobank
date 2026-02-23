# Promissory Real API Authentication (Static & Dynamic)

This document details the implementation of the "Real API" Promissory Flow authentication, specifically the "Static" (Nooshin) and "Dynamic" login mechanisms introduced to facilitate real API testing.

## Overview

Two new login mechanisms have been added to the `promissory_real_intro` screen:
1.  **Static Login (Nooshin):** A one-tap button that performs a background login using hardcoded test credentials.
2.  **Dynamic Login:** A form-based screen where users can manually input credentials to log in.

Both methods authenticate against the real API and store the resulting access token securely for use in subsequent API calls within the promissory flow.

## 1. Static Login (Nooshin)

This method allows for quick token retrieval without manual input.

*   **Trigger:** "Static Login (Nooshin)" button on `promissory_real_intro` screen.
*   **Action Parser:** `PromissoryLoginActionParser` (`promissory_real_login` action type).
*   **Credentials (Hardcoded):**
    *   National ID: `0063192373`
    *   Mobile: `09121877519`
    *   GPay Token: `1234`
    *   Birth Date: `13610629`
    *   CIF: `123`
*   **Behavior:**
    1.  Shows a Snackbar: "در حال دریافت توکن ثابت..." (Fetching static token...).
    2.  Calls `PromissoryRealAuthService.login()`.
    3.  On success, saves the token to secure storage and shows a success Snackbar.
    4.  On failure, shows an error Snackbar.

## 2. Dynamic Login

This method allows testing with arbitrary user credentials.

*   **Trigger:** "Dynamic Login" button on `promissory_real_intro` screen.
*   **Navigation:** Navigates to `PromissoryRealLoginScreen` (widget type: `promissory_real_login_form`).
*   **UI:** A form requesting National ID, Mobile Number, GPay Token, Birth Date, and CIF.
*   **Behavior:**
    1.  User fills out the form and taps "Login & Save Token".
    2.  Calls `PromissoryRealAuthService.login()` with the inputs.
    3.  On success, saves the token to secure storage. This allows you to proceed with other API calls in the flow using the new user context.

## 3. Implementation Details

### API Endpoint
*   **URL:** `http://192.168.107.22:8280/api/digitalbanking/logins/v1.0/tobank/users`
*   **Method:** `POST`
*   **Headers:**
    *   `app-platform`: `android`
    *   `serviceauthorization`: `Basic QzFVb3ZyYUVSQ0NRYm9ZcUhhcFVqZk9McWZNYTpXU1N4WUFWUThPUFVjS0FTZHJNaUhIX2NmWE10UmNCWW5wNGdoT2ZKQTdRYQ==`
    *   (And standard headers: content-type, device-uuid, etc.)

### Secure Token Storage
The `AuthManager` class is used to store the retrieved token.
*   **Dart Class:** `lib/core/api/auth/auth_manager.dart`
*   **Storage Keys:** `stac_access_token` (and related refresh keys).
*   **Usage:**
    *   The `AuthManager` automatically handles saving to `FlutterSecureStorage`.
    *   Subsequent API calls using `ConfigApiService` or other services utilizing `AuthInterceptor` (or manually retrieving via `AuthManager.getAccessToken()`) will automatically include this token in the `Authorization: Bearer <token>` header.

### Key Files
*   `lib/stac/tobank/flows/promissory_real/dart/promissory_real_auth_service.dart`: Shared logic for API call and token saving.
*   `lib/stac/tobank/flows/promissory_real/dart/promissory_login_action_parser.dart`: Parser for the static login action.
*   `lib/stac/tobank/flows/promissory_real/dart/promissory_real_login_screen.dart`: The form UI for dynamic login.
*   `lib/core/stac/parsers/widgets/promissory_real_login_parser.dart`: Parser to register the login screen in STAC.

## 4. How to Use Saved Token

Once logged in (via either method), the token is stored globally in the app's secure storage.

**Method A: Automatic (Recommended)**
If you are using `ConfigApiService` or any Dio instance configured with `AuthInterceptor`, you don't need to do anything. The interceptor will automatically fetch the token from `AuthManager` and attach it to the header.

**Method B: Manual Retrieval**
If you need the token for a specific manual request:

```dart
final authManager = AuthManager(storage: const FlutterSecureStorage());
await authManager.initialize(); // Ensure cache is loaded
final token = await authManager.getAccessToken();

if (token != null) {
  // Use token...
}
```

## 5. Troubleshooting
*   **LogCategory.network errors:** Check `promissory_real_auth_service.dart` and ensure it imports the correct `logger.dart` and uses `LogCategory.network` or `LogCategory.auth` (if defined in your updated generic category list).
*   **"No token found in successful login response":** The login API response structure might have changed. Check the `login` method in `promissory_real_auth_service.dart` to ensure it parses the JSON correctly (currently checks `access_token`, `token`, `result['access_token']`, etc.).


