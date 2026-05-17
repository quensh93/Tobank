# flows/gift_card_real/api_json/gift_card_real_intro.json

Source: lib/stac/tobank/flows/gift_card_real/api_json/gift_card_real_intro.json

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
      "data": "Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
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
    "children": [
      {
        "alignment": "center",
        "child": {
          "padding": {
            "left": 16.0,
            "right": 16.0,
            "bottom": 72.0
          },
          "child": {
            "mainAxisSize": "min",
            "children": [
              {
                "src": "assets/images/empty_list.png",
                "imageType": "asset",
                "width": 220.0,
                "height": 220.0,
                "fit": "contain",
                "type": "image"
              },
              {
                "height": 24.0,
                "type": "sizedBox"
              },
              {
                "data": "Ø´Ù…Ø§ Ú©Ø§Ø±ØªÛŒ Ø®Ø±ÛŒØ¯Ø§Ø±ÛŒ Ù†Ú©Ø±Ø¯Ù‡â€ŒØ§ÛŒØ¯",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.text.subtitle}}",
                  "fontSize": 16.0,
                  "fontWeight": "w600"
                },
                "textAlign": "center",
                "textDirection": "rtl",
                "type": "text"
              }
            ],
            "type": "column"
          },
          "type": "padding"
        },
        "type": "align"
      },
      {
        "alignment": "bottomCenter",
        "child": {
          "padding": {
            "left": 16.0,
            "right": 16.0,
            "bottom": 54.0
          },
          "child": {
            "onPressed": {
              "actionType": "showGiftCardPurchaseBottomSheet",
              "title": "Ø®Ø±ÛŒØ¯ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
              "message": "Ø¨Ù‡ Ù…Ø¨Ø§Ù„Øº Û³Û¶,Û°Û°Û° Ø±ÛŒØ§Ù„ Ø¨Ø§Ø¨Øª Ú©Ø§Ø±Ù…Ø²Ø¯ Ùˆ ÛµÛ·Û°,Û°Û°Û° Ø±ÛŒØ§Ù„ Ø¨Ø§Ø¨Øª Ø§Ø±Ø³Ø§Ù„ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡ Ø¨Ù‡ ØªØ­ÙˆÛŒÙ„ Ú¯ÛŒØ±Ù†Ø¯Ù‡ Ø§Ø¶Ø§ÙÙ‡ Ù…ÛŒâ€ŒÚ¯Ø±Ø¯Ø¯",
              "rulesLabel": "Ù‚ÙˆØ§Ù†ÛŒÙ† Ùˆ Ù…Ù‚Ø±Ø±Ø§Øª ØªÙˆØ¨Ø§Ù†Ú© Ø±Ø§ Ø®ÙˆØ§Ù†Ø¯Ù‡ Ùˆ Ù‚Ø¨ÙˆÙ„ Ø¯Ø§Ø±Ù…",
              "continueText": "Ø§Ø¯Ø§Ù…Ù‡",
              "continueAction": {
                "navigationStyle": "push",
                "actionType": "navigate",
                "request": {
                  "url": "http://192.168.179.21:8101/api/configurations/v1.0/configs/resolve/ipaam.builder.form.form.gift_card_real_select_amount/1",
                  "method": "post",
                  "headers": {
                    "Content-Type": "application/json",
                    "Accept": "*/*"
                  },
                  "body": {
                    "operator": "is",
                    "dimension": {
                      "app": "mobile"
                    }
                  }
                }
              }
            },
            "style": {
              "foregroundColor": "{{appColors.current.primary.onPrimary}}",
              "backgroundColor": "{{appColors.current.primary.color}}",
              "elevation": 0.0,
              "fixedSize": {
                "width": 190.0,
                "height": 64.0
              },
              "shape": {
                "type": "roundedRectangleBorder",
                "borderRadius": {
                  "topLeft": 14.0,
                  "topRight": 14.0,
                  "bottomLeft": 14.0,
                  "bottomRight": 14.0
                }
              }
            },
            "child": {
              "mainAxisSize": "min",
              "textDirection": "rtl",
              "children": [
                {
                  "icon": "add",
                  "iconType": "material",
                  "size": 22.0,
                  "color": "{{appColors.current.primary.onPrimary}}",
                  "type": "icon"
                },
                {
                  "width": 8.0,
                  "type": "sizedBox"
                },
                {
                  "data": "Ø®Ø±ÛŒØ¯ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
                  "style": {
                    "type": "custom",
                    "color": "{{appColors.current.primary.onPrimary}}",
                    "fontSize": 16.0,
                    "fontWeight": "w700"
                  },
                  "textDirection": "rtl",
                  "type": "text"
                }
              ],
              "type": "row"
            },
            "type": "filledButton"
          },
          "type": "padding"
        },
        "type": "align"
      }
    ],
    "type": "stack"
  },
  "type": "scaffold"
}
```
