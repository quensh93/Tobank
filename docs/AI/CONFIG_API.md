# Config API - Server-Driven UI Configuration Layer

## Overview

The Config API is a Dio-based layer for fetching SDUI (Server-Driven UI) configurations from a real backend API. This enables dynamic UI rendering where the UI structure is defined server-side and delivered to the mobile app.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        Config API Layer                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────┐     ┌─────────────────┐                   │
│  │ ConfigApiService│────▶│  ConfigApiModels│                   │
│  │   (Dio Client)  │     │  (Response DTOs)│                   │
│  └────────┬────────┘     └─────────────────┘                   │
│           │                                                     │
│           ▼                                                     │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              Real Backend API                            │   │
│  │  http://192.168.179.21:8101/api/configurations/...      │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## Files

| File | Description |
|------|-------------|
| `config_api.dart` | Barrel file - exports all modules |
| `config_api_models.dart` | Data models for API response parsing |
| `config_api_service.dart` | Dio-based HTTP service |

## API Endpoint

### Base URL
```
http://192.168.179.21:8101
```

### Endpoint Pattern
```
POST /api/configurations/v1.0/configs/resolve/{pathKey}/{build}?page={page}&size={size}
```

### Request Body
```json
{
  "operator": "is",
  "dimension": {
    "app": "mobile"
  }
}
```

### Response Structure
```json
{
  "status": {
    "code": "CONFIG-200",
    "message": ["عملیات با موفقیت انجام شد"],
    "description": "Successful"
  },
  "data": {
    "pages": 1,
    "total": 1,
    "content": [
      {
        "id": "uuid",
        "pathKey": "flutter_key_1.flutter_promissory_key_1",
        "key": "flutter_promissory_key_1",
        "build": 1,
        "title": "intro",
        "value": {
          // SDUI JSON content here
          "type": "scaffold",
          "appBar": {...},
          "body": {...}
        }
      }
    ]
  },
  "meta": {
    "time": "2026-01-25T09:43:22.718865492Z",
    "traceId": "ab27f2438dd2ad39e3aa33e7728213db"
  }
}
```

## Usage

### Basic Usage

```dart
import 'package:tobank_sdui/core/api/config_api/config_api.dart';

// Create service instance
final configApiService = ConfigApiService();

// Fetch SDUI configuration
final sduiJson = await configApiService.fetchSduiConfig(
  pathKey: 'flutter_key_1.flutter_promissory_key_1',
  build: 1,
);

// Use with STAC
return StacWidget(sduiJson);
```

### With Custom Base URL

```dart
final configApiService = ConfigApiService(
  baseUrl: 'http://your-api-server:8101',
  timeout: const Duration(seconds: 60),
);
```

### Get Full Response (for debugging)

```dart
final response = await configApiService.fetchFullResponse(
  pathKey: 'flutter_key_1.flutter_promissory_key_1',
  build: 1,
);

print('Status: ${response.status.code}');
print('Total items: ${response.data?.total}');
print('SDUI Content: ${response.sduiContent}');
```

## Error Handling

The service throws `ConfigApiException` for various error scenarios:

```dart
try {
  final sduiJson = await configApiService.fetchSduiConfig(...);
} on ConfigApiException catch (e) {
  if (e.isTimeout) {
    // Handle timeout
  } else if (e.isConnectionError) {
    // Handle connection error
  } else {
    // Handle other errors
    print('Error: ${e.message}');
  }
}
```

## Models

### ConfigApiResponse
Root response object containing status, data, and meta.

### ConfigApiStatus
Status information including code, message array, and description.

### ConfigApiData
Data wrapper with pagination info and content list.

### ConfigApiContent
Individual configuration item containing the SDUI JSON in the `value` field.

### ConfigApiRequest
Request builder for constructing API calls.

## Integration with STAC

The SDUI JSON returned from `value` field is compatible with STAC framework:

```dart
// The value field contains STAC-compatible JSON
final sduiJson = await configApiService.fetchSduiConfig(...);

// Render using STAC
Widget build(BuildContext context) {
  return StacWidget(sduiJson);
}
```

## Future Improvements

- [ ] Add caching layer for offline support
- [ ] Add token-based authentication
- [ ] Add multi-page flow support
- [ ] Add config versioning support
