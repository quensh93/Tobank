# Widgets Drawer

Interactive Widgets
Drawer
OverviewWidgetsActions

  * BackdropFilter

  * CarouselView
  * CircleAvatar
  * ClipOval
  * ClipRRect
  * ColoredBox

  * AlertDialog
  * AppBar
  * AutoComplete
  * BottomBar
  * CheckBox

  * CircularProgressIndicator

  * DropdownMenu
  * Dynamic View
  * ElevatedButton
  * FilledButton
  * FloatingActionButton

  * GestureDetector
  * IconButton
  * InkWell
  * LinearProgressIndicator
  * ListTile
  * List View
  * NetworkWidget
  * OutlinedButton
  * PageView
  * RadioGroup
  * RefreshIndicator

  * SingleChildScrollView

  * SliverAppBar

  * TabBar
  * TextButton
  * TextField
  * TextFormField
  * WebView

  * CustomScrollView
  * GridView

  * TableCell
  * TableRow

  * Vertical Divider

  * Example JSON

Interactive Widgets
# Drawer

Documentation for Drawer

# 
​
Drawer
The Stac Drawer allows you to build a Flutter Drawer widget using JSON. To know more about the Drawer widget in Flutter, refer to the official documentation.
## 
​
Properties
Property | Type | Description  
---|---|---  
backgroundColor | `String?` | The background color of the drawer.  
elevation | `double?` | The z-coordinate at which to place this drawer.  
shadowColor | `String?` | The color of the drawer’s shadow.  
surfaceTintColor | `String?` | The surface tint color of the drawer.  
shape | `StacShapeBorder?` | The shape of the drawer.  
width | `double?` | The width of the drawer.  
child | `Map?` | The widget below this widget in the tree.  
semanticLabel | `String?` | The semantic label for the drawer.  
clipBehavior | `Clip?` | The clip behavior of the drawer.  
## 
​
Example JSON
Copy
```
{
  "type": "drawer",
  "backgroundColor": "#FFFFFF",
  "elevation": 16.0,
  "shadowColor": "#000000",
  "surfaceTintColor": "#F2F2F2",
  "shape": {
    "type": "roundedRectangleBorder",
    "borderRadius": 16
  },
  "width": 304.0,
  "semanticLabel": " Drawer",
  "clipBehavior": "antiAlias",
  "child": {
    "type": "column",
    "children": [
      {
        "type": "text",
        "data": "Drawer Header"
      },
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
}

```

CircularProgressIndicatorDropdownMenu
⌘I