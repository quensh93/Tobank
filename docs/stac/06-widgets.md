# Widgets

Stac provides over 70 built-in widgets that cover most common UI needs. These widgets are JSON representations of Flutter widgets, allowing you to build complex UIs without writing Dart code.

## Widget Categories

### Layout Widgets
- **Column**: Vertical layout
- **Row**: Horizontal layout
- **Stack**: Overlapping layout
- **Container**: Box with decoration
- **Padding**: Add spacing
- **Center**: Center child widget
- **Align**: Position child widget
- **Expanded**: Take available space
- **Flexible**: Flexible sizing
- **SizedBox**: Fixed size container
- **AspectRatio**: Maintain aspect ratio
- **FractionallySizedBox**: Fractional sizing
- **LimitedBox**: Limit size
- **FittedBox**: Fit child to available space

### Display Widgets
- **Text**: Display text
- **Image**: Display images
- **Icon**: Display icons
- **Placeholder**: Placeholder widget
- **Divider**: Visual separator
- **VerticalDivider**: Vertical separator
- **Spacer**: Flexible space

### Input Widgets
- **TextField**: Text input
- **TextFormField**: Form text input
- **Checkbox**: Checkbox input
- **Radio**: Radio button
- **RadioGroup**: Radio button group
- **Switch**: Toggle switch
- **Slider**: Value slider
- **DropdownMenu**: Dropdown selection
- **AutoComplete**: Autocomplete input

### Button Widgets
- **ElevatedButton**: Raised button
- **FilledButton**: Filled button
- **OutlinedButton**: Outlined button
- **TextButton**: Text button
- **IconButton**: Icon button
- **FloatingActionButton**: Floating action button

### Navigation Widgets
- **AppBar**: App bar
- **BottomNavigationBar**: Bottom navigation
- **TabBar**: Tab navigation
- **TabBarView**: Tab content
- **Drawer**: Side drawer
- **BottomSheet**: Bottom sheet

### Scrolling Widgets
- **ListView**: Scrollable list
- **GridView**: Grid layout
- **SingleChildScrollView**: Single child scroll
- **CustomScrollView**: Custom scroll behavior
- **PageView**: Page-based scrolling
- **RefreshIndicator**: Pull to refresh

### Form Widgets
- **Form**: Form container
- **FormField**: Form field wrapper

### Dialog Widgets
- **AlertDialog**: Alert dialog
- **ModalBottomSheet**: Modal bottom sheet

### Progress Widgets
- **CircularProgressIndicator**: Circular progress
- **LinearProgressIndicator**: Linear progress

### Other Widgets
- **Card**: Material card
- **Chip**: Material chip
- **ListTile**: List item
- **CircleAvatar**: Circular avatar
- **BackdropFilter**: Backdrop filter
- **ClipOval**: Oval clipping
- **ClipRRect**: Rounded rectangle clipping
- **ColoredBox**: Colored box
- **Opacity**: Opacity modifier
- **Visibility**: Visibility control
- **SafeArea**: Safe area wrapper
- **Scaffold**: Material scaffold
- **GestureDetector**: Gesture detection
- **InkWell**: Material ink well
- **Hero**: Hero animation
- **Positioned**: Positioned widget
- **Table**: Table layout
- **TableRow**: Table row
- **TableCell**: Table cell
- **Wrap**: Wrap layout
- **Conditional**: Conditional rendering
- **DynamicView**: Dynamic view
- **NetworkWidget**: Network-based widget
- **SetValue**: Value setting widget
- **WebView**: Web view widget

## Common Widget Examples

### Text Widget

```json
{
  "type": "text",
  "data": "Hello World",
  "style": {
    "fontSize": 16,
    "fontWeight": "bold",
    "color": "#333333"
  }
}
```

### Container Widget

```json
{
  "type": "container",
  "width": 200,
  "height": 100,
  "decoration": {
    "color": "#FF5733",
    "borderRadius": 8
  },
  "child": {
    "type": "text",
    "data": "Container"
  }
}
```

### Column Widget

```json
{
  "type": "column",
  "mainAxisAlignment": "center",
  "crossAxisAlignment": "stretch",
  "children": [
    {
      "type": "text",
      "data": "First item"
    },
    {
      "type": "text",
      "data": "Second item"
    }
  ]
}
```

### Button Widget

```json
{
  "type": "elevatedButton",
  "child": {
    "type": "text",
    "data": "Click me"
  },
  "onPressed": {
    "actionType": "snackBar",
    "message": "Button clicked!"
  }
}
```

### TextField Widget

```json
{
  "type": "textField",
  "decoration": {
    "labelText": "Enter text",
    "hintText": "Type something...",
    "prefixIcon": {
      "type": "icon",
      "iconType": "material",
      "icon": "search"
    }
  }
}
```

### Image Widget

```json
{
  "type": "image",
  "src": "https://example.com/image.jpg",
  "width": 200,
  "height": 150,
  "fit": "cover"
}
```

### ListView Widget

```json
{
  "type": "listView",
  "children": [
    {
      "type": "listTile",
      "title": {
        "type": "text",
        "data": "Item 1"
      },
      "subtitle": {
        "type": "text",
        "data": "Subtitle 1"
      }
    },
    {
      "type": "listTile",
      "title": {
        "type": "text",
        "data": "Item 2"
      },
      "subtitle": {
        "type": "text",
        "data": "Subtitle 2"
      }
    }
  ]
}
```

### Card Widget

```json
{
  "type": "card",
  "child": {
    "type": "column",
    "children": [
      {
        "type": "text",
        "data": "Card Title",
        "style": {
          "fontSize": 18,
          "fontWeight": "bold"
        }
      },
      {
        "type": "text",
        "data": "Card content goes here"
      }
    ]
  }
}
```

### AppBar Widget

```json
{
  "type": "appBar",
  "title": {
    "type": "text",
    "data": "My App"
  },
  "actions": [
    {
      "type": "iconButton",
      "icon": {
        "type": "icon",
        "iconType": "material",
        "icon": "search"
      },
      "onPressed": {
        "actionType": "snackBar",
        "message": "Search clicked"
      }
    }
  ]
}
```

### Scaffold Widget

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "My App"
    }
  },
  "body": {
    "type": "center",
    "child": {
      "type": "text",
      "data": "Hello World"
    }
  },
  "floatingActionButton": {
    "type": "floatingActionButton",
    "child": {
      "type": "icon",
      "iconType": "material",
      "icon": "add"
    },
    "onPressed": {
      "actionType": "snackBar",
      "message": "FAB clicked"
    }
  }
}
```

## Widget Properties

### Common Properties

Most widgets support these common properties:

- **key**: Unique identifier for the widget
- **child**: Single child widget
- **children**: Multiple child widgets
- **onPressed**: Action when pressed
- **onTap**: Action when tapped
- **style**: Styling properties
- **decoration**: Decoration properties

### Style Properties

Text and container widgets support styling:

```json
{
  "style": {
    "fontSize": 16,
    "fontWeight": "bold",
    "color": "#333333",
    "backgroundColor": "#FFFFFF",
    "padding": {
      "top": 8,
      "bottom": 8,
      "left": 16,
      "right": 16
    },
    "margin": {
      "top": 4,
      "bottom": 4,
      "left": 8,
      "right": 8
    }
  }
}
```

### Decoration Properties

Container and other widgets support decoration:

```json
{
  "decoration": {
    "color": "#FF5733",
    "borderRadius": 8,
    "border": {
      "width": 1,
      "color": "#CCCCCC"
    },
    "boxShadow": [
      {
        "color": "#000000",
        "blurRadius": 4,
        "offset": {
          "x": 0,
          "y": 2
        }
      }
    ]
  }
}
```

## Layout Widgets

### Column

Vertical layout widget:

```json
{
  "type": "column",
  "mainAxisAlignment": "center",
  "crossAxisAlignment": "stretch",
  "mainAxisSize": "max",
  "children": [
    {
      "type": "text",
      "data": "Item 1"
    },
    {
      "type": "text",
      "data": "Item 2"
    }
  ]
}
```

**Properties:**
- `mainAxisAlignment`: "start", "end", "center", "spaceBetween", "spaceAround", "spaceEvenly"
- `crossAxisAlignment`: "start", "end", "center", "stretch", "baseline"
- `mainAxisSize`: "min", "max"
- `children`: Array of child widgets

### Row

Horizontal layout widget:

```json
{
  "type": "row",
  "mainAxisAlignment": "spaceBetween",
  "crossAxisAlignment": "center",
  "children": [
    {
      "type": "text",
      "data": "Left"
    },
    {
      "type": "text",
      "data": "Right"
    }
  ]
}
```

### Stack

Overlapping layout widget:

```json
{
  "type": "stack",
  "alignment": "center",
  "children": [
    {
      "type": "container",
      "width": 200,
      "height": 200,
      "decoration": {
        "color": "#FF5733"
      }
    },
    {
      "type": "text",
      "data": "Overlay"
    }
  ]
}
```

### Container

Box with decoration:

```json
{
  "type": "container",
  "width": 200,
  "height": 100,
  "padding": {
    "top": 16,
    "bottom": 16,
    "left": 16,
    "right": 16
  },
  "decoration": {
    "color": "#FFFFFF",
    "borderRadius": 8,
    "border": {
      "width": 1,
      "color": "#CCCCCC"
    }
  },
  "child": {
    "type": "text",
    "data": "Container content"
  }
}
```

## Input Widgets

### TextField

Text input widget:

```json
{
  "type": "textField",
  "keyboardType": "text",
  "textInputAction": "done",
  "maxLines": 1,
  "obscureText": false,
  "decoration": {
    "labelText": "Enter text",
    "hintText": "Type something...",
    "prefixIcon": {
      "type": "icon",
      "iconType": "material",
      "icon": "search"
    },
    "suffixIcon": {
      "type": "icon",
      "iconType": "material",
      "icon": "clear"
    }
  }
}
```

### TextFormField

Form text input with validation:

```json
{
  "type": "textFormField",
  "key": "email",
  "keyboardType": "emailAddress",
  "decoration": {
    "labelText": "Email",
    "hintText": "Enter your email"
  },
  "validator": {
    "required": true,
    "email": true
  }
}
```

### Checkbox

Checkbox input:

```json
{
  "type": "checkBox",
  "value": false,
  "onChanged": {
    "actionType": "setValue",
    "key": "checkboxValue",
    "value": "{{!checkboxValue}}"
  }
}
```

### Switch

Toggle switch:

```json
{
  "type": "switch",
  "value": false,
  "onChanged": {
    "actionType": "setValue",
    "key": "switchValue",
    "value": "{{!switchValue}}"
  }
}
```

## Button Widgets

### ElevatedButton

Raised button:

```json
{
  "type": "elevatedButton",
  "child": {
    "type": "text",
    "data": "Elevated Button"
  },
  "style": {
    "backgroundColor": "#4D00E9",
    "padding": {
      "top": 12,
      "bottom": 12,
      "left": 24,
      "right": 24
    }
  },
  "onPressed": {
    "actionType": "snackBar",
    "message": "Elevated button pressed"
  }
}
```

### IconButton

Icon button:

```json
{
  "type": "iconButton",
  "icon": {
    "type": "icon",
    "iconType": "material",
    "icon": "favorite"
  },
  "onPressed": {
    "actionType": "snackBar",
    "message": "Icon button pressed"
  }
}
```

## Navigation Widgets

### AppBar

Application bar:

```json
{
  "type": "appBar",
  "title": {
    "type": "text",
    "data": "My App"
  },
  "backgroundColor": "#4D00E9",
  "actions": [
    {
      "type": "iconButton",
      "icon": {
        "type": "icon",
        "iconType": "material",
        "icon": "search"
      }
    },
    {
      "type": "iconButton",
      "icon": {
        "type": "icon",
        "iconType": "material",
        "icon": "more_vert"
      }
    }
  ]
}
```

### BottomNavigationBar

Bottom navigation:

```json
{
  "type": "bottomNavigationBar",
  "currentIndex": 0,
  "items": [
    {
      "icon": {
        "type": "icon",
        "iconType": "material",
        "icon": "home"
      },
      "label": "Home"
    },
    {
      "icon": {
        "type": "icon",
        "iconType": "material",
        "icon": "search"
      },
      "label": "Search"
    },
    {
      "icon": {
        "type": "icon",
        "iconType": "material",
        "icon": "person"
      },
      "label": "Profile"
    }
  ],
  "onTap": {
    "actionType": "setValue",
    "key": "currentIndex",
    "value": "{{index}}"
  }
}
```

## Scrolling Widgets

### ListView

Scrollable list:

```json
{
  "type": "listView",
  "children": [
    {
      "type": "listTile",
      "title": {
        "type": "text",
        "data": "Item 1"
      },
      "subtitle": {
        "type": "text",
        "data": "Subtitle 1"
      },
      "leading": {
        "type": "icon",
        "iconType": "material",
        "icon": "star"
      },
      "trailing": {
        "type": "icon",
        "iconType": "material",
        "icon": "arrow_forward"
      }
    }
  ]
}
```

### GridView

Grid layout:

```json
{
  "type": "gridView",
  "crossAxisCount": 2,
  "crossAxisSpacing": 8,
  "mainAxisSpacing": 8,
  "children": [
    {
      "type": "card",
      "child": {
        "type": "text",
        "data": "Grid Item 1"
      }
    },
    {
      "type": "card",
      "child": {
        "type": "text",
        "data": "Grid Item 2"
      }
    }
  ]
}
```

## Form Widgets

### Form

Form container:

```json
{
  "type": "form",
  "key": "userForm",
  "child": {
    "type": "column",
    "children": [
      {
        "type": "textFormField",
        "key": "name",
        "decoration": {
          "labelText": "Name"
        },
        "validator": {
          "required": true
        }
      },
      {
        "type": "textFormField",
        "key": "email",
        "decoration": {
          "labelText": "Email"
        },
        "validator": {
          "required": true,
          "email": true
        }
      }
    ]
  }
}
```

## Special Widgets

### Conditional

Conditional rendering:

```json
{
  "type": "conditional",
  "condition": "user.isLoggedIn",
  "trueChild": {
    "type": "text",
    "data": "Welcome back!"
  },
  "falseChild": {
    "type": "text",
    "data": "Please sign in"
  }
}
```

### DynamicView

Dynamic view based on data:

```json
{
  "type": "dynamicView",
  "data": "{{items}}",
  "itemBuilder": {
    "type": "card",
    "child": {
      "type": "text",
      "data": "{{item.name}}"
    }
  }
}
```

### NetworkWidget

Network-based widget:

```json
{
  "type": "networkWidget",
  "url": "https://api.example.com/data",
  "loadingWidget": {
    "type": "circularProgressIndicator"
  },
  "errorWidget": {
    "type": "text",
    "data": "Failed to load data"
  },
  "successWidget": {
    "type": "text",
    "data": "{{data.message}}"
  }
}
```

## Best Practices

### 1. Widget Composition

Build complex UIs by composing simple widgets:

```json
{
  "type": "card",
  "child": {
    "type": "column",
    "children": [
      {
        "type": "text",
        "data": "Title",
        "style": {
          "fontSize": 18,
          "fontWeight": "bold"
        }
      },
      {
        "type": "text",
        "data": "Content"
      },
      {
        "type": "elevatedButton",
        "child": {
          "type": "text",
          "data": "Action"
        }
      }
    ]
  }
}
```

### 2. Consistent Styling

Use consistent styling across your app:

```json
{
  "style": {
    "fontSize": 16,
    "color": "#333333",
    "fontFamily": "Roboto"
  }
}
```

### 3. Proper Keys

Use keys for form fields and dynamic content:

```json
{
  "type": "textFormField",
  "key": "email",
  "decoration": {
    "labelText": "Email"
  }
}
```

### 4. Error Handling

Provide fallback widgets for error states:

```json
{
  "type": "networkWidget",
  "url": "https://api.example.com/data",
  "errorWidget": {
    "type": "text",
    "data": "Something went wrong"
  }
}
```

## Next Steps

- [Actions](./07-actions.md) - Learn about actions and interactions
- [Parsers](./08-parsers.md) - Create custom widgets
- [Theming](./09-theming-styles.md) - Customize appearance
- [Examples](./11-examples.md) - See complete examples
