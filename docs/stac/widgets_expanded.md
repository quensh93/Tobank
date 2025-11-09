# Widgets Expanded

Layout Widgets
Expanded
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
# Expanded

Documentation for Expanded

# 
​
Expanded
The Stac Expanded allows you to build a Flutter expanded widget using JSON. To know more about the expanded widget in Flutter, refer to the official documentation.
## 
​
Properties
Property | Type | Description  
---|---|---  
flex | `int` | The flex factor to use for the expanded widget. Defaults to `1`.  
child | `Map?` | The widget to display inside the expanded widget.  
## 
​
Example JSON
Copy
```
{
  "type": "expanded",
  "flex": 2,
  "child": {
    "type": "text",
    "data": "Hello, World!"
  }
}

```

ContainerFlexible
⌘I