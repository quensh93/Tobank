# flows/verify_identity_real/json/verify_identity_real_registration.json

Source: lib/stac/tobank/flows/verify_identity_real/json/verify_identity_real_registration.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "type": "stateFull",
  "onInit": {
    "actionType": "setValue",
    "values": [
      {
        "key": "verifyIdentitySelectedJobTitle",
        "value": "Ø­ÙˆØ²Ù‡ ÙØ¹Ø§Ù„ÛŒØª Ø®ÙˆØ¯ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯"
      },
      {
        "key": "verifyIdentityHasSelectedJob",
        "value": false
      }
    ]
  },
  "child": {
    "appBar": {
      "leading": {
        "padding": {
          "left": 12.0
        },
        "child": {
          "child": {
            "width": 42.0,
            "height": 42.0,
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
            "type": "container"
          },
          "type": "center"
        },
        "type": "padding"
      },
      "title": {
        "data": "{{appStrings.menu.items.verifyIdentity}}",
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
            "right": 15.0
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
              "width": 30.0,
              "height": 30.0,
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
      "type": "safeArea",
      "top": false,
      "bottom": true,
      "child": {
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
              "child": {
                "child": {
                  "crossAxisAlignment": "stretch",
                  "children": [
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
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
                          "topLeft": 10.0,
                          "topRight": 10.0,
                          "bottomLeft": 10.0,
                          "bottomRight": 10.0
                        }
                      },
                      "child": {
                        "data": "Ú©Ø§Ø±Ø¨Ø± Ú¯Ø±Ø§Ù…ÛŒ\nØ¨Ø§ ØªÚ©Ù…ÛŒÙ„ Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ø²ÛŒØ±ØŒ Ù…Ø±Ø§Ø­Ù„ Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª Ø´Ù…Ø§ Ø¨Ù‡ Ø§ØªÙ…Ø§Ù… Ù…ÛŒâ€ŒØ±Ø³Ø¯ Ùˆ Ù…ÛŒâ€ŒØªÙˆØ§Ù†ÛŒØ¯ Ø§Ø² Ø®Ø¯Ù…Ø§Øª Ø¨Ø±Ù†Ø§Ù…Ù‡ Ø§Ø³ØªÙØ§Ø¯Ù‡ Ú©Ù†ÛŒØ¯.",
                        "style": {
                          "type": "custom",
                          "color": "{{appColors.current.text.title}}",
                          "fontSize": 16.0,
                          "fontWeight": "w500",
                          "height": 1.8
                        },
                        "textAlign": "right",
                        "textDirection": "rtl",
                        "type": "text"
                      },
                      "type": "container"
                    },
                    {
                      "height": 32.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "Ø­ÙˆØ²Ù‡ ÙØ¹Ø§Ù„ÛŒØª",
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
                      "height": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 16.0,
                          "right": 16.0
                        },
                        "decoration": {
                          "color": "{{appColors.current.background.surface}}",
                          "border": {
                            "color": "{{appColors.current.input.borderEnabled}}",
                            "width": 1.0
                          },
                          "borderRadius": {
                            "topLeft": 8.0,
                            "topRight": 8.0,
                            "bottomLeft": 8.0,
                            "bottomRight": 8.0
                          }
                        },
                        "height": 56.0,
                        "child": {
                          "mainAxisAlignment": "spaceBetween",
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "type": "registryReactive",
                                "registryKey": "verifyIdentitySelectedJobTitle",
                                "child": {
                                  "data": "{{verifyIdentitySelectedJobTitle}}",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 14.0,
                                    "fontWeight": "w600"
                                  },
                                  "textAlign": "right",
                                  "textDirection": "rtl",
                                  "type": "text"
                                }
                              },
                              "type": "expanded"
                            },
                            {
                              "width": 12.0,
                              "type": "sizedBox"
                            },
                            {
                              "src": "{{appAssets.icons.arrowCircleDown}}",
                              "imageType": "asset",
                              "color": "{{appColors.current.text.subtitle}}",
                              "width": 33.0,
                              "height": 33.0,
                              "type": "image"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showJobSelectorBottomSheet",
                        "heightFactor": 0.75
                      },
                      "type": "gestureDetector"
                    }
                  ],
                  "type": "column"
                },
                "type": "singleChildScrollView"
              },
              "type": "expanded"
            },
            {
              "padding": {
                "top": 16.0
              },
              "child": {
                "type": "reactiveElevatedButton",
                "enabledKey": "verifyIdentityHasSelectedJob",
                "enabled": false,
                "onPressed": {
                  "navigationStyle": "push",
                  "actionType": "navigate",
                  "request": {
                    "url": "http://192.168.179.21:8101/api/configurations/v1.0/configs/resolve/ipaam.builder.form.form.test_screen/1",
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
                "style": {
                  "foregroundColor": "{{appColors.current.primary.onPrimary}}",
                  "backgroundColor": "{{appColors.current.primary.color}}",
                  "elevation": 0.0,
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 56.0
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
                "disabledStyle": {
                  "backgroundColor": "{{appColors.current.background.surfaceContainerHigh}}",
                  "elevation": 0.0,
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 56.0
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
                  "data": "{{appStrings.common.continue}}",
                  "style": {
                    "type": "custom",
                    "color": "{{appColors.current.primary.onPrimary}}",
                    "fontSize": 18.0,
                    "fontWeight": "w700"
                  },
                  "textDirection": "rtl",
                  "type": "text"
                }
              },
              "type": "padding"
            }
          ],
          "type": "column"
        },
        "type": "padding"
      }
    },
    "type": "scaffold"
  }
}
```
