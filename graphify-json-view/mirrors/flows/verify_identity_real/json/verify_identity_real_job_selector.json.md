# flows/verify_identity_real/json/verify_identity_real_job_selector.json

Source: lib/stac/tobank/flows/verify_identity_real/json/verify_identity_real_job_selector.json

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
      "data": "{{appStrings.menu.items.verifyIdentity}}",
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
      "crossAxisAlignment": "stretch",
      "children": [
        {
          "height": 24.0,
          "type": "sizedBox"
        },
        {
          "padding": {
            "left": 16.0,
            "right": 16.0
          },
          "child": {
            "data": "Ø­ÙˆØ²Ù‡ ÙØ¹Ø§Ù„ÛŒØª Ø®ÙˆØ¯ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
            "style": {
              "type": "custom",
              "color": "{{appColors.current.text.title}}",
              "fontSize": 18.0,
              "fontWeight": "w700"
            },
            "textAlign": "center",
            "textDirection": "rtl",
            "type": "text"
          },
          "type": "padding"
        },
        {
          "height": 16.0,
          "type": "sizedBox"
        },
        {
          "child": {
            "child": {
              "crossAxisAlignment": "stretch",
              "children": [
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ù¾Ø²Ø´Ú©",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ù¾Ø²Ø´Ú©"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ø¨Ø§Ø²Ø±Ú¯Ø§Ù†ÛŒ",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ø¨Ø§Ø²Ø±Ú¯Ø§Ù†ÛŒ"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ø¨Ø§Ø²Ù†Ø´Ø³ØªÙ‡",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ø¨Ø§Ø²Ù†Ø´Ø³ØªÙ‡"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "ØªÙˆÙ„ÛŒØ¯ÛŒ",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "ØªÙˆÙ„ÛŒØ¯ÛŒ"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ø®Ø¯Ù…Ø§ØªÛŒ",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ø®Ø¯Ù…Ø§ØªÛŒ"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ø³Ø§Ø®ØªÙ…Ø§Ù†ÛŒ",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ø³Ø§Ø®ØªÙ…Ø§Ù†ÛŒ"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "ÙØ±Ù‡Ù†Ú¯ÛŒ",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "ÙØ±Ù‡Ù†Ú¯ÛŒ"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ú©Ø§Ø±Ù…Ù†Ø¯ Ø¯ÙˆÙ„Øª",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ú©Ø§Ø±Ù…Ù†Ø¯ Ø¯ÙˆÙ„Øª"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ù…Ø±Ø§Ú©Ø² ØªÙØ±ÛŒØ­ÛŒØŒ ÙˆØ±Ø²Ø´ÛŒØŒ Ù…ÙˆØ²Ù‡ØŒ Ø¯ÛŒÙ†ÛŒ Ùˆ...",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ù…Ø±Ø§Ú©Ø² ØªÙØ±ÛŒØ­ÛŒØŒ ÙˆØ±Ø²Ø´ÛŒØŒ Ù…ÙˆØ²Ù‡ØŒ Ø¯ÛŒÙ†ÛŒ Ùˆ..."
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "ÙˆÚ©Ø§Ù„Øª",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "ÙˆÚ©Ø§Ù„Øª"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ø®Ø§Ù†Ù‡ Ø¯Ø§Ø±",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ø®Ø§Ù†Ù‡ Ø¯Ø§Ø±"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ù…Ø³ØªÙ…Ø±ÛŒ Ø¨Ú¯ÛŒØ±",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ù…Ø³ØªÙ…Ø±ÛŒ Ø¨Ú¯ÛŒØ±"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ø¯Ø§Ù†Ø´Ø¬Ùˆ",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ø¯Ø§Ù†Ø´Ø¬Ùˆ"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ø¨ÛŒÚ©Ø§Ø±",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ø¨ÛŒÚ©Ø§Ø±"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ø¯Ø§Ø±Ø§ÛŒ Ø¨ÛŒÙ…Ù‡ Ø¨ÛŒÚ©Ø§Ø±ÛŒ",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ø¯Ø§Ø±Ø§ÛŒ Ø¨ÛŒÙ…Ù‡ Ø¨ÛŒÚ©Ø§Ø±ÛŒ"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ø§Ø´Ø®Ø§Øµ Ø®Ø§Ø±Ø¬ÛŒ ÙØ§Ù‚Ø¯ Ù…Ø¬ÙˆØ² ÙØ¹Ø§Ù„ÛŒØª Ù…Ø¹ØªØ¨Ø±",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ø§Ø´Ø®Ø§Øµ Ø®Ø§Ø±Ø¬ÛŒ ÙØ§Ù‚Ø¯ Ù…Ø¬ÙˆØ² ÙØ¹Ø§Ù„ÛŒØª Ù…Ø¹ØªØ¨Ø±"
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                {
                  "child": {
                    "padding": {
                      "left": 20.0,
                      "top": 18.0,
                      "right": 20.0,
                      "bottom": 18.0
                    },
                    "decoration": {
                      "border": {
                        "bottom": {
                          "color": "{{appColors.current.background.surfaceContainerHigh}}",
                          "width": 1.0
                        }
                      }
                    },
                    "child": {
                      "data": "Ø³Ø§ÛŒØ± ÙØ¹Ø§Ù„Ø§Ù† Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ(ØµÙ†Ø§ÛŒØ¹ Ø¯Ø³ØªÛŒØŒ Ø±Ø§Ù‡Ù†Ù…Ø§ÛŒØ§Ù† ØªÙˆØ±ØŒÙˆ...",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "verifyIdentitySelectedJobTitle",
                            "value": "Ø³Ø§ÛŒØ± ÙØ¹Ø§Ù„Ø§Ù† Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ(ØµÙ†Ø§ÛŒØ¹ Ø¯Ø³ØªÛŒØŒ Ø±Ø§Ù‡Ù†Ù…Ø§ÛŒØ§Ù† ØªÙˆØ±ØŒÙˆ..."
                          },
                          {
                            "key": "verifyIdentityHasSelectedJob",
                            "value": true
                          }
                        ]
                      },
                      {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                }
              ],
              "type": "column"
            },
            "type": "singleChildScrollView"
          },
          "type": "expanded"
        }
      ],
      "type": "column"
    }
  },
  "type": "scaffold"
}
```
