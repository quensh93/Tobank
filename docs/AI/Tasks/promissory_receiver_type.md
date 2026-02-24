# Promissory Issuance: Legal vs Individual Receiver Implementation Details

## Overview
Implement the full flow for distinguishing and handling Individual (حقیقی) and Legal (حقوقی) receiver types in the Promissory Note issuance process.

## 1. `c:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\flows\promissory_real\dart\promissory_real_receiver_screen.dart` (Receiver Selection & API)
- [x] Add tab selection tracking variables (`recipientType`, `isIndividualSelected`, `isLegalSelected`).
- [x] Conditionally show submit buttons for Individual vs. Legal tabs.
- [x] Integrate existing identity API for Individual: `GET /identity/{{receiver.nationalCode}}/{{receiver.birthDateCompact}}`.
- [x] Integrate new identity API for Legal: `GET /identity/{{receiver.legalNationalId}}`.
- [x] Map responses into unified/distinct registry keys (`receiverIdentity.fullName`, `receiverIdentity.nationalId`, `receiverIdentity.address`, `receiverIdentity.phone`).

## 2. `c:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\flows\promissory_real\dart\promissory_real_data_screen.dart` (Receiver Info & Data Entry)
- [x] Conditionally render receiver info labels/values based on individual vs. legal (National Code vs. National ID, Mobile vs. Contact Number).
- [x] Disable "Payment Place" (Address) field and pre-fill it with the address from the new Legal API response if Legal.
- [x] Add minimum amount validation and text hint below the amount field ("حداقل مبلغ تعهد بیست میلیون ریال می‌باشد").

## 3. `c:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\flows\promissory_real\dart\promissory_real_payment_deposits_screen.dart` (Draft API Payload)
Update the `POST /promissories/draft` payload fields conditionally based on the receiver type:
- [x] **`recipientType`**: Set to `'I'` for Individual, `'C'` for Legal.
- [x] **`recipientNationalId`**:
  - Individual: `{{receiver.nationalCode}}`
  - Legal: `{{receiver.nationalId}}` (or `{{receiverIdentity.nationalId}}` depending on registry binding).
- [x] **`recipientBirthDate`**:
  - Individual: `{{replace(receiver.birthDate, '/', '')}}`
  - Legal: `null` or empty string.
- [x] **`recipientCellphone`**:
  - Individual: `{{removeLeadingZero(receiver.mobile)}}`
  - Legal: Use the phone number from the Legal API response.
- [x] **`recipientFullName`**:
  - Individual: `{{receiverIdentity.fullName}}`
  - Legal: Use the company name from the Legal API response.

## 4. `c:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\flows\promissory_real\dart\promissory_real_confirm_screen.dart` (Confirmation & Finalization)
- [x] Ensure any mapping or UI display dynamically references the correct identifier (National ID or National Code) and contact.
- [x] Ensure final submission `issue` API uses correct parameters if needed (usually similar to `draft`).
