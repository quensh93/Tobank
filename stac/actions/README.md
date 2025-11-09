# Custom STAC Actions

This folder contains custom STAC actions for the ToBank SDUI project.

## Available Actions

*No custom actions yet. Add your custom actions here.*

## Creating a Custom Action

1. Create a new Dart file following the naming convention: `custom_action_name.dart`
2. Extend the appropriate STAC action base class
3. Implement the required methods
4. Add JSON configuration support
5. Include error handling and logging
6. Add documentation and examples

## Example Structure

```dart
import 'package:stac/stac.dart';

class CustomAction extends StacAction {
  @override
  Future<void> execute(BuildContext context, Map<String, dynamic> data) async {
    // Your custom action implementation
  }
  
  @override
  Map<String, dynamic> toJson() {
    // JSON serialization
  }
  
  static CustomAction fromJson(Map<String, dynamic> json) {
    // JSON deserialization
  }
}
```

## Usage in JSON

```json
{
  "actionType": "custom_action_name",
  "parameter1": "value1",
  "parameter2": "value2"
}
```

## Action Types

- **API Actions**: Handle HTTP requests and responses
- **Navigation Actions**: Control app navigation and routing
- **State Actions**: Manage app state and data
- **UI Actions**: Control UI behavior and animations
- **Business Logic Actions**: Implement project-specific business rules
