# Widgets Column

Layout Widgets
Column
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
# Column

Documentation for Column

# 
​
Column
The Stac Column allows you to build a Flutter column widget using JSON. To know more about the column widget in Flutter, refer to the official documentation.
## 
​
Properties
Property | Type | Description  
---|---|---  
mainAxisAlignment | `MainAxisAlignment` | How the children should be placed along the main axis. Defaults to `MainAxisAlignment.start`.  
crossAxisAlignment | `CrossAxisAlignment` | How the children should be placed along the cross axis. Defaults to `CrossAxisAlignment.center`.  
mainAxisSize | `MainAxisSize` | How much space should be occupied in the main axis. Defaults to `MainAxisSize.max`.  
textDirection | `TextDirection?` | The text direction to use for resolving alignment.  
verticalDirection | `VerticalDirection` | The vertical direction to use for laying out children. Defaults to `VerticalDirection.down`.  
spacing | `double` | The spacing between children. Defaults to `0`.  
children | `List>` | The list of widgets to display inside the column. Defaults to an empty list.  
## 
​
Example JSON
Copy
```
{
  "type": "column",
  "mainAxisAlignment": "center",
  "crossAxisAlignment": "start",
  "mainAxisSize": "min",
  "textDirection": "ltr",
  "verticalDirection": "up",
  "spacing": 10,
  "children": [
    {
      "type": "text",
      "data": "Hello, World!"
    },
    {
      "type": "container",
      "width": 100,
      "height": 100,
      "color": "#FF0000"
    }
  ]
}

```

CenterContainer
⌘I