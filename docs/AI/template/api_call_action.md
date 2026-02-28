# StacApiCallAction Documentation

`StacApiCallAction` is a flexible, highly customizable action for handling server-driven API calls (SDUI) in the Tobank application. 

It provides everything needed to make a network request, handle custom base URLs, manage headers, bind response data to variables, and handle specific HTTP status codes with unique actions.

## 🌟 Key Features
- **Custom Base URLs**: Override the default configured application Base URL.
- **Header Management**: Append custom headers or completely overwrite and ignore the app's default headers.
- **Data Binding**: Bind the entire JSON response to a variable name (e.g., `{{depositResponse.body}}`).
- **Custom Error Handling**: Override the generic app error handlers by specifying explicit actions for specific status codes (e.g., `403` or `500`).

---

## 🛠️ Parameters Configuration

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `actionType` | `String` | `'apiCall'` | The type identifier for the Stac framework. |
| `path` | `String` | **Required** | The API endpoint path (e.g., `/api/v1/users`). Uses the default Base URL unless `fullUrl` is provided. |
| `method` | `String` | `'get'` | The HTTP method (`get`, `post`, `put`, `delete`, etc). |
| `headers` | `Map` | `null` | Custom headers to send with the request. By default, these are merged with the default app headers. |
| `ignoreDefaultHeaders` | `bool` | `false` | If `true`, the app's default headers (like tokens or app versions) will be completely ignored, and ONLY the headers provided in `headers` will be evaluated for this call. |
| `data` | `dynamic`| `null` | The request body data (JSON map, list, or string). |
| `data_bind` | `String` | `null` | A variable name to store the HTTP response. You can later access `{{variableName.body}}`, `{{variableName.statusCode}}`, or `{{variableName.headers}}` in subsequent SDUI actions (like `StacCustomSetValueAction`). |
| `fullUrl` | `String` | `null` | If provided, this URL completely overrides the global base URL for this specific API call. |
| `results` | `List` | `null` | A list of result objects mapped to specific `statusCode` values. See examples below. |

---

## 📖 Complete Examples

### 1. Basic Example (With Default Headers and Base URL)
This is a standard GET request. It uses the app's defined Base URL and injects the app's default headers automatically.

```json
{
  "actionType": "apiCall",
  "path": "/api/digitalbanking/deposits/v1.0/customer/{{userData.nationalCode}}",
  "method": "get",
  "data_bind": "depositResponse",
  "results": [
    {
      "statusCode": 200,
      "action": {
        "actionType": "setValue",
        "values": [
          {
            "key": "deposits.rawData",
            "value": "{{depositResponse.body}}"
          }
        ]
      }
    }
  ]
}
```

### 2. Overriding Base URL and Adding Headers
Use `fullUrl` to hit external APIs directly, and `headers` to pass special request headers.

```json
{
  "actionType": "apiCall",
  "path": "/ignored-path", 
  "fullUrl": "https://api.external-domain.com/v2/services",
  "method": "post",
  "data_bind": "externalResponse",
  "headers": {
    "X-Custom-Feature": "ExternalServiceIntegration",
    "Content-Type": "application/json"
  },
  "data": {
    "requestId": "{{form.request_id}}"
  },
  "results": [
    {
      "statusCode": 200,
      "action": {
        "actionType": "setValue",
        "key": "externalData",
        "value": "{{externalResponse.body.result}}"
      }
    }
  ]
}
```

### 3. Ignoring Default Headers (`ignoreDefaultHeaders: true`)
Sometimes you want to make an unauthenticated call or reach a public API without sending the user's `Authorization` token. By setting `ignoreDefaultHeaders: true`, the call strips away all default headers.

```json
{
  "actionType": "apiCall",
  "fullUrl": "https://api.public-service.com/prices",
  "method": "get",
  "ignoreDefaultHeaders": true,
  "headers": {
    "Accept": "application/json"
  },
  "data_bind": "priceData",
  "results": [
    {
      "statusCode": 200,
      "action": {
        "actionType": "setValue",
        "key": "prices",
        "value": "{{priceData.body}}"
      }
    }
  ]
}
```

### 4. Custom Error Handling & Core App Fallbacks
By default, the global STAC engine intercepts common API errors (like `401 Unauthorized`, `403 Forbidden`, or `500 Server Error`). For these standard errors, the backend STAC core might already have global Interceptors in place to show SnackBars, dialogs, or login screens. 

**Important Data Scope Behavior**: 
When an API call returns an error, its payload is ALWAYS written to the global `{{data}}` registry key. Even if you explicitly set `data_bind`, the `{{data}}` legacy key is still populated. This guarantees that global core App interceptors (which know nothing about your custom `data_bind`) will still function natively.

#### Local Error UI Overrides (`statusCode: -1`)
While core actions might show the *error graphic/snackbar*, the Core framework **cannot reset your screen's local UI state** (e.g., stopping a loading spinner button). You must handle resetting localized variables using the wildcard `-1` status block, which safely acts as a Catch-All fallback for *any* unhandled status code.

```json
{
  "actionType": "apiCall",
  "path": "/api/secure/transaction",
  "method": "post",
  "data_bind": "txResponse",
  "results": [
    {
      "statusCode": 200,
      "action": {
        "actionType": "navigate",
        "routeName": "success_screen"
      }
    },
    {
      "statusCode": -1,
      "action": {
        "actionType": "setValue",
        "values": [
          { "key": "isButtonLoading", "value": false }
        ]
      }
    }
  ]
}
```

> **Note**: For local fallback SnackBar messages, if `data_bind` is used, it is heavily recommended to read from `{{responses.txResponse.data.status.message.0}}` rather than the global `{{data}}` key to avoid race conditions with multiple background APIs overwriting the global state.
