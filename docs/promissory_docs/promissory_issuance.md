# Promissory Note Issuance (صدور سفته)

## Overview

The Promissory Note Issuance feature allows users to create and issue electronic promissory notes (سفته الکترونیکی) through the ToBank application. This document details the complete API flow, data models, pages, controllers, and the user journey required to complete the issuance process.

---

## Table of Contents

1. [User Flow Overview](#user-flow-overview)
2. [Page Structure & Navigation](#page-structure--navigation)
3. [Controllers & Core Functions](#controllers--core-functions)
4. [API Endpoints](#api-endpoints)
5. [Data Models](#data-models)
6. [Flow Diagrams](#flow-diagrams)

---

## User Flow Overview

```mermaid
flowchart TD
    A[🏠 Start: PromissoryScreen] --> B[Load Promissory Assets]
    B --> C[Select 'Request Promissory']
    C --> D[📄 RequestPromissoryScreen]
    D --> E[Load Rules Page]
    E --> F[Accept Rules & Check SANA]
    F --> G[Select Deposit Account]
    G --> H[Enter Issuer Information]
    H --> I[Enter Receiver Information]
    I --> J[Validate Receiver Info via API]
    J --> K[Enter Promissory Data]
    K --> L[Calculate Price via API]
    L --> M[Confirm & Submit Request]
    M --> N[Create Promissory via API]
    N --> O[Select Payment Method]
    O --> P{Payment Type?}
    P -->|Wallet| Q[Pay via Wallet]
    P -->|Gateway| R[Pay via Internet Gateway]
    P -->|Deposit| S[Pay via Deposit]
    Q --> T[Sign PDF Document]
    R --> U[Complete Payment in Browser]
    S --> T
    U --> T
    T --> V[Finalize Promissory via API]
    V --> W[✅ Success: Show Transaction Details]
```

---

## Page Structure & Navigation

The `RequestPromissoryScreen` uses a `PageView` with multiple pages:

| Page Index | Page Name | Description |
|------------|-----------|-------------|
| 0 | `VirtualBranchLoadingPage` | Initial loading state |
| 1 | `RequestPromissoryRulePage` | Display and accept rules |
| 2 | `RequestPromissoryIssuerPage` | Issuer (صادرکننده) information |
| 3 | `RequestPromissoryReceiverPage` | Receiver (ذینفع) information |
| 4 | `RequestPromissoryDataPage` | Promissory data (amount, date, etc.) |
| 5 | `RequestPromissoryConfirmPage` | Review and confirm details |
| 6 | `VirtualBranchLoadingPage` | Payment loading state |
| 7 | `RequestPromissoryPayInBrowserWidget` | Internet payment browser view |
| 8 | `RequestPromissorySignPage` | Digital signature page |
| 9 | `PromissoryTransactionDetailPage` | Final transaction result |

### Screen Flow Diagram

```mermaid
stateDiagram-v2
    [*] --> LoadingPage
    LoadingPage --> RulePage: Rules Loaded
    RulePage --> IssuerPage: Rules Accepted & SANA Verified
    IssuerPage --> ReceiverPage: Issuer Info Validated
    ReceiverPage --> DataPage: Receiver Info Retrieved
    DataPage --> ConfirmPage: Price Calculated
    ConfirmPage --> PaymentLoading: Request Submitted
    PaymentLoading --> SignPage: Wallet/Deposit Payment
    PaymentLoading --> BrowserPayment: Gateway Payment
    BrowserPayment --> SignPage: Payment Verified
    SignPage --> TransactionDetail: PDF Signed & Finalized
    TransactionDetail --> [*]
```

---

## UI Screenshots

The following screenshots show the user interface for each step in the promissory issuance flow:

### Step 1: Initial Screen
<img src="Screenshot_20260104_135504_ .jpg" alt="Promissory Services" style="max-width: 250px;"/>
<img src="Screenshot_20260104_135511_ .jpg" alt="My Promissory Notes" style="max-width: 250px;"/>

### Step 2: Rules Page
<img src="Screenshot_20260104_135526_ .jpg" alt="Rules Page" style="max-width: 250px;"/>

### Step 3: Selecting Deposit Account
<img src="Screenshot_20260104_135609_ .jpg" alt="Deposit Selection" style="max-width: 250px;"/>

### Step 4: Issuer Information Page
<img src="Screenshot_20260104_135709_ .jpg" alt="Issuer Information" style="max-width: 250px;"/>

### Step 5: Receiver Information Page
<img src="Screenshot_20260104_135725_ .jpg" alt="Receiver Information" style="max-width: 250px;"/>

### Step 6: Promissory Data Page
<img src="Screenshot_20260104_135743_ .jpg" alt="Promissory Data Part 1" style="max-width: 250px;"/>
<img src="Screenshot_20260104_140021_ .jpg" alt="Promissory Data Part 2" style="max-width: 250px;"/>

### Step 7: Confirmation Page
<img src="Screenshot_20260104_135929_ .jpg" alt="Confirmation Part 1" style="max-width: 250px;"/>
<img src="Screenshot_20260104_140009_ .jpg" alt="Confirmation Part 2" style="max-width: 250px;"/>

### Step 8: Payment Method
<img src="photo_2025-12-23_09-49-33.jpg" alt="Payment Method Part 1" style="max-width: 250px;"/>
<img src="photo_2025-12-23_09-49-38.jpg" alt="Payment Method Part 2" style="max-width: 250px;"/>

### Step 9: Digital Signature Page
<img src="Screenshot_20260104_140035_ .jpg" alt="Digital Signature" style="max-width: 250px;"/>

### Step 10: Transaction Details
<img src="Screenshot_20260104_140054_ .jpg" alt="Transaction Details" style="max-width: 250px;"/>

---

## Controllers & Core Functions

### 1. PromissoryController

**File:** `lib/controller/promissory/promissory_controller.dart`

**Purpose:** Main controller for the Promissory home screen, handles menu navigation and asset loading.

| Function | Description |
|----------|-------------|
| `getPromissoryAssetRequest()` | Fetches promissory sign coordination and bank details |
| `handleItemClick()` | Routes to different promissory services based on menu selection |
| `showPromissoryServices()` | Displays promissory services menu |
| `showMyPromissory()` | Displays user's promissory list |

### 2. RequestPromissoryController

**File:** `lib/controller/promissory/request_promissory_controller.dart`

**Purpose:** Main controller for the promissory issuance flow, manages all steps from rules to finalization.

#### Core Functions

| Function | Description | API Called |
|----------|-------------|------------|
| `getRulesRequest()` | Fetches promissory rules content | `GET /api/v1.0/page/promissory-request-rules` |
| `_checkUserSanaRequest()` | Validates user's SANA status | `GET /api/v1.0/openbanking/check-sana` |
| `_getDepositListRequest()` | Gets user's deposit accounts | `POST /api/v1.0/dibalite/customer/deposits` |
| `_getCustomerInfoRequest()` | Gets customer info with address | `POST /api/v1.0/dibalite/customer/info` |
| `_validateDestUserInfoRequest()` | Validates receiver's identity (individual) | `POST /api/v1.0/dibalite/dest/user/info` |
| `_getLegalInfoRequest()` | Gets legal entity info (company) | `POST /api/v2/promissory/company/inquiry` |
| `_getPromissoryAmountRequest()` | Calculates promissory fee/price | `POST /api/v2/promissory/price` |
| `_submitRequestPromissoryRequest()` | Creates the promissory request | `POST /api/v2/promissory/publish/request` |
| `getWalletDetailRequest()` | Gets user's wallet balance | `GET /api/v1.0/wallets` |
| `_promissoryPayment()` | Pays via wallet or deposit | `POST /api/v2/transactions/promissory/publish/fee` |
| `_promissoryInternetPayment()` | Initiates internet payment | `POST /api/v2/transactions/promissory/publish/fee` |
| `_signPdf()` | Signs the promissory PDF digitally | Local signing process |
| `_promissoryPublishFinalizeRequest()` | Finalizes the promissory after signing | `POST /api/v2/promissory/publish/finalize` |
| `_requestTransactionDetailById()` | Gets transaction status after payment | `GET /api/v1.0/users/transactions/{id}` |

#### Validation Functions

| Function | Description |
|----------|-------------|
| `validateRules()` | Ensures rules are accepted before proceeding |
| `validateIssuerPage()` | Validates issuer address and postal code |
| `validateReceiverPage()` | Validates receiver national code, mobile, birthdate |
| `validateDataPage()` | Validates amount, date, and payment address |
| `validatePaymentPage()` | Validates payment method selection |
| `validateConfirmPage()` | Triggers promissory request submission |

---

## API Endpoints

### 1. Get Promissory Sign Assets

Fetches sign coordination and tourism bank details.

**Endpoint:** `GET /api/v2/promissory/sign/asset`

**Headers:**
```json
{
  "accept": "application/json",
  "cache-control": "no-store",
  "App-Version": "3.9.6",
  "App-Platform": "android",
  "authorization": "GPAY {JWT_TOKEN}"
}
```

**Response:**
```json
{
  "success": true,
  "message": "",
  "data": {
    "datetime": {
      "solar_datetime": "1404-10-14 15:07:01.515660",
      "gregorian_datetime": "2026-01-04 15:07:01.515660",
      "time_stamp": 1767526621
    },
    "sign_coordination": {
      "x": 450,
      "y": 450,
      "width": 150,
      "height": 50,
      "x_ios": 450,
      "y_ios": 450,
      "width_ios": 150,
      "height_ios": 50,
      "page": 0
    },
    "tourism_bank_details": {
      "legal_national_number": "10320435268",
      "legal_phone_number": "02123952395",
      "payment_address": "سعادت آباد ، بلوار فرهنگ ، نبش کوچه نور، پلاک 6"
    }
  }
}
```

---

### 2. Get Promissory Request Rules

Fetches the rules and terms for promissory issuance.

**Endpoint:** `GET /api/v1.0/page/promissory-request-rules`

**Response:**
```json
{
  "data": {
    "data": {
      "id": 36,
      "title": "قوانین افتتاح سفته",
      "content": "- سفته در قانون تجارت سندی است که...",
      "slug": "promissory-request-rules",
      "created": "2022-09-20T15:12:31.411484+04:30",
      "html_content": ""
    },
    "success": true,
    "message": "عملیات موفق",
    "code": 0
  },
  "success": true,
  "message": "عملیات موفق",
  "code": 0
}
```

---

### 3. Check User SANA Status

Verifies user has valid SANA code for promissory operations.

**Endpoint:** `GET /api/v1.0/openbanking/check-sana`

**Response:**
```json
{
  "success": true,
  "message": "",
  "data": {}
}
```

---

### 4. Get Customer Deposits

Retrieves user's deposit accounts for IBAN selection.

**Endpoint:** `POST /api/v1.0/dibalite/customer/deposits`

**Request:**
```json
{
  "data": "BASE64_ENCODED_JSON"
}
```

**Decoded Request Body:**
```json
{
  "trackingNumber": "a6954c60-a34e-4f00-9975-84e68e9eca11",
  "customerNumber": "1765274"
}
```

**Response:**
```json
{
  "data": {
    "trackingNumber": "a6954c60-a34e-4f00-9975-84e68e9eca11",
    "registrationDate": 1767526629426,
    "transactionId": "1457337052906475520",
    "status": 1,
    "message": null,
    "errors": [],
    "deposits": [
      {
        "DepositNumber": "110.9992.1765274.1",
        "MainCustomerNumber": "1765274",
        "DepositTitle": "سپرده حقيقي سپرده سرمايه گذاري كوتاه مدت- توبانک",
        "DepositTypeNumber": "9992",
        "DepositTypeTitle": "سپرده سرمايه گذاري كوتاه مدت- توبانک- حقيقي",
        "CustomerRelationWithDepositPersian": "صاحب سپرده و امضاء",
        "CustomerRelationWithDepositEnglish": "depositOwnerAndSignerRelationType",
        "DepositState": "openState",
        "CurrencyName": "ريال",
        "CurrencySwiftCode": "IRR",
        "WithdrawRight": "true",
        "BranchCode": "110",
        "DepositIban": "IR120640011099921765274001",
        "shared": false,
        "cardInfo": {
          "pan": "5054161702844691",
          "cardType": 0,
          "status": 1,
          "depositNumber": "110.9992.1765274.1"
        },
        "deposite_kind": 1,
        "deposite_name": "کوتاه مدت"
      }
    ]
  },
  "message": "عملیات با موفقیت انجام شد",
  "success": true
}
```

---

### 5. Get Customer Info

Retrieves customer information including address.

**Endpoint:** `POST /api/v1.0/dibalite/customer/info`

**Decoded Request Body:**
```json
{
  "trackingNumber": "d714481d-e19f-445e-a339-374e517db007",
  "nationalCode": "1272125191",
  "forceCacheUpdate": false,
  "forceInquireAddressInfo": true,
  "getCustomerStartableProcesses": false,
  "getCustomerDeposits": false,
  "getCustomerActiveCertificate": false
}
```

**Response:**
```json
{
  "data": {
    "trackingNumber": "d714481d-e19f-445e-a339-374e517db007",
    "registrationDate": 1767526620167,
    "transactionId": "1457337014071422977",
    "status": 1,
    "nationalCode": "1272125191",
    "firstName": "علي",
    "lastName": "سينائي اصل",
    "gender": 1,
    "customerNumber": "1765274",
    "shahabCodeAcquired": true,
    "digitalBankingCustomer": true,
    "loyaltyCode": "91633120",
    "address": "اصفهان - شهر ناشناخته - کوچه شهیدرضازلالی22...",
    "postalCode": "8153887146",
    "customerStatus": 1,
    "ekycProvider": 1
  },
  "message": "عملیات با موفقیت انجام شد",
  "success": true
}
```

---

### 6. Get Destination User Info (Receiver Inquiry)

Validates receiver's identity for individual type.

**Endpoint:** `POST /api/v1.0/dibalite/dest/user/info`

**Request:**
```json
{
  "birth_date": "1375-11-13",
  "national_code": "0440636711",
  "mobile": "09124764369"
}
```

**Response:**
```json
{
  "data": {
    "first_name": "مهدي",
    "last_name": "جمشيدپور"
  },
  "message": "",
  "success": true
}
```

---

### 7. Get Promissory Price

Calculates the fee for promissory issuance.

**Endpoint:** `POST /api/v2/promissory/price`

**Request:**
```json
{
  "amount": 100000000,
  "gssToYekta": false
}
```

**Response:**
```json
{
  "success": true,
  "message": "",
  "data": {
    "amount": 100000000,
    "feeAmount": 150000,
    "taxAmount": 13500,
    "totalAmount": 163500
  }
}
```

---

### 8. Create Promissory Publish Request

Creates the promissory note request.

**Endpoint:** `POST /api/v2/promissory/publish/request`

**Request:**
```json
{
  "issuerType": "individual",
  "issuerNN": "1272125191",
  "issuerCellphone": "9162363723",
  "issuerFullName": "علي سينائي اصل",
  "issuerAccountNumber": "IR120640011099921765274001",
  "issuerAddress": "اصفهان - شهر ناشناخته...",
  "issuerPostalCode": "8153887146",
  "issuerSanaCheck": true,
  "recipientType": "individual",
  "recipientNN": "0440636711",
  "recipientCellphone": "9124764369",
  "recipientFullName": "مهدي جمشيدپور",
  "paymentPlace": "تهران",
  "amount": 100000000,
  "dueDate": "14050320",
  "description": "",
  "transferable": true
}
```

**Response:**
```json
{
  "success": true,
  "message": "",
  "data": {
    "id": 12345,
    "requestId": "REQ-123456",
    "unSignedPdf": "BASE64_PDF_DATA",
    "promissoryId": "PROM-123456"
  }
}
```

---

### 9. Pay Promissory Fee

Pays the promissory fee via wallet, deposit, or gateway.

**Endpoint:** `POST /api/v2/transactions/promissory/publish/fee`

**Request:**
```json
{
  "id": 12345,
  "gssToYekta": false,
  "transactionType": "wallet",
  "depositNumber": null
}
```

**Response (Wallet/Deposit):**
```json
{
  "success": true,
  "message": "",
  "data": {
    "id": 67890,
    "isSuccess": true,
    "amount": 163500,
    "message": "پرداخت موفق"
  }
}
```

**Response (Gateway):**
```json
{
  "success": true,
  "message": "",
  "data": {
    "transactionId": "TXN-123456",
    "url": "https://payment-gateway.ir/pay/..."
  }
}
```

---

### 10. Finalize Promissory Publish

Finalizes the promissory after PDF signing.

**Endpoint:** `POST /api/v2/promissory/publish/finalize`

**Request:**
```json
{
  "data": "BASE64_ENCODED_JSON"
}
```

**Decoded Request Body:**
```json
{
  "id": 12345,
  "signedPdf": "BASE64_SIGNED_PDF_DATA"
}
```

**Response:**
```json
{
  "success": true,
  "message": "",
  "data": {
    "promissoryId": "PROM-123456",
    "multiSignedPdf": "BASE64_MULTI_SIGNED_PDF"
  }
}
```

---

## Data Models

### Request Models

#### PromissoryRequestData
```dart
class PromissoryRequestData {
  PromissoryCustomerType? issuerType;      // individual / legal
  String? issuerNn;                         // National Number
  String? issuerCellphone;                  // Without leading 0
  String? issuerFullName;
  String? issuerAccountNumber;              // IBAN
  String? issuerAddress;
  String? issuerPostalCode;
  bool? issuerSanaCheck;
  PromissoryCustomerType? recipientType;
  String? recipientNn;
  String? recipientCellphone;
  String? recipientFullName;
  String? paymentPlace;
  int? amount;                              // In Rials
  String? dueDate;                          // Format: YYYYMMDD (Jalali)
  String? description;
  bool? transferable;
  String? loanType;
}
```

#### DestUserInfoRequestData
```dart
class DestUserInfoRequestData {
  String birthDate;      // Format: YYYY-MM-DD (Jalali)
  String nationalCode;
  String mobile;
}
```

### Response Models

#### PromissoryAssetResponseData
```dart
class PromissoryAssetResponseData {
  Data? data;
  bool? success;
  String? message;
}

class Data {
  SignDatetime? datetime;
  SignCoordination? signCoordination;
  TourismBankDetails? tourismBankDetails;
}

class SignCoordination {
  int? x, y, width, height;
  int? xIOS, yIOS, widthIOS, heightIOS;
  int? page;
}

class TourismBankDetails {
  String? legalNationalNumber;
  String? legalPhoneNumber;
  String? paymentAddress;
}
```

#### DestUserInfoResponse
```dart
class DestUserInfoResponse {
  DestUserInfoData? data;
  String? message;
  bool? success;
}

class DestUserInfoData {
  String? firstName;
  String? lastName;
}
```

#### PromissoryPublishResponseData
```dart
class PromissoryPublishResponseData {
  Data? data;
  String? message;
  bool? success;
}

class Data {
  int? id;
  String? requestId;
  String? unSignedPdf;
  String? promissoryId;
}
```

#### PromissoryPublishFinalizeResponse
```dart
class PromissoryPublishFinalizeResponse {
  Data? data;
  String? message;
  bool? success;
}

class Data {
  String? promissoryId;
  String? multiSignedPdf;
}
```

---

## Flow Diagrams

### Complete API Call Sequence

```mermaid
sequenceDiagram
    participant U as User
    participant App as App
    participant API as ToBank API
    participant Bank as Core Banking

    U->>App: Open Promissory Screen
    App->>API: GET /api/v2/promissory/sign/asset
    API-->>App: Sign coordinates & bank details
    
    U->>App: Tap "Request Promissory"
    App->>API: GET /api/v1.0/page/promissory-request-rules
    API-->>App: Rules content
    
    U->>App: Accept Rules
    App->>API: GET /api/v1.0/openbanking/check-sana
    API->>Bank: Verify SANA status
    Bank-->>API: SANA valid
    API-->>App: Success
    
    App->>API: POST /api/v1.0/dibalite/customer/deposits
    API->>Bank: Get deposits
    Bank-->>API: Deposit list
    API-->>App: Deposits
    
    U->>App: Select deposit account
    App->>API: POST /api/v1.0/dibalite/customer/info
    API->>Bank: Get customer info
    Bank-->>API: Customer details
    API-->>App: Address, postal code
    
    U->>App: Enter receiver info
    App->>API: POST /api/v1.0/dibalite/dest/user/info
    API->>Bank: Verify receiver
    Bank-->>API: Receiver name
    API-->>App: First name, last name
    
    U->>App: Enter amount & date
    App->>API: POST /api/v2/promissory/price
    API-->>App: Fee calculation
    
    U->>App: Confirm details
    App->>API: POST /api/v2/promissory/publish/request
    API->>Bank: Create promissory
    Bank-->>API: Unsigned PDF
    API-->>App: Request ID, unsigned PDF
    
    App->>API: GET /api/v1.0/wallets
    API-->>App: Wallet balance
    
    U->>App: Select payment method
    App->>API: POST /api/v2/transactions/promissory/publish/fee
    API->>Bank: Process payment
    Bank-->>API: Payment result
    API-->>App: Transaction success
    
    U->>App: Sign PDF (digital signature)
    App->>API: POST /api/v2/promissory/publish/finalize
    API->>Bank: Finalize promissory
    Bank-->>API: Multi-signed PDF
    API-->>App: Promissory ID, final PDF
    
    App->>U: Show success & download PDF
```

### Controller Methods Flow

```mermaid
flowchart TD
    subgraph Initialization
        A[onInit] --> B[getRulesRequest]
    end
    
    subgraph Rules
        B --> C[validateRules]
        C --> D[_checkUserSanaRequest]
        D --> E[_getDepositListRequest]
    end
    
    subgraph Issuer
        E --> F[validateDepositPage]
        F --> G[_getCustomerInfoRequest]
        G --> H[validateIssuerPage]
    end
    
    subgraph Receiver
        H --> I[validateReceiverPage]
        I -->|Individual| J[_validateDestUserInfoRequest]
        I -->|Legal| K[_getLegalInfoRequest]
    end
    
    subgraph Data
        J --> L[validateDataPage]
        K --> L
        L --> M[_getPromissoryAmountRequest]
    end
    
    subgraph Submit
        M --> N[validateConfirmPage]
        N --> O[_submitRequestPromissoryRequest]
        O --> P[getWalletDetailRequest]
    end
    
    subgraph Payment
        P --> Q[validatePaymentPage]
        Q -->|Wallet/Deposit| R[_promissoryPayment]
        Q -->|Gateway| S[_promissoryInternetPayment]
    end
    
    subgraph Finalize
        R --> T[_signPdf]
        S --> T
        T --> U[_promissoryPublishFinalizeRequest]
        U --> V[_requestTransactionDetailById]
    end
```

### Unified Master Flow

This comprehensive diagram combines the user journey, screen transitions, and backend API calls into a single view.

```mermaid
flowchart TD
    %% Define styles
    classDef screen fill:#e1f5fe,stroke:#01579b,stroke-width:2px,color:#000;
    classDef action fill:#fff9c4,stroke:#fbc02d,stroke-width:1px,color:#000,shape:stadium;
    classDef api fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px,color:#000,shape:cylinder;
    classDef logic fill:#f3e5f5,stroke:#7b1fa2,stroke-width:1px,stroke-dasharray: 5 5,color:#000,shape:rhombus;

    %% Legend
    subgraph Legend
        L1[Screen UI]:::screen
        L2(User Action):::action
        L3[(API Call)]:::api
        L4{Logic/Decision}:::logic
    end

    %% Step 1: Initialization
    subgraph Init [Step 1: Initialization]
        Start((Start)) --> S1[Promissory Home]:::screen
        S1 --> A1[(GET /api/v2/promissory/sign/asset)]:::api
        A1 --> U1(Tap 'Request Promissory'):::action
    end

    %% Step 2: Rules
    subgraph Rules [Step 2: Rules & Validation]
        U1 --> A2[(GET /api/v1.0/page/promissory-request-rules)]:::api
        A2 --> S2[Rules Page]:::screen
        S2 --> U2(Accept Rules):::action
        U2 --> A3[(GET /api/v1.0/openbanking/check-sana)]:::api
        A3 --> D1{Sana Valid?}:::logic
    end

    %% Step 3: Deposit & Issuer
    subgraph Issuer [Step 3: User Info]
        D1 -->|Yes| A4[(POST /api/v1.0/dibalite/customer/deposits)]:::api
        A4 --> S3[Deposit Selection]:::screen
        S3 --> U3(Select Deposit):::action
        U3 --> A5[(POST /api/v1.0/dibalite/customer/info)]:::api
        A5 --> S4[Issuer Info Page]:::screen
        S4 --> U4(Confirm Issuer):::action
    end

    %% Step 4: Receiver
    subgraph Receiver [Step 4: Receiver Info]
        U4 --> S5[Receiver Info Page]:::screen
        S5 --> U5(Enter Receiver Details):::action
        U5 --> D2{Receiver Type?}:::logic
        D2 -->|Individual| A6[(POST /api/v1.0/dibalite/dest/user/info)]:::api
        D2 -->|Legal| A7[(POST /api/v2/promissory/company/inquiry)]:::api
    end

    %% Step 5: Data & Price
    subgraph Data [Step 5: Promissory Data]
        A6 --> S6[Data Page]:::screen
        A7 --> S6
        S6 --> U6(Enter Amount & Date):::action
        U6 --> A8[(POST /api/v2/promissory/price)]:::api
    end

    %% Step 6: Confirmation
    subgraph Confirm [Step 6: Confirmation]
        A8 --> S7[Confirmation Page]:::screen
        S7 --> U7(Confirm & Submit):::action
        U7 --> A9[(POST /api/v2/promissory/publish/request)]:::api
    end

    %% Step 7: Payment
    subgraph Pay [Step 7: Payment]
        A9 --> A10[(GET /api/v1.0/wallets)]:::api
        A10 --> S8[Payment Method Page]:::screen
        S8 --> U8(Select Payment):::action
        U8 --> D3{Method?}:::logic
        D3 -->|Wallet/Deposit| A11[(POST .../publish/fee)]:::api
        D3 -->|Gateway| A12[(POST .../publish/fee)]:::api
        A12 --> S9[Browser Payment]:::screen
        S9 --> A11
    end

    %% Step 8: Finalize
    subgraph End [Step 8: Signing & Finish]
        A11 --> S10[Digital Signature Page]:::screen
        S10 --> U9(Sign PDF):::action
        U9 --> A13[(POST /api/v2/promissory/publish/finalize)]:::api
        A13 --> S11[Transaction Detail]:::screen
        S11 --> Stop((Finish))
    end

    %% Flow connections
    Init --> Rules
    Rules --> Issuer
    Issuer --> Receiver
    Receiver --> Data
    Data --> Confirm
    Confirm --> Pay
    Pay --> End
```

### Payment Types

```mermaid
graph TD
    A[Payment Selection] --> B{Payment Type}
    B -->|Wallet| C[Check Balance]
    C -->|Sufficient| D[Pay from Wallet]
    C -->|Insufficient| E[Show Error]
    B -->|Gateway| F[Get Payment URL]
    F --> G[Open Browser]
    G --> H[Complete Payment]
    H --> I[Verify Transaction]
    B -->|Deposit| J[Select Deposit]
    J --> K[Pay from Deposit]
    D --> L[Proceed to Sign]
    K --> L
    I --> L
```

---

## File Structure

```
lib/
├── controller/
│   └── promissory/
│       ├── promissory_controller.dart
│       ├── request_promissory_controller.dart
│       └── continue_request_promissory_controller.dart
├── model/
│   └── promissory/
│       ├── request/
│       │   ├── dest_user_info_request_data.dart
│       │   ├── promissory_request_data.dart
│       │   ├── promissory_amount_request_data.dart
│       │   ├── promissory_publish_finalize_request_data.dart
│       │   └── promissory_publish_payment_request_data.dart
│       └── response/
│           ├── dest_user_info_response_data.dart
│           ├── promissory_response_data.dart
│           ├── promissory_asset_response_data.dart
│           ├── promissory_amount_response_data.dart
│           ├── promissory_publish_finalize_response_data.dart
│           └── promissory_internet_payment_response_data.dart
├── service/
│   └── promissory_services.dart
└── ui/
    └── promissory/
        ├── promissory_screen.dart
        ├── promissory_service_page.dart
        └── request_promissory/
            ├── request_promissory_screen.dart
            ├── page/
            │   ├── request_promissory_rule_page.dart
            │   ├── request_promissory_issuer_page.dart
            │   ├── request_promissory_receiver_page.dart
            │   ├── request_promissory_data_page.dart
            │   ├── request_promissory_confirm_page.dart
            │   ├── request_promissory_sign_page.dart
            │   ├── request_promissory_pay_in_browser.dart
            │   └── promissory_transaction_detail_page.dart
            └── widget/
                ├── request_promissory_deposit_bottom_sheet.dart
                └── request_promissory_select_payment_bottom_sheet.dart
```

---

## Notes

1. **SANA Verification**: Users must have a valid SANA code to issue promissory notes.
2. **Receiver Types**: Supports both individual (حقیقی) and legal/company (حقوقی) receivers.
3. **Payment Methods**: Three options available - Wallet, Internet Gateway, and Deposit.
4. **Digital Signature**: The PDF is signed using the user's digital certificate (eKYC).
5. **Base64 Encoding**: Some endpoints require base64 encoded request body for security.
6. **Date Format**: All dates use Jalali (Persian) calendar format.
