# Visual JSON Editor Guide

## Overview

The Visual JSON Editor is a powerful GUI-based tool that allows you to create and modify STAC JSON configurations using drag-and-drop functionality, eliminating the need to write JSON manually. It provides an intuitive interface with a component palette, visual canvas, property editor, and tree view, making it easy to build complex UIs visually.

## Features

### 1. Component Palette
- **Organized Categories**: Components grouped by Layout, Display, Interactive, Lists, and Structure
- **Drag-and-Drop**: Simply drag components onto the canvas
- **Search/Filter**: Quickly find the component you need
- **Visual Icons**: Each component has a recognizable icon
- **Default Properties**: Components come with sensible defaults

### 2. Visual Canvas
- **WYSIWYG Editing**: See your UI as you build it
- **Nested Components**: Support for complex widget hierarchies
- **Selection Highlighting**: Selected widgets are visually highlighted
- **Drop Indicators**: Visual feedback showing where components will be placed
- **Empty State Guidance**: Helpful prompts when canvas is empty

### 3. Property Editor
- **Dynamic Properties**: Edit properties specific to each widget type
- **Type-Specific Inputs**: 
  - Text fields for strings
  - Number spinners for numeric values
  - Switches for booleans
  - Color pickers for colors
- **Add/Remove Properties**: Customize widgets with additional properties
- **Suggested Properties**: Quick-add common properties for each widget type

### 4. Widget Tree View
- **Hierarchical Display**: See your widget structure as a tree
- **Expand/Collapse**: Navigate complex hierarchies easily
- **Context Actions**: Duplicate or delete nodes
- **Selection Sync**: Syncs with canvas and property editor
- **Children Count**: Shows how many children each node has

### 5. JSON Synchronization
- **Bidirectional Sync**: Changes in visual editor update JSON and vice versa
- **Toggle Views**: Switch between visual and JSON editing modes
- **Real-Time Validation**: JSON is validated before applying changes
- **Error Handling**: Clear error messages when JSON is invalid

### 6. Import/Export
- **Export JSON**: Save your visual design as JSON
- **Import JSON**: Load existing JSON into the visual editor
- **Copy to Clipboard**: Quick copy functionality
- **Create New**: Start fresh with confirmation for unsaved changes

## Accessing the Visual Editor

### From Debug Panel
1. Open the Debug Panel in your app
2. Navigate to the "Tools" tab
3. Click on "Visual Editor"

### Direct Navigation
```dart
import 'package:debug_panel/debug_panel.dart';

Navigator.of(context).push(
  MaterialPageRoute(
    builder: (_) => const VisualEditorScreen(),
  ),
);
```

## Getting Started

### Basic Workflow

1. **Start with a Root Component**
   - Drag a layout component (Column, Row, or Container) onto the empty canvas
   - This becomes your root widget

2. **Add Child Components**
   - Drag components from the palette onto your root widget
   - Drop indicators show where the component will be placed
   - Components are added to the selected parent

3. **Edit Properties**
   - Click on any component to select it
   - Use the property editor on the right to modify properties
   - Changes are reflected immediately in the canvas

4. **Organize with Tree View**
   - Use the tree view to navigate complex hierarchies
   - Expand/collapse branches to focus on specific areas
   - Right-click nodes for duplicate/delete actions

5. **Export Your Design**
   - Switch to JSON view to see the generated JSON
   - Copy to clipboard or export to a file
   - Use in your app, mock data, or Firebase

## Component Categories

### Layout Components
Components that control the arrangement of child widgets:

- **Column**: Vertical arrangement of children
- **Row**: Horizontal arrangement of children
- **Stack**: Overlapping children
- **Container**: Single child with styling (padding, margin, decoration)
- **Center**: Centers its child
- **Padding**: Adds padding around its child
- **SizedBox**: Fixed size box
- **Expanded**: Expands to fill available space in Column/Row

### Display Components
Components that display content:

- **Text**: Display text with styling
- **Image**: Display images from network or assets
- **Icon**: Material Design icons
- **Divider**: Horizontal line separator
- **Card**: Material Design card
- **ListTile**: Standard list item with leading, title, subtitle, trailing

### Interactive Components
Components that respond to user input:

- **ElevatedButton**: Raised button with elevation
- **TextButton**: Flat text button
- **OutlinedButton**: Button with outline
- **IconButton**: Button with icon
- **TextField**: Text input field
- **Checkbox**: Checkbox input
- **Switch**: Toggle switch
- **Slider**: Slider for numeric input

### List Components
Components for displaying lists:

- **ListView**: Scrollable list of children
- **GridView**: Grid layout of children
- **Wrap**: Wraps children to next line when space runs out

### Structure Components
High-level structural components:

- **Scaffold**: Basic material design layout structure
- **AppBar**: Top app bar
- **BottomNavigationBar**: Bottom navigation bar
- **Drawer**: Side drawer menu

## Step-by-Step Tutorial

### Example 1: Creating a Simple Profile Card

#### Step 1: Add a Container
1. Find "Container" in the Layout category
2. Drag it onto the empty canvas
3. It becomes your root widget

#### Step 2: Add a Column Inside
1. Select the Container (click on it)
2. Drag a "Column" from the palette onto the Container
3. The Column is now a child of the Container

#### Step 3: Add Profile Content
1. Select the Column
2. Drag a "Text" widget onto the Column (for the name)
3. Drag another "Text" widget onto the Column (for the bio)
4. Drag an "ElevatedButton" onto the Column

#### Step 4: Customize Properties
1. Select the Container:
   - Add property "padding" → set to `{"all": 16}`
   - Add property "decoration" → set background color

2. Select the first Text widget:
   - Change "data" to "John Doe"
   - Add property "style" → set fontSize to 24, fontWeight to "bold"

3. Select the second Text widget:
   - Change "data" to "Software Developer"
   - Add property "style" → set fontSize to 16, color to "#666666"

4. Select the ElevatedButton:
   - Find its child Text widget in the tree
   - Change "data" to "Follow"

#### Step 5: Export
1. Click "JSON" to switch to JSON view
2. Review the generated JSON
3. Click "Copy JSON" to copy to clipboard

**Result JSON**:
```json
{
  "type": "container",
  "padding": {
    "all": 16
  },
  "child": {
    "type": "column",
    "crossAxisAlignment": "start",
    "children": [
      {
        "type": "text",
        "data": "John Doe",
        "style": {
          "fontSize": 24,
          "fontWeight": "bold"
        }
      },
      {
        "type": "text",
        "data": "Software Developer",
        "style": {
          "fontSize": 16,
          "color": "#666666"
        }
      },
      {
        "type": "elevatedButton",
        "child": {
          "type": "text",
          "data": "Follow"
        }
      }
    ]
  }
}
```

### Example 2: Creating a Product List Item

#### Step 1: Start with a Card
1. Drag a "Card" onto the canvas
2. This provides elevation and material design styling

#### Step 2: Add a Row for Horizontal Layout
1. Select the Card
2. Drag a "Row" onto the Card

#### Step 3: Add Image and Content
1. Select the Row
2. Drag an "Image" widget onto the Row (for product image)
3. Drag a "Column" onto the Row (for product details)

#### Step 4: Add Product Details
1. Select the Column
2. Drag a "Text" widget (for product name)
3. Drag another "Text" widget (for price)
4. Drag an "ElevatedButton" (for add to cart)

#### Step 5: Customize
1. Select the Image:
   - Set "src" to your image URL
   - Set "width" to 100
   - Set "height" to 100

2. Select the Column:
   - Set "crossAxisAlignment" to "start"
   - Set "mainAxisAlignment" to "spaceEvenly"

3. Customize text widgets with appropriate data and styles

4. Select the Row:
   - Set "mainAxisAlignment" to "start"

#### Step 6: Fine-tune with Tree View
1. Use the tree view to navigate the structure
2. Add padding to the Card
3. Add spacing between elements using SizedBox

### Example 3: Creating a Form

#### Step 1: Create Scaffold Structure
1. Drag a "Scaffold" onto the canvas
2. This provides the basic screen structure

#### Step 2: Add AppBar
1. Select the Scaffold
2. Drag an "AppBar" onto it
3. The AppBar automatically goes to the correct position

#### Step 3: Add Form Content
1. Select the Scaffold
2. Drag a "Column" onto the body area
3. Add multiple "TextField" widgets to the Column

#### Step 4: Add Submit Button
1. Drag an "ElevatedButton" to the bottom of the Column
2. Customize the button text

#### Step 5: Configure TextFields
For each TextField:
1. Add "decoration" property
2. Set "labelText" and "hintText"
3. Add "keyboardType" if needed

## Working with Properties

### Common Properties

#### Text Widget Properties
- **data**: The text to display (string)
- **style**: Text styling object
  - fontSize (number)
  - fontWeight ("normal", "bold")
  - color (hex string like "#FF0000")
  - fontFamily (string)

#### Container Properties
- **padding**: Padding object
  - all (number) - same padding on all sides
  - horizontal (number) - left and right
  - vertical (number) - top and bottom
  - left, right, top, bottom (individual numbers)
- **margin**: Same structure as padding
- **decoration**: Decoration object
  - color (hex string)
  - borderRadius (number or object)
- **width**: Fixed width (number)
- **height**: Fixed height (number)

#### Column/Row Properties
- **mainAxisAlignment**: "start", "center", "end", "spaceBetween", "spaceAround", "spaceEvenly"
- **crossAxisAlignment**: "start", "center", "end", "stretch"
- **children**: Array of child widgets

#### Button Properties
- **child**: The button's content (usually a Text widget)
- **onPressed**: Action to perform when pressed
- **style**: Button styling

### Adding Custom Properties

1. Select a widget
2. Scroll to the bottom of the property editor
3. Click "Add Property"
4. Enter the property name
5. Enter the property value
6. The property is added to the widget

### Suggested Properties

The property editor shows suggested properties based on the widget type:

- Click on a suggested property chip
- It's automatically added with a default value
- Modify the value as needed

## Advanced Features

### Duplicating Widgets

To duplicate a widget and its entire subtree:

1. Find the widget in the tree view
2. Right-click on it
3. Select "Duplicate"
4. A copy is created as a sibling

This is useful for:
- Creating multiple similar items
- Building list items
- Reusing complex widget structures

### Deleting Widgets

To delete a widget:

1. Find the widget in the tree view
2. Right-click on it
3. Select "Delete"
4. Confirm the deletion

**Note**: Deleting a widget also deletes all its children.

### Expanding/Collapsing Tree

For complex hierarchies:

- Click "Expand All" to see the entire tree
- Click "Collapse All" to collapse all branches
- Click individual arrows to expand/collapse specific branches

### JSON Editing Mode

Switch to JSON mode to:

1. **Make Bulk Changes**: Edit multiple properties at once
2. **Copy/Paste**: Copy JSON from other sources
3. **Advanced Editing**: Use features not available in visual mode
4. **Learn JSON Structure**: See how visual changes translate to JSON

To switch:
1. Click "JSON" button in the toolbar
2. Edit the JSON
3. Click "Apply" to update the visual editor
4. Click "Revert" to discard changes

### Import Existing JSON

To load existing JSON into the visual editor:

1. Click the menu icon (⋮)
2. Select "Import JSON"
3. Choose a JSON file
4. The visual editor loads the structure

This is useful for:
- Editing existing screens
- Converting JSON playground designs
- Modifying mock data files

### Export Options

Multiple ways to export your design:

1. **Copy to Clipboard**: Quick copy for pasting elsewhere
2. **Export to File**: Save as a .json file
3. **Switch to JSON View**: See and copy the JSON directly

## Navigation Flow Editor

The Navigation Flow Editor is a specialized tool for creating and managing app navigation:

### Features
- **Visual Route Map**: See all routes in your app
- **Route Configuration**: Define route names and parameters
- **Navigation Actions**: Configure navigation actions between screens
- **Parameter Passing**: Set up route parameters
- **Deep Linking**: Configure deep link patterns

### Creating a Navigation Flow

1. **Open Navigation Editor**
   - Click "Navigation" tab in the visual editor
   - Or access from the specialized editors menu

2. **Add Routes**
   - Click "Add Route"
   - Enter route name (e.g., "/home", "/profile")
   - Configure route parameters

3. **Define Screens**
   - For each route, specify the screen JSON
   - Link to existing screen configurations
   - Or create new screens inline

4. **Configure Navigation**
   - Add navigation actions between routes
   - Set up back navigation
   - Configure route guards (authentication, etc.)

5. **Export Navigation Config**
   - Export as navigation JSON
   - Use in your app's routing configuration
   - Deploy to Firebase or mock data

### Navigation JSON Structure

```json
{
  "routes": [
    {
      "path": "/home",
      "screen": "home_screen",
      "parameters": []
    },
    {
      "path": "/profile/:userId",
      "screen": "profile_screen",
      "parameters": ["userId"]
    },
    {
      "path": "/settings",
      "screen": "settings_screen",
      "parameters": [],
      "requiresAuth": true
    }
  ],
  "initialRoute": "/home"
}
```

## Menu Editor

The Menu Editor is a specialized tool for creating navigation menus and bottom navigation bars:

### Features
- **Visual Menu Builder**: Drag-and-drop menu item creation
- **Icon Selection**: Choose from Material Design icons
- **Action Configuration**: Set up navigation or custom actions
- **Reordering**: Drag to reorder menu items
- **Nested Menus**: Support for submenus and menu groups

### Creating a Bottom Navigation Bar

1. **Open Menu Editor**
   - Click "Menu" tab in the visual editor
   - Select "Bottom Navigation" type

2. **Add Menu Items**
   - Click "Add Item"
   - Set label (e.g., "Home", "Search", "Profile")
   - Choose icon from icon picker
   - Configure navigation action

3. **Configure Actions**
   - For each item, set the action:
     - Navigate to route
     - Show dialog
     - Custom action
   - Set active/inactive colors

4. **Preview**
   - See the menu rendered in real-time
   - Test navigation actions
   - Adjust styling

5. **Export Menu Config**
   - Export as menu JSON
   - Use in your app's navigation
   - Deploy to Firebase

### Menu JSON Structure

```json
{
  "type": "bottomNavigationBar",
  "items": [
    {
      "label": "Home",
      "icon": "home",
      "action": {
        "actionType": "navigate",
        "route": "/home"
      }
    },
    {
      "label": "Search",
      "icon": "search",
      "action": {
        "actionType": "navigate",
        "route": "/search"
      }
    },
    {
      "label": "Profile",
      "icon": "person",
      "action": {
        "actionType": "navigate",
        "route": "/profile"
      }
    }
  ],
  "selectedItemColor": "#2196F3",
  "unselectedItemColor": "#757575"
}
```

### Creating a Drawer Menu

1. **Open Menu Editor**
   - Select "Drawer" type

2. **Add Header**
   - Configure drawer header
   - Add user info or branding
   - Set background image/color

3. **Add Menu Items**
   - Add items with icons and labels
   - Group items into sections
   - Add dividers between groups

4. **Configure Actions**
   - Set navigation actions
   - Add logout or settings actions
   - Configure custom actions

5. **Export**
   - Export as drawer JSON
   - Integrate with Scaffold

## Tips and Best Practices

### 1. Start with Structure
- Begin with layout components (Column, Row, Container)
- Add content components later
- Build from outside-in (parent to children)

### 2. Use the Tree View
- Navigate complex hierarchies easily
- Quickly select deeply nested widgets
- Understand your widget structure

### 3. Leverage Suggested Properties
- Save time with common properties
- Learn which properties are available
- Discover new widget capabilities

### 4. Test as You Build
- The canvas shows real-time preview
- Catch layout issues early
- Iterate quickly

### 5. Use Duplicate for Repetition
- Don't rebuild similar widgets
- Duplicate and modify
- Maintain consistency

### 6. Switch Between Visual and JSON
- Use visual mode for structure
- Use JSON mode for bulk edits
- Learn JSON patterns from visual changes

### 7. Save Frequently
- Export JSON regularly
- Keep backups of complex designs
- Version control your JSON files

### 8. Organize with Containers
- Use Containers to group related widgets
- Add padding and margins for spacing
- Apply consistent styling

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Delete Selected Widget | Delete/Backspace |
| Duplicate Selected Widget | Ctrl/Cmd + D |
| Toggle JSON View | Ctrl/Cmd + J |
| Copy JSON | Ctrl/Cmd + C (in JSON view) |
| Save/Export | Ctrl/Cmd + S |
| New Design | Ctrl/Cmd + N |

## Troubleshooting

### Component Won't Drop
**Problem**: Dragging a component but it won't drop on the canvas

**Solutions**:
- Ensure you're dropping on a valid parent (some widgets only accept specific children)
- Check if the parent supports children (e.g., Text widgets can't have children)
- Try dropping on a different parent widget
- Start with a layout component (Column, Row, Container) as root

### Properties Not Updating
**Problem**: Changing properties but canvas doesn't update

**Solutions**:
- Ensure the widget is selected
- Check if the property name is correct
- Try switching to JSON view and back
- Restart the visual editor

### JSON Sync Errors
**Problem**: Error when switching from JSON to visual mode

**Solutions**:
- Check JSON syntax is valid
- Ensure all widget types are recognized
- Verify required properties are present
- Look at the error message for specific issues

### Tree View Not Showing
**Problem**: Tree view is empty or not updating

**Solutions**:
- Ensure you have widgets on the canvas
- Try collapsing and expanding all
- Refresh the visual editor
- Check console for errors

### Complex Hierarchies Hard to Navigate
**Problem**: Too many nested widgets, hard to find what you need

**Solutions**:
- Use the tree view search (if available)
- Collapse branches you're not working on
- Use descriptive property values to identify widgets
- Consider breaking into smaller components

## Integration with Other Tools

### With JSON Playground
1. Create a design in the visual editor
2. Export to JSON
3. Open in JSON playground for testing
4. Refine and iterate

### With Mock Data
1. Create screens in the visual editor
2. Export JSON to `assets/mock_data/screens/`
3. Use MockApiService to load them
4. Test in your app

### With Firebase
1. Design screens visually
2. Export JSON
3. Use Firebase CLI to upload
4. Deploy to production

### With STAC Logs
1. View a screen in STAC Logs
2. Click "Edit in Visual Editor"
3. Make changes visually
4. Save back to source

## Advanced Techniques

### Creating Reusable Components

1. Build a component in the visual editor
2. Export the JSON
3. Save as a template
4. Import and reuse in other designs

### Building Responsive Layouts

1. Use Expanded widgets in Rows/Columns
2. Set flex values for proportional sizing
3. Use MediaQuery-aware properties
4. Test with device frame in playground

### Styling Consistency

1. Define color palette in properties
2. Use consistent fontSize values
3. Create style templates
4. Document your design system

### Performance Optimization

1. Avoid deeply nested structures
2. Use const constructors where possible
3. Minimize widget rebuilds
4. Keep JSON files reasonably sized

## Next Steps

- **[JSON Playground Guide](10-json-playground-guide.md)**: Test your visual designs
- **[Custom Widgets Guide](02-custom-widgets-guide.md)**: Add custom components to the palette
- **[Firebase Integration](07-firebase-integration.md)**: Deploy your designs
- **[Debug Panel Guide](08-debug-panel-guide.md)**: Explore other debug tools

## Summary

The Visual JSON Editor provides:
- **Intuitive Interface**: Build UIs without writing JSON
- **Real-Time Preview**: See changes immediately
- **Powerful Tools**: Component palette, property editor, tree view
- **Specialized Editors**: Navigation and menu editors for specific use cases
- **Seamless Integration**: Works with playground, mock data, and Firebase
- **Flexible Workflow**: Switch between visual and JSON editing

Use the visual editor to:
- Rapidly prototype UI designs
- Build complex layouts visually
- Learn STAC JSON structure
- Create navigation flows and menus
- Collaborate with non-technical team members
- Accelerate your STAC development workflow

The visual editor makes server-driven UI development accessible to everyone, from developers to designers to product managers.
