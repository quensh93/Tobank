# flows/gift_card_real/json/gift_card_real_message.json

Source: lib/stac/tobank/flows/gift_card_real/json/gift_card_real_message.json

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
        "key": "giftCardRealContinueEnabled",
        "value": false
      },
      {
        "key": "giftCardRealHasCustomMessage",
        "value": false
      },
      {
        "key": "giftCardRealHasPresetMessage",
        "value": false
      },
      {
        "key": "giftCardRealSelectedPresetMessage",
        "value": ""
      },
      {
        "key": "giftCardRealMessageOption1Selected",
        "value": false
      },
      {
        "key": "giftCardRealMessageOption2Selected",
        "value": false
      },
      {
        "key": "giftCardRealMessageOption3Selected",
        "value": false
      },
      {
        "key": "giftCardRealMessageOption4Selected",
        "value": false
      },
      {
        "key": "giftCardRealMessageOption5Selected",
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
      "child": {
        "crossAxisAlignment": "stretch",
        "children": [
          {
            "child": {
              "padding": {
                "left": 16.0,
                "top": 20.0,
                "right": 16.0
              },
              "child": {
                "crossAxisAlignment": "stretch",
                "children": [
                  {
                    "textDirection": "rtl",
                    "children": [
                      {
                        "data": "Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
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
                        "width": 8.0,
                        "type": "sizedBox"
                      },
                      {
                        "child": {
                          "icon": "error_outline",
                          "iconType": "material",
                          "size": 24.0,
                          "color": "{{appColors.current.text.subtitle}}",
                          "type": "icon"
                        },
                        "onTap": {
                          "actionType": "showGiftCardMessageGuideBottomSheet",
                          "title": "Ø±Ø§Ù‡Ù†Ù…Ø§",
                          "description": "Ø¯Ø± ØµÙˆØ±Øª ÙˆØ±ÙˆØ¯ Ù…ØªÙ† Ø¯Ù„Ø®ÙˆØ§Ù‡ØŒ ÛŒÚ©ÛŒ Ø§Ø² Ù…ØªÙ†â€ŒÙ‡Ø§ÛŒ Ù¾ÛŒØ´â€ŒÙØ±Ø¶ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯ ØªØ§ Ø¯Ø± ØµÙˆØ±Øª Ø¹Ø¯Ù… Ù…ÙˆØ§ÙÙ‚Øª Ø¨Ø§Ù†Ú© Ø¨Ø§ Ù…ØªÙ† Ø¯Ù„Ø®ÙˆØ§Ù‡ Ø´Ù…Ø§ØŒ Ù…ØªÙ† Ù¾ÛŒØ´â€ŒÙØ±Ø¶ Ø¬Ø§ÛŒÚ¯Ø²ÛŒÙ† Ø¢Ù† Ø´ÙˆØ¯",
                          "closeText": "Ø¨Ø³ØªÙ†"
                        },
                        "type": "gestureDetector"
                      }
                    ],
                    "type": "row"
                  },
                  {
                    "height": 18.0,
                    "type": "sizedBox"
                  },
                  {
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
                      "type": "textFormField",
                      "id": "gift_card_real_custom_message",
                      "textDirection": "rtl",
                      "textAlign": "right",
                      "decoration": {
                        "hintText": "Ù…ØªÙ† Ø¯Ù„Ø®ÙˆØ§Ù‡ØªØ§Ù† Ø±Ø§ Ø¨Ù†ÙˆÛŒØ³ÛŒØ¯ (ØªØ§ Û´Û° Ú©Ø§Ø±Ø§Ú©ØªØ±)",
                        "hintStyle": {
                          "type": "custom",
                          "color": "{{appColors.current.text.hint}}",
                          "fontSize": 16.0,
                          "fontWeight": "w500"
                        },
                        "contentPadding": {
                          "left": 16.0,
                          "top": 16.0,
                          "right": 16.0,
                          "bottom": 16.0
                        },
                        "filled": false
                      },
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 19.0,
                        "fontWeight": "w600"
                      },
                      "keyboardType": "multiline",
                      "textInputAction": "newline",
                      "maxLength": 40,
                      "minLines": 2,
                      "maxLines": 3,
                      "onChanged": {
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "setValue",
                            "key": "giftCardRealCustomMessage",
                            "value": {
                              "actionType": "getFormValue",
                              "id": "gift_card_real_custom_message"
                            }
                          },
                          {
                            "actionType": "validateFields",
                            "resultKey": "giftCardRealHasCustomMessage",
                            "fields": [
                              {
                                "id": "gift_card_real_custom_message",
                                "rule": "^.{1,40}$"
                              }
                            ]
                          },
                          {
                            "actionType": "setValue",
                            "key": "giftCardRealContinueEnabled",
                            "value": "{{giftCardRealHasCustomMessage ? true : giftCardRealHasPresetMessage}}"
                          }
                        ]
                      }
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
                              "data": "ØªÙˆÙ„Ø¯Øª Ù…Ø¨Ø§Ø±Ú©",
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
                                "visible": "{{giftCardRealMessageOption1Selected}}",
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
                                "visible": "{{!giftCardRealMessageOption1Selected}}",
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
                              "key": "giftCardRealMessageOption1Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption2Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption3Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption4Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption5Selected",
                              "value": false
                            }
                          ]
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealHasPresetMessage",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealMessageOption1Selected",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealSelectedPresetMessage",
                          "value": "ØªÙˆÙ„Ø¯Øª Ù…Ø¨Ø§Ø±Ú©"
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealContinueEnabled",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealSelectedPresetOptionId",
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
                              "data": "Ø³Ø§Ù„Ø±ÙˆØ² Ø²Ù…ÛŒÙ†ÛŒ Ø´Ø¯Ù†Øª Ù…Ø¨Ø§Ø±Ú©",
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
                                "visible": "{{giftCardRealMessageOption2Selected}}",
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
                                "visible": "{{!giftCardRealMessageOption2Selected}}",
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
                              "key": "giftCardRealMessageOption1Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption2Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption3Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption4Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption5Selected",
                              "value": false
                            }
                          ]
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealHasPresetMessage",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealMessageOption2Selected",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealSelectedPresetMessage",
                          "value": "Ø³Ø§Ù„Ø±ÙˆØ² Ø²Ù…ÛŒÙ†ÛŒ Ø´Ø¯Ù†Øª Ù…Ø¨Ø§Ø±Ú©"
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealContinueEnabled",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealSelectedPresetOptionId",
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
                              "data": "Ø±ÙˆØ²ÛŒ Ú©Ù‡ ØªÙˆ Ø¨Ù‡ Ø¯Ù†ÛŒØ§ Ø¢Ù…Ø¯ÛŒØŒ Ù‚Ù„Ø¨Ù…Ø§Ù† Ù¾Ø± Ø§Ø² Ø´Ø§Ø¯ÛŒ Ùˆ Ø¹Ø´Ù‚ Ø´Ø¯",
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
                                "visible": "{{giftCardRealMessageOption3Selected}}",
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
                                "visible": "{{!giftCardRealMessageOption3Selected}}",
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
                              "key": "giftCardRealMessageOption1Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption2Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption3Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption4Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption5Selected",
                              "value": false
                            }
                          ]
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealHasPresetMessage",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealMessageOption3Selected",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealSelectedPresetMessage",
                          "value": "Ø±ÙˆØ²ÛŒ Ú©Ù‡ ØªÙˆ Ø¨Ù‡ Ø¯Ù†ÛŒØ§ Ø¢Ù…Ø¯ÛŒØŒ Ù‚Ù„Ø¨Ù…Ø§Ù† Ù¾Ø± Ø§Ø² Ø´Ø§Ø¯ÛŒ Ùˆ Ø¹Ø´Ù‚ Ø´Ø¯"
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealContinueEnabled",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealSelectedPresetOptionId",
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
                              "data": "Ú†Ù‡ ÙØ±Ø®Ù†Ø¯Ù‡ Ø±ÙˆØ²ÛŒ Ø§Ø³Øª ØªÙˆÙ„Ø¯ Ø²ÛŒØ¨Ø§ØªØ±ÛŒÙ† Ø¯Ø®ØªØ± Ø¯Ù†ÛŒØ§",
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
                                "visible": "{{giftCardRealMessageOption4Selected}}",
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
                                "visible": "{{!giftCardRealMessageOption4Selected}}",
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
                              "key": "giftCardRealMessageOption1Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption2Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption3Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption4Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption5Selected",
                              "value": false
                            }
                          ]
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealHasPresetMessage",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealMessageOption4Selected",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealSelectedPresetMessage",
                          "value": "Ú†Ù‡ ÙØ±Ø®Ù†Ø¯Ù‡ Ø±ÙˆØ²ÛŒ Ø§Ø³Øª ØªÙˆÙ„Ø¯ Ø²ÛŒØ¨Ø§ØªØ±ÛŒÙ† Ø¯Ø®ØªØ± Ø¯Ù†ÛŒØ§"
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealContinueEnabled",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealSelectedPresetOptionId",
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
                              "data": "Ø§Ù…ÛŒØ¯ÙˆØ§Ø±Ù… Ø±ÙˆØ²Ú¯Ø§Ø±Øª Ø¨Ù‡ Ø²ÛŒØ¨Ø§ÛŒÛŒ Ù‚Ù„Ø¨ Ù…Ù‡Ø±Ø¨Ø§Ù†Øª Ø¨Ø§Ø´Ø¯",
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
                                "visible": "{{giftCardRealMessageOption5Selected}}",
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
                                "visible": "{{!giftCardRealMessageOption5Selected}}",
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
                              "key": "giftCardRealMessageOption1Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption2Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption3Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption4Selected",
                              "value": false
                            },
                            {
                              "key": "giftCardRealMessageOption5Selected",
                              "value": false
                            }
                          ]
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealHasPresetMessage",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealMessageOption5Selected",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealSelectedPresetMessage",
                          "value": "Ø§Ù…ÛŒØ¯ÙˆØ§Ø±Ù… Ø±ÙˆØ²Ú¯Ø§Ø±Øª Ø¨Ù‡ Ø²ÛŒØ¨Ø§ÛŒÛŒ Ù‚Ù„Ø¨ Ù…Ù‡Ø±Ø¨Ø§Ù†Øª Ø¨Ø§Ø´Ø¯"
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealContinueEnabled",
                          "value": true
                        },
                        {
                          "actionType": "setValue",
                          "key": "giftCardRealSelectedPresetOptionId",
                          "value": 5
                        }
                      ],
                      "sync": false,
                      "actionType": "multiAction"
                    },
                    "type": "gestureDetector"
                  },
                  {
                    "height": 14.0,
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
              "enabledKey": "giftCardRealContinueEnabled",
              "onPressed": {
                "actionType": "sequence",
                "actions": [
                  {
                    "actionType": "setValue",
                    "key": "giftCardRealCustomMessage",
                    "value": {
                      "actionType": "getFormValue",
                      "id": "gift_card_real_custom_message"
                    }
                  },
                  {
                    "actionType": "setValue",
                    "key": "giftCardRealFinalMessage",
                    "value": "__STAC_OPEN__giftCardRealHasCustomMessage ? giftCardRealCustomMessage : giftCardRealSelectedPresetMessage}}"
                  },
                  {
                    "actionType": "setValue",
                    "key": "giftCardRealHasSelection",
                    "value": true
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
      "type": "form"
    },
    "type": "scaffold"
  }
}
```
