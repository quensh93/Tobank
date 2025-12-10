# Widgets Image

Display Widgets
Image
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

  * Enum: StacImageType
  * Example JSON

Display Widgets
# Image

Documentation for Image

# 
​
Image
The `Image` widget allows you to display an image in your Flutter app using JSON. It supports images from multiple sources, including assets, files, and network URLs, and provides customization options such as alignment, color, width, height, and fit. To learn more about the equivalent Flutter widgets and their properties, refer to the official Flutter documentation for Image.
## 
​
Properties
Property | Type | Description  
---|---|---  
`src` | `String` | The source of the image. For example, a URL for network images, file path for file images, or asset path.  
`alignment` | `StacAlignment` | The alignment of the image within its container. Defaults to `StacAlignment.center`.  
`imageType` | `StacImageType` | The type of the image source: `file`, `network`, or `asset`. Defaults to `StacImageType.network`.  
`color` | `String?` | The color to blend with the image, provided in hex format (e.g., `#FF0000` for red).  
`width` | `double?` | The width of the image in logical pixels.  
`height` | `double?` | The height of the image in logical pixels.  
`fit` | `BoxFit?` | How the image should be inscribed into the space allocated during layout.  
## 
​
Enum: StacImageType
Value | Description  
---|---  
`file` | Load the image from a local file.  
`network` | Load the image from a network URL.  
`asset` | Load the image from Flutter’s asset bundle.  
## 
​
Example JSON
Copy
```
{
  "type": "image",
  "src": "https://example.com/image.png",
  "alignment": "center",
  "imageType": "network",
  "color": "#FFFFFF",
  "width": 200.0,
  "height": 100.0,
  "fit": "contain"
}

```

IconOpacity
⌘I