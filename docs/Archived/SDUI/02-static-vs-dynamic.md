# Static Core vs Dynamic SDUI Components

## Overview

This document defines the clear boundary between **Static Core** (native Flutter code that must remain compiled) and **Dynamic Parts** (server-driven UI components).

---

## 1. STATIC CORE COMPONENTS

### 1.1 Security Infrastructure ⚠️ NEVER DYNAMIC

| Component | Reason | Files |
|-----------|--------|-------|
| **Encryption/Decryption** | Critical security | `app_util.dart`, `api_client.dart` |
| **Certificate Management** | PKI operations | `certificate_util.dart` |
| **Secure Storage** | Sensitive data | `storage_util.dart` |
| **Key Management** | Cryptographic keys | `key_alias_model.dart` |
| **Digital Signature** | Transaction signing | `sign_model.dart` |
| **VPN Detection** | Security policy | `app_util.dart` |
| **Device Security Check** | Root/Jailbreak | `secure_plugin/` |

### 1.2 Authentication Core ⚠️ NEVER DYNAMIC

```
lib/
├── controller/authentication/
│   ├── capture_personal_picture_controller.dart
│   ├── capture_personal_video_controller.dart
│   ├── ekyc_controllers...
│   └── register_controllers...
├── model/authentication/
│   ├── auth_info_data.dart
│   ├── certificate_models...
│   └── ekyc_models...
├── service/authentication/
│   └── authentication_service.dart
└── util/
    ├── authentication_constants.dart
    └── automate_auth/
```

**Why Static:**
- Biometric data processing
- Face recognition (ZoomId, Yekta)
- National ID verification
- OTP handling
- Token management

### 1.3 Core App Shell ⚠️ KEEP STATIC

```dart
// main.dart - App initialization
Future<void> _initializeApp() async {
  await configureInjection();
  await _initSharedPreferencesManager();
  await _initStorageUtil();
  await _initFastCachedImageConfig();
  // ... other initializations
}

// DashboardScreen - Main navigation shell
class DashboardScreen extends StatelessWidget {
  // Bottom navigation bar
  // PageView for main sections
}
```

### 1.4 Network Security Layer ⚠️ NEVER DYNAMIC

```dart
// API Client with security features
class ApiClient {
  // SSL Pinning
  // Request encryption
  // Response decryption
  // Digital signature injection
  // VPN detection
}

// API Transformer
class ApiTransformer extends BackgroundTransformer {
  // Encrypt request body
  // Decrypt response body
}
```

### 1.5 Native Plugin Integrations ⚠️ KEEP STATIC

| Plugin | Purpose |
|--------|---------|
| `secure_plugin` | Device security |
| `otp_plugin` | OTP generation |
| `pichak_plugin` | Banking integration |
| `zoom_id` | Face verification |
| `local_auth` | Biometrics |
| `flutter_secure_storage` | Secure storage |

---

## 2. DYNAMIC SDUI COMPONENTS

### 2.1 Menu & Navigation 🟢 HIGH PRIORITY

**Current State:** Already partially server-driven!

```dart
// Current JSON structure (menuWeb.json)
{
  "tobank_services": [...],
  "facility_services": [...],
  "payment_services": [...],
  "citizen_services": [...],
  "customer_club": {...},
  "banner_data": {...}
}
```

**SDUI Enhancement:**
- Add screen navigation targets
- Add dynamic icons
- Add conditional visibility rules
- Add user segment targeting

### 2.2 BPMS Workflows 🟢 HIGHEST PRIORITY

**150+ screens** can become dynamic!

```
Current BPMS Structure:
├── Marriage Loan (24 screens)
├── Children Loan (23 screens)
├── Military Guarantee (47 screens)
├── Credit Card Facility (20 screens)
├── Card Physical Issue (9 screens)
├── Card Reissue (8 screens)
├── Rayan Card (8 screens)
├── Retail Loan (7 screens)
├── Close Deposit (5 screens)
└── Parsa Loan (39 screens)
```

**Why Perfect for SDUI:**
- Form-based workflows
- Step-by-step processes
- Server already defines form fields
- Validation rules from server
- Dynamic field requirements

### 2.3 List Views 🟢 HIGH PRIORITY

| Screen | Dynamic Elements |
|--------|------------------|
| Transaction List | Items, filters, sorting |
| Card List | Card items, actions |
| Notification List | Items, badges |
| Deposit List | Account items |
| Bill List | Bill items, status |

### 2.4 Detail Pages 🟢 MEDIUM PRIORITY

| Screen | Dynamic Elements |
|--------|------------------|
| Transaction Detail | Fields, actions |
| Card Detail | Info sections, actions |
| Process Detail | Status, timeline |
| Receipt/Report | Content layout |

### 2.5 Forms & Data Entry 🟢 HIGH PRIORITY

**Field Types to Support:**
- Text input (with masks)
- Dropdown/Select
- Date picker
- Document upload
- Image capture
- Signature pad
- Checkbox/Radio
- Amount input (with formatter)

### 2.6 Dialogs & Bottom Sheets 🟢 MEDIUM PRIORITY

- Confirmation dialogs
- Selection lists
- Info/Help content
- Error messages
- Success messages

### 2.7 Banners & Promotions 🟢 ALREADY DYNAMIC

```dart
class BannerData {
  int interval;
  bool isLoop;
  bool showDismiss;
  double minHeight;
  List<BannerItem> bannerItemList;
}

class BannerItem {
  String? type;       // Action type
  String? url;        // Target URL
  String? imageUrl;   // Banner image
  String? eventCode;  // Analytics
  bool? isDisable;    // Visibility
  String? message;    // Alt text
}
```

---

## 3. HYBRID COMPONENTS

### 3.1 Dashboard Home Page

**Static Parts:**
- Header with user info
- Bottom navigation
- Pull-to-refresh mechanism

**Dynamic Parts:**
- Card carousel
- Quick actions grid
- Banner slider
- Service shortcuts
- Announcement cards

### 3.2 Settings Screen

**Static Parts:**
- Biometric toggle
- Logout action
- App version

**Dynamic Parts:**
- Theme selection
- Notification preferences
- Help/Support links

### 3.3 Card Management

**Static Parts:**
- Card scanner camera
- PIN entry pad
- Biometric confirmation

**Dynamic Parts:**
- Card list
- Card actions menu
- Card details
- Reissue flow forms

---

## 4. Decision Matrix

| Component | Sensitivity | Complexity | Frequency | Decision |
|-----------|-------------|------------|-----------|----------|
| Login Flow | 🔴 HIGH | Medium | Rare | **STATIC** |
| eKYC | 🔴 HIGH | High | Rare | **STATIC** |
| Biometric | 🔴 HIGH | High | Often | **STATIC** |
| PIN Entry | 🔴 HIGH | Low | Often | **STATIC** |
| Menu Items | 🟢 LOW | Low | Often | **DYNAMIC** |
| BPMS Forms | 🟢 LOW | High | Often | **DYNAMIC** |
| Lists | 🟢 LOW | Low | Often | **DYNAMIC** |
| Details | 🟢 LOW | Low | Often | **DYNAMIC** |
| Banners | 🟢 LOW | Low | Often | **DYNAMIC** |
| Dialogs | 🟢 LOW | Low | Often | **DYNAMIC** |

---

## 5. Implementation Boundaries

### 5.1 Static Core Package Structure

```
lib/
├── core/
│   ├── auth/
│   │   ├── auth_service.dart
│   │   ├── biometric_service.dart
│   │   ├── ekyc_service.dart
│   │   └── session_manager.dart
│   ├── security/
│   │   ├── encryption_service.dart
│   │   ├── certificate_service.dart
│   │   ├── storage_service.dart
│   │   └── device_security.dart
│   ├── network/
│   │   ├── api_client.dart
│   │   ├── interceptors/
│   │   └── transformers/
│   └── navigation/
│       ├── app_router.dart
│       └── deep_link_handler.dart
```

### 5.2 SDUI Engine Package Structure

```
lib/
├── sdui/
│   ├── engine/
│   │   ├── sdui_engine.dart
│   │   ├── json_parser.dart
│   │   └── cache_manager.dart
│   ├── registry/
│   │   ├── widget_registry.dart
│   │   ├── action_registry.dart
│   │   └── validator_registry.dart
│   ├── widgets/
│   │   ├── containers/
│   │   ├── inputs/
│   │   ├── displays/
│   │   └── navigation/
│   ├── actions/
│   │   ├── navigate_action.dart
│   │   ├── api_action.dart
│   │   └── dialog_action.dart
│   └── bindings/
│       ├── data_binding.dart
│       └── expression_evaluator.dart
```

---

## 6. Communication Between Static & Dynamic

### 6.1 Static → Dynamic

```dart
// Static core provides context to SDUI
class SDUIContext {
  final String? authToken;
  final String? userId;
  final String? customerNumber;
  final String? nationalCode;
  final bool isAuthenticated;
  final bool hasBiometric;
  final Map<String, dynamic> userProfile;
}
```

### 6.2 Dynamic → Static

```dart
// SDUI requests static actions
enum StaticAction {
  requireAuthentication,
  requireBiometric,
  signTransaction,
  captureDocument,
  scanCard,
  showOTP,
  logout,
}

// Action handler in static core
class StaticActionHandler {
  Future<dynamic> handle(StaticAction action, Map<String, dynamic> params);
}
```

---

## 7. Security Considerations

### 7.1 JSON Validation

```dart
// All SDUI JSON must be validated
class SDUIValidator {
  bool validateSchema(Map<String, dynamic> json);
  bool validateSignature(String json, String signature);
  bool validateVersion(String version);
}
```

### 7.2 Action Whitelist

```dart
// Only allowed actions can be executed
final Set<String> allowedActions = {
  'navigate',
  'api_call',
  'show_dialog',
  'show_toast',
  'copy_text',
  'share',
  'open_url',
};

// Blocked actions (must go through static handlers)
final Set<String> blockedActions = {
  'write_storage',
  'read_secure_storage',
  'sign_data',
  'decrypt_data',
};
```

### 7.3 Data Sanitization

```dart
// All user inputs must be sanitized
class InputSanitizer {
  String sanitize(String input, String type);
  bool validate(String input, List<ValidationRule> rules);
}
```

---

## Next Document

→ [03-json-schema-design.md](./03-json-schema-design.md) - Detailed JSON Schema Design

