# Actions Navigate

Actions
Navigate Action
OverviewWidgetsActions
#####  Actions
  * Navigate Action

##### UI Actions
  * Dialog Action
  * Modal Bottom Sheet Action
  * SnackBar

##### Form Actions
  * Form Validate Action
  * Get Form Value Action

##### Network Actions
  * Network Request Action

##### Utility Actions
  * Delay Action
  * Multi Action
  * None Action

  * Navigate Action

  * Example JSON
  * Navigate with a Network Request
  * Navigate with a Widget JSON
  * Navigate with an Asset Path
  * Navigate with a Route Name

 Actions
# Navigate Action

Documentation for Navigate Action

# 
​
Navigate Action
The Stac Navigate Action allows you to perform navigation actions in a Flutter application using JSON. To know more about navigation in Flutter, refer to the official documentation.
## 
​
Properties
Property | Type | Description  
---|---|---  
request | `StacNetworkRequest?` | The network request to perform before navigation.  
widgetJson | `Map?` | The JSON representation of the widget to navigate to.  
assetPath | `String?` | The asset path of the widget to navigate to.  
routeName | `String?` | The name of the route to navigate to.  
navigationStyle | `Style?` | The style of navigation (e.g., push, pop, pushReplacement, etc.).  
result | `Map?` | The result to return when popping the route.  
arguments | `Map?` | The arguments to pass to the route.  
### 
​
Style
The `Style` enum defines the different styles of navigation that can be used in the Stac Navigate Action. Value | Description  
---|---  
`push` | Pushes a new route onto the navigator stack.  
`pop` | Pops the current route off the navigator stack.  
`pushReplacement` | Replaces the current route with a new route.  
`pushAndRemoveAll` | Pushes a new route and removes all the previous routes.  
`popAll` | Pops all the routes off the navigator stack.  
`pushNamed` | Pushes a named route onto the navigator stack.  
`pushNamedAndRemoveAll` | Pushes a named route and removes all the previous routes.  
`pushReplacementNamed` | Replaces the current route with a named route.  
## 
​
Example JSON
### 
​
Navigate with a Network Request
Copy
```
{
  "actionType": "navigate",
  "request": {
    "url": "https://example.com/api",
    "method": "get"
  },
  "navigationStyle": "push"
}

```

### 
​
Navigate with a Widget JSON
Copy
```
{
  "actionType": "navigate",
  "widgetJson": {
    "type": "scaffold",
    "appBar": {
      "type": "appBar",
      "title": {
        "type": "text",
        "data": "My App"
      }
    },
    "body": {
      "type": "center",
      "child": {
        "type": "text",
        "data": "Hello, World!"
      }
    }
  },
  "navigationStyle": "push"
}

```

### 
​
Navigate with an Asset Path
Copy
```
{
  "actionType": "navigate",
  "assetPath": "assets/widgets/my_widget.json",
  "navigationStyle": "push"
}

```

### 
​
Navigate with a Route Name
Copy
```
{
  "actionType": "navigate",
  "routeName": "/home",
  "navigationStyle": "pushNamed"
}

```

Dialog Action
⌘I