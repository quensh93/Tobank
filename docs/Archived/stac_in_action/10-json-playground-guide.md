# JSON Playground Guide

## Overview

The JSON Playground is an interactive development tool that allows you to test and experiment with STAC JSON configurations in real-time. It provides a split-view interface with a JSON editor on one side and a live preview on the other, making it easy to iterate on UI designs without restarting your application.

## Features

### 1. Real-Time Preview
- **Live Rendering**: See your STAC JSON rendered instantly as you type
- **Error Display**: Clear error messages when JSON is invalid or rendering fails
- **Device Frame**: Optional device frame simulation to preview on different screen sizes

### 2. JSON Editor
- **Syntax Highlighting**: Color-coded JSON for better readability
- **Real-Time Validation**: Instant feedback on JSON syntax errors
- **Line Numbers**: Easy navigation with line numbers
- **Format Button**: Auto-format JSON with proper indentation
- **Copy to Clipboard**: Quick copy functionality

### 3. Template Library
- **Pre-built Templates**: 11+ ready-to-use templates for common patterns
- **Organized by Category**: Templates grouped by Layout, Display, and Interactive
- **Quick Start**: Load a template and modify it to your needs

### 4. Session Management
- **Save Sessions**: Save your work for later
- **Load Sessions**: Quickly restore previous playground sessions
- **Multiple Sessions**: Manage multiple saved configurations

### 5. Import/Export
- **Export to File**: Save JSON to a file for sharing or version control
- **Import from File**: Load JSON from external files
- **Share**: Share JSON configurations with team members

## Accessing the Playground

### From Debug Panel
1. Open the Debug Panel in your app
2. Navigate to the "Tools" tab
3. Click on "STAC Logs"
4. Click the code icon (</>) in the app bar to open the playground

### Direct Navigation
```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (_) => const JsonPlaygroundScreen(),
  ),
);
```

## Using the Playground

### Basic Workflow

1. **Start with a Template**
   - Click the library icon (📚) in the toolbar
   - Browse templates by category
   - Select a template to load it into the editor

2. **Edit the JSON**
   - Modify the JSON in the editor
   - Use the format button to clean up formatting
   - Watch the preview update in real-time

3. **Test and Iterate**
   - See your changes rendered immediately
   - Fix any errors shown in the error panel
   - Toggle device frame to see how it looks on mobile

4. **Save Your Work**
   - Click the save icon (💾) when satisfied
   - Give your session a name
   - Load it later from the saved sessions

### Template Categories

#### Layout Templates
- **Column Layout**: Vertical arrangement of widgets
- **Row Layout**: Horizontal arrangement of widgets
- **Container**: Styled container with padding and decoration
- **List View**: Scrollable list of items
- **Scaffold**: Complete screen with app bar

#### Display Templates
- **Simple Text**: Basic text widget with styling
- **Image**: Network image with fit options
- **Card**: Material design card

#### Interactive Templates
- **Button**: Elevated button with action
- **Text Field**: Input field with label and hint
- **Form**: Complete form with multiple fields

## Example: Creating a Custom Card

### Step 1: Load the Card Template
```json
{
  "type": "card",
  "elevation": 4,
  "margin": {
    "all": 16
  },
  "child": {
    "type": "padding",
    "padding": {
      "all": 16
    },
    "child": {
      "type": "column",
      "crossAxisAlignment": "start",
      "children": [
        {
          "type": "text",
          "data": "Card Title",
          "style": {
            "fontSize": 20,
            "fontWeight": "bold"
          }
        },
        {
          "type": "sizedBox",
          "height": 8
        },
        {
          "type": "text",
          "data": "This is a card with some content inside it.",
          "style": {
            "fontSize": 14,
            "color": "#666666"
          }
        }
      ]
    }
  }
}
```

### Step 2: Customize the Content
Modify the text, colors, and spacing to match your design:

```json
{
  "type": "card",
  "elevation": 8,
  "margin": {
    "all": 16
  },
  "child": {
    "type": "padding",
    "padding": {
      "all": 20
    },
    "child": {
      "type": "column",
      "crossAxisAlignment": "start",
      "children": [
        {
          "type": "row",
          "mainAxisAlignment": "spaceBetween",
          "children": [
            {
              "type": "text",
              "data": "Product Card",
              "style": {
                "fontSize": 24,
                "fontWeight": "bold",
                "color": "#2196F3"
              }
            },
            {
              "type": "icon",
              "icon": "favorite",
              "color": "#E91E63",
              "size": 28
            }
          ]
        },
        {
          "type": "sizedBox",
          "height": 12
        },
        {
          "type": "text",
          "data": "A beautiful product with amazing features.",
          "style": {
            "fontSize": 16,
            "color": "#666666"
          }
        },
        {
          "type": "sizedBox",
          "height": 16
        },
        {
          "type": "elevatedButton",
          "child": {
            "type": "text",
            "data": "Add to Cart"
          },
          "onPressed": {
            "actionType": "showDialog",
            "title": "Success",
            "message": "Added to cart!"
          }
        }
      ]
    }
  }
}
```

### Step 3: Save and Export
1. Click the save icon to save your session
2. Use the export option to save to a file
3. Use this JSON in your app or Firebase

## Tips and Best Practices

### 1. Start Simple
- Begin with a basic template
- Add complexity gradually
- Test each change before adding more

### 2. Use the Format Button
- Keep your JSON readable
- Format before saving
- Makes debugging easier

### 3. Leverage Templates
- Don't start from scratch
- Modify existing templates
- Create your own template library

### 4. Test Error Handling
- Try invalid JSON to see error messages
- Understand what causes rendering failures
- Learn from error suggestions

### 5. Save Frequently
- Save working versions
- Create multiple variations
- Easy to revert if needed

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Format JSON | Ctrl/Cmd + Shift + F |
| Copy to Clipboard | Ctrl/Cmd + C (in editor) |
| Save Session | Ctrl/Cmd + S |

## Troubleshooting

### Preview Not Updating
**Problem**: Changes in editor don't reflect in preview

**Solutions**:
- Check for JSON syntax errors
- Ensure JSON is valid
- Look for error messages in the error panel

### Rendering Errors
**Problem**: JSON is valid but widget doesn't render

**Solutions**:
- Verify widget type is correct
- Check all required properties are provided
- Refer to STAC widget documentation
- Look at the stack trace for details

### Template Not Loading
**Problem**: Template selector doesn't show templates

**Solutions**:
- Restart the app
- Check that templates are properly defined
- Report issue if problem persists

### Save/Load Issues
**Problem**: Sessions not saving or loading

**Solutions**:
- Check storage permissions
- Clear app data and try again
- Ensure session names are unique

## Advanced Features

### Device Frame Simulation
Toggle the device frame to see how your UI looks on a mobile device:
- Click the phone icon in the toolbar
- Preview shows a device frame around your UI
- Useful for testing responsive layouts

### Import from File
Load JSON from external sources:
1. Click the menu icon (⋮)
2. Select "Import from file"
3. Choose a JSON file
4. JSON loads into the editor

### Export to File
Share your JSON with others:
1. Click the menu icon (⋮)
2. Select "Export to file"
3. Choose save location
4. Share the file

## Integration with STAC Logs

The playground integrates seamlessly with STAC Logs:

1. **From Logs to Playground**
   - View a log entry in STAC Logs
   - Click "Open in Playground" to edit the JSON
   - Make changes and test immediately

2. **From Playground to App**
   - Test JSON in playground
   - Save to mock data or Firebase
   - See it live in your app

## Next Steps

- **[Visual Editor Guide](09-visual-editor-guide.md)**: Learn about the drag-and-drop visual editor
- **[Custom Widgets Guide](02-custom-widgets-guide.md)**: Create custom STAC widgets
- **[Firebase Integration](07-firebase-integration.md)**: Deploy your JSON to Firebase
- **[Mock Data Guide](06-mock-data-guide.md)**: Use playground JSON in mock data

## Summary

The JSON Playground is a powerful tool for:
- Rapid prototyping of STAC UIs
- Testing JSON configurations
- Learning STAC widget syntax
- Debugging rendering issues
- Sharing UI designs with team members

Use it to accelerate your STAC development workflow and create better server-driven UIs faster.
