# Promissory Draft API Integration

## Goal
Integrate the "Promissory Draft" API into the `promissory_real_payment_deposits_screen.dart` file. The API call is triggered when the user selects a deposit and taps continue.

## API Details
- **URL**: `http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/draft`
- **Method**: `POST`
- **Headers**:
  - `accept`: `application/json`
  - `authorization`: `Bearer <token>` (Use `{{auth.accessToken}}`)
  - `content-type`: `application/json`

## Checklist & Implementation Steps

### 1. Data Source Verification & Preparation
- [x] **Verify Data Bindings**: Ensure the following keys are available in the context:
    - [x] `sourceAccount`: `{{selectedDeposit.depositNumber}}` (From Deposit Screen)
    - [x] `issuerAccountNumber`: `{{selectedDeposit.depositIban}}` (From Deposit Screen)
    - [x] `issuerBirthDate`: `{{userData.birthDate}}` (From Issuer Screen)
    - [x] `issuerNN`: `{{userData.nationalCode}}`
    - [x] `issuerSanaCheck`: `true` (Hardcoded)
    - [x] `issuerCellphone`: `{{removeLeadingZero(userData.mobile)}}` (Logic: Pre-sanitized)
    - [x] `issuerFullName`: `{{userData.fullName}}`
    - [x] `issuerAddress`: `{{userData.address}}`
    - [x] `issuerPostalCode`: `{{userData.postalCode}}`
    - [x] `recipientType`: `"I"` (Hardcoded)
    - [x] `recipientBirthDate`: `{{receiver.birthDate}}`
    - [x] `recipientNationalId`: `{{receiver.nationalCode}}`
    - [x] `recipientCellphone`: `{{receiver.mobile}}`
    - [x] `recipientFullName`: `{{receiverIdentity.fullName}}`
    - [x] `paymentPlace`: `تهران، آرشام` (Hardcoded)
    - [x] `amount`: `{{form.promissory_amount}}`
    - [x] `dueDate`: `{{form.promissory_due_date}}`
    - [x] `description`: `{{form.description}}`
    - [x] `transferable`: `true` (Hardcoded)

### 2. File Modifications

#### `promissory_real_issuer_screen.dart`
- [x] **Capture Birth Date**: Update the `promissory_real_issuer` response handling to save `birthDate` from the API response into `userData.birthDate`.
- [x] **Store Raw Phone Number**: Save `userData.mobile` without sanitization to ensure UI display works (Sanitization happens at API call).

#### `promissory_real_payment_deposits_screen.dart`
- [x] **Save Selected Deposit**: Ensure `selectedDeposit.depositNumber` and `selectedDeposit.depositIban` are saved when a user selects a deposit (Handled in `promissory_real_deposits_parser.dart`).
- [x] **Implement Network Request**: Add `StacNetworkRequestAction` to the `onContinue` action.
- [x] **Request Body Configuration**: (Same as correctly identified json)
- [x] **Response Handling (Success 200)**:
    - [x] **Save All Response Data**: Store IDs and full response.
    - [x] **Navigation**: Navigate to `promissory_real_sign`.

#### `promissory_real_confirm_screen.dart`
- [x] **Remove Network Request**: Revert the submit button to simple navigation to `promissory_real_payment`.

- [x] **Response Handling (Error)**:
    - [x] Display appropriate error message from response (`{{data.status.message}}` or `{{data.status.description}}`).

## Files to Modify
- `lib/stac/tobank/flows/promissory_real/dart/promissory_real_confirm_screen.dart`
- `lib/stac/tobank/flows/promissory_real/dart/promissory_real_issuer_screen.dart`
- `lib/core/stac/parsers/widgets/promissory_real_deposits_parser.dart`
