# flows/transfer_real/json/transfer_real_card_result.json

Source: lib/stac/tobank/flows/transfer_real/json/transfer_real_card_result.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "appBar": {
    "leading": {
      "onPressed": {
        "navigationStyle": "pop",
        "actionType": "navigate"
      },
      "icon": {
        "src": "{{appAssets.icons.arrowRight}}",
        "imageType": "asset",
        "color": "{{appColors.current.text.title}}",
        "width": 24.0,
        "height": 24.0,
        "type": "image"
      },
      "type": "iconButton"
    },
    "title": {
      "data": "Ø§Ù†ØªÙ‚Ø§Ù„ ÙˆØ¬Ù‡",
      "style": {
        "type": "alias",
        "value": "{{appStyles.appbarStyle}}"
      },
      "textDirection": "rtl",
      "type": "text"
    },
    "centerTitle": true,
    "type": "appBar"
  },
  "backgroundColor": "{{appColors.current.background.surface}}",
  "body": {
    "padding": {
      "left": 16.0,
      "top": 14.0,
      "right": 16.0,
      "bottom": 35.0
    },
    "child": {
      "crossAxisAlignment": "stretch",
      "children": [
        {
          "child": {
            "type": "receiptRepaintBoundary",
            "boundaryKey": "transferCardReceiptContent",
            "child": {
              "child": {
                "crossAxisAlignment": "stretch",
                "children": [
                  {
                    "children": [
                      {
                        "height": 6.0,
                        "type": "sizedBox"
                      },
                      {
                        "src": "assets/icons/ic_transaction_success.svg",
                        "imageType": "asset",
                        "width": 96.0,
                        "height": 96.0,
                        "type": "image"
                      },
                      {
                        "height": 12.0,
                        "type": "sizedBox"
                      },
                      {
                        "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ù…ÙˆÙÙ‚",
                        "style": {
                          "type": "custom",
                          "color": "#12B76A",
                          "fontSize": 20.0,
                          "fontWeight": "w700"
                        },
                        "textAlign": "center",
                        "textDirection": "rtl",
                        "type": "text"
                      },
                      {
                        "height": 10.0,
                        "type": "sizedBox"
                      },
                      {
                        "data": "Ø¹Ù…Ù„ÛŒØ§Øª Ø§Ù†ØªÙ‚Ø§Ù„ ÙˆØ¬Ù‡ Ú©Ø§Ø±Øª Ø¨Ù‡ Ú©Ø§Ø±Øª Ø¨Ø§ Ù…ÙˆÙÙ‚ÛŒØª Ø§Ù†Ø¬Ø§Ù… Ø´Ø¯.",
                        "style": {
                          "type": "custom",
                          "color": "{{appColors.current.text.title}}",
                          "fontSize": 17.0,
                          "fontWeight": "w600"
                        },
                        "textAlign": "center",
                        "textDirection": "rtl",
                        "type": "text"
                      }
                    ],
                    "type": "column"
                  },
                  {
                    "height": 16.0,
                    "type": "sizedBox"
                  },
                  {
                    "padding": {
                      "left": 14.0,
                      "top": 14.0,
                      "right": 14.0,
                      "bottom": 14.0
                    },
                    "decoration": {
                      "color": "{{appColors.current.background.surfaceContainer}}",
                      "border": {
                        "color": "{{appColors.current.input.borderEnabled}}",
                        "width": 1.0
                      },
                      "borderRadius": {
                        "topLeft": 16.0,
                        "topRight": 16.0,
                        "bottomLeft": 16.0,
                        "bottomRight": 16.0
                      }
                    },
                    "child": {
                      "children": [
                        {
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "data": "Ù…Ø¨Ù„Øº Ù¾Ø±Ø¯Ø§Ø®ØªÛŒ",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 17.0,
                                  "fontWeight": "w500"
                                },
                                "textAlign": "right",
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "expanded"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "alignment": "centerStart",
                                "child": {
                                  "type": "registryReactive",
                                  "registryKey": "transferApiCardAmountRaw",
                                  "child": {
                                    "mainAxisSize": "min",
                                    "textDirection": "ltr",
                                    "children": [
                                      {
                                        "type": "text",
                                        "data": "{{transferApiCardAmountRaw}}",
                                        "textDirection": "ltr",
                                        "style": {
                                          "type": "custom",
                                          "fontSize": 17,
                                          "fontWeight": "w700",
                                          "color": "{{appColors.current.text.title}}"
                                        }
                                      },
                                      {
                                        "width": 4.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "data": "Ø±ÛŒØ§Ù„",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 17.0,
                                          "fontWeight": "w700"
                                        },
                                        "textDirection": "rtl",
                                        "type": "text"
                                      }
                                    ],
                                    "type": "row"
                                  }
                                },
                                "type": "align"
                              },
                              "type": "expanded"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "padding": {
                            "top": 11.0,
                            "bottom": 11.0
                          },
                          "child": {
                            "mainAxisAlignment": "spaceBetween",
                            "children": [
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "padding"
                        },
                        {
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "data": "Ù†ÙˆØ¹ ØªØ±Ø§Ú©Ù†Ø´",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 17.0,
                                  "fontWeight": "w500"
                                },
                                "textAlign": "right",
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "expanded"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "alignment": "centerStart",
                                "child": {
                                  "data": "Ú©Ø§Ø±Øª Ø¨Ù‡ Ú©Ø§Ø±Øª",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 17.0,
                                    "fontWeight": "w700"
                                  },
                                  "textAlign": "left",
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                "type": "align"
                              },
                              "type": "expanded"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "padding": {
                            "top": 11.0,
                            "bottom": 11.0
                          },
                          "child": {
                            "mainAxisAlignment": "spaceBetween",
                            "children": [
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "padding"
                        },
                        {
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "data": "Ø²Ù…Ø§Ù† ØªØ±Ø§Ú©Ù†Ø´",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 17.0,
                                  "fontWeight": "w500"
                                },
                                "textAlign": "right",
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "expanded"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "alignment": "centerStart",
                                "child": {
                                  "data": "Û°Ûµ Ø§Ø±Ø¯ÛŒØ¨Ù‡Ø´Øª Û±Û´Û°Ûµ - Û±Û²:Û²Û¹",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 17.0,
                                    "fontWeight": "w700"
                                  },
                                  "textAlign": "left",
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                "type": "align"
                              },
                              "type": "expanded"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "padding": {
                            "top": 11.0,
                            "bottom": 11.0
                          },
                          "child": {
                            "mainAxisAlignment": "spaceBetween",
                            "children": [
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "padding"
                        },
                        {
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ø§Ø² Ø·Ø±ÛŒÙ‚",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 17.0,
                                  "fontWeight": "w500"
                                },
                                "textAlign": "right",
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "expanded"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "alignment": "centerStart",
                                "child": {
                                  "data": "Ø¨Ø§Ù†Ú© Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 17.0,
                                    "fontWeight": "w700"
                                  },
                                  "textAlign": "left",
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                "type": "align"
                              },
                              "type": "expanded"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "padding": {
                            "top": 11.0,
                            "bottom": 11.0
                          },
                          "child": {
                            "mainAxisAlignment": "spaceBetween",
                            "children": [
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "padding"
                        },
                        {
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "data": "Ù…Ø¨Ø¯Ø§",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 17.0,
                                  "fontWeight": "w500"
                                },
                                "textAlign": "right",
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "expanded"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "alignment": "centerStart",
                                "child": {
                                  "type": "registryReactive",
                                  "registryKey": "transferApiCardSourceNumber",
                                  "child": {
                                    "type": "text",
                                    "data": "{{transferApiCardSourceNumber}}",
                                    "textDirection": "ltr",
                                    "textAlign": "left",
                                    "style": {
                                      "type": "custom",
                                      "fontSize": 17,
                                      "fontWeight": "w700",
                                      "color": "{{appColors.current.text.title}}"
                                    }
                                  }
                                },
                                "type": "align"
                              },
                              "type": "expanded"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "padding": {
                            "top": 11.0,
                            "bottom": 11.0
                          },
                          "child": {
                            "mainAxisAlignment": "spaceBetween",
                            "children": [
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "padding"
                        },
                        {
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "data": "Ù…Ù‚ØµØ¯",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 17.0,
                                  "fontWeight": "w500"
                                },
                                "textAlign": "right",
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "expanded"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "alignment": "centerStart",
                                "child": {
                                  "type": "registryReactive",
                                  "registryKey": "transferApiCardDestinationNumber",
                                  "child": {
                                    "type": "text",
                                    "data": "{{transferApiCardDestinationNumber}}",
                                    "textDirection": "ltr",
                                    "textAlign": "left",
                                    "style": {
                                      "type": "custom",
                                      "fontSize": 17,
                                      "fontWeight": "w700",
                                      "color": "{{appColors.current.text.title}}"
                                    }
                                  }
                                },
                                "type": "align"
                              },
                              "type": "expanded"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "padding": {
                            "top": 11.0,
                            "bottom": 11.0
                          },
                          "child": {
                            "mainAxisAlignment": "spaceBetween",
                            "children": [
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "padding"
                        },
                        {
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "data": "Ù†Ø§Ù… ØµØ§Ø­Ø¨ Ú©Ø§Ø±Øª",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 17.0,
                                  "fontWeight": "w500"
                                },
                                "textAlign": "right",
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "expanded"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "alignment": "centerStart",
                                "child": {
                                  "type": "registryReactive",
                                  "registryKey": "transferApiCardDestinationName",
                                  "child": {
                                    "type": "text",
                                    "data": "{{transferApiCardDestinationName}}",
                                    "textDirection": "rtl",
                                    "textAlign": "left",
                                    "style": {
                                      "type": "custom",
                                      "fontSize": 17,
                                      "fontWeight": "w700",
                                      "color": "{{appColors.current.text.title}}"
                                    }
                                  }
                                },
                                "type": "align"
                              },
                              "type": "expanded"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "padding": {
                            "top": 11.0,
                            "bottom": 11.0
                          },
                          "child": {
                            "mainAxisAlignment": "spaceBetween",
                            "children": [
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "padding"
                        },
                        {
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "data": "Ø´Ù…Ø§Ø±Ù‡ Ù¾ÛŒÚ¯ÛŒØ±ÛŒ",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 17.0,
                                  "fontWeight": "w500"
                                },
                                "textAlign": "right",
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "expanded"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "alignment": "centerStart",
                                "child": {
                                  "data": "Û³ÛµÛ¶Û¹Û¸Û³Û¶ÛµÛ°Û¸Û´Û³Û³",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 17.0,
                                    "fontWeight": "w700"
                                  },
                                  "textAlign": "left",
                                  "textDirection": "ltr",
                                  "type": "text"
                                },
                                "type": "align"
                              },
                              "type": "expanded"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "padding": {
                            "top": 11.0,
                            "bottom": 11.0
                          },
                          "child": {
                            "mainAxisAlignment": "spaceBetween",
                            "children": [
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              },
                              {
                                "color": "{{appColors.current.input.borderEnabled}}",
                                "width": 3.0,
                                "height": 1.0,
                                "type": "container"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "padding"
                        },
                        {
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "data": "ØªÙˆØ¶ÛŒØ­Ø§Øª",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 17.0,
                                  "fontWeight": "w500"
                                },
                                "textAlign": "right",
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "expanded"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "alignment": "centerStart",
                                "child": {
                                  "type": "registryReactive",
                                  "registryKey": "transferApiCardDescriptionHasText",
                                  "child": {
                                    "type": "visibility",
                                    "visible": "[[transferApiCardDescriptionHasText]]",
                                    "child": {
                                      "type": "registryReactive",
                                      "registryKey": "transferApiCardDescription",
                                      "child": {
                                        "type": "text",
                                        "data": "{{transferApiCardDescription}}",
                                        "textDirection": "rtl",
                                        "textAlign": "left",
                                        "style": {
                                          "type": "custom",
                                          "fontSize": 17,
                                          "fontWeight": "w600",
                                          "color": "{{appColors.current.text.title}}"
                                        }
                                      }
                                    },
                                    "replacement": {
                                      "data": "-",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.subtitle}}",
                                        "fontSize": 17.0,
                                        "fontWeight": "w600"
                                      },
                                      "textAlign": "left",
                                      "textDirection": "rtl",
                                      "type": "text"
                                    }
                                  }
                                },
                                "type": "align"
                              },
                              "type": "expanded"
                            }
                          ],
                          "type": "row"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  {
                    "height": 18.0,
                    "type": "sizedBox"
                  },
                  {
                    "mainAxisAlignment": "center",
                    "crossAxisAlignment": "center",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "src": "assets/icons/ic_tobank.svg",
                        "imageType": "asset",
                        "width": 56.0,
                        "height": 56.0,
                        "type": "image"
                      },
                      {
                        "width": 16.0,
                        "type": "sizedBox"
                      },
                      {
                        "color": "{{appColors.current.text.subtitle}}",
                        "width": 0.7,
                        "height": 45.0,
                        "type": "container"
                      },
                      {
                        "width": 16.0,
                        "type": "sizedBox"
                      },
                      {
                        "crossAxisAlignment": "end",
                        "children": [
                          {
                            "data": "ÛŒÚ© Ø´Ø¹Ø¨Ù‡ Ù…Ø¬Ø§Ø²ÛŒ Ù‡Ù…Ø±Ø§Ù‡ Ø´Ù…Ø§Ø³Øª!",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 18.0,
                              "fontWeight": "w600"
                            },
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          {
                            "height": 8.0,
                            "type": "sizedBox"
                          },
                          {
                            "data": "www.tobank.ir",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 16.0,
                              "fontWeight": "w500"
                            },
                            "textDirection": "ltr",
                            "type": "text"
                          }
                        ],
                        "type": "column"
                      }
                    ],
                    "type": "row"
                  }
                ],
                "type": "column"
              },
              "type": "singleChildScrollView"
            }
          },
          "type": "expanded"
        },
        {
          "height": 12.0,
          "type": "sizedBox"
        },
        {
          "children": [
            {
              "child": {
                "onPressed": {
                  "actionType": "transferReceipt",
                  "mode": "shareText",
                  "title": "Ø±Ø³ÛŒØ¯ ØªØ±Ø§Ú©Ù†Ø´",
                  "pixelRatio": 3.0,
                  "boundaryKey": "transferCardReceiptContent"
                },
                "style": {
                  "foregroundColor": "{{appColors.current.text.title}}",
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 57.0
                  },
                  "side": {
                    "color": "{{appColors.current.input.borderEnabled}}"
                  },
                  "shape": {
                    "type": "roundedRectangleBorder",
                    "borderRadius": {
                      "topLeft": 12.0,
                      "topRight": 12.0,
                      "bottomLeft": 12.0,
                      "bottomRight": 12.0
                    }
                  }
                },
                "child": {
                  "mainAxisAlignment": "center",
                  "children": [
                    {
                      "data": "Ù…ØªÙ† Ø±Ø³ÛŒØ¯",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 18.0,
                        "fontWeight": "w600"
                      },
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    {
                      "width": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "src": "assets/icons/ic_download.svg",
                      "imageType": "asset",
                      "color": "{{appColors.current.text.title}}",
                      "width": 26.0,
                      "height": 26.0,
                      "type": "image"
                    }
                  ],
                  "type": "row"
                },
                "type": "outlinedButton"
              },
              "type": "expanded"
            },
            {
              "width": 10.0,
              "type": "sizedBox"
            },
            {
              "child": {
                "onPressed": {
                  "actionType": "transferReceipt",
                  "mode": "shareImage",
                  "title": "Ø±Ø³ÛŒØ¯ ØªØ±Ø§Ú©Ù†Ø´",
                  "pixelRatio": 3.0,
                  "boundaryKey": "transferCardReceiptContent"
                },
                "style": {
                  "foregroundColor": "{{appColors.current.text.title}}",
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 57.0
                  },
                  "side": {
                    "color": "{{appColors.current.input.borderEnabled}}"
                  },
                  "shape": {
                    "type": "roundedRectangleBorder",
                    "borderRadius": {
                      "topLeft": 12.0,
                      "topRight": 12.0,
                      "bottomLeft": 12.0,
                      "bottomRight": 12.0
                    }
                  }
                },
                "child": {
                  "mainAxisAlignment": "center",
                  "children": [
                    {
                      "data": "ØªØµÙˆÛŒØ± Ø±Ø³ÛŒØ¯",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 18.0,
                        "fontWeight": "w600"
                      },
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    {
                      "width": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "src": "assets/icons/ic_share.svg",
                      "imageType": "asset",
                      "color": "{{appColors.current.text.title}}",
                      "width": 26.0,
                      "height": 26.0,
                      "type": "image"
                    }
                  ],
                  "type": "row"
                },
                "type": "outlinedButton"
              },
              "type": "expanded"
            }
          ],
          "type": "row"
        }
      ],
      "type": "column"
    },
    "type": "padding"
  },
  "type": "scaffold"
}
```
