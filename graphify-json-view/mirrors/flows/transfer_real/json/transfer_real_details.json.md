# flows/transfer_real/json/transfer_real_details.json

Source: lib/stac/tobank/flows/transfer_real/json/transfer_real_details.json

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
        "key": "transferApiAmountWords",
        "value": ""
      },
      {
        "key": "transferApiReasonTitle",
        "value": ""
      },
      {
        "key": "transferApiHasReason",
        "value": false
      },
      {
        "key": "transferApiDetailsContinueEnabled",
        "value": false
      }
    ]
  },
  "child": {
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
      "autovalidateMode": "onUserInteraction",
      "child": {
        "padding": {
          "left": 16.0,
          "top": 16.0,
          "right": 16.0,
          "bottom": 23.0
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
                      "mainAxisAlignment": "spaceBetween",
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "data": "Ù…Ø¨Ù„Øº",
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
                            "type": "registryReactive",
                            "registryKey": "transferApiAmountWords",
                            "child": {
                              "type": "text",
                              "data": "{{transferApiAmountWords}}",
                              "textDirection": "rtl",
                              "textAlign": "left",
                              "maxLines": 2,
                              "overflow": "ellipsis",
                              "style": {
                                "type": "custom",
                                "fontSize": 13,
                                "fontWeight": "w600",
                                "height": 1.35,
                                "color": "{{appColors.current.text.subtitle}}"
                              }
                            }
                          },
                          "type": "expanded"
                        }
                      ],
                      "type": "row"
                    },
                    {
                      "height": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "type": "textFormField",
                      "id": "transferApiAmountInput",
                      "textDirection": "ltr",
                      "textAlign": "left",
                      "formatThousands": true,
                      "thousandsSeparator": ",",
                      "decoration": {
                        "hintText": "Ù…Ø¨Ù„Øº Ø§Ù†ØªÙ‚Ø§Ù„ Ø±Ø§ Ø¨Ù‡ Ø±ÛŒØ§Ù„ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                        "hintStyle": {
                          "type": "custom",
                          "color": "{{appColors.current.text.hint}}",
                          "fontSize": 16.0,
                          "fontWeight": "w500"
                        },
                        "contentPadding": {
                          "left": 16.0,
                          "top": 19.5,
                          "right": 16.0,
                          "bottom": 19.5
                        },
                        "filled": false,
                        "hintTextDirection": "rtl",
                        "hintTextAlign": "right"
                      },
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "keyboardType": "number",
                      "maxLength": 14,
                      "maxLines": 1,
                      "inputFormatters": [
                        {
                          "type": "allow",
                          "rule": "[0-9]"
                        }
                      ],
                      "onChanged": {
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "setValue",
                            "key": "transferApiAmountRaw",
                            "value": {
                              "actionType": "getFormValue",
                              "id": "transferApiAmountInput"
                            }
                          },
                          {
                            "actionType": "amountToWords",
                            "sourceKey": "transferApiAmountRaw",
                            "destinationKey": "transferApiAmountWords",
                            "divideBy": 10,
                            "minDigits": 2,
                            "suffix": "ØªÙˆÙ…Ø§Ù†"
                          },
                          {
                            "actionType": "setTransferDetailsContinueEnabled",
                            "amountRawKey": "transferApiAmountRaw",
                            "reasonSelectedKey": "transferApiHasReason",
                            "continueEnabledKey": "transferApiDetailsContinueEnabled"
                          }
                        ]
                      }
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "Ø¨Ø§Ø¨Øª",
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
                      "height": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 16.0,
                          "top": 19.5,
                          "right": 16.0,
                          "bottom": 19.5
                        },
                        "decoration": {
                          "border": {
                            "color": "{{appColors.current.input.borderEnabled}}",
                            "width": 1.0
                          },
                          "borderRadius": {
                            "topLeft": 14.0,
                            "topRight": 14.0,
                            "bottomLeft": 14.0,
                            "bottomRight": 14.0
                          }
                        },
                        "child": {
                          "mainAxisAlignment": "start",
                          "crossAxisAlignment": "center",
                          "textDirection": "ltr",
                          "children": [
                            {
                              "icon": "keyboard_arrow_down",
                              "iconType": "material",
                              "size": 22.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            },
                            {
                              "width": 10.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "type": "visibility",
                                "visible": "[[transferApiHasReason]]",
                                "child": {
                                  "type": "registryReactive",
                                  "registryKey": "transferApiReasonTitle",
                                  "child": {
                                    "type": "text",
                                    "data": "{{transferApiReasonTitle}}",
                                    "textDirection": "rtl",
                                    "textAlign": "right",
                                    "maxLines": 2,
                                    "overflow": "ellipsis",
                                    "style": {
                                      "type": "custom",
                                      "fontSize": 16,
                                      "fontWeight": "w600",
                                      "color": "{{appColors.current.text.title}}"
                                    }
                                  }
                                },
                                "replacement": {
                                  "data": "Ø¯Ù„ÛŒÙ„ Ø§Ù†ØªÙ‚Ø§Ù„ ÙˆØ¬Ù‡",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.hint}}",
                                    "fontSize": 16.0,
                                    "fontWeight": "w500"
                                  },
                                  "textAlign": "right",
                                  "textDirection": "rtl",
                                  "type": "text"
                                }
                              },
                              "type": "expanded"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showTransferPurposeBottomSheet",
                        "title": "Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ø§Ø¨Øª:",
                        "selectedValueKey": "transferApiReasonTitle",
                        "hasValueKey": "transferApiHasReason",
                        "amountRawKey": "transferApiAmountRaw",
                        "continueEnabledKey": "transferApiDetailsContinueEnabled",
                        "heightFactor": 0.72
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "Ø´Ù†Ø§Ø³Ù‡ Ù¾Ø±Ø¯Ø§Ø®Øª",
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
                      "height": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "type": "textFormField",
                      "id": "transferApiPayIdInput",
                      "textDirection": "ltr",
                      "textAlign": "right",
                      "decoration": {
                        "hintText": "Ø´Ù†Ø§Ø³Ù‡ Ù¾Ø±Ø¯Ø§Ø®Øª (Ø§Ø®ØªÛŒØ§Ø±ÛŒ)",
                        "hintStyle": {
                          "type": "custom",
                          "color": "{{appColors.current.text.hint}}",
                          "fontSize": 16.0,
                          "fontWeight": "w500"
                        },
                        "contentPadding": {
                          "left": 16.0,
                          "top": 19.5,
                          "right": 16.0,
                          "bottom": 19.5
                        },
                        "filled": false
                      },
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "keyboardType": "number",
                      "maxLines": 1,
                      "inputFormatters": [
                        {
                          "type": "allow",
                          "rule": "[0-9]"
                        }
                      ]
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "ØªÙˆØ¶ÛŒØ­Ø§Øª",
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
                      "height": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "type": "textFormField",
                      "id": "transferApiDescriptionInput",
                      "textDirection": "rtl",
                      "textAlign": "right",
                      "decoration": {
                        "hintText": "ØªÙˆØ¶ÛŒØ­Ø§Øª ØªØ±Ø§Ú©Ù†Ø´ (Ø§Ø®ØªÛŒØ§Ø±ÛŒ)",
                        "hintStyle": {
                          "type": "custom",
                          "color": "{{appColors.current.text.hint}}",
                          "fontSize": 16.0,
                          "fontWeight": "w500"
                        },
                        "contentPadding": {
                          "left": 16.0,
                          "top": 19.5,
                          "right": 16.0,
                          "bottom": 19.5
                        },
                        "filled": false
                      },
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "keyboardType": "text",
                      "maxLines": 2
                    }
                  ],
                  "type": "column"
                },
                "type": "singleChildScrollView"
              },
              "type": "expanded"
            },
            {
              "height": 12.0,
              "type": "sizedBox"
            },
            {
              "type": "reactiveElevatedButton",
              "enabledKey": "transferApiDetailsContinueEnabled",
              "onPressed": {
                "actionType": "showTransferTypeBottomSheet",
                "title": "Ø±ÙˆØ´ Ø§Ù†ØªÙ‚Ø§Ù„ Ø®ÙˆØ¯ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                "heightFactor": 0.68,
                "selectedTypeKey": "transferApiTransferTypeTitle",
                "onSelectAction": {
                  "actionType": "navigate",
                  "routeName": "transfer_real_confirm",
                  "navigationStyle": "push"
                }
              },
              "style": {
                "foregroundColor": "{{appColors.current.button.primary.foregroundColor}}",
                "backgroundColor": "{{appColors.current.button.primary.backgroundColor}}",
                "fixedSize": {
                  "width": 999999.0,
                  "height": 57.0
                },
                "shape": {
                  "type": "roundedRectangleBorder",
                  "borderRadius": {
                    "topLeft": 10.0,
                    "topRight": 10.0,
                    "bottomLeft": 10.0,
                    "bottomRight": 10.0
                  }
                }
              },
              "disabledStyle": {
                "foregroundColor": "{{appColors.current.text.hint}}",
                "backgroundColor": "{{appColors.current.background.surfaceContainerHigh}}",
                "fixedSize": {
                  "width": 999999.0,
                  "height": 57.0
                },
                "shape": {
                  "type": "roundedRectangleBorder",
                  "borderRadius": {
                    "topLeft": 10.0,
                    "topRight": 10.0,
                    "bottomLeft": 10.0,
                    "bottomRight": 10.0
                  }
                }
              },
              "child": {
                "data": "Ø§Ø¯Ø§Ù…Ù‡",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.button.primary.foregroundColor}}",
                  "fontSize": 18.0,
                  "fontWeight": "w700"
                },
                "type": "text"
              }
            }
          ],
          "type": "column"
        },
        "type": "padding"
      },
      "type": "form"
    },
    "type": "scaffold"
  }
}
```
