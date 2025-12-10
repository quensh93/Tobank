# Tobank App - Project Analysis for SDUI Migration

## Executive Summary

This document provides a comprehensive analysis of the Tobank banking application to design a hybrid SDUI (Server-Driven UI) architecture. The app will be divided into **Static Core** (security-critical, native Flutter) and **Dynamic Parts** (server-driven, JSON-based).

---

## 1. Current Project Structure

### 1.1 Directory Overview

```
lib/
├── controller/         # 243 GetX Controllers
├── model/             # 559 Data Models
├── service/           # 51 Service Classes (API Layer)
├── ui/                # 775 UI Components & Screens
├── util/              # 49 Utility Classes
├── widget/            # 8 Common Widgets
├── new_structure/     # Clean Architecture (161 files)
│   ├── core/          # DI, Theme, Network, Utils
│   └── features/      # Feature-based modules (Bloc pattern)
├── gen/               # Generated Assets
├── generated/         # Localization
└── main.dart          # Entry Point
```

### 1.2 Technology Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter 3.2+ |
| State Management | GetX (main), Bloc (new_structure) |
| DI | get_it + injectable |
| Network | Dio with custom encryption |
| Storage | flutter_secure_storage, get_storage |
| Auth/Security | ZoomId, Yekta eKYC, Biometric |
| Logging | Sentry, Talker |

---

## 2. Feature Categorization

### 2.1 Main Feature Areas

| Feature Area | Screens | Controllers | Priority |
|--------------|---------|-------------|----------|
| **Authentication** | 29 | 21 | STATIC |
| **Dashboard** | 43 | 12 | HYBRID |
| **Card Management** | 36 | 6 | DYNAMIC |
| **BPMS Workflows** | 157 | 71 | DYNAMIC |
| **Deposit/Transfer** | 20 | 9 | DYNAMIC |
| **Promissory** | 78 | 19 | DYNAMIC |
| **Payments** | 45 | 15 | DYNAMIC |
| **Settings** | 5 | 1 | HYBRID |

### 2.2 BPMS (Business Process Management) - Critical for SDUI

The app has extensive workflow/form handling via BPMS:

```
BPMS Processes:
├── Marriage Loan Procedure (24 screens)
├── Children Loan Procedure (23 screens)
├── Military Guarantee (47 screens)
├── Credit Card Facility (20 screens)
├── Card Physical Issue (9 screens)
├── Rayan Card Facility (8 screens)
├── Retail Loan (7 screens)
├── Close Deposit (5 screens)
└── Document Completion (1 screen)
```

---

## 3. Current Architecture Patterns

### 3.1 Controller Pattern (GetX)

```dart
class MarriageLoanProcedureController extends GetxController {
  // State Variables
  bool isLoading = false;
  bool hasError = false;
  PageController pageController = PageController();
  
  // Form Data
  TextEditingController trackingCodeController = TextEditingController();
  EnumValue? selectedMarriageLoanAmountData;
  List<EnumValue> marriageLoanAmountDataList = [];
  
  // API Response Models
  ProcessStartFormDataResponse? processStartFormDataResponse;
  StartProcessResponse? startProcessResponse;
  ApplicantTaskListResponse? applicantTaskListResponse;
  
  // Methods
  void validateCustomerCheckPage() { ... }
  void _startProcess() { ... }
  void getApplicantTaskListRequest() { ... }
}
```

### 3.2 API Provider Pattern

```dart
enum ApiProviderEnum {
  startProcess(
    title: 'Start BPMS process',
    path: 'dibalite/process/start',
    method: ApiMethod.post,
    requireBase64EncodedBody: true,
    requireEkycSign: true,
    successStatusCodes: [200, 409],
  ),
  // 200+ API endpoints defined
}
```

### 3.3 Menu Data Model (Already Server-Driven!)

```dart
class MenuDataModel {
  List<MenuItemData> facilityServices;
  List<MenuItemData> tobankServices;
  List<MenuItemData> paymentServices;
  List<MenuItemData> citizenServices;
  MenuItemData? daranService;
  MenuItemData? customerClub;
  BannerData? bannerData;
}

class MenuItemData {
  String? uuid;
  String? title;
  String? subtitle;
  int? order;
  String? message;
  bool? isDisable;
  bool? requireNationalCode;
  bool? requireCard;
  bool? requireDeposit;
  List<MenuItemData>? child;
}
```

### 3.4 Form Field Pattern (BPMS)

```dart
class TaskDataFormField {
  String? id;           // Field identifier
  String? label;        // Display label
  String? type;         // Field type (string, enum, date, etc.)
  Value? value;         // Current value
  List<EnumValue>? enumValues;  // Dropdown options
}

class EnumValue {
  String key;   // Value key
  String title; // Display title
}
```

---

## 4. Security Components (STATIC CORE)

### 4.1 Authentication & Identity

| Component | File | Purpose |
|-----------|------|---------|
| MainController | `main_controller.dart` | Auth state, session management |
| AuthInfoData | `auth_info_data.dart` | User credentials, tokens |
| StorageUtil | `storage_util.dart` | Secure storage operations |
| Certificate Utils | `certificate_util.dart` | Digital signature, PKI |

### 4.2 Secure Storage Keys

```dart
// Critical storage keys that must remain static
- authInfoSecureStorage      // User auth data
- authenticateCertificateModel  // Digital certificate
- encryptionKeyPairSecureStorage  // RSA keys
- passwordSecureStorage      // User password
- keyAliasModel             // Key management
- base64UserSignatureImage  // Signature
```

### 4.3 eKYC Providers

```dart
enum EKycProvider {
  zoomId,  // Biometric verification
  yekta,   // Alternative provider
}
```

---

## 5. Dynamic Components (SDUI Candidates)

### 5.1 Menu System ✅ Already Partially SDUI
- Menu items fetched from server
- Feature flags (is_disable, require_*)
- Banner system

### 5.2 BPMS Forms 🎯 High Priority
- Multi-step forms with validation
- Dynamic field types (text, dropdown, date, document)
- Task-based workflow progression

### 5.3 List/Grid Views 🎯 High Priority
- Transaction lists
- Card lists
- Notification lists
- Service menus

### 5.4 Detail Pages 🎯 Medium Priority
- Transaction details
- Card details
- Process details

### 5.5 Dialogs & Bottom Sheets
- Confirmation dialogs
- Selection bottom sheets
- Help/Info dialogs

---

## 6. API Communication Layer

### 6.1 Request Flow

```
App Request → Base64 Encode → Encrypt → Sign (eKYC) → Server
Server Response → Decrypt → Parse → Model
```

### 6.2 Security Headers

```dart
headers['Digital-Signature-Provider'] = signData.provider;
headers['Digital-Signature'] = signData.sign;
headers['Trace-ID'] = signData.traceID;
headers['Authorization'] = 'GPAY ${token}';
```

### 6.3 API Result Pattern

```dart
sealed class ApiResult<S, F> {}
class Success<S, F> extends ApiResult<S, F> { S value; }
class Failure<S, F> extends ApiResult<S, F> { F exception; }
```

---

## 7. UI Component Patterns

### 7.1 Common Widgets

| Widget | Purpose | SDUI Potential |
|--------|---------|----------------|
| ContinueButtonWidget | Primary action button | HIGH |
| CardTemplateItem | Card display | HIGH |
| ServiceItemWidget | Service menu item | HIGH |
| DocumentPickerWidget | Document upload | MEDIUM |
| CustomAppBar | App header | HIGH |
| CustomLoading | Loading states | HIGH |
| DetailItemWidget | Key-value display | HIGH |

### 7.2 Screen Patterns

```dart
// Pattern 1: PageView with Steps
Scaffold(
  body: PageView(
    controller: pageController,
    physics: NeverScrollableScrollPhysics(),
    children: [
      Page1(),
      Page2(),
      Page3(),
    ],
  ),
)

// Pattern 2: GetBuilder with State
GetBuilder<Controller>(
  builder: (controller) {
    return controller.isLoading 
      ? LoadingWidget() 
      : ContentWidget();
  },
)
```

---

## 8. Localization System

```dart
// Already supports RTL (Persian/Farsi)
Directionality(
  textDirection: TextDirection.rtl,
  child: content,
)

// Uses ARB files for translations
AppLocalizations.of(context)!.key_name
```

---

## 9. Theme System

```dart
class AppMainTheme {
  static AppMainTheme light() => ...;
  static AppMainTheme dark() => ...;
}

// Colors, typography, and styles defined in theme
ThemeUtil.titleStyle
ThemeUtil.subtitleStyle
context.theme.colorScheme.primary
```

---

## 10. Recommendations for SDUI

### 10.1 Static Core (Keep Native)

1. **Authentication Flow**
   - Login/Register screens
   - OTP verification
   - eKYC enrollment
   - Biometric setup

2. **Security Layer**
   - Encryption/Decryption
   - Certificate management
   - Secure storage
   - VPN detection

3. **Core Navigation**
   - Bottom navigation bar
   - Main dashboard shell
   - Deep linking handlers

### 10.2 Dynamic SDUI (Server-Driven)

1. **All BPMS Workflows** - 150+ screens
2. **Menu Items & Services** - Already partial
3. **Forms & Data Entry**
4. **List Views & Grids**
5. **Detail Pages**
6. **Banners & Promotions**
7. **Help & Support Content**

---

## Next Steps

1. ✅ Project Analysis (This Document)
2. 🔄 Define Static vs Dynamic Boundaries
3. 🔄 Design JSON Schema Structure
4. 🔄 Create Widget Registry
5. 🔄 Define Action Handlers
6. 🔄 Implementation Roadmap

