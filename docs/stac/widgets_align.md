# Widgets Align

Layout Widgets
Align
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

Layout Widgets
# Align

Documentation for Align

# 
​
Align
Stac align allows you to build the Flutter align widget using JSON. To know more about the align widget in Flutter, refer to the official documentation.
## 
​
Properties
Property | Type | Description  
---|---|---  
alignment | `StacAlignment` | How to align the child.  
widthFactor | `double` | If non-null, sets its width to the child’s width multiplied by this factor.  
heightFactor | `double` | If non-null, sets its height to the child’s height multiplied by this factor.  
child | `Map` | The widget below this widget in the tree.  
## 
​
Example
Copy
```
{
  "type": "align",
  "alignment": "topEnd",
  "child": {
    "type": "container",
    "color": "#FC5632",
    "clipBehavior": "hardEdge",
    "height": 250,
    "width": 200,
    "child": {
      "type": "align",
      "alignment": "bottomCenter",
      "child": {
        "type": "text",
        "data": "Flutter",
        "style": {
          "fontSize": 23,
          "fontWeight": "w600"
        }
      }
    }
  }
}

```

AspectRatio
⌘I