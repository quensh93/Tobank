# flows/profile_real/json/profile_real_rules.json

Source: lib/stac/tobank/flows/profile_real/json/profile_real_rules.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "appBar": {
    "leading": {
      "padding": {
        "left": 12.0
      },
      "child": {
        "child": {
          "src": "{{appAssets.icons.support}}",
          "imageType": "asset",
          "color": "{{appColors.current.text.title}}",
          "width": 24.0,
          "height": 24.0,
          "type": "image"
        },
        "type": "center"
      },
      "type": "padding"
    },
    "title": {
      "data": "{{appStrings.profile.real.rules.title}}",
      "style": {
        "type": "alias",
        "value": "{{appStyles.appbarStyle}}"
      },
      "textDirection": "rtl",
      "type": "text"
    },
    "actions": [
      {
        "padding": {
          "right": 12.0
        },
        "child": {
          "onPressed": {
            "navigationStyle": "pop",
            "actionType": "navigate"
          },
          "icon": {
            "src": "{{appAssets.icons.arrowBack}}",
            "imageType": "asset",
            "color": "{{appColors.current.text.title}}",
            "width": 31.0,
            "height": 31.0,
            "type": "image"
          },
          "type": "iconButton"
        },
        "type": "padding"
      }
    ],
    "centerTitle": true,
    "type": "appBar"
  },
  "backgroundColor": "{{appColors.current.background.surface}}",
  "body": {
    "padding": {
      "left": 16.0,
      "top": 16.0,
      "right": 16.0,
      "bottom": 16.0
    },
    "child": {
      "padding": {
        "left": 14.0,
        "top": 14.0,
        "right": 14.0,
        "bottom": 14.0
      },
      "decoration": {
        "color": "{{appColors.current.background.surface}}",
        "border": {
          "color": "{{appColors.current.input.borderEnabled}}",
          "width": 1.0
        },
        "borderRadius": {
          "topLeft": 12.0,
          "topRight": 12.0,
          "bottomLeft": 12.0,
          "bottomRight": 12.0
        }
      },
      "child": {
        "data": "{{appStrings.profile.real.rules.content}}",
        "style": {
          "type": "custom",
          "color": "{{appColors.current.text.title}}",
          "fontSize": 16.0,
          "fontWeight": "w500"
        },
        "textAlign": "right",
        "textDirection": "rtl",
        "type": "text"
      },
      "type": "container"
    },
    "type": "singleChildScrollView"
  },
  "type": "scaffold"
}
```
