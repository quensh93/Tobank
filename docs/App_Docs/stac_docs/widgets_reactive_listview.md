# ReactiveListView Widget

## 🎯 Overview

`reactiveListView` is a powerful, data-driven list widget designed for **Server-Driven UI**. 
It connects directly to the **Stac Registry** to render lists dynamically. 

Unlike standard static lists, this widget is **fully reactive**:
*   **Auto-Rebuilds**: Updates instantly when Registry data changes (e.g., API response, selection state).
*   **State Aware**: Built-in handling for **Loading**, **Error**, and **Empty** states.
*   **Generic**: Works with **ANY** API response structure via `dataKey` and `dataPath`.
*   **Interactive**: Supports selection and actions via `onItemTap`.

**Type**: `reactiveListView`  
**Location**: `lib/core/stac/parsers/widgets/reactive_list_view_parser.dart`

---

## 📋 JSON Structure

```json
{
  "type": "reactiveListView",
  "dataKey": "deposits.rawData",
  "dataPath": "data",
  "isLoadedKey": "deposits.isLoaded",
  "errorKey": "deposits.error",
  "itemIdField": "depositNumber",
  "selectedIdKey": "selectedDepositId",
  "padding": { "left": 16, "right": 16, "top": 8, "bottom": 8 },
  "separator": { "type": "sizedBox", "height": 16.0 },
  "loadingWidget": { "type": "circularProgressIndicator" },
  "errorWidget": { "type": "text", "data": "Error: {{error}}" },
  "emptyWidget": { "type": "text", "data": "No items found" },
  "onItemTap": {
    "actionType": "sequence",
    "actions": [
      { "actionType": "setValue", "key": "selectedDepositId", "value": "{{item.depositNumber}}" }
    ]
  },
  "itemTemplate": {
    "type": "container",
    "child": { "type": "text", "data": "{{item.depositTitle}}" }
  }
}
```

## ⚙️ Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| **`dataKey`** | `String` | **Required**. The registry key containing the raw API response (or list data). |
| **`dataPath`** | `String` | Optional path to extract the list from the raw data (dot-separated, e.g., `result.items`). |
| **`itemIdField`** | `String` | Field name in the item object used as a unique ID (default: `id`). Used for selection logic. |
| **`selectedIdKey`** | `String` | Registry key that holds the ID of the currently selected item. |
| **`isLoadedKey`** | `String` | Registry key (boolean) indicating if data has finished loading. |
| **`errorKey`** | `String` | Registry key containing an error message (if any). |
| **`loadingWidget`** | `Widget` | Shown while `isLoadedKey` is `false`. |
| **`errorWidget`** | `Widget` | Shown if `errorKey` is typically non-null. Supports `{{error}}` placeholder. |
| **`emptyWidget`** | `Widget` | Shown if the resolved list is empty or null. |
| **`itemTemplate`** | `Widget` | **Required**. Template for rendering each item. Supports `{{item.*}}` placeholders. |
| **`onItemTap`** | `Action` | Action to execute when an item is tapped. Supports `{{item.*}}` placeholders. |
| **`separator`** | `Widget` | Widget displayed between items (e.g., `sizedBox`, `divider`). |
| **`padding`** | `EdgeInsets` | Padding around the list content. |

---

## 🛠️ Generic API Support

Attributes `dataKey` and `dataPath` allow you to adapt to **any** API structure without code changes.

### Example 1: List inside a nested object
**API Response:**
```json
{
  "status": 200,
  "result": {
    "transactions": [ ... ]
  }
}
```
**Stac Config:**
*   `dataKey`: `"api_response_key"` (where you stored the fetched JSON)
*   `dataPath`: `"result.transactions"`

### Example 2: List at the root
**API Response:**
```json
[ { "id": 1 }, { "id": 2 } ]
```
**Stac Config:**
*   `dataKey`: `"my_list_key"`
*   `dataPath`: `""` (or null/omit)

---

## 🧩 State Management

The widget automatically switches UI based on registry state keys:

1.  **Loading**: Checks `isLoadedKey`. If `false` (or key missing), shows `loadingWidget`.
2.  **Error**: Checks `errorKey`. If formatted as a string and not empty, shows `errorWidget`.
    *   *Tip*: Use `{{error}}` in your `errorWidget` to display the specific message.
3.  **Empty**: If data list is null or empty, shows `emptyWidget`.
4.  **Success**: Renders the list using `itemTemplate`.

---

## 🎨 Layout & Data Binding

### Item Template
The `itemTemplate` defines how a single row looks. access data using:
*   **`{{item.FIELD_NAME}}`**: Value from the current item (e.g., `{{item.title}}`).
*   **`{{index}}`**: The current row index (0-based).
*   **`{{totalCount}}`**: Total number of items.

### Selection State
Use **`{{isSelected}}`** to style items dynamically based on the `selectedIdKey` interaction.

**Example (Color Change):**
```json
"color": "{{isSelected ? appColors.primary : appColors.grey}}"
```

### Interactions (`onItemTap`)
When an item is tapped, the `onItemTap` action is executed. This is usually used to **update the registry**, which triggers a reactive rebuild.

**Standard Selection Pattern:**
```json
"onItemTap": {
  "actionType": "sequence",
  "actions": [
    {
      "actionType": "setValue",
      "key": "selectedDepositId", 
      "value": "{{item.depositNumber}}" 
    },
    {
      "actionType": "setValue",
      "key": "hasSelection", 
      "value": true 
    }
  ]
}
```
*Flow:* Tap -> `setValue` updates `selectedDepositId` -> Registry notifies listeners -> `reactiveListView` rebuilds -> `{{isSelected}}` re-evaluates -> UI updates.

---

## 🚀 Advanced Usage

### External Updates
Since the list is reactive, **any** registry change will update it.
*   **Filter Buttons**: A button outside the list can update `filterType` in registry.
*   **Timers**: A background timer can update `timeRemaining`.

### Conditional Layouts
Wrap `reactiveListView` in a `conditional` widget to swap between views (e.g., List vs Grid) dynamically.

### Infinite Scroll / Pagination
*(Future feature)*: The parser structure supports adding `onEndReached` callback for pagination requests.

---
