# flows/gift_card_real/json/gift_card_real_custom_message.json

Source: lib/stac/tobank/flows/gift_card_real/json/gift_card_real_custom_message.json

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
        "key": "giftCardRealCustomAltMessageContinueEnabled",
        "value": false
      },
      {
        "key": "giftCardRealCustomAltMessageOption1Selected",
        "value": false
      },
      {
        "key": "giftCardRealCustomAltMessageOption2Selected",
        "value": false
      },
      {
        "key": "giftCardRealCustomAltMessageOption3Selected",
        "value": false
      },
      {
        "key": "giftCardRealCustomAltMessageOption4Selected",
        "value": false
      },
      {
        "key": "giftCardRealCustomAltMessageOption5Selected",
        "value": false
      },
      {
        "key": "giftCardRealCustomReplacementMessage",
        "value": ""
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
      "crossAxisAlignment": "stretch",
      "children": [
        {
          "child": {
            "padding": {
              "left": 16.0,
              "top": 16.0,
              "right": 16.0
            },
            "child": {
              "crossAxisAlignment": "stretch",
              "children": [
                {
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
                    "padding": {
                      "left": 14.0,
                      "top": 14.0,
                      "right": 14.0,
                      "bottom": 14.0
                    },
                    "child": {
                      "data": "Ù„Ø·ÙØ§ ÛŒÚ©ÛŒ Ø§Ø² Ù…ØªÙ†â€ŒÙ‡Ø§ÛŒ Ù¾ÛŒØ´â€ŒÙØ±Ø¶ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯ ØªØ§ Ø¯Ø± ØµÙˆØ±Øª Ø¹Ø¯Ù… Ù…ÙˆØ§ÙÙ‚Øª Ø¨Ø§Ù†Ú© Ø¨Ø§ Ù…ØªÙ† Ø¯Ù„Ø®ÙˆØ§Ù‡ Ø´Ù…Ø§ØŒ Ù…ØªÙ† Ù¾ÛŒØ´â€ŒÙØ±Ø¶ Ø¬Ø§ÛŒÚ¯Ø²ÛŒÙ† Ø¢Ù† Ø´ÙˆØ¯",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.subtitle}}",
                        "fontSize": 16.0,
                        "fontWeight": "w500",
                        "height": 1.7
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    "type": "padding"
                  },
                  "type": "container"
                },
                {
                  "height": 20.0,
                  "type": "sizedBox"
                },
                {
                  "textDirection": "rtl",
                  "children": [
                    {
                      "data": "Ù…ØªÙ† Ù¾ÛŒØ´â€ŒÙØ±Ø¶ Ø¬Ø§ÛŒÚ¯Ø²ÛŒÙ†",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 19.0,
                        "fontWeight": "w700"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    {
                      "data": " *",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.primary.color}}",
                        "fontSize": 35.0,
                        "fontWeight": "w700"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    }
                  ],
                  "type": "row"
                },
                {
                  "height": 14.0,
                  "type": "sizedBox"
                },
                {
                  "child": {
                    "padding": {
                      "left": 16.0,
                      "top": 20.0,
                      "right": 16.0,
                      "bottom": 20.0
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
                      "crossAxisAlignment": "center",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "child": {
                            "data": "Ø¢Ø±Ø²ÙˆÙ…Ù†Ø¯ Ø®ÙˆØ´Ø¨Ø®ØªÛŒ Ø´Ù…Ø§",
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
                          "type": "expanded"
                        },
                        {
                          "width": 10.0,
                          "type": "sizedBox"
                        },
                        {
                          "alignment": "center",
                          "children": [
                            {
                              "type": "visibility",
                              "visible": "{{giftCardRealCustomAltMessageOption1Selected}}",
                              "child": {
                                "icon": "radio_button_checked",
                                "iconType": "material",
                                "size": 30.0,
                                "color": "{{appColors.current.secondary.color}}",
                                "type": "icon"
                              }
                            },
                            {
                              "type": "visibility",
                              "visible": "{{!giftCardRealCustomAltMessageOption1Selected}}",
                              "child": {
                                "icon": "radio_button_unchecked",
                                "iconType": "material",
                                "size": 30.0,
                                "color": "{{appColors.current.text.title}}",
                                "type": "icon"
                              }
                            }
                          ],
                          "type": "stack"
                        }
                      ],
                      "type": "row"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "giftCardRealCustomAltMessageOption1Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption2Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption3Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption4Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption5Selected",
                            "value": false
                          }
                        ]
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomAltMessageOption1Selected",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomReplacementMessage",
                        "value": "Ø¢Ø±Ø²ÙˆÙ…Ù†Ø¯ Ø®ÙˆØ´Ø¨Ø®ØªÛŒ Ø´Ù…Ø§"
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomHasReplacementMessage",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomAltMessageContinueEnabled",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomReplacementMessageOptionId",
                        "value": 1
                      }
                    ],
                    "sync": false,
                    "actionType": "multiAction"
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
                      "top": 20.0,
                      "right": 16.0,
                      "bottom": 20.0
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
                      "crossAxisAlignment": "center",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "child": {
                            "data": "Ù‡Ù…Ø³Ø± Ø¹Ø²ÛŒØ²Ù… Ø³Ø§Ù„Ø±ÙˆØ² Ø¹Ù‡Ø¯ Ùˆ Ù¾ÛŒÙ…Ø§Ù† Ø¬Ø§ÙˆÛŒØ¯Ø§Ù†Ù…Ø§Ù† Ù…Ø¨Ø§Ø±Ú©",
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
                          "type": "expanded"
                        },
                        {
                          "width": 10.0,
                          "type": "sizedBox"
                        },
                        {
                          "alignment": "center",
                          "children": [
                            {
                              "type": "visibility",
                              "visible": "{{giftCardRealCustomAltMessageOption2Selected}}",
                              "child": {
                                "icon": "radio_button_checked",
                                "iconType": "material",
                                "size": 30.0,
                                "color": "{{appColors.current.secondary.color}}",
                                "type": "icon"
                              }
                            },
                            {
                              "type": "visibility",
                              "visible": "{{!giftCardRealCustomAltMessageOption2Selected}}",
                              "child": {
                                "icon": "radio_button_unchecked",
                                "iconType": "material",
                                "size": 30.0,
                                "color": "{{appColors.current.text.title}}",
                                "type": "icon"
                              }
                            }
                          ],
                          "type": "stack"
                        }
                      ],
                      "type": "row"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "giftCardRealCustomAltMessageOption1Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption2Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption3Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption4Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption5Selected",
                            "value": false
                          }
                        ]
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomAltMessageOption2Selected",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomReplacementMessage",
                        "value": "Ù‡Ù…Ø³Ø± Ø¹Ø²ÛŒØ²Ù… Ø³Ø§Ù„Ø±ÙˆØ² Ø¹Ù‡Ø¯ Ùˆ Ù¾ÛŒÙ…Ø§Ù† Ø¬Ø§ÙˆÛŒØ¯Ø§Ù†Ù…Ø§Ù† Ù…Ø¨Ø§Ø±Ú©"
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomHasReplacementMessage",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomAltMessageContinueEnabled",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomReplacementMessageOptionId",
                        "value": 2
                      }
                    ],
                    "sync": false,
                    "actionType": "multiAction"
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
                      "top": 20.0,
                      "right": 16.0,
                      "bottom": 20.0
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
                      "crossAxisAlignment": "center",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "child": {
                            "data": "ØªÙ…Ø§Ù… Ù‚Ù„Ø¨Ù… Ù…Ø§Ù„ ØªÙˆØ³Øª",
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
                          "type": "expanded"
                        },
                        {
                          "width": 10.0,
                          "type": "sizedBox"
                        },
                        {
                          "alignment": "center",
                          "children": [
                            {
                              "type": "visibility",
                              "visible": "{{giftCardRealCustomAltMessageOption3Selected}}",
                              "child": {
                                "icon": "radio_button_checked",
                                "iconType": "material",
                                "size": 30.0,
                                "color": "{{appColors.current.secondary.color}}",
                                "type": "icon"
                              }
                            },
                            {
                              "type": "visibility",
                              "visible": "{{!giftCardRealCustomAltMessageOption3Selected}}",
                              "child": {
                                "icon": "radio_button_unchecked",
                                "iconType": "material",
                                "size": 30.0,
                                "color": "{{appColors.current.text.title}}",
                                "type": "icon"
                              }
                            }
                          ],
                          "type": "stack"
                        }
                      ],
                      "type": "row"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "giftCardRealCustomAltMessageOption1Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption2Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption3Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption4Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption5Selected",
                            "value": false
                          }
                        ]
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomAltMessageOption3Selected",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomReplacementMessage",
                        "value": "ØªÙ…Ø§Ù… Ù‚Ù„Ø¨Ù… Ù…Ø§Ù„ ØªÙˆØ³Øª"
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomHasReplacementMessage",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomAltMessageContinueEnabled",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomReplacementMessageOptionId",
                        "value": 3
                      }
                    ],
                    "sync": false,
                    "actionType": "multiAction"
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
                      "top": 20.0,
                      "right": 16.0,
                      "bottom": 20.0
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
                      "crossAxisAlignment": "center",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "child": {
                            "data": "Ø¯ÙˆØ³ØªØª Ø¯Ø§Ø±Ù…ØŒ Ù‡Ù…Ø±Ø§Ù‡ Ù‡Ù…ÛŒØ´Ú¯ÛŒ Ù…Ù†",
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
                          "type": "expanded"
                        },
                        {
                          "width": 10.0,
                          "type": "sizedBox"
                        },
                        {
                          "alignment": "center",
                          "children": [
                            {
                              "type": "visibility",
                              "visible": "{{giftCardRealCustomAltMessageOption4Selected}}",
                              "child": {
                                "icon": "radio_button_checked",
                                "iconType": "material",
                                "size": 30.0,
                                "color": "{{appColors.current.secondary.color}}",
                                "type": "icon"
                              }
                            },
                            {
                              "type": "visibility",
                              "visible": "{{!giftCardRealCustomAltMessageOption4Selected}}",
                              "child": {
                                "icon": "radio_button_unchecked",
                                "iconType": "material",
                                "size": 30.0,
                                "color": "{{appColors.current.text.title}}",
                                "type": "icon"
                              }
                            }
                          ],
                          "type": "stack"
                        }
                      ],
                      "type": "row"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "giftCardRealCustomAltMessageOption1Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption2Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption3Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption4Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption5Selected",
                            "value": false
                          }
                        ]
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomAltMessageOption4Selected",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomReplacementMessage",
                        "value": "Ø¯ÙˆØ³ØªØª Ø¯Ø§Ø±Ù…ØŒ Ù‡Ù…Ø±Ø§Ù‡ Ù‡Ù…ÛŒØ´Ú¯ÛŒ Ù…Ù†"
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomHasReplacementMessage",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomAltMessageContinueEnabled",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomReplacementMessageOptionId",
                        "value": 4
                      }
                    ],
                    "sync": false,
                    "actionType": "multiAction"
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
                      "top": 20.0,
                      "right": 16.0,
                      "bottom": 20.0
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
                      "crossAxisAlignment": "center",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "child": {
                            "data": "Ø®ÙˆØ´Ø§ Ø¯Ù„ÛŒ Ú©Ù‡ Ø¯Ù„Ø¯Ø§Ø±Ø´ ØªÙˆ Ú¯Ø±Ø¯ÛŒØŒ Ø®ÙˆØ´Ø§ Ø¬Ø§Ù†ÛŒ Ú©Ù‡ Ø¬Ø§Ù†Ø§Ù†Ø´ ØªÙˆ Ø¨Ø§Ø´ÛŒ",
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
                          "type": "expanded"
                        },
                        {
                          "width": 10.0,
                          "type": "sizedBox"
                        },
                        {
                          "alignment": "center",
                          "children": [
                            {
                              "type": "visibility",
                              "visible": "{{giftCardRealCustomAltMessageOption5Selected}}",
                              "child": {
                                "icon": "radio_button_checked",
                                "iconType": "material",
                                "size": 30.0,
                                "color": "{{appColors.current.secondary.color}}",
                                "type": "icon"
                              }
                            },
                            {
                              "type": "visibility",
                              "visible": "{{!giftCardRealCustomAltMessageOption5Selected}}",
                              "child": {
                                "icon": "radio_button_unchecked",
                                "iconType": "material",
                                "size": 30.0,
                                "color": "{{appColors.current.text.title}}",
                                "type": "icon"
                              }
                            }
                          ],
                          "type": "stack"
                        }
                      ],
                      "type": "row"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actions": [
                      {
                        "actionType": "setValue",
                        "values": [
                          {
                            "key": "giftCardRealCustomAltMessageOption1Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption2Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption3Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption4Selected",
                            "value": false
                          },
                          {
                            "key": "giftCardRealCustomAltMessageOption5Selected",
                            "value": false
                          }
                        ]
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomAltMessageOption5Selected",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomReplacementMessage",
                        "value": "Ø®ÙˆØ´Ø§ Ø¯Ù„ÛŒ Ú©Ù‡ Ø¯Ù„Ø¯Ø§Ø±Ø´ ØªÙˆ Ú¯Ø±Ø¯ÛŒØŒ Ø®ÙˆØ´Ø§ Ø¬Ø§Ù†ÛŒ Ú©Ù‡ Ø¬Ø§Ù†Ø§Ù†Ø´ ØªÙˆ Ø¨Ø§Ø´ÛŒ"
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomHasReplacementMessage",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomAltMessageContinueEnabled",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "giftCardRealCustomReplacementMessageOptionId",
                        "value": 5
                      }
                    ],
                    "sync": false,
                    "actionType": "multiAction"
                  },
                  "type": "gestureDetector"
                },
                {
                  "height": 18.0,
                  "type": "sizedBox"
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
            "left": 16.0,
            "right": 16.0,
            "bottom": 24.0
          },
          "child": {
            "type": "reactiveElevatedButton",
            "enabledKey": "giftCardRealCustomAltMessageContinueEnabled",
            "onPressed": {
              "actionType": "sequence",
              "actions": [
                {
                  "actionType": "setValue",
                  "values": [
                    {
                      "key": "giftCardRealHasSelection",
                      "value": true
                    },
                    {
                      "key": "giftCardRealCustomHasSelection",
                      "value": true
                    }
                  ]
                },
                {
                  "navigationStyle": "pop",
                  "actionType": "navigate"
                },
                {
                  "navigationStyle": "pop",
                  "actionType": "navigate"
                },
                {
                  "navigationStyle": "pop",
                  "actionType": "navigate"
                }
              ]
            },
            "style": {
              "foregroundColor": "{{appColors.current.primary.onPrimary}}",
              "backgroundColor": "{{appColors.current.primary.color}}",
              "elevation": 0.0,
              "fixedSize": {
                "width": 999999.0,
                "height": 62.0
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
            "disabledStyle": {
              "foregroundColor": "{{appColors.current.button.disabled.foregroundColor}}",
              "backgroundColor": "{{appColors.current.button.disabled.backgroundColor}}",
              "elevation": 0.0,
              "fixedSize": {
                "width": 999999.0,
                "height": 62.0
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
              "data": "Ø§Ø¯Ø§Ù…Ù‡",
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
    "type": "scaffold"
  }
}
```
