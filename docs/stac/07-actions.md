# Actions

Actions in Stac handle user interactions and business logic. They provide a way to define what happens when users interact with your UI, such as button presses, form submissions, navigation, and API calls.

## Built-in Actions

Stac provides several built-in action types:

### Navigation Actions
- **navigate**: Navigate to a new screen
- **navigateBack**: Go back to previous screen
- **navigateAndClear**: Navigate and clear navigation stack

### Form Actions
- **formValidate**: Validate form fields
- **getFormValue**: Get form field values
- **setFormValue**: Set form field values
- **clearForm**: Clear form fields

### UI Actions
- **snackBar**: Show snack bar message
- **dialog**: Show dialog
- **modalBottomSheet**: Show modal bottom sheet
- **setValue**: Set variable value

### Network Actions
- **networkRequest**: Make HTTP request
- **delay**: Add delay before next action

### Utility Actions
- **multi**: Execute multiple actions
- **none**: No action (placeholder)

## Action Structure

All actions follow a consistent JSON structure:

```json
{
  "actionType": "actionName",
  "property1": "value1",
  "property2": "value2"
}
```

## Navigation Actions

### Navigate

Navigate to a new screen:

```json
{
  "actionType": "navigate",
  "route": "/profile",
  "arguments": {
    "userId": "123",
    "userName": "John Doe"
  }
}
```

**Properties:**
- `route`: The route to navigate to
- `arguments`: Optional arguments to pass to the new screen

### Navigate Back

Go back to the previous screen:

```json
{
  "actionType": "navigateBack",
  "result": {
    "message": "Data saved successfully"
  }
}
```

**Properties:**
- `result`: Optional result data to return

### Navigate and Clear

Navigate and clear the navigation stack:

```json
{
  "actionType": "navigateAndClear",
  "route": "/login"
}
```

## Form Actions

### Form Validate

Validate form fields:

```json
{
  "actionType": "formValidate",
  "formKey": "userForm"
}
```

**Properties:**
- `formKey`: The key of the form to validate

### Get Form Value

Get form field values:

```json
{
  "actionType": "getFormValue",
  "formKey": "userForm",
  "onSuccess": {
    "actionType": "snackBar",
    "message": "Form submitted successfully"
  },
  "onError": {
    "actionType": "snackBar",
    "message": "Please fill in all required fields"
  }
}
```

**Properties:**
- `formKey`: The key of the form
- `onSuccess`: Action to execute on successful validation
- `onError`: Action to execute on validation error

### Set Form Value

Set form field values:

```json
{
  "actionType": "setFormValue",
  "formKey": "userForm",
  "values": {
    "name": "John Doe",
    "email": "john@example.com"
  }
}
```

**Properties:**
- `formKey`: The key of the form
- `values`: Object with field keys and values

### Clear Form

Clear form fields:

```json
{
  "actionType": "clearForm",
  "formKey": "userForm"
}
```

## UI Actions

### Snack Bar

Show a snack bar message:

```json
{
  "actionType": "snackBar",
  "message": "Hello World!",
  "duration": 3000,
  "backgroundColor": "#4D00E9",
  "textColor": "#FFFFFF"
}
```

**Properties:**
- `message`: The message to display
- `duration`: Duration in milliseconds (optional)
- `backgroundColor`: Background color (optional)
- `textColor`: Text color (optional)

### Dialog

Show a dialog:

```json
{
  "actionType": "dialog",
  "title": "Confirm Action",
  "content": "Are you sure you want to proceed?",
  "actions": [
    {
      "text": "Cancel",
      "onPressed": {
        "actionType": "navigateBack"
      }
    },
    {
      "text": "Confirm",
      "onPressed": {
        "actionType": "snackBar",
        "message": "Action confirmed"
      }
    }
  ]
}
```

**Properties:**
- `title`: Dialog title
- `content`: Dialog content
- `actions`: Array of dialog actions

### Modal Bottom Sheet

Show a modal bottom sheet:

```json
{
  "actionType": "modalBottomSheet",
  "title": "Options",
  "items": [
    {
      "text": "Option 1",
      "onTap": {
        "actionType": "snackBar",
        "message": "Option 1 selected"
      }
    },
    {
      "text": "Option 2",
      "onTap": {
        "actionType": "snackBar",
        "message": "Option 2 selected"
      }
    }
  ]
}
```

**Properties:**
- `title`: Bottom sheet title
- `items`: Array of bottom sheet items

### Set Value

Set a variable value:

```json
{
  "actionType": "setValue",
  "key": "isLoading",
  "value": true
}
```

**Properties:**
- `key`: The variable key
- `value`: The value to set

## Network Actions

### Network Request

Make an HTTP request:

```json
{
  "actionType": "networkRequest",
  "url": "https://api.example.com/users",
  "method": "POST",
  "headers": {
    "Content-Type": "application/json",
    "Authorization": "Bearer token"
  },
  "body": {
    "name": "{{form.name}}",
    "email": "{{form.email}}"
  },
  "onSuccess": {
    "actionType": "snackBar",
    "message": "User created successfully"
  },
  "onError": {
    "actionType": "snackBar",
    "message": "Failed to create user"
  }
}
```

**Properties:**
- `url`: The request URL
- `method`: HTTP method (GET, POST, PUT, DELETE)
- `headers`: Request headers
- `body`: Request body
- `onSuccess`: Action to execute on success
- `onError`: Action to execute on error

### Delay

Add a delay before executing the next action:

```json
{
  "actionType": "delay",
  "duration": 2000,
  "onComplete": {
    "actionType": "snackBar",
    "message": "Delay completed"
  }
}
```

**Properties:**
- `duration`: Delay duration in milliseconds
- `onComplete`: Action to execute after delay

## Utility Actions

### Multi Action

Execute multiple actions in sequence:

```json
{
  "actionType": "multi",
  "actions": [
    {
      "actionType": "formValidate",
      "formKey": "userForm"
    },
    {
      "actionType": "getFormValue",
      "formKey": "userForm",
      "onSuccess": {
        "actionType": "networkRequest",
        "url": "https://api.example.com/users",
        "method": "POST",
        "body": "{{formData}}"
      }
    }
  ]
}
```

**Properties:**
- `actions`: Array of actions to execute

### None Action

No action (useful as placeholder):

```json
{
  "actionType": "none"
}
```

## Action Examples

### Button with Navigation

```json
{
  "type": "elevatedButton",
  "child": {
    "type": "text",
    "data": "Go to Profile"
  },
  "onPressed": {
    "actionType": "navigate",
    "route": "/profile",
    "arguments": {
      "userId": "123"
    }
  }
}
```

### Form Submission

```json
{
  "type": "elevatedButton",
  "child": {
    "type": "text",
    "data": "Submit"
  },
  "onPressed": {
    "actionType": "multi",
    "actions": [
      {
        "actionType": "formValidate",
        "formKey": "userForm"
      },
      {
        "actionType": "getFormValue",
        "formKey": "userForm",
        "onSuccess": {
          "actionType": "networkRequest",
          "url": "https://api.example.com/users",
          "method": "POST",
          "body": "{{formData}}",
          "onSuccess": {
            "actionType": "snackBar",
            "message": "User created successfully"
          },
          "onError": {
            "actionType": "snackBar",
            "message": "Failed to create user"
          }
        },
        "onError": {
          "actionType": "snackBar",
          "message": "Please fill in all required fields"
        }
      }
    ]
  }
}
```

### Confirmation Dialog

```json
{
  "type": "elevatedButton",
  "child": {
    "type": "text",
    "data": "Delete"
  },
  "onPressed": {
    "actionType": "dialog",
    "title": "Confirm Delete",
    "content": "Are you sure you want to delete this item?",
    "actions": [
      {
        "text": "Cancel",
        "onPressed": {
          "actionType": "navigateBack"
        }
      },
      {
        "text": "Delete",
        "onPressed": {
          "actionType": "multi",
          "actions": [
            {
              "actionType": "networkRequest",
              "url": "https://api.example.com/items/{{itemId}}",
              "method": "DELETE",
              "onSuccess": {
                "actionType": "snackBar",
                "message": "Item deleted successfully"
              },
              "onError": {
                "actionType": "snackBar",
                "message": "Failed to delete item"
              }
            },
            {
              "actionType": "navigateBack"
            }
          ]
        }
      }
    ]
  }
}
```

### Loading State

```json
{
  "type": "elevatedButton",
  "child": {
    "type": "conditional",
    "condition": "isLoading",
    "trueChild": {
      "type": "circularProgressIndicator",
      "color": "#FFFFFF"
    },
    "falseChild": {
      "type": "text",
      "data": "Submit"
    }
  },
  "onPressed": {
    "actionType": "multi",
    "actions": [
      {
        "actionType": "setValue",
        "key": "isLoading",
        "value": true
      },
      {
        "actionType": "networkRequest",
        "url": "https://api.example.com/submit",
        "method": "POST",
        "onSuccess": {
          "actionType": "setValue",
          "key": "isLoading",
          "value": false
        },
        "onError": {
          "actionType": "setValue",
          "key": "isLoading",
          "value": false
        }
      }
    ]
  }
}
```

## Variable Resolution

Actions support variable resolution for dynamic values:

### Form Data

```json
{
  "actionType": "networkRequest",
  "url": "https://api.example.com/users",
  "method": "POST",
  "body": {
    "name": "{{form.name}}",
    "email": "{{form.email}}"
  }
}
```

### User Data

```json
{
  "actionType": "navigate",
  "route": "/profile",
  "arguments": {
    "userId": "{{user.id}}",
    "userName": "{{user.name}}"
  }
}
```

### Custom Variables

```json
{
  "actionType": "setValue",
  "key": "counter",
  "value": "{{counter + 1}}"
}
```

## Error Handling

### Network Request Error

```json
{
  "actionType": "networkRequest",
  "url": "https://api.example.com/data",
  "onSuccess": {
    "actionType": "snackBar",
    "message": "Data loaded successfully"
  },
  "onError": {
    "actionType": "dialog",
    "title": "Error",
    "content": "Failed to load data. Please try again.",
    "actions": [
      {
        "text": "OK",
        "onPressed": {
          "actionType": "navigateBack"
        }
      }
    ]
  }
}
```

### Form Validation Error

```json
{
  "actionType": "getFormValue",
  "formKey": "userForm",
  "onSuccess": {
    "actionType": "snackBar",
    "message": "Form submitted successfully"
  },
  "onError": {
    "actionType": "snackBar",
    "message": "Please fill in all required fields"
  }
}
```

## Custom Actions

You can create custom actions by implementing the `StacActionParser` interface:

```dart
class CustomActionParser implements StacActionParser<CustomAction> {
  @override
  String get actionType => 'custom';

  @override
  CustomAction getModel(Map<String, dynamic> json) => CustomAction.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, CustomAction model) async {
    // Custom action logic
    await performCustomAction(model);
  }
}
```

Register the custom action:

```dart
void main() async {
  await Stac.initialize(
    actionParsers: [
      CustomActionParser(),
    ],
  );
  runApp(MyApp());
}
```

Use the custom action in JSON:

```json
{
  "actionType": "custom",
  "parameter1": "value1",
  "parameter2": "value2"
}
```

## Best Practices

### 1. Action Composition

Use multi actions to compose complex behaviors:

```json
{
  "actionType": "multi",
  "actions": [
    {
      "actionType": "setValue",
      "key": "isLoading",
      "value": true
    },
    {
      "actionType": "networkRequest",
      "url": "https://api.example.com/data",
      "onSuccess": {
        "actionType": "setValue",
        "key": "isLoading",
        "value": false
      },
      "onError": {
        "actionType": "setValue",
        "key": "isLoading",
        "value": false
      }
    }
  ]
}
```

### 2. Error Handling

Always provide error handling for network requests:

```json
{
  "actionType": "networkRequest",
  "url": "https://api.example.com/data",
  "onError": {
    "actionType": "snackBar",
    "message": "Something went wrong"
  }
}
```

### 3. User Feedback

Provide feedback for user actions:

```json
{
  "actionType": "snackBar",
  "message": "Action completed successfully"
}
```

### 4. Loading States

Use loading states for async operations:

```json
{
  "actionType": "setValue",
  "key": "isLoading",
  "value": true
}
```

## Next Steps

- [Parsers](./08-parsers.md) - Create custom widgets and actions
- [Theming](./09-theming-styles.md) - Customize appearance
- [Examples](./11-examples.md) - See complete examples
- [API Reference](./12-api-reference.md) - Detailed API documentation
