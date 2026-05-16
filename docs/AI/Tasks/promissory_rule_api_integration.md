# Promissory Rule Real API Integration

**Status**: Done
**Created**: 2026-01-28
**Assigned**: Antigravity

## Description
Update the Promissory Intro screen to navigate to the Promissory Rule screen using a real API call instead of the mock implementation. This involves updating the navigation action in the JSON configuration to point to the correct API endpoint.

## Objectives / Checklist
- [x] Create this task file based on the template.
- [x] Analyze `promissory_intro.json` to identify the navigation action.
- [x] Update the URL in `promissory_intro.json` to the real API endpoint.
- [x] Verify the structure matches the expected API call format.
- [x] Update this task file with progress.

## Flow Overview (Real API Integration)

### 1. Intro Screen (`promissory_intro`)
- **Widget Type**: `promissory_intro`
- **Description**: The entry point for the real promissory flow.
- **Action**: Navigates to the Login flow.

### 2. Login Flow (`promissory_login_form`)
- **Widget Type**: `promissory_login_form` (Dynamic Widget)
- **Dart File**: `lib/stac/tobank/flows/promissory_old/dart/promissory_screen.dart`
- **Auth Service**: `lib/stac/tobank/flows/promissory_old/dart/promissory_auth_service.dart`
- **Action**: 
    - User enters National ID, Mobile, etc.
    - Submit calls `PromissoryRealAuthService.login`.
    - Real API: `POST http://192.168.107.22:8280/api/digitalbanking/logins/v1.0/tobank/users`
    - On success (200 + Token), navigates to Rules screen.

### 3. Rules Screen (`promissory_rules`)
- **API Endpoint**: `https://api.tobank.com/flows/promissory_old/promissory_rules` (Mapped to local JSON via interceptor for now, or real API if configured).
- **File**: `lib/stac/tobank/flows/promissory_old/api/GET_promissory_rules.json`
- **Action**: User accepts rules -> Navigates to Deposits screen (`promissory_deposits`).

### 4. Deposits Screen (`promissory_deposits`)
- **Widget Type**: `promissory_deposits`
- **Dart File**: `lib/stac/tobank/flows/promissory_old/dart/promissory_deposits_screen.dart`
- **Service**: `lib/stac/tobank/flows/promissory_old/dart/promissory_service.dart`
- **Action**:
    - `PromissoryRealService.getDeposits` is called on init.
    - API: `GET http://192.168.107.22:8280/api/digitalbanking/deposits/v1.0/customer/{customerId}`
    - response is mapped to UI model.
    - `requestPromissoryDepositPage` (in `promissory_deposits_screen.dart`) is rendered with the fetched data.
    - **Navigation Logic**:
        - `PromissoryRealService.getDeposits` fetches data.
        - `requestPromissoryDepositPage` builds the list.
        - Selection saves data to `form.*`.
        - "Continue" navigates to `promissory_receiver`.

## Key Files & Implementations

- **Services**:
    - `PromissoryRealService.dart`: Handles Deposit API calls. Added `ISpectDioInterceptor` and `_logCurl` for debugging.
    - `PromissoryRealAuthService.dart`: Handles Login API calls. Added `ISpectDioInterceptor` and `_logCurl`.
- **Screens**:
    - `PromissoryRealDepositsScreen`: Stateful widget that fetches data and renders the deposit list.
    - `request_promissory_deposit_page.dart`: Builds the dynamic UI for deposit selection (Fixed `RenderFlex` overflow here).
- **Configuration**:
    - `stac_widget_loader.dart`: Maps `promissory_deposits` to the correct screen.

## Progress Log
- **2026-01-28**: Created task file.
- **2026-01-28**: Identified target file and current mock implementation.
- **2026-01-28**: Updated `promissory_intro.json` with the real API URL.
- **2026-01-28**: Resolved 401 Unauthorized in `PromissoryRealService` (fixed double Bearer prefix).
- **2026-01-28**: Added detailed network logging (ISpect + CURL) to Services.
- **2026-01-28**: Fixed `RenderFlex` overflow in Deposit Listing UI.
- **2026-01-28**: Documented full flow and file usage.
