# flows/transfer_real/json/transfer_real_card_details.json

Source: lib/stac/tobank/flows/transfer_real/json/transfer_real_card_details.json

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
        "key": "transferApiCardAmountWords",
        "value": ""
      },
      {
        "key": "transferApiCardDetailsContinueEnabled",
        "value": false
      },
      {
        "key": "transferApiCardAmountHasText",
        "value": false
      },
      {
        "key": "transferApiCardDescription",
        "value": ""
      },
      {
        "key": "transferApiCardDescriptionHasText",
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
                          "topLeft": 12.0,
                          "topRight": 12.0,
                          "bottomLeft": 12.0,
                          "bottomRight": 12.0
                        }
                      },
                      "child": {
                        "crossAxisAlignment": "stretch",
                        "children": [
                          {
                            "crossAxisAlignment": "center",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "width": 44.0,
                                "child": {
                                  "alignment": "centerStart",
                                  "child": {
                                    "data": "Ù…Ø¨Ø¯Ø§",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
                                      "fontWeight": "w600"
                                    },
                                    "textDirection": "rtl",
                                    "type": "text"
                                  },
                                  "type": "align"
                                },
                                "type": "sizedBox"
                              },
                              {
                                "width": 10.0,
                                "type": "sizedBox"
                              },
                              {
                                "type": "registryReactive",
                                "registryKey": "transferApiCardSourceIcon",
                                "child": {
                                  "decoration": {
                                    "color": "#FFFFFF",
                                    "border": {
                                      "color": "{{appColors.current.input.borderEnabled}}",
                                      "width": 1.0
                                    },
                                    "shape": "circle"
                                  },
                                  "width": 38.0,
                                  "height": 38.0,
                                  "child": {
                                    "child": {
                                      "type": "image",
                                      "src": "{{transferApiCardSourceIcon}}",
                                      "imageType": "asset",
                                      "width": 28,
                                      "height": 28
                                    },
                                    "type": "center"
                                  },
                                  "type": "container"
                                }
                              },
                              {
                                "width": 10.0,
                                "type": "sizedBox"
                              },
                              {
                                "child": {
                                  "crossAxisAlignment": "stretch",
                                  "children": [
                                    {
                                      "type": "registryReactive",
                                      "registryKey": "transferApiCardSourceName",
                                      "child": {
                                        "type": "text",
                                        "data": "{{transferApiCardSourceName}}",
                                        "textDirection": "rtl",
                                        "textAlign": "right",
                                        "style": {
                                          "type": "custom",
                                          "fontSize": 16,
                                          "fontWeight": "w700",
                                          "color": "{{appColors.current.text.title}}"
                                        }
                                      }
                                    },
                                    {
                                      "height": 6.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "type": "registryReactive",
                                      "registryKey": "transferApiCardSourceNumber",
                                      "child": {
                                        "type": "text",
                                        "data": "{{transferApiCardSourceNumber}}",
                                        "textDirection": "ltr",
                                        "textAlign": "right",
                                        "style": {
                                          "type": "custom",
                                          "fontSize": 15,
                                          "fontWeight": "w600",
                                          "color": "{{appColors.current.text.title}}"
                                        }
                                      }
                                    }
                                  ],
                                  "type": "column"
                                },
                                "type": "expanded"
                              }
                            ],
                            "type": "row"
                          },
                          {
                            "height": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "thickness": 1.0,
                            "color": "{{appColors.current.input.borderEnabled}}",
                            "type": "divider"
                          },
                          {
                            "height": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "crossAxisAlignment": "center",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "width": 44.0,
                                "child": {
                                  "alignment": "centerStart",
                                  "child": {
                                    "data": "Ù…Ù‚ØµØ¯",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
                                      "fontWeight": "w600"
                                    },
                                    "textDirection": "rtl",
                                    "type": "text"
                                  },
                                  "type": "align"
                                },
                                "type": "sizedBox"
                              },
                              {
                                "width": 10.0,
                                "type": "sizedBox"
                              },
                              {
                                "type": "registryReactive",
                                "registryKey": "transferApiCardDestinationIcon",
                                "child": {
                                  "decoration": {
                                    "color": "#FFFFFF",
                                    "border": {
                                      "color": "{{appColors.current.input.borderEnabled}}",
                                      "width": 1.0
                                    },
                                    "shape": "circle"
                                  },
                                  "width": 38.0,
                                  "height": 38.0,
                                  "child": {
                                    "child": {
                                      "type": "image",
                                      "src": "{{transferApiCardDestinationIcon}}",
                                      "imageType": "asset",
                                      "width": 28,
                                      "height": 28
                                    },
                                    "type": "center"
                                  },
                                  "type": "container"
                                }
                              },
                              {
                                "width": 10.0,
                                "type": "sizedBox"
                              },
                              {
                                "child": {
                                  "crossAxisAlignment": "stretch",
                                  "children": [
                                    {
                                      "type": "registryReactive",
                                      "registryKey": "transferApiCardDestinationName",
                                      "child": {
                                        "type": "text",
                                        "data": "{{transferApiCardDestinationName}}",
                                        "textDirection": "rtl",
                                        "textAlign": "right",
                                        "style": {
                                          "type": "custom",
                                          "fontSize": 16,
                                          "fontWeight": "w700",
                                          "color": "{{appColors.current.text.title}}"
                                        }
                                      }
                                    },
                                    {
                                      "height": 6.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "type": "registryReactive",
                                      "registryKey": "transferApiCardDestinationNumber",
                                      "child": {
                                        "type": "text",
                                        "data": "{{transferApiCardDestinationNumber}}",
                                        "textDirection": "ltr",
                                        "textAlign": "right",
                                        "style": {
                                          "type": "custom",
                                          "fontSize": 15,
                                          "fontWeight": "w600",
                                          "color": "{{appColors.current.text.title}}"
                                        }
                                      }
                                    }
                                  ],
                                  "type": "column"
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
                      "height": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "type": "textFormField",
                      "id": "transferApiCardAmountInput",
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
                        "suffixIcon": {
                          "type": "visibility",
                          "visible": "[[transferApiCardAmountHasText]]",
                          "child": {
                            "child": {
                              "padding": {
                                "left": 10.0,
                                "right": 10.0
                              },
                              "child": {
                                "icon": "close",
                                "iconType": "material",
                                "size": 19.0,
                                "color": "{{appColors.current.text.subtitle}}",
                                "type": "icon"
                              },
                              "type": "padding"
                            },
                            "onTap": {
                              "actionType": "setValue",
                              "values": [
                                {
                                  "key": "transferApiCardAmountInput",
                                  "value": ""
                                },
                                {
                                  "key": "transferApiCardAmountRaw",
                                  "value": ""
                                },
                                {
                                  "key": "transferApiCardAmountWords",
                                  "value": ""
                                },
                                {
                                  "key": "transferApiCardDetailsContinueEnabled",
                                  "value": false
                                },
                                {
                                  "key": "transferApiCardAmountHasText",
                                  "value": false
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          },
                          "replacement": {
                            "width": 24.0,
                            "type": "sizedBox"
                          }
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
                            "key": "transferApiCardAmountRaw",
                            "value": {
                              "actionType": "getFormValue",
                              "id": "transferApiCardAmountInput"
                            }
                          },
                          {
                            "actionType": "amountToWords",
                            "sourceKey": "transferApiCardAmountRaw",
                            "destinationKey": "transferApiCardAmountWords",
                            "divideBy": 10,
                            "minDigits": 2,
                            "suffix": "ØªÙˆÙ…Ø§Ù†"
                          },
                          {
                            "actionType": "validateFields",
                            "resultKey": "transferApiCardDetailsContinueEnabled",
                            "fields": [
                              {
                                "id": "transferApiCardAmountInput"
                              }
                            ]
                          },
                          {
                            "actionType": "validateFields",
                            "resultKey": "transferApiCardAmountHasText",
                            "fields": [
                              {
                                "id": "transferApiCardAmountInput"
                              }
                            ]
                          }
                        ]
                      }
                    },
                    {
                      "height": 6.0,
                      "type": "sizedBox"
                    },
                    {
                      "type": "registryReactive",
                      "registryKey": "transferApiCardAmountWords",
                      "child": {
                        "type": "text",
                        "data": "{{transferApiCardAmountWords}}",
                        "textDirection": "rtl",
                        "textAlign": "right",
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
                      "id": "transferApiCardDescriptionInput",
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
                      "maxLines": 2,
                      "onChanged": {
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "setValue",
                            "key": "transferApiCardDescription",
                            "value": {
                              "actionType": "getFormValue",
                              "id": "transferApiCardDescriptionInput"
                            }
                          },
                          {
                            "actionType": "validateFields",
                            "resultKey": "transferApiCardDescriptionHasText",
                            "fields": [
                              {
                                "id": "transferApiCardDescriptionInput"
                              }
                            ]
                          }
                        ]
                      }
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
              "enabledKey": "transferApiCardDetailsContinueEnabled",
              "onPressed": {
                "routeName": "transfer_real_confirm",
                "navigationStyle": "push",
                "actionType": "navigate"
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
