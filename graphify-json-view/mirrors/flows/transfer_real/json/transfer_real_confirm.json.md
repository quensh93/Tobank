# flows/transfer_real/json/transfer_real_confirm.json

Source: lib/stac/tobank/flows/transfer_real/json/transfer_real_confirm.json

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
        "key": "transferApiCardPaymentEnabled",
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
      "type": "visibility",
      "visible": "[[transferApiTabCard]]",
      "child": {
        "padding": {
          "left": 16.0,
          "top": 16.0,
          "right": 16.0,
          "bottom": 21.0
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
                          "topLeft": 14.0,
                          "topRight": 14.0,
                          "bottomLeft": 14.0,
                          "bottomRight": 14.0
                        }
                      },
                      "child": {
                        "crossAxisAlignment": "stretch",
                        "children": [
                          {
                            "mainAxisAlignment": "spaceBetween",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "data": "Ù…Ø¨Ù„Øº Ø§Ù†ØªÙ‚Ø§Ù„",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 18.0,
                                  "fontWeight": "w700"
                                },
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              {
                                "type": "registryReactive",
                                "registryKey": "transferApiCardAmountRaw",
                                "child": {
                                  "mainAxisSize": "min",
                                  "textDirection": "ltr",
                                  "children": [
                                    {
                                      "data": "Ø±ÛŒØ§Ù„",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 15.0,
                                        "fontWeight": "w500"
                                      },
                                      "textDirection": "rtl",
                                      "type": "text"
                                    },
                                    {
                                      "width": 4.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "type": "text",
                                      "data": "{{transferApiCardAmountRaw}}",
                                      "textDirection": "ltr",
                                      "textAlign": "left",
                                      "style": {
                                        "type": "custom",
                                        "fontSize": 18,
                                        "fontWeight": "w700",
                                        "color": "{{appColors.current.text.title}}"
                                      }
                                    }
                                  ],
                                  "type": "row"
                                }
                              }
                            ],
                            "type": "row"
                          },
                          {
                            "height": 14.0,
                            "type": "sizedBox"
                          },
                          {
                            "height": 1.0,
                            "thickness": 1.0,
                            "color": "{{appColors.current.input.borderEnabled}}",
                            "type": "divider"
                          },
                          {
                            "height": 14.0,
                            "type": "sizedBox"
                          },
                          {
                            "crossAxisAlignment": "center",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "width": 42.0,
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
                                "type": "container"
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
                                    "color": "{{appColors.current.background.surfaceContainer}}",
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
                                      "width": 24,
                                      "height": 24
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
                                          "fontSize": 18,
                                          "fontWeight": "w600",
                                          "color": "{{appColors.current.text.title}}"
                                        }
                                      }
                                    },
                                    {
                                      "height": 8.0,
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
                                          "fontSize": 17,
                                          "fontWeight": "w700",
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
                            "height": 14.0,
                            "type": "sizedBox"
                          },
                          {
                            "height": 1.0,
                            "thickness": 1.0,
                            "color": "{{appColors.current.input.borderEnabled}}",
                            "type": "divider"
                          },
                          {
                            "height": 14.0,
                            "type": "sizedBox"
                          },
                          {
                            "crossAxisAlignment": "center",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "width": 42.0,
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
                                "type": "container"
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
                                    "color": "{{appColors.current.background.surfaceContainer}}",
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
                                      "width": 24,
                                      "height": 24
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
                                          "fontSize": 18,
                                          "fontWeight": "w600",
                                          "color": "{{appColors.current.text.title}}"
                                        }
                                      }
                                    },
                                    {
                                      "height": 8.0,
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
                                          "fontSize": 17,
                                          "fontWeight": "w700",
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
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "ØªØ§Ø±ÛŒØ® Ø§Ù†Ù‚Ø¶Ø§",
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
                      "id": "transferApiCardExpireInput",
                      "textDirection": "ltr",
                      "textAlign": "right",
                      "decoration": {
                        "hintText": "Û°Û¶/Û±Û°",
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
                        "fontSize": 18.0,
                        "fontWeight": "w600"
                      },
                      "keyboardType": "number",
                      "maxLength": 5,
                      "inputFormatters": [
                        {
                          "type": "allow",
                          "rule": "[0-9/]"
                        }
                      ],
                      "onChanged": {
                        "actionType": "validateFields",
                        "resultKey": "transferApiCardPaymentEnabled",
                        "fields": [
                          {
                            "id": "transferApiCardExpireInput",
                            "rule": "^[0-9Û°-Û¹]{2}/[0-9Û°-Û¹]{2}$"
                          },
                          {
                            "id": "transferApiCardCvv2Input",
                            "rule": "^\\d{3,4}$"
                          },
                          {
                            "id": "transferApiCardOtpInput",
                            "rule": "^\\d{5,8}$"
                          }
                        ]
                      },
                      "onTap": {
                        "actionType": "showCardExpireSelectBottomSheet",
                        "formFieldId": "transferApiCardExpireInput",
                        "title": "ØªØ§Ø±ÛŒØ® Ø§Ù†Ù‚Ø¶Ø§ÛŒ Ú©Ø§Ø±Øª Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ù†Ù…Ø§ÛŒÛŒØ¯",
                        "monthTitle": "Ù…Ø§Ù‡",
                        "yearTitle": "Ø³Ø§Ù„",
                        "confirmText": "ØªØ§ÛŒÛŒØ¯",
                        "onSelectedAction": {
                          "actionType": "validateFields",
                          "resultKey": "transferApiCardPaymentEnabled",
                          "fields": [
                            {
                              "id": "transferApiCardExpireInput",
                              "rule": "^[0-9Û°-Û¹]{2}/[0-9Û°-Û¹]{2}$"
                            },
                            {
                              "id": "transferApiCardCvv2Input",
                              "rule": "^\\d{3,4}$"
                            },
                            {
                              "id": "transferApiCardOtpInput",
                              "rule": "^\\d{5,8}$"
                            }
                          ]
                        }
                      },
                      "readOnly": true
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "CVV2",
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
                      "id": "transferApiCardCvv2Input",
                      "textDirection": "ltr",
                      "textAlign": "right",
                      "decoration": {
                        "hintText": "CVV2 Ø±Ø§ ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯",
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
                        "fontSize": 18.0,
                        "fontWeight": "w600"
                      },
                      "keyboardType": "number",
                      "maxLength": 4,
                      "inputFormatters": [
                        {
                          "type": "allow",
                          "rule": "[0-9]"
                        }
                      ],
                      "onChanged": {
                        "actionType": "validateFields",
                        "resultKey": "transferApiCardPaymentEnabled",
                        "fields": [
                          {
                            "id": "transferApiCardExpireInput",
                            "rule": "^[0-9Û°-Û¹]{2}/[0-9Û°-Û¹]{2}$"
                          },
                          {
                            "id": "transferApiCardCvv2Input",
                            "rule": "^\\d{3,4}$"
                          },
                          {
                            "id": "transferApiCardOtpInput",
                            "rule": "^\\d{5,8}$"
                          }
                        ]
                      },
                      "readOnly": false
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "Ø±Ù…Ø² Ù¾ÙˆÛŒØ§",
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
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "flex": 2,
                          "child": {
                            "type": "textFormField",
                            "id": "transferApiCardOtpInput",
                            "textDirection": "ltr",
                            "textAlign": "right",
                            "decoration": {
                              "hintText": "Ø±Ù…Ø² Ù¾ÙˆÛŒØ§ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯",
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
                              "fontSize": 18.0,
                              "fontWeight": "w600"
                            },
                            "keyboardType": "number",
                            "inputFormatters": [
                              {
                                "type": "allow",
                                "rule": "[0-9]"
                              }
                            ],
                            "onChanged": {
                              "actionType": "validateFields",
                              "resultKey": "transferApiCardPaymentEnabled",
                              "fields": [
                                {
                                  "id": "transferApiCardExpireInput",
                                  "rule": "^[0-9Û°-Û¹]{2}/[0-9Û°-Û¹]{2}$"
                                },
                                {
                                  "id": "transferApiCardCvv2Input",
                                  "rule": "^\\d{3,4}$"
                                },
                                {
                                  "id": "transferApiCardOtpInput",
                                  "rule": "^\\d{5,8}$"
                                }
                              ]
                            },
                            "readOnly": false
                          },
                          "type": "expanded"
                        },
                        {
                          "width": 8.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "type": "otpCountdownButton",
                            "initialSeconds": 119,
                            "startOnTap": true,
                            "requestLabel": "Ø±Ù…Ø² Ù¾ÙˆÛŒØ§",
                            "retryLabel": "Ø¯Ø±ÛŒØ§ÙØª Ù…Ø¬Ø¯Ø¯",
                            "showIcon": false,
                            "borderColor": "{{appColors.current.input.borderEnabled}}",
                            "expiredBorderColor": "{{appColors.current.input.borderEnabled}}",
                            "countdownTextColor": "{{appColors.current.text.title}}",
                            "retryTextColor": "{{appColors.current.text.title}}",
                            "backgroundColor": "{{appColors.current.background.surface}}",
                            "height": 56,
                            "minWidth": 132,
                            "onStart": {
                              "actionType": "customSnackBar",
                              "snackStyle": "infoCard",
                              "message": "Ø±Ù…Ø² Ù¾ÙˆÛŒØ§ Ø¨Ø§ Ù…ÙˆÙÙ‚ÛŒØª Ø§Ø±Ø³Ø§Ù„ Ø´Ø¯.",
                              "backgroundColor": "#1D2939",
                              "textColor": "#D0D5DD",
                              "duration": 2200
                            },
                            "onRetry": {
                              "actionType": "customSnackBar",
                              "snackStyle": "infoCard",
                              "message": "Ø±Ù…Ø² Ù¾ÙˆÛŒØ§ Ø¨Ø§ Ù…ÙˆÙÙ‚ÛŒØª Ø§Ø±Ø³Ø§Ù„ Ø´Ø¯.",
                              "backgroundColor": "#1D2939",
                              "textColor": "#D0D5DD",
                              "duration": 2200
                            }
                          },
                          "type": "expanded"
                        }
                      ],
                      "type": "row"
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
              "enabledKey": "transferApiCardPaymentEnabled",
              "onPressed": {
                "actionType": "showTransferCardConfirmDialog",
                "title": "ØªØ§ÛŒÛŒØ¯ Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ú©Ø§Ø±Øª Ø¨Ù‡ Ú©Ø§Ø±Øª",
                "cardLabel": "Ú©Ø§Ø±Øª Ù…Ù‚ØµØ¯",
                "ownerNameLabel": "Ù†Ø§Ù… ØµØ§Ø­Ø¨ Ú©Ø§Ø±Øª",
                "amountLabel": "Ù…Ø¨Ù„Øº Ø§Ù†ØªÙ‚Ø§Ù„",
                "destinationCardKey": "transferApiCardDestinationNumber",
                "destinationNameKey": "transferApiCardDestinationName",
                "amountKey": "transferApiCardAmountRaw",
                "cancelText": "Ø§Ù†ØµØ±Ø§Ù",
                "confirmText": "ØªØ§ÛŒÛŒØ¯",
                "confirmAction": {
                  "routeName": "transfer_real_card_result",
                  "navigationStyle": "push",
                  "actionType": "navigate"
                }
              },
              "style": {
                "foregroundColor": "{{appColors.current.text.onPrimary}}",
                "backgroundColor": "{{appColors.current.primary.color}}",
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
                "data": "Ø§Ù†ØªÙ‚Ø§Ù„ ÙˆØ¬Ù‡",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.text.onPrimary}}",
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
      "replacement": {
        "padding": {
          "left": 16.0,
          "top": 16.0,
          "right": 16.0,
          "bottom": 21.0
        },
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
                  "topLeft": 14.0,
                  "topRight": 14.0,
                  "bottomLeft": 14.0,
                  "bottomRight": 14.0
                }
              },
              "child": {
                "crossAxisAlignment": "stretch",
                "children": [
                  {
                    "mainAxisAlignment": "spaceBetween",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "type": "registryReactive",
                        "registryKey": "transferApiTransferTypeTitle",
                        "child": {
                          "mainAxisSize": "min",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "data": "Ù…Ø¨Ù„Øº Ø§Ù†ØªÙ‚Ø§Ù„",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 18.0,
                                "fontWeight": "w700"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            {
                              "width": 4.0,
                              "type": "sizedBox"
                            },
                            {
                              "type": "text",
                              "data": "{{transferApiTransferTypeTitle}}",
                              "textDirection": "rtl",
                              "style": {
                                "type": "custom",
                                "fontSize": 18,
                                "fontWeight": "w700",
                                "color": "{{appColors.current.text.title}}"
                              }
                            }
                          ],
                          "type": "row"
                        }
                      },
                      {
                        "type": "registryReactive",
                        "registryKey": "transferApiAmountRaw",
                        "child": {
                          "mainAxisSize": "min",
                          "textDirection": "ltr",
                          "children": [
                            {
                              "data": "Ø±ÛŒØ§Ù„",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 15.0,
                                "fontWeight": "w500"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            {
                              "width": 4.0,
                              "type": "sizedBox"
                            },
                            {
                              "type": "text",
                              "data": "{{transferApiAmountRaw}}",
                              "textDirection": "ltr",
                              "textAlign": "left",
                              "style": {
                                "type": "custom",
                                "fontSize": 18,
                                "fontWeight": "w700",
                                "color": "{{appColors.current.text.title}}"
                              }
                            }
                          ],
                          "type": "row"
                        }
                      }
                    ],
                    "type": "row"
                  },
                  {
                    "height": 14.0,
                    "type": "sizedBox"
                  },
                  {
                    "height": 1.0,
                    "thickness": 1.0,
                    "color": "{{appColors.current.input.borderEnabled}}",
                    "type": "divider"
                  },
                  {
                    "height": 14.0,
                    "type": "sizedBox"
                  },
                  {
                    "crossAxisAlignment": "center",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "width": 42.0,
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
                        "type": "container"
                      },
                      {
                        "width": 10.0,
                        "type": "sizedBox"
                      },
                      {
                        "decoration": {
                          "color": "{{appColors.current.background.surfaceContainer}}",
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
                            "src": "assets/icons/ic_gardeshgari.svg",
                            "imageType": "asset",
                            "width": 24.0,
                            "height": 24.0,
                            "type": "image"
                          },
                          "type": "center"
                        },
                        "type": "container"
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
                              "data": "Ø³Ø¬Ø§Ø¯ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 18.0,
                                "fontWeight": "w600"
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
                              "data": "Û±Û±Û°.Û¹Û¹Û²Û².Û±Û·Û¹Û³Û¸ÛµÛ¸.Û±",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 17.0,
                                "fontWeight": "w700"
                              },
                              "textAlign": "right",
                              "textDirection": "ltr",
                              "type": "text"
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
                    "height": 14.0,
                    "type": "sizedBox"
                  },
                  {
                    "height": 1.0,
                    "thickness": 1.0,
                    "color": "{{appColors.current.input.borderEnabled}}",
                    "type": "divider"
                  },
                  {
                    "height": 14.0,
                    "type": "sizedBox"
                  },
                  {
                    "crossAxisAlignment": "center",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "width": 42.0,
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
                        "type": "container"
                      },
                      {
                        "width": 10.0,
                        "type": "sizedBox"
                      },
                      {
                        "decoration": {
                          "color": "{{appColors.current.background.surfaceContainer}}",
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
                            "src": "assets/icons/ic_gardeshgari.svg",
                            "imageType": "asset",
                            "width": 24.0,
                            "height": 24.0,
                            "type": "image"
                          },
                          "type": "center"
                        },
                        "type": "container"
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
                              "registryKey": "transferApiDestinationName",
                              "child": {
                                "type": "text",
                                "data": "{{transferApiDestinationName}}",
                                "textDirection": "rtl",
                                "textAlign": "right",
                                "style": {
                                  "type": "custom",
                                  "fontSize": 18,
                                  "fontWeight": "w600",
                                  "color": "{{appColors.current.text.title}}"
                                }
                              }
                            },
                            {
                              "height": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "type": "registryReactive",
                              "registryKey": "transferApiDestinationIban",
                              "child": {
                                "type": "text",
                                "data": "IR{{transferApiDestinationIban}}",
                                "textDirection": "ltr",
                                "textAlign": "right",
                                "style": {
                                  "type": "custom",
                                  "fontSize": 17,
                                  "fontWeight": "w700",
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
              "child": {
                "type": "sizedBox"
              },
              "type": "expanded"
            },
            {
              "onPressed": {
                "routeName": "transfer_real_result",
                "navigationStyle": "push",
                "actionType": "navigate"
              },
              "style": {
                "foregroundColor": "#FFFFFF",
                "backgroundColor": "#E31B2F",
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
                "data": "Ø§Ù†ØªÙ‚Ø§Ù„ ÙˆØ¬Ù‡",
                "style": {
                  "type": "custom",
                  "color": "#FFFFFF",
                  "fontSize": 18.0,
                  "fontWeight": "w700"
                },
                "type": "text"
              },
              "type": "filledButton"
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
