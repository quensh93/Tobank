# Promissory Codes & Structures

This document provides a detailed mapping of the promissory issuance flow to the corresponding Dart files (UI, Controllers, and Logic) in the codebase.

---

## 1. Controllers & Logic

The core logic for the promissory issuance flow is handled by the following controllers:

    *   *Path:* [`request_promissory_controller.dart`](request_promissory_controller.dart)
    *   *Role:* Manages the state of the `PageView`, handles API calls for each step, and validates user input.

    *   *Path:* [`promissory_controller.dart`](promissory_controller.dart)
    *   *Role:* Handles the entry point to promissory services and loading initial assets.

    *   *Path:* [`promissory_transaction_detail_page_controller.dart`](promissory_transaction_detail_page_controller.dart)
    *   *Role:* Manages the final transaction receipt screen.

---

## 2. UI Screens & Steps

### Step 1: Entry & Asset Loading
The entry point where users select "Request Promissory".

*   **UI File:** [`promissory_screen.dart`](promissory_screen.dart) (Entry)
*   **Controller:** [`PromissoryController`](promissory_controller.dart)

<img src="Screenshot_20260104_135504_ .jpg" alt="Entry Screen" width="250"/> <img src="Screenshot_20260104_135511_ .jpg" alt="My Promissory" width="250"/>

---

### Step 2: Rules Page
Users must read and accept the rules before proceeding.

*   **UI File:** [`request_promissory_rule_page.dart`](request_promissory_rule_page.dart)
*   **Path:** `request_promissory_rule_page.dart`

<img src="Screenshot_20260104_135526_ .jpg" alt="Rules Page" width="250"/>

---

### Step 3: Deposit Account Selection
Users select the deposit account associated with the promissory note.

*   **UI Component:** [`request_promissory_deposit_bottom_sheet.dart`](request_promissory_deposit_bottom_sheet.dart)
*   **Path:** `request_promissory_deposit_bottom_sheet.dart`

<img src="Screenshot_20260104_135609_ .jpg" alt="Deposit Selection" width="250"/>

---

### Step 4: Issuer Information
Form to enter or verify the issuer (Creator) details.

*   **UI File:** [`request_promissory_issuer_page.dart`](request_promissory_issuer_page.dart)
*   **Path:** `request_promissory_issuer_page.dart`

<img src="Screenshot_20260104_135709_ .jpg" alt="Issuer Page" width="250"/>

---

### Step 5: Receiver Information
Form to enter the receiver (Beneficiary) details.

*   **UI File:** [`request_promissory_receiver_page.dart`](request_promissory_receiver_page.dart)
*   **Path:** `request_promissory_receiver_page.dart`

<img src="Screenshot_20260104_135725_ .jpg" alt="Receiver Page" width="250"/>

---

### Step 6: Promissory Data
Input for Amount, Due Date, and Description.

*   **UI File:** [`request_promissory_data_page.dart`](request_promissory_data_page.dart)
*   **Path:** `request_promissory_data_page.dart`

<img src="Screenshot_20260104_135743_ .jpg" alt="Data Page" width="250"/> <img src="Screenshot_20260104_140021_ .jpg" alt="Data Page 2" width="250"/>

---

### Step 7: Confirmation
Reviewing all details before submission.

*   **UI File:** [`request_promissory_confirm_page.dart`](request_promissory_confirm_page.dart)
*   **Path:** `request_promissory_confirm_page.dart`

<img src="Screenshot_20260104_135929_ .jpg" alt="Confirm 1" width="250"/> <img src="Screenshot_20260104_140009_ .jpg" alt="Confirm 2" width="250"/>

---

### Step 8: Payment
Selecting the payment method (Wallet, Deposit, or Gateway).

*   **UI Component:** [`request_promissory_select_payment_bottom_sheet.dart`](request_promissory_select_payment_bottom_sheet.dart)
*   **Browser Payment UI:** [`request_promissory_pay_in_browser.dart`](request_promissory_pay_in_browser.dart)

<img src="photo_2025-12-23_09-49-33.jpg" alt="Payment 1" width="250"/> <img src="photo_2025-12-23_09-49-38.jpg" alt="Payment 2" width="250"/>

---

### Step 9: Digital Signature
Final step to sign the document.

*   **UI File:** [`request_promissory_sign_page.dart`](request_promissory_sign_page.dart)
*   **Path:** `request_promissory_sign_page.dart`

<img src="Screenshot_20260104_140035_ .jpg" alt="Sign Page" width="250"/>

---

### Step 10: Transaction Detail
Final receipt showing the created promissory note status.

*   **UI File:** [`promissory_transaction_detail_page.dart`](promissory_transaction_detail_page.dart)
*   **Path:** `promissory_transaction_detail_page.dart`

<img src="Screenshot_20260104_140054_ .jpg" alt="Detail Page" width="250"/>

---

## 3. Data Models

Request and Response models used in this flow are located in:

*   **Request Models:**
    *   [`promissory_request_data.dart`](promissory_request_data.dart)
*   **Response Models:**
    *   [`promissory_publish_finalize_response_data.dart`](promissory_publish_finalize_response_data.dart)

