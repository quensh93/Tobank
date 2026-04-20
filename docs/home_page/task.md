# Home Page Task

## Goal

Plan and implement the new Tobank SDUI home page flow, starting from the existing menu and focusing first on the Dart implementation path.

## Section 1: Entry Point

When the app launches and the user selects Tobank SDUI, the current first screen is the menu (`منو`).

The new home page flow must be added from this menu entry point.

Primary question for implementation:

- Where should this page be added in the current Tobank menu flow?
- The entry point is after app launch -> select Tobank SDUI -> see menu.

## Section 2: Menu Update

In the Tobank menu, add a new button/item:

- `home`

This new button should live in the existing menu flow under:

- `C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\menu`

## Section 3: Option Selection Screen

When the user taps the new `home` button, show a selection screen for choosing the flow entry mode.

This screen must match the existing UI used when tapping:

- `احراز هویت api واقعی`

Implementation guidance:

- Find the existing screen used by `احراز هویت api واقعی`.
- Reuse or copy the same UI structure and interaction pattern.
- Do not redesign this selector screen from scratch unless the current implementation forces it.

Selector content:

- Title/context: `مسیر های ورود جریان`
- Option 1: `محلی json ...`
- Option 2: `بازگزاری dart`
- Option 3: `load from json api`

Important note:

- The task description later says "for now we just focus on dart side (when user tap on the first option -> load from local dart)".
- This conflicts with the option order above, where the first listed option is `محلی json ...`.
- During implementation, this should be clarified or handled explicitly.
- For now, the only in-scope implementation path is the Dart path.

## Section 4: Current Scope - Dart Only

For now, focus only on the Dart side.

When the user taps the Dart option, the app should open the new home page.

This page must be created based on the screenshots already added here:

- `C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\docs\home_page`

Starting point screenshot:

- `home_state0_not_auth_dark.jpg`

Other screenshots in the same folder represent different states of the page and should be used to model the full Dart implementation.

Important warning:

- Do not implement the bottom navigation at all in this task.
- The bottom navigation is not part of the home page.
- It belongs to the parent container around the home page.

## Code Location

All code for this task should live under:

- `C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\home_page`

Folder structure should follow the same pattern used in other Tobank sections such as:

- `C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank\profile`

Required subfolders:

- `dart`
- `api`
- `json`

Current implementation scope:

- Only the `dart` folder is in scope now.

## General Implementation Direction

The project is currently using STAC Dart syntax for SDUI.

The home page should be built from the provided screenshots and implemented in the same architectural style and coding pattern already used across:

- `C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\lib\stac\tobank`

Before implementation, read existing Tobank sections carefully to understand:

- structure
- naming
- patterns
- reusable widgets/components
- STAC conventions already used in this repository

## Reference Material

Read the docs under:

- `C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\docs`

Pay special attention to:

- `C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\docs\AI`

## Assets Guidance

For icons and related visual assets:

- Reuse existing Tobank assets where possible.
- Check other Tobank sections before introducing new assets.
- Prefer consistency with existing sections over adding new one-off icons.

## Practical Deliverables

This task breaks down into these deliverables:

1. Add a new `home` item to the Tobank menu.
2. Open a selector screen from that menu item.
3. Make the selector screen match the existing `احراز هویت api واقعی` screen pattern.
4. Create the new `home_page` folder structure with `dart`, `api`, and `json`.
5. Implement only the Dart path first.
6. Build the home page UI from the provided screenshots.
7. Exclude bottom navigation from this implementation.

## Open Points To Confirm During Implementation

1. The exact selector option order versus the note that says the "first option" should load local Dart.
2. The exact source file/screen currently used by `احراز هویت api واقعی`, which should be copied for the selector UI.
3. The exact menu action or routing hook where the new `home` item should be attached in the existing Tobank menu implementation.
