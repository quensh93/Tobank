# flows/cartable_real/json/cartable_real_intro.json

Source: lib/stac/tobank/flows/cartable_real/json/cartable_real_intro.json

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
        "key": "isCartableTab",
        "value": true
      },
      {
        "key": "historyFilter",
        "value": "all"
      },
      {
        "key": "historySelectedAll",
        "value": true
      },
      {
        "key": "historySelectedOpen",
        "value": false
      },
      {
        "key": "historySelectedClosed",
        "value": false
      },
      {
        "key": "historyShowOpenCard",
        "value": true
      },
      {
        "key": "historyShowClosedCards",
        "value": true
      }
    ]
  },
  "child": {
    "backgroundColor": "{{appColors.current.background.surface}}",
    "body": {
      "children": [
        {
          "height": 52.0,
          "type": "sizedBox"
        },
        {
          "decoration": {
            "color": "{{appColors.current.background.surfaceContainer}}",
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
          "margin": {
            "left": 16.0,
            "right": 16.0
          },
          "child": {
            "textDirection": "rtl",
            "children": [
              {
                "child": {
                  "child": {
                    "height": 56.0,
                    "child": {
                      "padding": {
                        "top": 8.0
                      },
                      "child": {
                        "mainAxisAlignment": "spaceBetween",
                        "children": [
                          {
                            "type": "container"
                          },
                          {
                            "type": "visibility",
                            "visible": "[[isCartableTab]]",
                            "child": {
                              "data": "Ú©Ø§Ø±ØªØ§Ø¨Ù„",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 16.0,
                                "fontWeight": "w900"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "replacement": {
                              "data": "Ú©Ø§Ø±ØªØ§Ø¨Ù„",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 16.0,
                                "fontWeight": "w400"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            }
                          },
                          {
                            "padding": {
                              "left": 16.0,
                              "right": 16.0
                            },
                            "child": {
                              "type": "visibility",
                              "visible": "[[isCartableTab]]",
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
                            },
                            "type": "padding"
                          }
                        ],
                        "type": "column"
                      },
                      "type": "padding"
                    },
                    "type": "sizedBox"
                  },
                  "onTap": {
                    "actionType": "setValue",
                    "key": "isCartableTab",
                    "value": true
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              },
              {
                "color": "{{appColors.current.input.borderEnabled}}",
                "width": 2.0,
                "height": 24.0,
                "type": "container"
              },
              {
                "child": {
                  "child": {
                    "height": 56.0,
                    "child": {
                      "padding": {
                        "top": 8.0
                      },
                      "child": {
                        "mainAxisAlignment": "spaceBetween",
                        "children": [
                          {
                            "type": "container"
                          },
                          {
                            "type": "visibility",
                            "visible": "[[!isCartableTab]]",
                            "child": {
                              "data": "ØªØ§Ø±ÛŒØ®Ú†Ù‡ ÙØ¹Ø§Ù„ÛŒØªâ€ŒÙ‡Ø§",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 16.0,
                                "fontWeight": "w900"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "replacement": {
                              "data": "ØªØ§Ø±ÛŒØ®Ú†Ù‡ ÙØ¹Ø§Ù„ÛŒØªâ€ŒÙ‡Ø§",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 16.0,
                                "fontWeight": "w400"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            }
                          },
                          {
                            "padding": {
                              "left": 16.0,
                              "right": 16.0
                            },
                            "child": {
                              "type": "visibility",
                              "visible": "[[!isCartableTab]]",
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
                            },
                            "type": "padding"
                          }
                        ],
                        "type": "column"
                      },
                      "type": "padding"
                    },
                    "type": "sizedBox"
                  },
                  "onTap": {
                    "actionType": "setValue",
                    "key": "isCartableTab",
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
          "height": 8.0,
          "type": "sizedBox"
        },
        {
          "child": {
            "type": "visibility",
            "visible": "[[isCartableTab]]",
            "child": {
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
                      "decoration": {
                        "color": "{{appColors.current.background.surfaceContainer}}",
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
                            "child": {
                              "crossAxisAlignment": "stretch",
                              "children": [
                                {
                                  "data": "Ù†ÙˆØ¹ Ø¯Ø±Ø®ÙˆØ§Ø³Øª: ØªØ³Ù‡ÛŒÙ„Ø§Øª Ù‚Ø±Ø¶ Ø§Ù„Ø­Ø³Ù†Ù‡ Ø§Ø²Ø¯ÙˆØ§Ø¬",
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
                                {
                                  "height": 24.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "data": "Ù…Ø±Ø­Ù„Ù‡ Ø¨Ø¹Ø¯",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.subtitle}}",
                                        "fontSize": 14.0,
                                        "fontWeight": "w500"
                                      },
                                      "textAlign": "right",
                                      "textDirection": "rtl",
                                      "type": "text"
                                    },
                                    {
                                      "width": 24.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø§ØµÙ„Ø§Ø­ Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ù…Ø­Ù„ Ø³Ú©ÙˆÙ†Øª Ù…ØªÙ‚Ø§Ø¶ÛŒ",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 16.0,
                                          "fontWeight": "w600"
                                        },
                                        "textAlign": "left",
                                        "textDirection": "rtl",
                                        "softWrap": false,
                                        "overflow": "ellipsis",
                                        "maxLines": 1,
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    }
                                  ],
                                  "type": "row"
                                }
                              ],
                              "type": "column"
                            },
                            "type": "padding"
                          },
                          {
                            "color": "{{appColors.current.input.borderEnabled}}",
                            "width": 999999.0,
                            "height": 1.0,
                            "type": "container"
                          },
                          {
                            "padding": {
                              "top": 8.0,
                              "bottom": 8.0
                            },
                            "child": {
                              "textDirection": "rtl",
                              "children": [
                                {
                                  "child": {
                                    "child": {
                                      "padding": {
                                        "left": 8.0,
                                        "top": 8.0,
                                        "right": 8.0,
                                        "bottom": 8.0
                                      },
                                      "child": {
                                        "mainAxisAlignment": "center",
                                        "textDirection": "rtl",
                                        "children": [
                                          {
                                            "src": "assets/icons/ic_detail.svg",
                                            "imageType": "asset",
                                            "width": 24.0,
                                            "height": 24.0,
                                            "type": "image"
                                          },
                                          {
                                            "width": 8.0,
                                            "type": "sizedBox"
                                          },
                                          {
                                            "data": "Ø¬Ø²Ø¦ÛŒØ§Øª",
                                            "style": {
                                              "type": "custom",
                                              "color": "{{appColors.current.text.title}}",
                                              "fontSize": 14.0,
                                              "fontWeight": "w500"
                                            },
                                            "type": "text"
                                          }
                                        ],
                                        "type": "row"
                                      },
                                      "type": "padding"
                                    },
                                    "onTap": {
                                      "actionType": "sequence",
                                      "actions": [
                                        {
                                          "actionType": "setValue",
                                          "values": [
                                            {
                                              "key": "crDetailVariantMarriageLoan",
                                              "value": true
                                            },
                                            {
                                              "key": "crDetailVariantChildLoan",
                                              "value": false
                                            },
                                            {
                                              "key": "crDetailVariantCompleteDocsDone",
                                              "value": false
                                            },
                                            {
                                              "key": "crDetailVariantCompleteDocsEmpty",
                                              "value": false
                                            }
                                          ]
                                        },
                                        {
                                          "routeName": "cartable_real_detail",
                                          "actionType": "navigate"
                                        }
                                      ]
                                    },
                                    "type": "gestureDetector"
                                  },
                                  "type": "expanded"
                                },
                                {
                                  "color": "{{appColors.current.input.borderEnabled}}",
                                  "width": 1.0,
                                  "height": 32.0,
                                  "type": "container"
                                },
                                {
                                  "child": {
                                    "child": {
                                      "padding": {
                                        "left": 8.0,
                                        "top": 8.0,
                                        "right": 8.0,
                                        "bottom": 8.0
                                      },
                                      "child": {
                                        "mainAxisAlignment": "center",
                                        "textDirection": "rtl",
                                        "children": [
                                          {
                                            "src": "assets/icons/ic_continue_process.svg",
                                            "imageType": "asset",
                                            "width": 24.0,
                                            "height": 24.0,
                                            "type": "image"
                                          },
                                          {
                                            "width": 8.0,
                                            "type": "sizedBox"
                                          },
                                          {
                                            "data": "Ø§Ø¯Ø§Ù…Ù‡ ÙØ±Ø¢ÛŒÙ†Ø¯",
                                            "style": {
                                              "type": "custom",
                                              "color": "{{appColors.current.text.title}}",
                                              "fontSize": 14.0,
                                              "fontWeight": "w500"
                                            },
                                            "type": "text"
                                          }
                                        ],
                                        "type": "row"
                                      },
                                      "type": "padding"
                                    },
                                    "onTap": {
                                      "actionType": "showResult",
                                      "title": "Ø§Ø¯Ø§Ù…Ù‡ ÙØ±Ø¢ÛŒÙ†Ø¯",
                                      "content": "Ø§Ø¯Ø§Ù…Ù‡ ÙØ±Ø¢ÛŒÙ†Ø¯ Ø¨Ù‡ Ø²ÙˆØ¯ÛŒ ÙØ¹Ø§Ù„ Ù…ÛŒâ€ŒØ´ÙˆØ¯."
                                    },
                                    "type": "gestureDetector"
                                  },
                                  "type": "expanded"
                                }
                              ],
                              "type": "row"
                            },
                            "type": "padding"
                          }
                        ],
                        "type": "column"
                      },
                      "type": "container"
                    },
                    {
                      "height": 12.0,
                      "type": "sizedBox"
                    }
                  ],
                  "type": "column"
                },
                "type": "padding"
              },
              "type": "singleChildScrollView"
            },
            "replacement": {
              "children": [
                {
                  "padding": {
                    "left": 16.0,
                    "top": 8.0,
                    "right": 16.0,
                    "bottom": 8.0
                  },
                  "child": {
                    "textDirection": "rtl",
                    "children": [
                      {
                        "child": {
                          "type": "visibility",
                          "visible": "[[historySelectedAll]]",
                          "child": {
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
                            "child": {
                              "padding": {
                                "left": 12.0,
                                "top": 6.0,
                                "right": 12.0,
                                "bottom": 6.0
                              },
                              "child": {
                                "data": "Ù‡Ù…Ù‡",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.secondary.color}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "type": "text"
                              },
                              "type": "padding"
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
                            "child": {
                              "padding": {
                                "left": 12.0,
                                "top": 6.0,
                                "right": 12.0,
                                "bottom": 6.0
                              },
                              "child": {
                                "data": "Ù‡Ù…Ù‡",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "type": "text"
                              },
                              "type": "padding"
                            },
                            "type": "container"
                          }
                        },
                        "onTap": {
                          "actionType": "setValue",
                          "values": [
                            {
                              "key": "historyFilter",
                              "value": "all"
                            },
                            {
                              "key": "historySelectedAll",
                              "value": true
                            },
                            {
                              "key": "historySelectedOpen",
                              "value": false
                            },
                            {
                              "key": "historySelectedClosed",
                              "value": false
                            },
                            {
                              "key": "historyShowOpenCard",
                              "value": true
                            },
                            {
                              "key": "historyShowClosedCards",
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
                          "visible": "[[historySelectedOpen]]",
                          "child": {
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
                            "child": {
                              "padding": {
                                "left": 12.0,
                                "top": 6.0,
                                "right": 12.0,
                                "bottom": 6.0
                              },
                              "child": {
                                "data": "Ø¯Ø±Ø®ÙˆØ§Ø³Øªâ€ŒÙ‡Ø§ÛŒ Ø¨Ø§Ø²",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.secondary.color}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "type": "text"
                              },
                              "type": "padding"
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
                            "child": {
                              "padding": {
                                "left": 12.0,
                                "top": 6.0,
                                "right": 12.0,
                                "bottom": 6.0
                              },
                              "child": {
                                "data": "Ø¯Ø±Ø®ÙˆØ§Ø³Øªâ€ŒÙ‡Ø§ÛŒ Ø¨Ø§Ø²",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "type": "text"
                              },
                              "type": "padding"
                            },
                            "type": "container"
                          }
                        },
                        "onTap": {
                          "actionType": "setValue",
                          "values": [
                            {
                              "key": "historyFilter",
                              "value": "open"
                            },
                            {
                              "key": "historySelectedAll",
                              "value": false
                            },
                            {
                              "key": "historySelectedOpen",
                              "value": true
                            },
                            {
                              "key": "historySelectedClosed",
                              "value": false
                            },
                            {
                              "key": "historyShowOpenCard",
                              "value": true
                            },
                            {
                              "key": "historyShowClosedCards",
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
                          "visible": "[[historySelectedClosed]]",
                          "child": {
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
                            "child": {
                              "padding": {
                                "left": 12.0,
                                "top": 6.0,
                                "right": 12.0,
                                "bottom": 6.0
                              },
                              "child": {
                                "data": "Ø¯Ø±Ø®ÙˆØ§Ø³Øªâ€ŒÙ‡Ø§ÛŒ Ø¨Ø³ØªÙ‡",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.secondary.color}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "type": "text"
                              },
                              "type": "padding"
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
                            "child": {
                              "padding": {
                                "left": 12.0,
                                "top": 6.0,
                                "right": 12.0,
                                "bottom": 6.0
                              },
                              "child": {
                                "data": "Ø¯Ø±Ø®ÙˆØ§Ø³Øªâ€ŒÙ‡Ø§ÛŒ Ø¨Ø³ØªÙ‡",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "type": "text"
                              },
                              "type": "padding"
                            },
                            "type": "container"
                          }
                        },
                        "onTap": {
                          "actionType": "setValue",
                          "values": [
                            {
                              "key": "historyFilter",
                              "value": "closed"
                            },
                            {
                              "key": "historySelectedAll",
                              "value": false
                            },
                            {
                              "key": "historySelectedOpen",
                              "value": false
                            },
                            {
                              "key": "historySelectedClosed",
                              "value": true
                            },
                            {
                              "key": "historyShowOpenCard",
                              "value": false
                            },
                            {
                              "key": "historyShowClosedCards",
                              "value": true
                            }
                          ]
                        },
                        "type": "gestureDetector"
                      }
                    ],
                    "type": "row"
                  },
                  "type": "padding"
                },
                {
                  "child": {
                    "child": {
                      "padding": {
                        "left": 16.0,
                        "top": 8.0,
                        "right": 16.0,
                        "bottom": 8.0
                      },
                      "child": {
                        "children": [
                          {
                            "type": "visibility",
                            "visible": "[[historyShowOpenCard]]",
                            "child": {
                              "children": [
                                {
                                  "decoration": {
                                    "color": "{{appColors.current.background.surfaceContainer}}",
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
                                  "child": {
                                    "children": [
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
                                              "data": "ÙˆØ§Ù… Ù‚Ø±Ø¶ Ø§Ù„Ø­Ø³Ù†Ù‡ Ø§Ø²Ø¯ÙˆØ§Ø¬",
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
                                              "height": 24.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "mainAxisAlignment": "spaceBetween",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "mainAxisSize": "min",
                                                  "textDirection": "rtl",
                                                  "children": [
                                                    {
                                                      "data": "ÙˆØ¶Ø¹ÛŒØª Ø¯Ø±Ø®ÙˆØ§Ø³Øª",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textAlign": "right",
                                                      "textDirection": "rtl",
                                                      "type": "text"
                                                    },
                                                    {
                                                      "width": 2.0,
                                                      "type": "sizedBox"
                                                    },
                                                    {
                                                      "data": ":",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textDirection": "ltr",
                                                      "type": "text"
                                                    }
                                                  ],
                                                  "type": "row"
                                                },
                                                {
                                                  "data": "Ø¨Ø§Ø²",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 14.0,
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
                                              "height": 16.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "mainAxisAlignment": "spaceBetween",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "mainAxisSize": "min",
                                                  "textDirection": "rtl",
                                                  "children": [
                                                    {
                                                      "data": "ØªØ§Ø±ÛŒØ® Ø«Ø¨Øª Ø¯Ø±Ø®ÙˆØ§Ø³Øª",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textAlign": "right",
                                                      "textDirection": "rtl",
                                                      "type": "text"
                                                    },
                                                    {
                                                      "width": 2.0,
                                                      "type": "sizedBox"
                                                    },
                                                    {
                                                      "data": ":",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textDirection": "ltr",
                                                      "type": "text"
                                                    }
                                                  ],
                                                  "type": "row"
                                                },
                                                {
                                                  "data": "Û¶ Ø¯ÛŒ Û±Û´Û°Û´",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 14.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            }
                                          ],
                                          "type": "column"
                                        },
                                        "type": "padding"
                                      },
                                      {
                                        "color": "{{appColors.current.input.borderEnabled}}",
                                        "width": 999999.0,
                                        "height": 1.0,
                                        "type": "container"
                                      },
                                      {
                                        "height": 48.0,
                                        "child": {
                                          "child": {
                                            "padding": {
                                              "left": 8.0,
                                              "top": 8.0,
                                              "right": 8.0,
                                              "bottom": 8.0
                                            },
                                            "child": {
                                              "mainAxisAlignment": "center",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "src": "assets/icons/ic_detail.svg",
                                                  "imageType": "asset",
                                                  "width": 24.0,
                                                  "height": 24.0,
                                                  "type": "image"
                                                },
                                                {
                                                  "width": 8.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Ø¬Ø²Ø¦ÛŒØ§Øª",
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
                                            "type": "padding"
                                          },
                                          "onTap": {
                                            "actionType": "sequence",
                                            "actions": [
                                              {
                                                "actionType": "setValue",
                                                "values": [
                                                  {
                                                    "key": "crDetailVariantMarriageLoan",
                                                    "value": true
                                                  },
                                                  {
                                                    "key": "crDetailVariantChildLoan",
                                                    "value": false
                                                  },
                                                  {
                                                    "key": "crDetailVariantCompleteDocsDone",
                                                    "value": false
                                                  },
                                                  {
                                                    "key": "crDetailVariantCompleteDocsEmpty",
                                                    "value": false
                                                  }
                                                ]
                                              },
                                              {
                                                "routeName": "cartable_real_detail",
                                                "actionType": "navigate"
                                              }
                                            ]
                                          },
                                          "type": "gestureDetector"
                                        },
                                        "type": "sizedBox"
                                      }
                                    ],
                                    "type": "column"
                                  },
                                  "type": "container"
                                },
                                {
                                  "height": 16.0,
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
                            "visible": "[[historyShowClosedCards]]",
                            "child": {
                              "children": [
                                {
                                  "decoration": {
                                    "color": "{{appColors.current.background.surfaceContainer}}",
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
                                  "child": {
                                    "children": [
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
                                              "data": "ØªÚ©Ù…ÛŒÙ„ Ù…Ø¯Ø§Ø±Ú©",
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
                                              "height": 24.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "mainAxisAlignment": "spaceBetween",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "mainAxisSize": "min",
                                                  "textDirection": "rtl",
                                                  "children": [
                                                    {
                                                      "data": "ÙˆØ¶Ø¹ÛŒØª Ø¯Ø±Ø®ÙˆØ§Ø³Øª",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textAlign": "right",
                                                      "textDirection": "rtl",
                                                      "type": "text"
                                                    },
                                                    {
                                                      "width": 2.0,
                                                      "type": "sizedBox"
                                                    },
                                                    {
                                                      "data": ":",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textDirection": "ltr",
                                                      "type": "text"
                                                    }
                                                  ],
                                                  "type": "row"
                                                },
                                                {
                                                  "data": "Ø¨Ø³ØªÙ‡",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 14.0,
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
                                              "height": 16.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "mainAxisAlignment": "spaceBetween",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "mainAxisSize": "min",
                                                  "textDirection": "rtl",
                                                  "children": [
                                                    {
                                                      "data": "ØªØ§Ø±ÛŒØ® Ø«Ø¨Øª Ø¯Ø±Ø®ÙˆØ§Ø³Øª",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textAlign": "right",
                                                      "textDirection": "rtl",
                                                      "type": "text"
                                                    },
                                                    {
                                                      "width": 2.0,
                                                      "type": "sizedBox"
                                                    },
                                                    {
                                                      "data": ":",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textDirection": "ltr",
                                                      "type": "text"
                                                    }
                                                  ],
                                                  "type": "row"
                                                },
                                                {
                                                  "data": "Û²Û´ ÙØ±ÙˆØ±Ø¯ÛŒÙ† Û±Û´Û°Ûµ",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 14.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            }
                                          ],
                                          "type": "column"
                                        },
                                        "type": "padding"
                                      },
                                      {
                                        "color": "{{appColors.current.input.borderEnabled}}",
                                        "width": 999999.0,
                                        "height": 1.0,
                                        "type": "container"
                                      },
                                      {
                                        "height": 48.0,
                                        "child": {
                                          "child": {
                                            "padding": {
                                              "left": 8.0,
                                              "top": 8.0,
                                              "right": 8.0,
                                              "bottom": 8.0
                                            },
                                            "child": {
                                              "mainAxisAlignment": "center",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "src": "assets/icons/ic_detail.svg",
                                                  "imageType": "asset",
                                                  "width": 24.0,
                                                  "height": 24.0,
                                                  "type": "image"
                                                },
                                                {
                                                  "width": 8.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Ø¬Ø²Ø¦ÛŒØ§Øª",
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
                                            "type": "padding"
                                          },
                                          "onTap": {
                                            "actionType": "sequence",
                                            "actions": [
                                              {
                                                "actionType": "setValue",
                                                "values": [
                                                  {
                                                    "key": "crDetailVariantMarriageLoan",
                                                    "value": false
                                                  },
                                                  {
                                                    "key": "crDetailVariantChildLoan",
                                                    "value": false
                                                  },
                                                  {
                                                    "key": "crDetailVariantCompleteDocsDone",
                                                    "value": true
                                                  },
                                                  {
                                                    "key": "crDetailVariantCompleteDocsEmpty",
                                                    "value": false
                                                  }
                                                ]
                                              },
                                              {
                                                "routeName": "cartable_real_detail",
                                                "actionType": "navigate"
                                              }
                                            ]
                                          },
                                          "type": "gestureDetector"
                                        },
                                        "type": "sizedBox"
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
                                  "decoration": {
                                    "color": "{{appColors.current.background.surfaceContainer}}",
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
                                  "child": {
                                    "children": [
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
                                              "data": "ØªÚ©Ù…ÛŒÙ„ Ù…Ø¯Ø§Ø±Ú©",
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
                                              "height": 24.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "mainAxisAlignment": "spaceBetween",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "mainAxisSize": "min",
                                                  "textDirection": "rtl",
                                                  "children": [
                                                    {
                                                      "data": "ÙˆØ¶Ø¹ÛŒØª Ø¯Ø±Ø®ÙˆØ§Ø³Øª",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textAlign": "right",
                                                      "textDirection": "rtl",
                                                      "type": "text"
                                                    },
                                                    {
                                                      "width": 2.0,
                                                      "type": "sizedBox"
                                                    },
                                                    {
                                                      "data": ":",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textDirection": "ltr",
                                                      "type": "text"
                                                    }
                                                  ],
                                                  "type": "row"
                                                },
                                                {
                                                  "data": "Ø¨Ø³ØªÙ‡",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 14.0,
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
                                              "height": 16.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "mainAxisAlignment": "spaceBetween",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "mainAxisSize": "min",
                                                  "textDirection": "rtl",
                                                  "children": [
                                                    {
                                                      "data": "ØªØ§Ø±ÛŒØ® Ø«Ø¨Øª Ø¯Ø±Ø®ÙˆØ§Ø³Øª",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textAlign": "right",
                                                      "textDirection": "rtl",
                                                      "type": "text"
                                                    },
                                                    {
                                                      "width": 2.0,
                                                      "type": "sizedBox"
                                                    },
                                                    {
                                                      "data": ":",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textDirection": "ltr",
                                                      "type": "text"
                                                    }
                                                  ],
                                                  "type": "row"
                                                },
                                                {
                                                  "data": "Û²Û³ ÙØ±ÙˆØ±Ø¯ÛŒÙ† Û±Û´Û°Ûµ",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 14.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            }
                                          ],
                                          "type": "column"
                                        },
                                        "type": "padding"
                                      },
                                      {
                                        "color": "{{appColors.current.input.borderEnabled}}",
                                        "width": 999999.0,
                                        "height": 1.0,
                                        "type": "container"
                                      },
                                      {
                                        "height": 48.0,
                                        "child": {
                                          "child": {
                                            "padding": {
                                              "left": 8.0,
                                              "top": 8.0,
                                              "right": 8.0,
                                              "bottom": 8.0
                                            },
                                            "child": {
                                              "mainAxisAlignment": "center",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "src": "assets/icons/ic_detail.svg",
                                                  "imageType": "asset",
                                                  "width": 24.0,
                                                  "height": 24.0,
                                                  "type": "image"
                                                },
                                                {
                                                  "width": 8.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Ø¬Ø²Ø¦ÛŒØ§Øª",
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
                                            "type": "padding"
                                          },
                                          "onTap": {
                                            "actionType": "sequence",
                                            "actions": [
                                              {
                                                "actionType": "setValue",
                                                "values": [
                                                  {
                                                    "key": "crDetailVariantMarriageLoan",
                                                    "value": false
                                                  },
                                                  {
                                                    "key": "crDetailVariantChildLoan",
                                                    "value": false
                                                  },
                                                  {
                                                    "key": "crDetailVariantCompleteDocsDone",
                                                    "value": false
                                                  },
                                                  {
                                                    "key": "crDetailVariantCompleteDocsEmpty",
                                                    "value": true
                                                  }
                                                ]
                                              },
                                              {
                                                "routeName": "cartable_real_detail",
                                                "actionType": "navigate"
                                              }
                                            ]
                                          },
                                          "type": "gestureDetector"
                                        },
                                        "type": "sizedBox"
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
                                  "decoration": {
                                    "color": "{{appColors.current.background.surfaceContainer}}",
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
                                  "child": {
                                    "children": [
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
                                              "data": "ØªÚ©Ù…ÛŒÙ„ Ù…Ø¯Ø§Ø±Ú©",
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
                                              "height": 24.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "mainAxisAlignment": "spaceBetween",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "mainAxisSize": "min",
                                                  "textDirection": "rtl",
                                                  "children": [
                                                    {
                                                      "data": "ÙˆØ¶Ø¹ÛŒØª Ø¯Ø±Ø®ÙˆØ§Ø³Øª",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textAlign": "right",
                                                      "textDirection": "rtl",
                                                      "type": "text"
                                                    },
                                                    {
                                                      "width": 2.0,
                                                      "type": "sizedBox"
                                                    },
                                                    {
                                                      "data": ":",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textDirection": "ltr",
                                                      "type": "text"
                                                    }
                                                  ],
                                                  "type": "row"
                                                },
                                                {
                                                  "data": "Ø¨Ø³ØªÙ‡",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 14.0,
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
                                              "height": 16.0,
                                              "type": "sizedBox"
                                            },
                                            {
                                              "mainAxisAlignment": "spaceBetween",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "mainAxisSize": "min",
                                                  "textDirection": "rtl",
                                                  "children": [
                                                    {
                                                      "data": "ØªØ§Ø±ÛŒØ® Ø«Ø¨Øª Ø¯Ø±Ø®ÙˆØ§Ø³Øª",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textAlign": "right",
                                                      "textDirection": "rtl",
                                                      "type": "text"
                                                    },
                                                    {
                                                      "width": 2.0,
                                                      "type": "sizedBox"
                                                    },
                                                    {
                                                      "data": ":",
                                                      "style": {
                                                        "type": "custom",
                                                        "color": "{{appColors.current.text.subtitle}}",
                                                        "fontSize": 14.0,
                                                        "fontWeight": "w500"
                                                      },
                                                      "textDirection": "ltr",
                                                      "type": "text"
                                                    }
                                                  ],
                                                  "type": "row"
                                                },
                                                {
                                                  "data": "Û²Û³ ÙØ±ÙˆØ±Ø¯ÛŒÙ† Û±Û´Û°Ûµ",
                                                  "style": {
                                                    "type": "custom",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "fontSize": 14.0,
                                                    "fontWeight": "w600"
                                                  },
                                                  "textAlign": "left",
                                                  "textDirection": "rtl",
                                                  "type": "text"
                                                }
                                              ],
                                              "type": "row"
                                            }
                                          ],
                                          "type": "column"
                                        },
                                        "type": "padding"
                                      },
                                      {
                                        "color": "{{appColors.current.input.borderEnabled}}",
                                        "width": 999999.0,
                                        "height": 1.0,
                                        "type": "container"
                                      },
                                      {
                                        "height": 48.0,
                                        "child": {
                                          "child": {
                                            "padding": {
                                              "left": 8.0,
                                              "top": 8.0,
                                              "right": 8.0,
                                              "bottom": 8.0
                                            },
                                            "child": {
                                              "mainAxisAlignment": "center",
                                              "textDirection": "rtl",
                                              "children": [
                                                {
                                                  "src": "assets/icons/ic_detail.svg",
                                                  "imageType": "asset",
                                                  "width": 24.0,
                                                  "height": 24.0,
                                                  "type": "image"
                                                },
                                                {
                                                  "width": 8.0,
                                                  "type": "sizedBox"
                                                },
                                                {
                                                  "data": "Ø¬Ø²Ø¦ÛŒØ§Øª",
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
                                            "type": "padding"
                                          },
                                          "onTap": {
                                            "actionType": "sequence",
                                            "actions": [
                                              {
                                                "actionType": "setValue",
                                                "values": [
                                                  {
                                                    "key": "crDetailVariantMarriageLoan",
                                                    "value": false
                                                  },
                                                  {
                                                    "key": "crDetailVariantChildLoan",
                                                    "value": true
                                                  },
                                                  {
                                                    "key": "crDetailVariantCompleteDocsDone",
                                                    "value": false
                                                  },
                                                  {
                                                    "key": "crDetailVariantCompleteDocsEmpty",
                                                    "value": false
                                                  }
                                                ]
                                              },
                                              {
                                                "routeName": "cartable_real_detail",
                                                "actionType": "navigate"
                                              }
                                            ]
                                          },
                                          "type": "gestureDetector"
                                        },
                                        "type": "sizedBox"
                                      }
                                    ],
                                    "type": "column"
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
                      "type": "padding"
                    },
                    "type": "singleChildScrollView"
                  },
                  "type": "expanded"
                }
              ],
              "type": "column"
            }
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
