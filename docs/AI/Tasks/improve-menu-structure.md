---
status: completed
title: Improve Menu Screen Structure (Separation of Incomplete Items)
---

# Objective
The user requested to separate completed items (Splash, Login, Verify OTP) from incomplete/placeholder items in the menu screen, and to place critical items (Login, Splash, Verify OTP) at the top.

# Implementation Details

1.  **Menu Items API (`GET_menu-items.json`)**:
    *   Split the `menuItems` list into two distinct lists: `completedItems` and `incompleteItems`.
    *   `completedItems`: Contains Splash, Login, and Verify OTP (in that order).
    *   `incompleteItems`: Contains Home, Account, Transfer, etc. (some are implemented but labeled as secondary per user request to separate them).

2.  **Menu Screen Layout (`tobank_menu.dart`)**:
    *   Updated `body` to use a `StacListView` as the main container.
    *   Added two `StacDynamicView` widgets corresponding to the two lists (`data.completedItems` and `data.incompleteItems`).
    *   Added a visual separator (`StacRow` with dividers and title "سایر موارد") between the two sections.
    *   Used `StacListView` inside the dynamic views.

3.  **Recursive Item Template Injection (`TobankStacDartScreen.dart`)**:
    *   Updated the injection logic to be recursive. It now traverses the entire JSON tree to find any widget with `type: 'listView'`.
    *   Automatically injects the standard `itemTemplate` (Menu Item Card) if missing.
    *   Automatically sets `shrinkWrap: true` and `physics: 'never'` (NeverScrollableScrollPhysics) on these inner ListViews to ensure they nest correctly within the main ScrollView without scrolling conflicts.

# Verification
*   Menu items should be split into two groups.
*   Top group has Splash, Login, Verify OTP.
*   Bottom group has the rest.
*   A separator with text "سایر موارد" appears between them.
*   Scrolling works on the whole page, but inner lists do not scroll independently.
*   Theme toggle and other functionalities remain intact.
