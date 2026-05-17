# flows/transaction_real/json/transaction_real_intro.json

Source: lib/stac/tobank/flows/transaction_real/json/transaction_real_intro.json

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
        "key": "trIntroIsTobankTab",
        "value": false
      },
      {
        "key": "trIntroChipAllSelected",
        "value": true
      },
      {
        "key": "trIntroChipWalletSelected",
        "value": false
      },
      {
        "key": "trIntroShowSuccessTx",
        "value": true
      },
      {
        "key": "trIntroShowFailedTx",
        "value": true
      },
      {
        "key": "trFilterDirectionReceive",
        "value": false
      },
      {
        "key": "trFilterDirectionSend",
        "value": false
      },
      {
        "key": "trFilterWalletTypeSelected",
        "value": false
      },
      {
        "key": "trFilterTypeGiftCard",
        "value": false
      },
      {
        "key": "trFilterTypeTransferWallet",
        "value": false
      },
      {
        "key": "trFilterTypeCardToCard",
        "value": false
      },
      {
        "key": "trFilterTypeBuyInternet",
        "value": false
      },
      {
        "key": "trFilterTypeBuyRecharge",
        "value": false
      },
      {
        "key": "trFilterTypeCharity",
        "value": false
      },
      {
        "key": "trFilterTypeWalletCharge",
        "value": false
      },
      {
        "key": "trFilterTypeBillPayment",
        "value": false
      },
      {
        "key": "trFilterTypeGroupBill",
        "value": false
      },
      {
        "key": "trFilterTypeRefund",
        "value": false
      },
      {
        "key": "trFilterTypeSafeBox",
        "value": false
      },
      {
        "key": "trFilterStatusSuccessSelected",
        "value": false
      },
      {
        "key": "trFilterStatusFailedSelected",
        "value": false
      },
      {
        "key": "trFilterStatusNoLimit",
        "value": true
      }
    ]
  },
  "child": {
    "backgroundColor": "{{appColors.current.background.surface}}",
    "body": {
      "crossAxisAlignment": "stretch",
      "children": [
        {
          "height": 65.0,
          "type": "sizedBox"
        },
        {
          "decoration": {
            "color": "{{appColors.current.background.surfaceContainer}}",
            "borderRadius": {
              "topLeft": 12.0,
              "topRight": 12.0,
              "bottomLeft": 12.0,
              "bottomRight": 12.0
            }
          },
          "margin": {
            "left": 20.0,
            "top": 10.0,
            "right": 20.0,
            "bottom": 10.0
          },
          "child": {
            "textDirection": "rtl",
            "children": [
              {
                "child": {
                  "child": {
                    "color": "transparent",
                    "width": 999999.0,
                    "height": 54.0,
                    "child": {
                      "mainAxisAlignment": "center",
                      "children": [
                        {
                          "type": "visibility",
                          "visible": "[[trIntroIsTobankTab]]",
                          "child": {
                            "data": "ØªÙˆØ¨Ø§Ù†Ú©",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 16.0,
                              "fontWeight": "w800"
                            },
                            "textAlign": "center",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "replacement": {
                            "data": "ØªÙˆØ¨Ø§Ù†Ú©",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.hint}}",
                              "fontSize": 16.0,
                              "fontWeight": "w500"
                            },
                            "textAlign": "center",
                            "textDirection": "rtl",
                            "type": "text"
                          }
                        },
                        {
                          "height": 8.0,
                          "type": "sizedBox"
                        },
                        {
                          "type": "visibility",
                          "visible": "[[trIntroIsTobankTab]]",
                          "child": {
                            "decoration": {
                              "color": "{{appColors.current.primary.color}}",
                              "borderRadius": {
                                "topLeft": 3.0,
                                "topRight": 3.0,
                                "bottomLeft": 3.0,
                                "bottomRight": 3.0
                              }
                            },
                            "width": 56.0,
                            "height": 3.0,
                            "type": "container"
                          },
                          "replacement": {
                            "color": "transparent",
                            "width": 56.0,
                            "height": 3.0,
                            "type": "container"
                          }
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "setValue",
                    "key": "trIntroIsTobankTab",
                    "value": true
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              },
              {
                "color": "{{appColors.current.input.borderEnabled}}",
                "width": 1.0,
                "height": 25.0,
                "type": "container"
              },
              {
                "child": {
                  "child": {
                    "color": "transparent",
                    "width": 999999.0,
                    "height": 54.0,
                    "child": {
                      "mainAxisAlignment": "center",
                      "children": [
                        {
                          "type": "visibility",
                          "visible": "[[!trIntroIsTobankTab]]",
                          "child": {
                            "data": "Ø³Ù¾Ø±Ø¯Ù‡â€ŒÙ‡Ø§",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 16.0,
                              "fontWeight": "w800"
                            },
                            "textAlign": "center",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "replacement": {
                            "data": "Ø³Ù¾Ø±Ø¯Ù‡â€ŒÙ‡Ø§",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.hint}}",
                              "fontSize": 16.0,
                              "fontWeight": "w500"
                            },
                            "textAlign": "center",
                            "textDirection": "rtl",
                            "type": "text"
                          }
                        },
                        {
                          "height": 8.0,
                          "type": "sizedBox"
                        },
                        {
                          "type": "visibility",
                          "visible": "[[!trIntroIsTobankTab]]",
                          "child": {
                            "decoration": {
                              "color": "{{appColors.current.primary.color}}",
                              "borderRadius": {
                                "topLeft": 3.0,
                                "topRight": 3.0,
                                "bottomLeft": 3.0,
                                "bottomRight": 3.0
                              }
                            },
                            "width": 56.0,
                            "height": 3.0,
                            "type": "container"
                          },
                          "replacement": {
                            "color": "transparent",
                            "width": 56.0,
                            "height": 3.0,
                            "type": "container"
                          }
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "setValue",
                    "key": "trIntroIsTobankTab",
                    "value": false
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              }
            ],
            "type": "row"
          },
          "type": "container"
        },
        {
          "child": {
            "padding": {
              "left": 14.0,
              "right": 14.0
            },
            "child": {
              "type": "visibility",
              "visible": "[[trIntroIsTobankTab]]",
              "child": {
                "child": {
                  "crossAxisAlignment": "stretch",
                  "children": [
                    {
                      "height": 14.0,
                      "type": "sizedBox"
                    },
                    {
                      "textDirection": "rtl",
                      "children": [
                        {
                          "child": {
                            "padding": {
                              "left": 12.0,
                              "right": 12.0
                            },
                            "decoration": {
                              "color": "transparent",
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
                            "height": 36.0,
                            "child": {
                              "mainAxisAlignment": "center",
                              "textDirection": "rtl",
                              "children": [
                                {
                                  "icon": "tune",
                                  "iconType": "material",
                                  "size": 16.0,
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "type": "icon"
                                },
                                {
                                  "width": 6.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "data": "ÙÛŒÙ„ØªØ±Ù‡Ø§",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 14.0,
                                    "fontWeight": "w600"
                                  },
                                  "type": "text"
                                }
                              ],
                              "type": "row"
                            },
                            "type": "container"
                          },
                          "onTap": {
                            "routeName": "transaction_real_filter",
                            "navigationStyle": "push",
                            "actionType": "navigate"
                          },
                          "type": "gestureDetector"
                        },
                        {
                          "width": 6.0,
                          "type": "sizedBox"
                        },
                        {
                          "color": "{{appColors.current.input.borderEnabled}}",
                          "width": 1.0,
                          "height": 25.0,
                          "type": "container"
                        },
                        {
                          "width": 6.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "type": "visibility",
                            "visible": "[[trIntroChipAllSelected]]",
                            "child": {
                              "padding": {
                                "left": 12.0,
                                "right": 12.0
                              },
                              "decoration": {
                                "color": "{{appColors.current.secondary.secondaryContainer}}",
                                "border": {
                                  "color": "{{appColors.current.secondary.color}}",
                                  "width": 1.0
                                },
                                "borderRadius": {
                                  "topLeft": 8.0,
                                  "topRight": 8.0,
                                  "bottomLeft": 8.0,
                                  "bottomRight": 8.0
                                }
                              },
                              "height": 36.0,
                              "child": {
                                "child": {
                                  "data": "Ù‡Ù…Ù‡",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.secondary.color}}",
                                    "fontSize": 14.0,
                                    "fontWeight": "w600"
                                  },
                                  "textAlign": "center",
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                "type": "center"
                              },
                              "type": "container"
                            },
                            "replacement": {
                              "padding": {
                                "left": 12.0,
                                "right": 12.0
                              },
                              "decoration": {
                                "color": "transparent",
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
                              "height": 36.0,
                              "child": {
                                "child": {
                                  "data": "Ù‡Ù…Ù‡",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 14.0,
                                    "fontWeight": "w600"
                                  },
                                  "textAlign": "center",
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                "type": "center"
                              },
                              "type": "container"
                            }
                          },
                          "onTap": {
                            "actionType": "setValue",
                            "values": [
                              {
                                "key": "trIntroChipAllSelected",
                                "value": true
                              },
                              {
                                "key": "trIntroChipWalletSelected",
                                "value": false
                              },
                              {
                                "key": "trIntroShowSuccessTx",
                                "value": true
                              },
                              {
                                "key": "trIntroShowFailedTx",
                                "value": true
                              }
                            ]
                          },
                          "type": "gestureDetector"
                        },
                        {
                          "width": 8.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "type": "visibility",
                            "visible": "[[trIntroChipWalletSelected]]",
                            "child": {
                              "padding": {
                                "left": 12.0,
                                "right": 12.0
                              },
                              "decoration": {
                                "color": "{{appColors.current.secondary.secondaryContainer}}",
                                "border": {
                                  "color": "{{appColors.current.secondary.color}}",
                                  "width": 1.0
                                },
                                "borderRadius": {
                                  "topLeft": 8.0,
                                  "topRight": 8.0,
                                  "bottomLeft": 8.0,
                                  "bottomRight": 8.0
                                }
                              },
                              "height": 36.0,
                              "child": {
                                "child": {
                                  "data": "ØªØ±Ø§Ú©Ù†Ø´ Ù‡Ø§ÛŒ Ú©ÛŒÙ Ù¾ÙˆÙ„",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.secondary.color}}",
                                    "fontSize": 14.0,
                                    "fontWeight": "w600"
                                  },
                                  "textAlign": "center",
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                "type": "center"
                              },
                              "type": "container"
                            },
                            "replacement": {
                              "padding": {
                                "left": 12.0,
                                "right": 12.0
                              },
                              "decoration": {
                                "color": "transparent",
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
                              "height": 36.0,
                              "child": {
                                "child": {
                                  "data": "ØªØ±Ø§Ú©Ù†Ø´ Ù‡Ø§ÛŒ Ú©ÛŒÙ Ù¾ÙˆÙ„",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 14.0,
                                    "fontWeight": "w600"
                                  },
                                  "textAlign": "center",
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                "type": "center"
                              },
                              "type": "container"
                            }
                          },
                          "onTap": {
                            "actionType": "setValue",
                            "values": [
                              {
                                "key": "trIntroChipAllSelected",
                                "value": false
                              },
                              {
                                "key": "trIntroChipWalletSelected",
                                "value": true
                              }
                            ]
                          },
                          "type": "gestureDetector"
                        }
                      ],
                      "type": "row"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "type": "visibility",
                      "visible": "[[trIntroChipAllSelected]]",
                      "child": {
                        "children": [
                          {
                            "type": "visibility",
                            "visible": "[[trIntroShowSuccessTx]]",
                            "child": {
                              "children": [
                                {
                                  "padding": {
                                    "left": 14.0,
                                    "top": 14.0,
                                    "right": 14.0,
                                    "bottom": 14.0
                                  },
                                  "decoration": {
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ø§Ù‚Ø³Ø§Ø·",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Û±,Û°Û°Û¶,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "Û°Û± ÙØ±ÙˆØ±Ø¯ÛŒÙ† Û±Û´Û°Ûµ - Û±Û±:Û´Û³",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                },
                                {
                                  "height": 10.0,
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
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "Ø³Ø±ÙˆÛŒØ³ Ú©Ø§Ø±Ù…Ø²Ø¯ Ø³ÙØªÙ‡",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Û³Û¸,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "Û°Û² Ø§Ø³ÙÙ†Ø¯ Û±Û´Û°Û´ - Û±Ûµ:Û²Û·",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                },
                                {
                                  "height": 10.0,
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
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "Ú©Ø§Ø±Øª Ø¨Ù‡ Ú©Ø§Ø±Øª",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Û±Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "Û°Û¶ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û±:Û°Û²",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                },
                                {
                                  "height": 10.0,
                                  "type": "sizedBox"
                                }
                              ],
                              "type": "column"
                            },
                            "replacement": {
                              "type": "sizedBox"
                            }
                          },
                          {
                            "type": "visibility",
                            "visible": "[[trIntroShowFailedTx]]",
                            "child": {
                              "children": [
                                {
                                  "padding": {
                                    "left": 14.0,
                                    "top": 14.0,
                                    "right": 14.0,
                                    "bottom": 14.0
                                  },
                                  "decoration": {
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemFailedCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "Ø³Ø±ÙˆÛŒØ³ Ú©Ø§Ø±Ù…Ø²Ø¯ Ø³ÙØªÙ‡",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Û³Û±Û³,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "ÛµÛ¸ Ø¨Ù‡Ù…Ù† Û±Û´Û°Û´ - Û±Û°:Û°Ûµ",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                },
                                {
                                  "height": 10.0,
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
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemFailedCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "Ø´Ø§Ø±Ú˜ Ú©ÛŒÙ Ù¾ÙˆÙ„ ØªÙˆØ¨Ø§Ù†Ú©",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "ÛµÛ°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "ÛµÛ¸ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û´:Û°Û³",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                },
                                {
                                  "height": 10.0,
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
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemFailedCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "Ú©Ø§Ø±Øª Ø¨Ù‡ Ú©Ø§Ø±Øª",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Û±Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "Û°Û¶ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Ûµ:Û°Û¸",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                }
                              ],
                              "type": "column"
                            },
                            "replacement": {
                              "type": "sizedBox"
                            }
                          }
                        ],
                        "type": "column"
                      },
                      "replacement": {
                        "type": "sizedBox"
                      }
                    },
                    {
                      "type": "visibility",
                      "visible": "[[trIntroChipWalletSelected]]",
                      "child": {
                        "children": [
                          {
                            "type": "visibility",
                            "visible": "[[trIntroShowSuccessTx]]",
                            "child": {
                              "children": [
                                {
                                  "padding": {
                                    "left": 14.0,
                                    "top": 14.0,
                                    "right": 14.0,
                                    "bottom": 14.0
                                  },
                                  "decoration": {
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "ØªØ±Ø§Ú©Ù†Ø´ Ú©ÛŒÙ Ù¾ÙˆÙ„",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Û±Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "Û°Û³ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û³:Û³Û°",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                },
                                {
                                  "height": 10.0,
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
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "Ø³Ø±ÙˆÛŒØ³ Ø§Ø¹ØªØ¨Ø§Ø±Ø³Ù†Ø¬ÛŒ",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Û¸,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "Û°Û± Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û²:Û°Û±",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                },
                                {
                                  "height": 10.0,
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
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "Ø³Ø±ÙˆÛŒØ³ Ø§Ø¹ØªØ¨Ø§Ø±Ø³Ù†Ø¬ÛŒ",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Û¸Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "Û²Û¶ Ø¢Ø°Ø± Û±Û´Û°Û´ - Û±Û±:Û±Û¶",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                },
                                {
                                  "height": 10.0,
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
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "Ø³ÙØ§Ø±Ø´ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Û±,Û³Û¶Û¸,ÛµÛ°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "Û²Û¶ Ø¢Ø°Ø± Û±Û´Û°Û´ - Û±Û±:ÛµÛ°",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                },
                                {
                                  "height": 10.0,
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
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "ØªØ±Ø§Ú©Ù†Ø´ Ú©ÛŒÙ Ù¾ÙˆÙ„",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Û±,Û´Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "Û²Û¶ Ø¢Ø°Ø± Û±Û´Û°Û´ - Û±Û±:Û´Û°",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                },
                                {
                                  "height": 10.0,
                                  "type": "sizedBox"
                                }
                              ],
                              "type": "column"
                            },
                            "replacement": {
                              "type": "sizedBox"
                            }
                          },
                          {
                            "type": "visibility",
                            "visible": "[[trIntroShowFailedTx]]",
                            "child": {
                              "children": [
                                {
                                  "padding": {
                                    "left": 14.0,
                                    "top": 14.0,
                                    "right": 14.0,
                                    "bottom": 14.0
                                  },
                                  "decoration": {
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemFailedCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "Ø´Ø§Ø±Ú˜ Ú©ÛŒÙ Ù¾ÙˆÙ„ ØªÙˆØ¨Ø§Ù†Ú©",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "ÛµÛ°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "Û°Û¸ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û´:Û°Û³",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                },
                                {
                                  "height": 10.0,
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
                                    "color": "transparent",
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
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "width": 28.0,
                                        "height": 28.0,
                                        "child": {
                                          "src": "{{appAssets.icons.transactionItemFailedCurrent}}",
                                          "imageType": "asset",
                                          "width": 28.0,
                                          "height": 28.0,
                                          "type": "image"
                                        },
                                        "type": "sizedBox"
                                      },
                                      {
                                        "width": 12.0,
                                        "type": "sizedBox"
                                      },
                                      {
                                        "child": {
                                          "crossAxisAlignment": "stretch",
                                          "children": [
                                            {
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "child": {
                                                    "data": "Ø§Ù†ØªÙ‚Ø§Ù„ Ú©ÛŒÙ Ù¾ÙˆÙ„",
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
                                                  "width": 12.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Û²Ûµ,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 16.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            },
                                            {
                                              "height": 8.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "data": "Û°Û¸ Ø¯ÛŒ Û±Û´Û°Û´ - Û±Û°:Û±Û¶",
                                              "style": {
                                                "type": "custom",
                                                "color": "{{appColors.current.text.subtitle}}",
                                                "fontSize": 13.0,
                                                "fontWeight": "w500"
                                              },
                                              "textAlign": "right",
                                              "textDirection": "rtl",
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
                                  "type": "container"
                                }
                              ],
                              "type": "column"
                            },
                            "replacement": {
                              "type": "sizedBox"
                            }
                          }
                        ],
                        "type": "column"
                      },
                      "replacement": {
                        "type": "sizedBox"
                      }
                    },
                    {
                      "height": 10.0,
                      "type": "sizedBox"
                    }
                  ],
                  "type": "column"
                },
                "type": "singleChildScrollView"
              },
              "replacement": {
                "child": {
                  "children": [
                    {
                      "height": 14.0,
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
                        "color": "transparent",
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
                        "textDirection": "rtl",
                        "children": [
                          {
                            "width": 28.0,
                            "height": 28.0,
                            "child": {
                              "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                              "imageType": "asset",
                              "width": 28.0,
                              "height": 28.0,
                              "type": "image"
                            },
                            "type": "sizedBox"
                          },
                          {
                            "width": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "child": {
                              "crossAxisAlignment": "stretch",
                              "children": [
                                {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "child": {
                                        "data": "Ù¾Ù„",
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
                                      "width": 12.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "Û²Û¹Û¹,Û¹Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textAlign": "left",
                                      "textDirection": "rtl",
                                      "type": "text"
                                    }
                                  ],
                                  "type": "row"
                                },
                                {
                                  "height": 8.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "data": "Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 13.0,
                                    "fontWeight": "w500"
                                  },
                                  "textAlign": "right",
                                  "textDirection": "rtl",
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
                      "type": "container"
                    },
                    {
                      "height": 10.0,
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
                        "color": "transparent",
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
                        "textDirection": "rtl",
                        "children": [
                          {
                            "width": 28.0,
                            "height": 28.0,
                            "child": {
                              "src": "{{appAssets.icons.transactionItemFailedCurrent}}",
                              "imageType": "asset",
                              "width": 28.0,
                              "height": 28.0,
                              "type": "image"
                            },
                            "type": "sizedBox"
                          },
                          {
                            "width": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "child": {
                              "crossAxisAlignment": "stretch",
                              "children": [
                                {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "child": {
                                        "data": "Ù¾Ù„",
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
                                      "width": 12.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ°Û°,Û°Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textAlign": "left",
                                      "textDirection": "rtl",
                                      "type": "text"
                                    }
                                  ],
                                  "type": "row"
                                },
                                {
                                  "height": 8.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "data": "Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 13.0,
                                    "fontWeight": "w500"
                                  },
                                  "textAlign": "right",
                                  "textDirection": "rtl",
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
                      "type": "container"
                    },
                    {
                      "height": 10.0,
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
                        "color": "transparent",
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
                        "textDirection": "rtl",
                        "children": [
                          {
                            "width": 28.0,
                            "height": 28.0,
                            "child": {
                              "src": "{{appAssets.icons.transactionItemFailedCurrent}}",
                              "imageType": "asset",
                              "width": 28.0,
                              "height": 28.0,
                              "type": "image"
                            },
                            "type": "sizedBox"
                          },
                          {
                            "width": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "child": {
                              "crossAxisAlignment": "stretch",
                              "children": [
                                {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "child": {
                                        "data": "Ù¾Ù„",
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
                                      "width": 12.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ°Û°,Û°Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textAlign": "left",
                                      "textDirection": "rtl",
                                      "type": "text"
                                    }
                                  ],
                                  "type": "row"
                                },
                                {
                                  "height": 8.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "data": "Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 13.0,
                                    "fontWeight": "w500"
                                  },
                                  "textAlign": "right",
                                  "textDirection": "rtl",
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
                      "type": "container"
                    },
                    {
                      "height": 10.0,
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
                        "color": "transparent",
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
                        "textDirection": "rtl",
                        "children": [
                          {
                            "width": 28.0,
                            "height": 28.0,
                            "child": {
                              "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                              "imageType": "asset",
                              "width": 28.0,
                              "height": 28.0,
                              "type": "image"
                            },
                            "type": "sizedBox"
                          },
                          {
                            "width": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "child": {
                              "crossAxisAlignment": "stretch",
                              "children": [
                                {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "child": {
                                        "data": "Ù¾Ù„",
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
                                      "width": 12.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "Û±Û°,ÛµÛ°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textAlign": "left",
                                      "textDirection": "rtl",
                                      "type": "text"
                                    }
                                  ],
                                  "type": "row"
                                },
                                {
                                  "height": 8.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "data": "Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 13.0,
                                    "fontWeight": "w500"
                                  },
                                  "textAlign": "right",
                                  "textDirection": "rtl",
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
                      "type": "container"
                    },
                    {
                      "height": 10.0,
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
                        "color": "transparent",
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
                        "textDirection": "rtl",
                        "children": [
                          {
                            "width": 28.0,
                            "height": 28.0,
                            "child": {
                              "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                              "imageType": "asset",
                              "width": 28.0,
                              "height": 28.0,
                              "type": "image"
                            },
                            "type": "sizedBox"
                          },
                          {
                            "width": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "child": {
                              "crossAxisAlignment": "stretch",
                              "children": [
                                {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "child": {
                                        "data": "Ù¾Ø§ÛŒØ§",
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
                                      "width": 12.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ´Û³,Û¸Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textAlign": "left",
                                      "textDirection": "rtl",
                                      "type": "text"
                                    }
                                  ],
                                  "type": "row"
                                },
                                {
                                  "height": 8.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "data": "Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 13.0,
                                    "fontWeight": "w500"
                                  },
                                  "textAlign": "right",
                                  "textDirection": "rtl",
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
                      "type": "container"
                    },
                    {
                      "height": 10.0,
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
                        "color": "transparent",
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
                        "textDirection": "rtl",
                        "children": [
                          {
                            "width": 28.0,
                            "height": 28.0,
                            "child": {
                              "src": "{{appAssets.icons.transactionItemFailedCurrent}}",
                              "imageType": "asset",
                              "width": 28.0,
                              "height": 28.0,
                              "type": "image"
                            },
                            "type": "sizedBox"
                          },
                          {
                            "width": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "child": {
                              "crossAxisAlignment": "stretch",
                              "children": [
                                {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "child": {
                                        "data": "Ù¾Ø§ÛŒØ§",
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
                                      "width": 12.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ´Û³,Û¹Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textAlign": "left",
                                      "textDirection": "rtl",
                                      "type": "text"
                                    }
                                  ],
                                  "type": "row"
                                },
                                {
                                  "height": 8.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "data": "Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯Ù¾ÙˆØ±",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 13.0,
                                    "fontWeight": "w500"
                                  },
                                  "textAlign": "right",
                                  "textDirection": "rtl",
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
                      "type": "container"
                    },
                    {
                      "height": 10.0,
                      "type": "sizedBox"
                    }
                  ],
                  "type": "column"
                },
                "type": "singleChildScrollView"
              }
            },
            "type": "padding"
          },
          "type": "expanded"
        }
      ],
      "type": "column"
    },
    "type": "scaffold"
  }
}
```
