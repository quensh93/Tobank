# Widgets Stack

Layout Widgets
Stack
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
# Stack

Documentation for Stack

# 
​
Stack
The Stac Stack allows you to build a Flutter stack widget using JSON. To know more about the stack widget in Flutter, refer to the official documentation.
## 
​
Properties
Property | Type | Description  
---|---|---  
alignment | `StacAlignmentDirectional` | How to align the non-positioned and partially-positioned children. Defaults to `StacAlignmentDirectional.topStart`.  
clipBehavior | `Clip` | How to clip the content. Defaults to `Clip.hardEdge`.  
fit | `StackFit` | How to size the non-positioned children. Defaults to `StackFit.loose`.  
textDirection | `TextDirection?` | The text direction to use for resolving alignment.  
children | `List>` | The list of widgets to display inside the stack. Defaults to an empty list.  
## 
​
Example JSON
Copy
```
{
  "type": "stack",
  "alignment": "center",
  "clipBehavior": "antiAlias",
  "fit": "expand",
  "textDirection": "ltr",
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

SpacerWrap
⌘I