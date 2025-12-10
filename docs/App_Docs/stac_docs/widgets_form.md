# Widgets Form

Interactive Widgets
Form
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

Interactive Widgets
# Form

Documentation for Form

# 
​
Form
The Stac Form allows you to build a Flutter form widget using JSON. To know more about the form widget in Flutter, refer to the official documentation.
## 
​
Properties
Property | Type | Description  
---|---|---  
autovalidateMode | `AutovalidateMode?` | The mode to control auto validation.  
child | `Map` | The widget to display inside the form.  
## 
​
Example JSON
Copy
```
{
  "type": "form",
  "autovalidateMode": "always",
  "child": {
    "type": "column",
    "children": [
      {
        "type": "textFormField",
        "id": "username",
        "decoration": {
          "labelText": "Username"
        }
      },
      {
        "type": "textFormField",
        "id": "password",
        "decoration": {
          "labelText": "Password"
        }
      },
      {
        "type": "filledButton",
        "child": {
          "type": "text",
          "data": "Submit"
        },
        "onPressed": {
          "actionType": "validateForm",
          "isValid": {
            "actionType": "networkRequest",
            "url": "https://dummyjson.com/auth/login",
            "method": "post",
            "contentType": "application/json",
            "body": {
              "username": {
                "actionType": "getFormValue",
                "id": "username"
              },
              "password": {
                "actionType": "getFormValue",
                "id": "password"
              }
            }
          }
        }
      }
    ]
  }
}

```

FloatingActionButtonGestureDetector
⌘I