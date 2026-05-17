# flows/verify_identity_real/json/verify_identity_real_signature_guide.json

Source: lib/stac/tobank/flows/verify_identity_real/json/verify_identity_real_signature_guide.json

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
        "src": "{{appAssets.icons.arrowBack}}",
        "imageType": "asset",
        "color": "{{appColors.current.text.title}}",
        "width": 30.0,
        "height": 30.0,
        "type": "image"
      },
      "type": "iconButton"
    },
    "title": {
      "data": "Ø±Ø§Ù‡Ù†Ù…Ø§",
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
    "type": "safeArea",
    "top": false,
    "bottom": true,
    "child": {
      "children": [
        {
          "color": "{{appColors.current.background.surface}}",
          "width": 999999.0,
          "height": 999999.0,
          "type": "container"
        },
        {
          "padding": {
            "left": 16.0,
            "top": 16.0,
            "right": 16.0,
            "bottom": 16.0
          },
          "child": {
            "crossAxisAlignment": "stretch",
            "children": [
              {
                "padding": {
                  "left": 20.0,
                  "top": 20.0,
                  "right": 20.0,
                  "bottom": 20.0
                },
                "decoration": {
                  "color": "{{appColors.current.background.surfaceContainer}}",
                  "border": {
                    "color": "{{appColors.current.input.borderEnabled}}",
                    "width": 1.0
                  },
                  "borderRadius": {
                    "topLeft": 18.0,
                    "topRight": 18.0,
                    "bottomLeft": 18.0,
                    "bottomRight": 18.0
                  }
                },
                "child": {
                  "crossAxisAlignment": "stretch",
                  "children": [
                    {
                      "data": "Ø±Ø§Ù‡Ù†Ù…Ø§ÛŒ Ø«Ø¨Øª Ø§Ù…Ø¶Ø§",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 20.0,
                        "fontWeight": "w700"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    {
                      "height": 12.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "Ù†ÙˆØ¹ Ø±Ø§Ù‡Ù†Ù…Ø§ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯. Ø±Ø§Ù‡Ù†Ù…Ø§ÛŒ ØªØµÙˆÛŒØ±ÛŒ Ù†Ù…ÙˆÙ†Ù‡â€ŒÛŒ Ø§Ù…Ø¶Ø§ÛŒ ØµØ­ÛŒØ­ Ø±Ø§ Ù†Ù…Ø§ÛŒØ´ Ù…ÛŒâ€ŒØ¯Ù‡Ø¯.",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.subtitle}}",
                        "fontSize": 15.0,
                        "fontWeight": "w500",
                        "height": 1.8
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    }
                  ],
                  "type": "column"
                },
                "type": "container"
              },
              {
                "height": 20.0,
                "type": "sizedBox"
              },
              {
                "child": {
                  "padding": {
                    "left": 16.0,
                    "top": 16.0,
                    "right": 16.0,
                    "bottom": 16.0
                  },
                  "decoration": {
                    "color": "{{appColors.current.background.surface}}",
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
                    "crossAxisAlignment": "center",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "decoration": {
                          "color": "{{appColors.current.background.surfaceContainer}}",
                          "borderRadius": {
                            "topLeft": 24.0,
                            "topRight": 24.0,
                            "bottomLeft": 24.0,
                            "bottomRight": 24.0
                          }
                        },
                        "width": 48.0,
                        "height": 48.0,
                        "child": {
                          "child": {
                            "src": "{{appAssets.icons.visualTutorialCurrent}}",
                            "imageType": "asset",
                            "color": "{{appColors.current.text.title}}",
                            "width": 22.0,
                            "height": 22.0,
                            "type": "image"
                          },
                          "type": "center"
                        },
                        "type": "container"
                      },
                      {
                        "width": 14.0,
                        "type": "sizedBox"
                      },
                      {
                        "child": {
                          "crossAxisAlignment": "stretch",
                          "children": [
                            {
                              "data": "Ø±Ø§Ù‡Ù†Ù…Ø§ÛŒ ØªØµÙˆÛŒØ±ÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 16.0,
                                "fontWeight": "w700"
                              },
                              "textAlign": "right",
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            {
                              "height": 6.0,
                              "type": "sizedBox"
                            },
                            {
                              "data": "Ù…Ø´Ø§Ù‡Ø¯Ù‡ Ù†Ù…ÙˆÙ†Ù‡ ØµÙØ­Ù‡ Ùˆ Ù…Ø­Ù„ Ø«Ø¨Øª Ø§Ù…Ø¶Ø§",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 13.0,
                                "fontWeight": "w500",
                                "height": 1.6
                              },
                              "textAlign": "right",
                              "textDirection": "rtl",
                              "type": "text"
                            }
                          ],
                          "type": "column"
                        },
                        "type": "expanded"
                      },
                      {
                        "width": 8.0,
                        "type": "sizedBox"
                      },
                      {
                        "src": "{{appAssets.icons.arrowRight}}",
                        "imageType": "asset",
                        "color": "{{appColors.current.text.subtitle}}",
                        "width": 18.0,
                        "height": 18.0,
                        "type": "image"
                      }
                    ],
                    "type": "row"
                  },
                  "type": "container"
                },
                "onTap": {
                  "navigationStyle": "push",
                  "actionType": "navigate",
                  "request": {
                    "url": "http://192.168.179.21:8101/api/configurations/v1.0/configs/resolve/ipaam.builder.form.form.verify_identity_real_signature_visual_guide/1",
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
                },
                "type": "gestureDetector"
              },
              {
                "height": 12.0,
                "type": "sizedBox"
              },
              {
                "child": {
                  "padding": {
                    "left": 16.0,
                    "top": 16.0,
                    "right": 16.0,
                    "bottom": 16.0
                  },
                  "decoration": {
                    "color": "{{appColors.current.background.surface}}",
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
                    "crossAxisAlignment": "center",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "decoration": {
                          "color": "{{appColors.current.background.surfaceContainer}}",
                          "borderRadius": {
                            "topLeft": 24.0,
                            "topRight": 24.0,
                            "bottomLeft": 24.0,
                            "bottomRight": 24.0
                          }
                        },
                        "width": 48.0,
                        "height": 48.0,
                        "child": {
                          "child": {
                            "src": "{{appAssets.icons.voiceTutorialCurrent}}",
                            "imageType": "asset",
                            "color": "{{appColors.current.text.title}}",
                            "width": 22.0,
                            "height": 22.0,
                            "type": "image"
                          },
                          "type": "center"
                        },
                        "type": "container"
                      },
                      {
                        "width": 14.0,
                        "type": "sizedBox"
                      },
                      {
                        "child": {
                          "crossAxisAlignment": "stretch",
                          "children": [
                            {
                              "data": "Ø±Ø§Ù‡Ù†Ù…Ø§ÛŒ ØµÙˆØªÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 16.0,
                                "fontWeight": "w700"
                              },
                              "textAlign": "right",
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            {
                              "height": 6.0,
                              "type": "sizedBox"
                            },
                            {
                              "data": "ØªÙˆØ¶ÛŒØ­ ØµÙˆØªÛŒ Ø§ÛŒÙ† Ù…Ø±Ø­Ù„Ù‡",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 13.0,
                                "fontWeight": "w500",
                                "height": 1.6
                              },
                              "textAlign": "right",
                              "textDirection": "rtl",
                              "type": "text"
                            }
                          ],
                          "type": "column"
                        },
                        "type": "expanded"
                      },
                      {
                        "width": 8.0,
                        "type": "sizedBox"
                      },
                      {
                        "src": "{{appAssets.icons.arrowRight}}",
                        "imageType": "asset",
                        "color": "{{appColors.current.text.subtitle}}",
                        "width": 18.0,
                        "height": 18.0,
                        "type": "image"
                      }
                    ],
                    "type": "row"
                  },
                  "type": "container"
                },
                "onTap": {
                  "actionType": "showResult",
                  "title": "{{appStrings.common.comingSoon}}",
                  "content": "Ø±Ø§Ù‡Ù†Ù…Ø§ÛŒ ØµÙˆØªÛŒ Ø§ÛŒÙ† Ø¨Ø®Ø´ Ù‡Ù†ÙˆØ² Ø§Ø¶Ø§ÙÙ‡ Ù†Ø´Ø¯Ù‡ Ø§Ø³Øª."
                },
                "type": "gestureDetector"
              }
            ],
            "type": "column"
          },
          "type": "singleChildScrollView"
        }
      ],
      "type": "stack"
    }
  },
  "type": "scaffold"
}
```
