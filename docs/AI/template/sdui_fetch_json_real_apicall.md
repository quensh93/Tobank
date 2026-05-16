# SDUI API Navigation Integration Template

**Use Case**: Converting a mock/static navigation step to a real API-driven SDUI call.
**Reference Code**: `lib/stac/tobank/flows/promissory` (contains verified API call structures).

## 1. Task Setup
- [ ] **Define the Goal**: Connect screen [A] to screen [B] using Real API.
- [ ] **Get the API Endpoint**: Ensure you have the full URL (e.g., `http://192.168.../api/...`).
- [ ] **Identify Source File**: Locate the specific `.json` file for Screen A.

## 2. Implementation Pattern
Find the interactive element (Button, GestureDetector) in the JSON file and replace its action with the specific `navigate` request format.

### Target Structure
```json
"onTap" (or "onPressed"): {
  "actionType": "navigate",
  "navigationStyle": "push",
  "request": {
    "url": "INSERT_REAL_API_ENDPOINT_HERE",
    "method": "get"
  }
}
```

## 3. Execution Steps
1.  **Search**: Find the text label or key of the button (e.g., "ادامه", "Next") in the JSON file.
2.  **Replace**: Overwrite the existing `onTap` object with the **Target Structure** above.
3.  **Clean Up**: Remove any mock data or `flowNext` logic if it conflicts with the API call.

## 4. Verification
- [ ] **URL Check**: Does the URL match exactly?
- [ ] **Method Check**: Is it `"method": "get"`?
- [ ] **Context Check**: Is this inside the correct component (e.g., the specific submit button)?

## 5. Documentation
- [ ] Update the specific task file in `docs/AI/Tasks/`.
- [ ] Log the change in `docs/AI/history/YYYY-MM.md` as:
  `- ✨ **feat**: Integrated real API navigation for [Screen Name]`
