# Widgets Opacity

Display Widgets
Opacity
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

Display Widgets
# Opacity

Documentation for Opacity

# 
​
Opacity
Stac opacity allows you to build the Flutter Opacity widget using JSON. To know more about the Slider widget in Flutter, refer to the official documentation.
## 
​
Properties
Property | Type | Description  
---|---|---  
opacity | `double` | The opacity value between 0.0 and 1.0 which controls the visibility of the child, with 0.0 being fully transparent (invisible) and 1.0 being fully opaque (visible).  
child | `Map` | The child widget of the opacity.  
## 
​
Example JSON
Copy
```
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Opacity"
    }
  },
  "body": {
    "type": "center",
    "child": {
      "type": "opacity",
      "opacity": 0.5,
      "child": {
        "type": "text",
        "data": "Opacity Widget",
        "style": {
          "fontSize": 23,
          "fontWeight": "w600"
        }
      }
    }
  }
}

```

ImagePlaceholder
⌘I