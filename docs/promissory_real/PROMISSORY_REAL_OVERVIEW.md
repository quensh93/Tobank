# Promissory Real - Real API Integration

## Overview

The **Promissory Real** flow demonstrates how to fetch and render SDUI (Server-Driven UI) content from a real backend API, as opposed to the local JSON files used in the regular Promissory flow.

## Architecture

```
┌────────────────────────────────────────────────────────────────────┐
│                   Promissory Real Flow                              │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│  ┌─────────────────────┐                                          │
│  │PromissoryRealScreen │                                          │
│  │   (StatefulWidget)  │                                          │
│  └──────────┬──────────┘                                          │
│             │                                                      │
│             ▼                                                      │
│  ┌─────────────────────┐     ┌─────────────────────┐              │
│  │  ConfigApiService   │────▶│  Configuration API   │              │
│  │    (Dio Client)     │◀────│    (Real Backend)    │              │
│  └──────────┬──────────┘     └─────────────────────┘              │
│             │                                                      │
│             ▼                                                      │
│  ┌─────────────────────┐                                          │
│  │    SDUI JSON        │                                          │
│  │  (from API value)   │                                          │
│  └──────────┬──────────┘                                          │
│             │                                                      │
│             ▼                                                      │
│  ┌─────────────────────┐                                          │
│  │    StacWidget       │                                          │
│  │  (Renders UI)       │                                          │
│  └─────────────────────┘                                          │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘
```

## Files

| Path | Description |
|------|-------------|
| `lib/stac/tobank/flows/promissory_old/dart/promissory_screen.dart` | Main screen widget |
| `lib/core/api/config_api/config_api_service.dart` | API service |
| `lib/core/api/config_api/config_api_models.dart` | Response models |
| `lib/core/api/config_api/config_api.dart` | Barrel file |

## API Details

### Endpoint
```
POST http://192.168.179.21:8101/api/configurations/v1.0/configs/resolve/flutter_key_1.flutter_promissory_key_1/1?page=0&size=10
```

### Request Headers
```
Content-Type: application/json
Accept: */*
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
The API returns a wrapper object with the SDUI JSON in `data.content[0].value`:

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
        "id": "4106dd66-9e8b-4d6f-a17d-309152dd827b",
        "pathKey": "flutter_key_1.flutter_promissory_key_1",
        "key": "flutter_promissory_key_1",
        "build": 1,
        "title": "intro",
        "value": {
          // This is the SDUI JSON to render
          "type": "scaffold",
          "appBar": {...},
          "body": {...}
        }
      }
    ]
  }
}
```

## Screen States

The `PromissoryRealScreen` handles four states:

1. **Loading** - Shows a circular progress indicator while fetching data
2. **Error** - Shows error message with retry button
3. **Success** - Renders the SDUI using `StacWidget`
4. **Empty** - Shows message when no data is returned

## Menu Integration

The flow is added to the menu in `GET_menu-items.json`:

```json
{
  "title": "سفته (API واقعی)",
  "description": "صدور سفته با استفاده از API واقعی",
  "icon": "{{appAssets.icons.wallet}}",
  "dartPath": "lib/stac/tobank/flows/promissory_old/dart/promissory_screen.dart",
  "jsonPath": null,
  "apiPath": null,
  "widgetType": "promissory_intro",
  "flowSteps": [
    "promissory_intro"
  ]
}
```

Note: `jsonPath` and `apiPath` are `null` because this flow uses the real API instead of local files.

## Comparison with Regular Promissory Flow

| Feature | Promissory (Local) | Promissory Real (API) |
|---------|-------------------|----------------------|
| Data Source | Local JSON files | Real backend API |
| Offline Support | ✅ Yes | ❌ No (needs network) |
| Dynamic Updates | ❌ No (requires app update) | ✅ Yes (server-side) |
| Buttons in Menu | Dart, JSON, API | Start only |
| File Structure | dart/, json/, api/ | dart/ only |

## Usage

### Accessing in App

1. Open the menu
2. Look for "سفته (API واقعی)" in the Linear Flows section
3. Tap "Start" to launch the screen

### Programmatic Navigation

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const PromissoryRealScreen(),
  ),
);
```

## Error Handling

The screen handles various error scenarios:

- **Network timeout** - Shows "Request timeout" message
- **Connection error** - Shows "Connection failed" message  
- **Server error** - Shows server error details
- **Empty response** - Shows "No SDUI content found" message
- **Render error** - Shows STAC parsing error details

All errors display a retry button for the user.

## Logging

The service logs all API activity using `AppLogger`:

```dart
// Request logging
AppLogger.d('ConfigAPI Request: POST /api/configurations/...');

// Response logging
AppLogger.d('ConfigAPI Response: 200');

// Error logging
AppLogger.e('ConfigAPI Error: Connection timeout');
```

## Future Improvements

- [ ] Add caching for offline mode
- [ ] Support multiple pages/flows
- [ ] Add authentication token support
- [ ] Implement pull-to-refresh
- [ ] Add skeleton loading state
