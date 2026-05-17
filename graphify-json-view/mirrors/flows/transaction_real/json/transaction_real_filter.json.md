# flows/transaction_real/json/transaction_real_filter.json

Source: lib/stac/tobank/flows/transaction_real/json/transaction_real_filter.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "type": "stateFull",
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
        "data": "ÙÛŒÙ„ØªØ± ØªØ±Ø§Ú©Ù†Ø´â€ŒÙ‡Ø§",
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
            "height": 6.0,
            "type": "sizedBox"
          },
          {
            "type": "visibility",
            "visible": "[[trIntroChipWalletSelected]]",
            "child": {
              "children": [
                {
                  "mainAxisAlignment": "start",
                  "textDirection": "rtl",
                  "children": [
                    {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterDirectionReceive]]",
                        "child": {
                          "padding": {
                            "left": 8.0,
                            "right": 8.0
                          },
                          "decoration": {
                            "color": "{{appColors.current.success.color}}",
                            "border": {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 0.7
                            },
                            "borderRadius": {
                              "topLeft": 8.0,
                              "topRight": 8.0,
                              "bottomLeft": 8.0,
                              "bottomRight": 8.0
                            }
                          },
                          "width": 120.0,
                          "height": 36.0,
                          "child": {
                            "mainAxisAlignment": "center",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "icon": "south",
                                "iconType": "material",
                                "size": 16.0,
                                "color": "{{appColors.current.text.onPrimary}}",
                                "type": "icon"
                              },
                              {
                                "width": 6.0,
                                "type": "sizedBox"
                              },
                              {
                                "data": "Ø¯Ø±ÛŒØ§ÙØª ÙˆØ¬Ù‡",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.onPrimary}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "textDirection": "rtl",
                                "type": "text"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "container"
                        },
                        "replacement": {
                          "padding": {
                            "left": 8.0,
                            "right": 8.0
                          },
                          "decoration": {
                            "color": "transparent",
                            "border": {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 0.7
                            },
                            "borderRadius": {
                              "topLeft": 8.0,
                              "topRight": 8.0,
                              "bottomLeft": 8.0,
                              "bottomRight": 8.0
                            }
                          },
                          "width": 120.0,
                          "height": 36.0,
                          "child": {
                            "mainAxisAlignment": "center",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "icon": "south",
                                "iconType": "material",
                                "size": 16.0,
                                "color": "{{appColors.current.text.hint}}",
                                "type": "icon"
                              },
                              {
                                "width": 6.0,
                                "type": "sizedBox"
                              },
                              {
                                "data": "Ø¯Ø±ÛŒØ§ÙØª ÙˆØ¬Ù‡",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "textDirection": "rtl",
                                "type": "text"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "container"
                        }
                      },
                      "onTap": {
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "setValue",
                            "key": "trFilterDirectionReceive",
                            "value": "{{!trFilterDirectionReceive}}"
                          },
                          {
                            "actionType": "setValue",
                            "key": "trFilterDirectionSend",
                            "value": false
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
                        "visible": "[[trFilterDirectionSend]]",
                        "child": {
                          "padding": {
                            "left": 8.0,
                            "right": 8.0
                          },
                          "decoration": {
                            "color": "{{appColors.current.warning.color}}",
                            "border": {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 0.7
                            },
                            "borderRadius": {
                              "topLeft": 8.0,
                              "topRight": 8.0,
                              "bottomLeft": 8.0,
                              "bottomRight": 8.0
                            }
                          },
                          "width": 120.0,
                          "height": 36.0,
                          "child": {
                            "mainAxisAlignment": "center",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "icon": "north",
                                "iconType": "material",
                                "size": 16.0,
                                "color": "{{appColors.current.text.onPrimary}}",
                                "type": "icon"
                              },
                              {
                                "width": 6.0,
                                "type": "sizedBox"
                              },
                              {
                                "data": "Ø§Ø±Ø³Ø§Ù„ ÙˆØ¬Ù‡",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.onPrimary}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "textDirection": "rtl",
                                "type": "text"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "container"
                        },
                        "replacement": {
                          "padding": {
                            "left": 8.0,
                            "right": 8.0
                          },
                          "decoration": {
                            "color": "transparent",
                            "border": {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 0.7
                            },
                            "borderRadius": {
                              "topLeft": 8.0,
                              "topRight": 8.0,
                              "bottomLeft": 8.0,
                              "bottomRight": 8.0
                            }
                          },
                          "width": 120.0,
                          "height": 36.0,
                          "child": {
                            "mainAxisAlignment": "center",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "icon": "north",
                                "iconType": "material",
                                "size": 16.0,
                                "color": "{{appColors.current.text.hint}}",
                                "type": "icon"
                              },
                              {
                                "width": 6.0,
                                "type": "sizedBox"
                              },
                              {
                                "data": "Ø§Ø±Ø³Ø§Ù„ ÙˆØ¬Ù‡",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "textDirection": "rtl",
                                "type": "text"
                              }
                            ],
                            "type": "row"
                          },
                          "type": "container"
                        }
                      },
                      "onTap": {
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "setValue",
                            "key": "trFilterDirectionSend",
                            "value": "{{!trFilterDirectionSend}}"
                          },
                          {
                            "actionType": "setValue",
                            "key": "trFilterDirectionReceive",
                            "value": false
                          }
                        ]
                      },
                      "type": "gestureDetector"
                    }
                  ],
                  "type": "row"
                },
                {
                  "height": 18.0,
                  "type": "sizedBox"
                }
              ],
              "type": "column"
            },
            "replacement": {
              "height": 2.0,
              "type": "sizedBox"
            }
          },
          {
            "data": "Ø¨Ø§Ø²Ù‡ Ø²Ù…Ø§Ù†ÛŒ",
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
            "height": 12.0,
            "type": "sizedBox"
          },
          {
            "textDirection": "rtl",
            "children": [
              {
                "child": {
                  "child": {
                    "padding": {
                      "left": 14.0,
                      "right": 14.0
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
                    "height": 52.0,
                    "child": {
                      "textDirection": "ltr",
                      "children": [
                        {
                          "src": "{{appAssets.icons.calendar}}",
                          "imageType": "asset",
                          "color": "{{appColors.current.secondary.color}}",
                          "width": 20.0,
                          "height": 20.0,
                          "type": "image"
                        },
                        {
                          "width": 8.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "type": "registryReactive",
                            "registryKey": "form.trFilterFromDate",
                            "child": {
                              "data": "Ø§Ø² ØªØ§Ø±ÛŒØ®",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 16.0,
                                "fontWeight": "w600"
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
                    "actionType": "persianDatePicker",
                    "formFieldId": "trFilterFromDate",
                    "firstDate": "1400/01/01",
                    "lastDate": "1450/12/29",
                    "includeTime": true
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              },
              {
                "width": 10.0,
                "type": "sizedBox"
              },
              {
                "child": {
                  "child": {
                    "padding": {
                      "left": 14.0,
                      "right": 14.0
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
                    "height": 52.0,
                    "child": {
                      "textDirection": "ltr",
                      "children": [
                        {
                          "src": "{{appAssets.icons.calendar}}",
                          "imageType": "asset",
                          "color": "{{appColors.current.secondary.color}}",
                          "width": 20.0,
                          "height": 20.0,
                          "type": "image"
                        },
                        {
                          "width": 8.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "type": "registryReactive",
                            "registryKey": "form.trFilterToDate",
                            "child": {
                              "data": "ØªØ§ ØªØ§Ø±ÛŒØ®",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 16.0,
                                "fontWeight": "w600"
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
                    "actionType": "persianDatePicker",
                    "formFieldId": "trFilterToDate",
                    "firstDate": "1400/01/01",
                    "lastDate": "1450/12/29",
                    "includeTime": true
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              }
            ],
            "type": "row"
          },
          {
            "height": 20.0,
            "type": "sizedBox"
          },
          {
            "data": "Ù†ÙˆØ¹ ØªØ±Ø§Ú©Ù†Ø´",
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
            "height": 12.0,
            "type": "sizedBox"
          },
          {
            "children": [
              {
                "textDirection": "rtl",
                "children": [
                  {
                    "child": {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterTypeGiftCard]]",
                        "child": {
                          "decoration": {
                            "color": "{{appColors.current.secondary.color}}",
                            "borderRadius": {
                              "topLeft": 6.0,
                              "topRight": 6.0,
                              "bottomLeft": 6.0,
                              "bottomRight": 6.0
                            }
                          },
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø®Ø±ÛŒØ¯ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.onPrimary}}",
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
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø®Ø±ÛŒØ¯ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500"
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
                        "key": "trFilterTypeGiftCard",
                        "value": "{{!trFilterTypeGiftCard}}"
                      },
                      "type": "gestureDetector"
                    },
                    "type": "expanded"
                  },
                  {
                    "width": 8.0,
                    "type": "sizedBox"
                  },
                  {
                    "child": {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterTypeTransferWallet]]",
                        "child": {
                          "decoration": {
                            "color": "{{appColors.current.secondary.color}}",
                            "borderRadius": {
                              "topLeft": 6.0,
                              "topRight": 6.0,
                              "bottomLeft": 6.0,
                              "bottomRight": 6.0
                            }
                          },
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø§Ù†ØªÙ‚Ø§Ù„ Ú©ÛŒÙ Ù¾ÙˆÙ„",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.onPrimary}}",
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
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø§Ù†ØªÙ‚Ø§Ù„ Ú©ÛŒÙ Ù¾ÙˆÙ„",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500"
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
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "setValue",
                            "key": "trFilterTypeTransferWallet",
                            "value": "{{!trFilterTypeTransferWallet}}"
                          },
                          {
                            "actionType": "setValue",
                            "key": "trFilterWalletTypeSelected",
                            "value": "{{trFilterTypeTransferWallet}}"
                          }
                        ]
                      },
                      "type": "gestureDetector"
                    },
                    "type": "expanded"
                  },
                  {
                    "width": 8.0,
                    "type": "sizedBox"
                  },
                  {
                    "child": {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterTypeCardToCard]]",
                        "child": {
                          "decoration": {
                            "color": "{{appColors.current.secondary.color}}",
                            "borderRadius": {
                              "topLeft": 6.0,
                              "topRight": 6.0,
                              "bottomLeft": 6.0,
                              "bottomRight": 6.0
                            }
                          },
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ú©Ø§Ø±Øª Ø¨Ù‡ Ú©Ø§Ø±Øª",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.onPrimary}}",
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
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ú©Ø§Ø±Øª Ø¨Ù‡ Ú©Ø§Ø±Øª",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500"
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
                        "key": "trFilterTypeCardToCard",
                        "value": "{{!trFilterTypeCardToCard}}"
                      },
                      "type": "gestureDetector"
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
                "textDirection": "rtl",
                "children": [
                  {
                    "child": {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterTypeBuyInternet]]",
                        "child": {
                          "decoration": {
                            "color": "{{appColors.current.secondary.color}}",
                            "borderRadius": {
                              "topLeft": 6.0,
                              "topRight": 6.0,
                              "bottomLeft": 6.0,
                              "bottomRight": 6.0
                            }
                          },
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø®Ø±ÛŒØ¯ Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†ØªÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.onPrimary}}",
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
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø®Ø±ÛŒØ¯ Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†ØªÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500"
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
                        "key": "trFilterTypeBuyInternet",
                        "value": "{{!trFilterTypeBuyInternet}}"
                      },
                      "type": "gestureDetector"
                    },
                    "type": "expanded"
                  },
                  {
                    "width": 8.0,
                    "type": "sizedBox"
                  },
                  {
                    "child": {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterTypeBuyRecharge]]",
                        "child": {
                          "decoration": {
                            "color": "{{appColors.current.secondary.color}}",
                            "borderRadius": {
                              "topLeft": 6.0,
                              "topRight": 6.0,
                              "bottomLeft": 6.0,
                              "bottomRight": 6.0
                            }
                          },
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø®Ø±ÛŒØ¯ Ø´Ø§Ø±Ú˜ Ù…Ø³ØªÙ‚ÛŒÙ…",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.onPrimary}}",
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
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø®Ø±ÛŒØ¯ Ø´Ø§Ø±Ú˜ Ù…Ø³ØªÙ‚ÛŒÙ…",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500"
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
                        "key": "trFilterTypeBuyRecharge",
                        "value": "{{!trFilterTypeBuyRecharge}}"
                      },
                      "type": "gestureDetector"
                    },
                    "type": "expanded"
                  },
                  {
                    "width": 8.0,
                    "type": "sizedBox"
                  },
                  {
                    "child": {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterTypeCharity]]",
                        "child": {
                          "decoration": {
                            "color": "{{appColors.current.secondary.color}}",
                            "borderRadius": {
                              "topLeft": 6.0,
                              "topRight": 6.0,
                              "bottomLeft": 6.0,
                              "bottomRight": 6.0
                            }
                          },
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ù†ÛŒÚ©ÙˆÚ©Ø§Ø±ÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.onPrimary}}",
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
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ù†ÛŒÚ©ÙˆÚ©Ø§Ø±ÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500"
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
                        "key": "trFilterTypeCharity",
                        "value": "{{!trFilterTypeCharity}}"
                      },
                      "type": "gestureDetector"
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
                "textDirection": "rtl",
                "children": [
                  {
                    "child": {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterTypeWalletCharge]]",
                        "child": {
                          "decoration": {
                            "color": "{{appColors.current.secondary.color}}",
                            "borderRadius": {
                              "topLeft": 6.0,
                              "topRight": 6.0,
                              "bottomLeft": 6.0,
                              "bottomRight": 6.0
                            }
                          },
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø´Ø§Ø±Ú˜ Ú©ÛŒÙ Ù¾ÙˆÙ„",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.onPrimary}}",
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
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø´Ø§Ø±Ú˜ Ú©ÛŒÙ Ù¾ÙˆÙ„",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500"
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
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "setValue",
                            "key": "trFilterTypeWalletCharge",
                            "value": "{{!trFilterTypeWalletCharge}}"
                          },
                          {
                            "actionType": "setValue",
                            "key": "trFilterWalletTypeSelected",
                            "value": "{{trFilterTypeWalletCharge}}"
                          }
                        ]
                      },
                      "type": "gestureDetector"
                    },
                    "type": "expanded"
                  },
                  {
                    "width": 8.0,
                    "type": "sizedBox"
                  },
                  {
                    "child": {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterTypeBillPayment]]",
                        "child": {
                          "decoration": {
                            "color": "{{appColors.current.secondary.color}}",
                            "borderRadius": {
                              "topLeft": 6.0,
                              "topRight": 6.0,
                              "bottomLeft": 6.0,
                              "bottomRight": 6.0
                            }
                          },
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ù‚Ø¨ÙˆØ¶",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.onPrimary}}",
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
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ù‚Ø¨ÙˆØ¶",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500"
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
                        "key": "trFilterTypeBillPayment",
                        "value": "{{!trFilterTypeBillPayment}}"
                      },
                      "type": "gestureDetector"
                    },
                    "type": "expanded"
                  },
                  {
                    "width": 8.0,
                    "type": "sizedBox"
                  },
                  {
                    "child": {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterTypeGroupBill]]",
                        "child": {
                          "decoration": {
                            "color": "{{appColors.current.secondary.color}}",
                            "borderRadius": {
                              "topLeft": 6.0,
                              "topRight": 6.0,
                              "bottomLeft": 6.0,
                              "bottomRight": 6.0
                            }
                          },
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ú¯Ø±ÙˆÙ‡ÛŒ Ù‚Ø¨ÙˆØ¶",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.onPrimary}}",
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
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ú¯Ø±ÙˆÙ‡ÛŒ Ù‚Ø¨ÙˆØ¶",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500"
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
                        "key": "trFilterTypeGroupBill",
                        "value": "{{!trFilterTypeGroupBill}}"
                      },
                      "type": "gestureDetector"
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
                "textDirection": "rtl",
                "children": [
                  {
                    "child": {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterTypeRefund]]",
                        "child": {
                          "decoration": {
                            "color": "{{appColors.current.secondary.color}}",
                            "borderRadius": {
                              "topLeft": 6.0,
                              "topRight": 6.0,
                              "bottomLeft": 6.0,
                              "bottomRight": 6.0
                            }
                          },
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø§Ø³ØªØ±Ø¯Ø§Ø¯ ÙˆØ¬Ù‡",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.onPrimary}}",
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
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "Ø§Ø³ØªØ±Ø¯Ø§Ø¯ ÙˆØ¬Ù‡",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500"
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
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "setValue",
                            "key": "trFilterTypeRefund",
                            "value": "{{!trFilterTypeRefund}}"
                          },
                          {
                            "actionType": "setValue",
                            "key": "trFilterWalletTypeSelected",
                            "value": "{{trFilterTypeRefund}}"
                          }
                        ]
                      },
                      "type": "gestureDetector"
                    },
                    "type": "expanded"
                  },
                  {
                    "width": 8.0,
                    "type": "sizedBox"
                  },
                  {
                    "child": {
                      "child": {
                        "type": "visibility",
                        "visible": "[[trFilterTypeSafeBox]]",
                        "child": {
                          "decoration": {
                            "color": "{{appColors.current.secondary.color}}",
                            "borderRadius": {
                              "topLeft": 6.0,
                              "topRight": 6.0,
                              "bottomLeft": 6.0,
                              "bottomRight": 6.0
                            }
                          },
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "ØµÙ†Ø¯ÙˆÙ‚ Ø§Ù…Ø§Ù†Ø§Øª",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.onPrimary}}",
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
                          "height": 44.0,
                          "child": {
                            "child": {
                              "data": "ØµÙ†Ø¯ÙˆÙ‚ Ø§Ù…Ø§Ù†Ø§Øª",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500"
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
                        "key": "trFilterTypeSafeBox",
                        "value": "{{!trFilterTypeSafeBox}}"
                      },
                      "type": "gestureDetector"
                    },
                    "type": "expanded"
                  },
                  {
                    "width": 8.0,
                    "type": "sizedBox"
                  },
                  {
                    "child": {
                      "type": "sizedBox"
                    },
                    "type": "expanded"
                  }
                ],
                "type": "row"
              }
            ],
            "type": "column"
          },
          {
            "height": 20.0,
            "type": "sizedBox"
          },
          {
            "data": "ÙˆØ¶Ø¹ÛŒØª ØªØ±Ø§Ú©Ù†Ø´",
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
            "height": 12.0,
            "type": "sizedBox"
          },
          {
            "textDirection": "rtl",
            "children": [
              {
                "child": {
                  "child": {
                    "type": "visibility",
                    "visible": "[[trFilterStatusSuccessSelected]]",
                    "child": {
                      "padding": {
                        "left": 10.0,
                        "right": 10.0
                      },
                      "decoration": {
                        "color": "{{appColors.current.success.color}}",
                        "borderRadius": {
                          "topLeft": 8.0,
                          "topRight": 8.0,
                          "bottomLeft": 8.0,
                          "bottomRight": 8.0
                        }
                      },
                      "height": 44.0,
                      "child": {
                        "mainAxisAlignment": "center",
                        "textDirection": "rtl",
                        "children": [
                          {
                            "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                            "imageType": "asset",
                            "width": 18.0,
                            "height": 18.0,
                            "type": "image"
                          },
                          {
                            "width": 8.0,
                            "type": "sizedBox"
                          },
                          {
                            "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ù…ÙˆÙÙ‚",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.onPrimary}}",
                              "fontSize": 14.0,
                              "fontWeight": "w600"
                            },
                            "textDirection": "rtl",
                            "type": "text"
                          }
                        ],
                        "type": "row"
                      },
                      "type": "container"
                    },
                    "replacement": {
                      "padding": {
                        "left": 10.0,
                        "right": 10.0
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
                      "height": 44.0,
                      "child": {
                        "mainAxisAlignment": "center",
                        "textDirection": "rtl",
                        "children": [
                          {
                            "src": "{{appAssets.icons.transactionItemSuccessCurrent}}",
                            "imageType": "asset",
                            "width": 18.0,
                            "height": 18.0,
                            "type": "image"
                          },
                          {
                            "width": 8.0,
                            "type": "sizedBox"
                          },
                          {
                            "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ù…ÙˆÙÙ‚",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 14.0,
                              "fontWeight": "w600"
                            },
                            "textDirection": "rtl",
                            "type": "text"
                          }
                        ],
                        "type": "row"
                      },
                      "type": "container"
                    }
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "key": "trFilterStatusSuccessSelected",
                        "value": "{{!trFilterStatusSuccessSelected}}"
                      },
                      {
                        "actionType": "setValue",
                        "key": "trFilterStatusFailedSelected",
                        "value": false
                      },
                      {
                        "actionType": "setValue",
                        "key": "trFilterStatusNoLimit",
                        "value": "{{!trFilterStatusSuccessSelected}}"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              },
              {
                "width": 10.0,
                "type": "sizedBox"
              },
              {
                "child": {
                  "child": {
                    "type": "visibility",
                    "visible": "[[trFilterStatusFailedSelected]]",
                    "child": {
                      "padding": {
                        "left": 10.0,
                        "right": 10.0
                      },
                      "decoration": {
                        "color": "{{appColors.current.error.color}}",
                        "borderRadius": {
                          "topLeft": 8.0,
                          "topRight": 8.0,
                          "bottomLeft": 8.0,
                          "bottomRight": 8.0
                        }
                      },
                      "height": 44.0,
                      "child": {
                        "mainAxisAlignment": "center",
                        "textDirection": "rtl",
                        "children": [
                          {
                            "src": "{{appAssets.icons.transactionItemFailedCurrent}}",
                            "imageType": "asset",
                            "width": 18.0,
                            "height": 18.0,
                            "type": "image"
                          },
                          {
                            "width": 8.0,
                            "type": "sizedBox"
                          },
                          {
                            "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ù†Ø§Ù…ÙˆÙÙ‚",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.onPrimary}}",
                              "fontSize": 14.0,
                              "fontWeight": "w600"
                            },
                            "textDirection": "rtl",
                            "type": "text"
                          }
                        ],
                        "type": "row"
                      },
                      "type": "container"
                    },
                    "replacement": {
                      "padding": {
                        "left": 10.0,
                        "right": 10.0
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
                      "height": 44.0,
                      "child": {
                        "mainAxisAlignment": "center",
                        "textDirection": "rtl",
                        "children": [
                          {
                            "src": "{{appAssets.icons.transactionItemFailedCurrent}}",
                            "imageType": "asset",
                            "width": 18.0,
                            "height": 18.0,
                            "type": "image"
                          },
                          {
                            "width": 8.0,
                            "type": "sizedBox"
                          },
                          {
                            "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ù†Ø§Ù…ÙˆÙÙ‚",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 14.0,
                              "fontWeight": "w600"
                            },
                            "textDirection": "rtl",
                            "type": "text"
                          }
                        ],
                        "type": "row"
                      },
                      "type": "container"
                    }
                  },
                  "onTap": {
                    "actionType": "sequence",
                    "actions": [
                      {
                        "actionType": "setValue",
                        "key": "trFilterStatusFailedSelected",
                        "value": "{{!trFilterStatusFailedSelected}}"
                      },
                      {
                        "actionType": "setValue",
                        "key": "trFilterStatusSuccessSelected",
                        "value": false
                      },
                      {
                        "actionType": "setValue",
                        "key": "trFilterStatusNoLimit",
                        "value": "{{!trFilterStatusFailedSelected}}"
                      }
                    ]
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              }
            ],
            "type": "row"
          },
          {
            "height": 26.0,
            "type": "sizedBox"
          },
          {
            "onPressed": {
              "actionType": "sequence",
              "actions": [
                {
                  "actionType": "setValue",
                  "values": [
                    {
                      "key": "trIntroIsTobankTab",
                      "value": true
                    },
                    {
                      "key": "trIntroChipWalletSelected",
                      "value": true,
                      "condition": "trFilterWalletTypeSelected"
                    },
                    {
                      "key": "trIntroChipAllSelected",
                      "value": false,
                      "condition": "trFilterWalletTypeSelected"
                    },
                    {
                      "key": "trIntroChipWalletSelected",
                      "value": false,
                      "condition": "!trFilterWalletTypeSelected"
                    },
                    {
                      "key": "trIntroChipAllSelected",
                      "value": true,
                      "condition": "!trFilterWalletTypeSelected"
                    },
                    {
                      "key": "trIntroShowSuccessTx",
                      "value": true,
                      "condition": "trFilterStatusNoLimit"
                    },
                    {
                      "key": "trIntroShowFailedTx",
                      "value": true,
                      "condition": "trFilterStatusNoLimit"
                    },
                    {
                      "key": "trIntroShowSuccessTx",
                      "value": true,
                      "condition": "trFilterStatusSuccessSelected"
                    },
                    {
                      "key": "trIntroShowFailedTx",
                      "value": false,
                      "condition": "trFilterStatusSuccessSelected"
                    },
                    {
                      "key": "trIntroShowSuccessTx",
                      "value": false,
                      "condition": "trFilterStatusFailedSelected"
                    },
                    {
                      "key": "trIntroShowFailedTx",
                      "value": true,
                      "condition": "trFilterStatusFailedSelected"
                    }
                  ]
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
              "minimumSize": {
                "width": 999999.0,
                "height": 56.0
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
              "data": "ÙÛŒÙ„ØªØ± Ù†ØªØ§ÛŒØ¬",
              "style": {
                "type": "custom",
                "color": "{{appColors.current.primary.onPrimary}}",
                "fontSize": 18.0,
                "fontWeight": "w700"
              },
              "textDirection": "rtl",
              "type": "text"
            },
            "type": "filledButton"
          },
          {
            "height": 12.0,
            "type": "sizedBox"
          }
        ],
        "type": "column"
      },
      "type": "singleChildScrollView"
    },
    "type": "scaffold"
  }
}
```
