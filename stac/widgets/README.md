# Custom STAC Widgets

This folder contains custom STAC widgets for the ToBank SDUI project.

## Available Widgets

*No custom widgets yet. Add your custom widgets here.*

## Creating a Custom Widget

1. Create a new Dart file following the naming convention: `custom_widget_name.dart`
2. Extend the appropriate STAC widget base class
3. Implement the required methods
4. Add JSON configuration support
5. Include documentation and examples

## Example Structure

```dart
import 'package:stac/stac.dart';

class CustomWidget extends StacWidget {
  @override
  Widget build(BuildContext context) {
    // Your custom widget implementation
  }
  
  @override
  Map<String, dynamic> toJson() {
    // JSON serialization
  }
  
  static CustomWidget fromJson(Map<String, dynamic> json) {
    // JSON deserialization
  }
}
```

## Usage in JSON

```json
{
  "type": "custom_widget_name",
  "property1": "value1",
  "property2": "value2"
}
```
