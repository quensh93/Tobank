# Widgets Visibility

Display Widgets
Visibility
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
  * Example 1: Basic Visibility
  * Example 2: Hidden with Replacement

Display Widgets
# Visibility

Documentation for Visibility

# 
​
Visibility
Stac Visibility allows you to build the Flutter Visibility widget using JSON. To know more about the Visibility widget in Flutter, refer to the official documentation.
* * *
## 
​
Properties
Property | Type | Description  
---|---|---  
`child` | `Map` | The widget to be displayed when `visible` is `true`.  
`replacement` | `Map?` | The widget to display when `visible` is `false`. Defaults to an empty widget (`SizedBox.shrink`).  
`visible` | `bool` | Whether the child is visible. Defaults to `true`.  
`maintainState` | `bool` | Whether to maintain the state of the widget when it is hidden. Defaults to `false`.  
`maintainAnimation` | `bool` | Whether to maintain the animation of the widget when it is hidden. Defaults to `false`.  
`maintainSize` | `bool` | Whether to maintain the size of the widget when it is hidden. Defaults to `false`.  
`maintainSemantics` | `bool` | Whether to maintain the semantics of the widget when it is hidden. Defaults to `false`.  
`maintainInteractivity` | `bool` | Whether to maintain the interactivity of the widget when it is hidden. Defaults to `false`.  
* * *
## 
​
Example JSON
### 
​
Example 1: Basic Visibility
Copy
```
{
  "type": "visibility",
  "child": {
    "type": "text",
    "data": "I am visible!"
  },
  "visible": true
}

```

### 
​
Example 2: Hidden with Replacement
Copy
```
{
  "type": "visibility",
  "child": {
    "type": "text",
    "data": "I am hidden!"
  },
  "replacement": {
    "type": "container",
    "color": "#FF5733",
    "width": 50,
    "height": 50
  },
  "visible": false
}

```

PlaceholderAlertDialog
⌘I