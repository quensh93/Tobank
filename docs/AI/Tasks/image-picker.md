# Image Picker Screen - STAC Package

## Status: ✅ Implemented & Stable

**Created**: 2025-12-29
**Last Updated**: 2025-12-30

### Quick Summary
Implementation of image picking and display functionality using STAC package:
- File picking using `file_picker` package
- Image display in a container with placeholder support
- Blob handling on web platform
- **Stable State**: All known bugs (text encoding, re-selection issues, conditional rendering) have been resolved.

## Overview

This task involved creating a screen under the "سایر موارد" (Other Items) section in the menu. The screen:
1. Provides a file picker button to select an image from local storage.
2. Displays the selected image in a container.
3. Uses a placeholder when no image is selected.
4. Handles web-specific constraints (blob URLs).

## Requirements

### Menu Entry
- **Section**: سایر موارد (Other Items / incompleteItems)
- **Title**: نمایش و اپلود تصویر (Image Display and Upload)
- **Icon**: image icon

### Screen Functionality
1. **File Picker Button**: Allows user to pick an image.
2. **Image Display**: Shows the picked image or a placeholder.
3. **Web Support**: Handles file access permissions and blob URLs correctly.

## Implementation Details

### Components
- **StacCustomImage**: Used to support `errorBuilder` and `registryKey` for reactive updates without full rebuilds.
- **CustomImageParser**: Parses the JSON definition for the image widget.

### Recent Fixes & Stabilization
- **Persian Text Encoding**: Fixed issues where Persian characters in JSON files were corrupted/not displaying correctly.
- **Image Display Logic**: Resolved issues with `conditionalBuilder` not being supported by replacing it with `StacCustomImage`'s `errorBuilder`.
- **Re-selection Bug**: Fixed a bug where selecting a second image would fail or not update the display.
- **State Management**: Ensured `StacRegistry` updates propagate correctly updates to the UI.

## Success Criteria

- [x] File picker button works on all platforms
- [x] Selected image displays in container
- [x] Screen accessible from "سایر موارد" menu
- [x] Works with Dart mode
- [x] Works with JSON mode
- [x] Works with API JSON mode
- [x] Web blob handling verified
- [x] Text encoding correct (Persian chars)
- [x] Stable on re-entry and re-selection

## Technical Challenges Faced

### `StacImage` Missing Properties
**Problem**: Standard `StacImage` lacked `errorBuilder` and `registryKey` needed for our reactive placeholder pattern.
**Solution**: Created `StacCustomImage` dart class and matching parser logic to handle these properties, specifically passing `registryKey` to bypass template caching for `src`.

### JSON Encoding
**Problem**: JSON files generated or edited sometimes had encoding issues with Persian characters.
**Solution**: Ensured all JSON files are saved and read with correct UTF-8 encoding.

### Conditional Rendering
**Problem**: `conditionalBuilder` was not fully supported or caused issues in this context.
**Solution**: Switched to using `errorBuilder` property on the image widget itself to handle the "no image" state, which is more robust for this simpler use case.
