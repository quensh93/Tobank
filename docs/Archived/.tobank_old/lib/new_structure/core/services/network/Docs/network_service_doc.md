Below is a simple `networkServiceDoc.md` file that documents the new network service we created. It includes an overview, a map of the components, a description of the data flow, and a list of files with their responsibilities. The documentation is concise and easy to understand, suitable for developers who need to work with or maintain the network service.

---

# Network Service Documentation

## Overview

The network service is a modular, robust, and type-safe solution for handling HTTP requests in a Flutter application. It uses `Dio` for HTTP communication, `fpdart` for functional error handling, and `freezed` for type-safe failure models. The service includes features like pre-request checks, request signing, logging, error handling, and Sentry integration for crash reporting.

The main goals of the network service are:
- **Type Safety:** Use `Either<AppFailure, Map>` to handle success and failure cases.
- **Error Handling:** Map errors to meaningful `AppFailure` types for consistent handling.
- **Logging:** Log requests, responses, and errors for debugging.
- **Extensibility:** Easily add new features (e.g., new HTTP methods, transformations).

## Component Map

Below is a map of the key components and their relationships:

```
[UI/Repository] --> [DioManager]
                     |
                     v
[DioConfig]   [DioInterceptors] --> [LogService]
    |              |
    v              v
[DioTransformer]  [Sentry]
    |
    v
[ApiMiddleware] --> [AppFailureHandler] --> [ApiFailureHandler]
    |                   |                     |
    v                   v                     v
[Response]     [AppFailureFactory]    [ApiFailureFactory]
```

### Component Descriptions

- **DioManager**: The core class that orchestrates HTTP requests (GET, POST, PUT). It handles pre-checks, request signing, and error handling.
- **DioConfig**: Configures the `Dio` instance (e.g., base URL, timeouts, status codes).
- **DioInterceptors**: Adds logging (via `LogService`) and Sentry integration to the `Dio` instance.
- **LogService**: Logs requests, responses, and errors for debugging.
- **DioTransformer**: Handles request/response transformations (e.g., encryption, decryption, base64 encoding).
- **ApiMiddleware**: Processes responses, handling success and error cases.
- **AppFailureHandler**: Maps responses to `AppFailure` types for application-level errors.
- **ApiFailureHandler**: Maps API-specific errors to `ApiFailure` types.
- **AppFailureFactory**: Creates `AppFailure` instances from `DioException`s and status codes.
- **ApiFailureFactory**: Creates `ApiFailure` instances from error messages.
- **AppUtil**: Provides utility functions (e.g., network checks, device security checks, request signing).

## Data Flow

The data flow describes how a request is processed from the UI to the network and back:

1. **Initiate Request**: The UI or a repository calls `DioManager.getRequest` (or `postRequest`, `putRequest`) with an endpoint and parameters.
2. **Pre-Request Checks**: `DioManager` checks for VPN, network connectivity, and device security. If any check fails, it returns `Left(AppFailure)`.
3. **Configure Dio**: `DioConfig` sets up the `Dio` instance with the base URL, method, timeouts, and success status codes.
4. **Add Interceptors**: `DioInterceptors` adds logging (via `LogService`) and Sentry integration.
5. **Set Transformer**: `DioTransformer` is set to handle request/response transformations (e.g., encryption, decryption).
6. **Prepare Headers**: `DioManager` adds default headers (e.g., `Authorization` if a token is required).
7. **Sign Request**: If required, `DioManager` signs the request body and adds signing headers.
8. **Send Request**: `Dio` sends the HTTP request to the server.
9. **Handle Response**: `ApiMiddleware` processes the response:
    - Success (200–299): Returns `Right(Map<String, dynamic>)`.
    - Error: Uses `AppFailureHandler` and `ApiFailureHandler` to map the error to `Left(AppFailure)`.
10. **Log Events**: `DioInterceptors` logs the request, response, and any errors via `LogService`.
11. **Return Result**: `DioManager` returns `Either<AppFailure, Map<String, dynamic>>` to the caller.

### Example Flow: Fetching User Data

- **Step 1:** UI calls `userRepository.fetchUser("123")`, which calls `dioManager.getRequest(endpoint: '/users/123', requireToken: true)`.
- **Step 2:** `DioManager` checks network (online), VPN (none), and skips device security (not required).
- **Step 3:** `DioConfig` configures `Dio` with base URL `https://api.example.com/api/v2`.
- **Step 4:** `DioInterceptors` logs the request: `REQUEST[GET] => /users/123`.
- **Step 5:** `Dio` sends the request to `https://api.example.com/api/v2/users/123`.
- **Step 6:** Server responds with `200` and `{"id": "123", "name": "John Doe"}`.
- **Step 7:** `ApiMiddleware` returns `Right({"id": "123", "name": "John Doe"})`.
- **Step 8:** `DioInterceptors` logs the response: `RESPONSE[200] => Data: {"id": "123", "name": "John Doe"}`.
- **Step 9:** UI receives `Right({"id": "123", "name": "John Doe"})` and displays the user data.

If the device is offline, the flow stops at Step 2, returning `Left(AppFailure.noConnectionFailure())`.

## Files and Responsibilities

Below is a list of the key files in the network service, organized by directory, with their responsibilities:

### Directory: `lib/new_structure/core/network`

- **dio/dio_manager.dart**
    - **Responsibility:** Orchestrates HTTP requests (GET, POST, PUT). Handles pre-checks, request signing, header preparation, and error handling.
    - **Key Class:** `DioManager`

- **dio/dio_config.dart**
    - **Responsibility:** Configures the `Dio` instance with base settings (e.g., base URL, timeouts, status codes).
    - **Key Class:** `DioConfig`

- **dio/dio_interceptors.dart**
    - **Responsibility:** Adds logging (via `LogService`) and Sentry integration to the `Dio` instance.
    - **Key Class:** `DioInterceptors`

- **dio/dio_transformer.dart**
    - **Responsibility:** Transforms requests and responses (e.g., encryption, decryption, base64 encoding).
    - **Key Class:** `DioTransformer`

- **services/network/logging/log_service.dart**
    - **Responsibility:** Logs requests, responses, and errors for debugging.
    - **Key Classes:** `LogService` (abstract), `ApiLogService` (implementation)

- **api_middleware/api_middleware.dart**
    - **Responsibility:** Processes responses, handling success and error cases by mapping to `Either<AppFailure, Map>`.
    - **Key Class:** `ApiMiddleware`

- **failures/app_failure/app_failure.dart**
    - **Responsibility:** Defines the `AppFailure` union type for application-level failures.
    - **Key Class:** `AppFailure`

- **failures/app_failure/app_failure_factory.dart**
    - **Responsibility:** Creates `AppFailure` instances from `DioException`s and status codes.
    - **Key Class:** `AppFailureFactory`

- **failures/app_failure/app_failure_handler.dart**
    - **Responsibility:** Maps response errors to `AppFailure` types, delegating API-specific errors to `ApiFailureHandler`.
    - **Key Class:** `AppFailureHandler`

- **failures/api_failure/api_failure.dart**
    - **Responsibility:** Defines the `ApiFailure` union type for API-specific failures.
    - **Key Class:** `ApiFailure`

- **failures/api_failure/api_failure_factory.dart**
    - **Responsibility:** Creates `ApiFailure` instances from error messages.
    - **Key Class:** `ApiFailureFactory`

- **failures/api_failure/api_failure_handler.dart**
    - **Responsibility:** Extracts error messages from API responses and maps them to `ApiFailure` types.
    - **Key Class:** `ApiFailureHandler`

### Directory: `lib/util`

- **app_util.dart**
    - **Responsibility:** Provides utility functions (e.g., network checks, device security checks, request signing, token retrieval).
    - **Key Class:** `AppUtil`

### Directory: `lib/new_structure/core/constants/addresses`

- **url_addresses.dart**
    - **Responsibility:** Defines URL addresses (e.g., base URL for the API).
    - **Key Class:** `UrlAddresses`

## Additional Notes

- **Error Handling:** The service uses `Either` from `fpdart` to handle success (`Right`) and failure (`Left`) cases. Failures are represented as `AppFailure` or `ApiFailure` types.
- **Logging:** All requests, responses, and errors are logged in debug mode using `LogService`. In non-debug mode, errors are sent to Sentry.
- **Extensibility:** To add a new HTTP method (e.g., DELETE), create a new method in `DioManager` (e.g., `deleteRequest`) that calls `_makeRequest` with `method: 'DELETE'`.

For more details, refer to the source code or the data flow explanation in the project documentation.

---

This `networkServiceDoc.md` file provides a clear and concise overview of the network service, making it easy for developers to understand its structure, flow, and components. You can save this content as `networkServiceDoc.md` in your project’s documentation directory (e.g., `docs/networkServiceDoc.md`). If you need additional sections (e.g., setup instructions, testing guide), let me know!