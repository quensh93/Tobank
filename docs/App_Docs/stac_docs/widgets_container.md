# Widgets Container

Layout Widgets
Container
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
# Container

Documentation for Container

# 
​
Container
Stac container allows you to build the Flutter container widget using JSON. To know more about the container widget in Flutter, refer to the official documentation.
## 
​
Properties
Property | Type | Description  
---|---|---  
alignment | `StacAlignment` | The alignment of the child within the container.  
padding | `StacEdgeInsets` | The padding to apply around the child.  
decoration | `StacBoxDecoration` | The decoration to paint behind the child.  
foregroundDecoration | `StacBoxDecoration` | The decoration to paint in front of the child.  
color | `String` | The hex color to paint behind the child.  
width | `double` | The width of the container.  
height | `double` | The height of the container.  
constraints | `StacBoxConstraints` | Additional constraints to apply to the container.  
margin | `StacEdgeInsets` | The margin to apply around the container.  
child | `Map` | The child widget of the container.  
clipBehavior | `Clip` | The clip behavior of the container.  
## 
​
Example JSON
Copy
```
{
  "type":  "container",
  "alignment":  "center",
  "padding":  {
    "top":  16.0,
    "bottom":  16.0,
    "left":  16.0,
    "right":  16.0
  },
  "decoration":  {
    "color":  "#FF5733",
    "borderRadius":  {
      "topLeft":  16.0,
      "topRight":  16.0,
      "bottomLeft":  16.0,
      "bottomRight":  16.0
    }
  },
  "width":  200.0,
  "height":  200.0,
  "child":  {
    "type":  "text",
    "data":  "Hello, World!",
    "style":  {
      "color":  "#FFFFFF",
      "fontSize":  24.0
    }
  }
}

```

ColumnExpanded
⌘I