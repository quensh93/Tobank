# Widgets Padding

Layout Widgets
Padding
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

Layout Widgets
# Padding

Documentation for Padding

# 
​
Padding
Stac padding allows you to build the Flutter padding widget using JSON. To know more about the padding widget in Flutter, refer to the official documentation.
## 
​
Properties
Property | Type | Description  
---|---|---  
padding | `StacEdgeInsets` | The amount of space by which to inset the child. Examples: `"padding": 12` for uniform padding, `"padding": {"left": 0, "right": 0}` for specific sides, or `{"padding": [8, 12, 8, 12]}` for left, top, right, bottom.  
child | `Map` | The widget below this widget in the tree.  
## 
​
Example JSON
Copy
```
{
  "type": "padding",
  "padding": {
    "left": 0,
    "right": 0
  },
  "child": {
    "type": "container",
    "color": "#672BFF",
    "clipBehavior": "hardEdge",
    "height": 75,
    "width": 700
  }
}

```

Limited BoxPositioned
⌘I