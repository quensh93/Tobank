# Figma Icon Export Instructions

## How to Export SVG Icon from Figma

### Step 1: Open Figma Design
1. Open the Figma link: https://www.figma.com/design/G0vx068PwQB3ZOMm8jFdlR/TOBANK---Application-Develop-?node-id=9665-2535&t=GATzE7dg4WOU9vw2-4
2. Navigate to the calendar icon (node-id: 9665-2535)

### Step 2: Select the Icon
1. Click on the calendar icon element
2. Make sure it's the correct icon for the date picker

### Step 3: Export as SVG
1. In the right sidebar, find the **Export** section
2. Click **"+"** to add an export setting
3. Select **"SVG"** as the format
4. Click **"Export [icon name]"** button
5. Save the file

### Step 4: Replace Existing Icon
1. **File to replace**: `assets/icons/ic_calendar.svg`
2. **Action**: Replace the existing `ic_calendar.svg` file with the exported SVG
3. **Location**: `C:\Users\alisi\OneDrive\Desktop\Works\Stac\tobank_sdui\assets\icons\ic_calendar.svg`

### Step 5: Verify
- The file should be named exactly: `ic_calendar.svg`
- It should be in: `assets/icons/` folder
- The code already references this path, so no code changes needed

## Current Code Reference

The login screen already uses this icon:
- **Dart**: `lib/stac/tobank/login/dart/tobank_login.dart` (line 208)
- **Path**: `assets/icons/ic_calendar.svg`
- **Usage**: Date picker suffix icon

Once you replace the file, the icon will automatically update in the app!

