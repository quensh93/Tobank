# Widgets Webview

Interactive Widgets
WebView
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

  * WebView

  * Example JSON

Interactive Widgets
# WebView

Documentation for WebView

# 
​
WebView
The Stac WebView allows you to display WebView widget using JSON in your app. It is based on the webview_flutter plugin.
## 
​
Usage
  1. Add `stac_webview` as a dependency in your pubspec.yaml file.

Install the plugin by running the following command from the project root:
Copy
```
flutter pub add stac_webview

```

or add it manually in your `pubspec.yaml` file:
Copy
```
  dependencies:
    stac_webview:

```

  1. Add `StacWebViewParser` in Stac initialize.

Copy
```
void main() async {
  await Stac.initialize(
    parsers: const [
      StacWebViewParser(),
    ],
  );
  runApp(const MyApp());
}

```

## 
​
Properties
Property | Type | Description  
---|---|---  
`url` | `String` | The URL to load in the `WebView`.  
`javaScriptMode` | `JavaScriptMode` | Sets whether JavaScript execution is enabled. Default is `JavaScriptMode.unrestricted`.  
`backgroundColor` | `String` | Background color of the `WebView`. Default is `#FFFFFF`.  
`userAgent` | `String?` | The user agent for the `WebView`.  
`enableZoom` | `bool` | Sets whether zoom is enabled for the `WebView`. Default is `false`.  
`layoutDirection` | `TextDirection` | The layout direction for the `WebView`. Default is `TextDirection.ltr`.  
## 
​
Example JSON
Copy
```
{
  "type": "webView",
  "url": "https://github.com/StacDev/stac"
}

```

TextFormFieldCustomScrollView
⌘I