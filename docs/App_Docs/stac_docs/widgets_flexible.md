# Widgets Flexible

Layout Widgets
Flexible
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
# Flexible

Documentation for Flexible

# 
​
Flexible
The Stac Flexible allows you to build a Flutter flexible widget using JSON. To know more about the flexible widget in Flutter, refer to the official documentation.
## 
​
Properties
Property | Type | Description  
---|---|---  
child | `Map?` | The widget to display inside the flexible widget.  
flex | `int` | The flex factor to use for the flexible widget. Defaults to `1`.  
fit | `FlexFit` | How the child should be inscribed into the available space. Defaults to `FlexFit.loose`.  
## 
​
Example JSON
Copy
```
{
  "type": "flexible",
  "flex": 2,
  "fit": "tight",
  "child": {
    "type": "text",
    "data": "Hello, World!"
  }
}

```

ExpandedFittedBox
⌘I