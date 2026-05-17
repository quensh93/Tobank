# flows/package_real/json/package_real_payment_success.json

Source: lib/stac/tobank/flows/package_real/json/package_real_payment_success.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
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
      "data": "Ø§ÛŒÙ†ØªØ±Ù†Øª",
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
    "top": false,
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
              "type": "receiptRepaintBoundary",
              "boundaryKey": "packageRealReceiptContent",
              "child": {
                "child": {
                  "crossAxisAlignment": "stretch",
                  "children": [
                    {
                      "height": 20.0,
                      "type": "sizedBox"
                    },
                    {
                      "children": [
                        {
                          "child": {
                            "decoration": {
                              "color": "#E7F7ED",
                              "shape": "circle"
                            },
                            "width": 84.0,
                            "height": 84.0,
                            "child": {
                              "child": {
                                "decoration": {
                                  "color": "#BFEFD0",
                                  "shape": "circle"
                                },
                                "width": 58.0,
                                "height": 58.0,
                                "child": {
                                  "child": {
                                    "decoration": {
                                      "color": "#24B76A",
                                      "shape": "circle"
                                    },
                                    "width": 40.0,
                                    "height": 40.0,
                                    "child": {
                                      "child": {
                                        "icon": "check",
                                        "iconType": "material",
                                        "size": 22.0,
                                        "color": "#FFFFFF",
                                        "type": "icon"
                                      },
                                      "type": "center"
                                    },
                                    "type": "container"
                                  },
                                  "type": "center"
                                },
                                "type": "container"
                              },
                              "type": "center"
                            },
                            "type": "container"
                          },
                          "type": "center"
                        },
                        {
                          "height": 14.0,
                          "type": "sizedBox"
                        },
                        {
                          "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ù…ÙˆÙÙ‚",
                          "style": {
                            "type": "custom",
                            "color": "#17945A",
                            "fontSize": 22.0,
                            "fontWeight": "w700"
                          },
                          "textAlign": "center",
                          "textDirection": "rtl",
                          "type": "text"
                        }
                      ],
                      "type": "column"
                    },
                    {
                      "height": 18.0,
                      "type": "sizedBox"
                    },
                    {
                      "padding": {
                        "left": 12.0,
                        "top": 10.0,
                        "right": 12.0,
                        "bottom": 10.0
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
                        "crossAxisAlignment": "stretch",
                        "children": [
                          {
                            "padding": {
                              "top": 8.0,
                              "bottom": 8.0
                            },
                            "child": {
                              "textDirection": "rtl",
                              "children": [
                                {
                                  "data": "Ù…Ø¨Ù„Øº",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w500"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                {
                                  "child": {
                                    "type": "sizedBox"
                                  },
                                  "type": "expanded"
                                },
                                {
                                  "data": "{{crPayReceiptAmount}} Ø±ÛŒØ§Ù„",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w600"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                }
                              ],
                              "type": "row"
                            },
                            "type": "padding"
                          },
                          {
                            "color": "#E5E7EB",
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
                                  "data": "Ø²Ù…Ø§Ù† ØªØ±Ø§Ú©Ù†Ø´",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w500"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                {
                                  "child": {
                                    "type": "sizedBox"
                                  },
                                  "type": "expanded"
                                },
                                {
                                  "data": "{{crPayReceiptTime}}",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w600"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                }
                              ],
                              "type": "row"
                            },
                            "type": "padding"
                          },
                          {
                            "color": "#E5E7EB",
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
                                  "data": "Ø®Ø¯Ù…Øª",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w500"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                {
                                  "child": {
                                    "type": "sizedBox"
                                  },
                                  "type": "expanded"
                                },
                                {
                                  "data": "{{crPayReceiptPackage}}",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w600"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                }
                              ],
                              "type": "row"
                            },
                            "type": "padding"
                          },
                          {
                            "color": "#E5E7EB",
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
                                  "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ø§Ø² Ø·Ø±ÛŒÙ‚",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w500"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                {
                                  "child": {
                                    "type": "sizedBox"
                                  },
                                  "type": "expanded"
                                },
                                {
                                  "data": "{{crPayReceiptVia}}",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w600"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                }
                              ],
                              "type": "row"
                            },
                            "type": "padding"
                          },
                          {
                            "color": "#E5E7EB",
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
                                  "data": "Ù…Ø¨Ø¯Ø§",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w500"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                {
                                  "child": {
                                    "type": "sizedBox"
                                  },
                                  "type": "expanded"
                                },
                                {
                                  "data": "{{crPayReceiptFrom}}",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w600"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                }
                              ],
                              "type": "row"
                            },
                            "type": "padding"
                          },
                          {
                            "color": "#E5E7EB",
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
                                  "data": "Ø´Ù…Ø§Ø±Ù‡ Ù¾ÛŒÚ¯ÛŒØ±ÛŒ",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w500"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                {
                                  "child": {
                                    "type": "sizedBox"
                                  },
                                  "type": "expanded"
                                },
                                {
                                  "data": "{{crPayReceiptTracking}}",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.title}}",
                                    "fontSize": 15.0,
                                    "fontWeight": "w600"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
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
                      "height": 24.0,
                      "type": "sizedBox"
                    },
                    {
                      "textDirection": "rtl",
                      "children": [
                        {
                          "src": "assets/icons/ic_tobank_red.svg",
                          "imageType": "asset",
                          "width": 40.0,
                          "height": 18.0,
                          "fit": "contain",
                          "type": "image"
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
                                "data": "ÛŒÚ© Ø´Ø¹Ø¨Ù‡ Ù…Ø¬Ø§Ø²ÛŒ Ù‡Ù…Ø±Ø§Ù‡ Ø´Ù…Ø§Ø³Øª!",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "textAlign": "right",
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              {
                                "height": 2.0,
                                "type": "sizedBox"
                              },
                              {
                                "data": "www.tobank.ir",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 16.0,
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
                    }
                  ],
                  "type": "column"
                },
                "type": "singleChildScrollView"
              }
            },
            "type": "expanded"
          },
          {
            "children": [
              {
                "child": {
                  "onPressed": {
                    "actionType": "transferReceipt",
                    "mode": "shareText",
                    "title": "Ø±Ø³ÛŒØ¯ Ø®Ø±ÛŒØ¯ Ø¨Ø³ØªÙ‡",
                    "pixelRatio": 3.0,
                    "boundaryKey": "packageRealReceiptContent"
                  },
                  "style": {
                    "fixedSize": {
                      "width": 999999.0,
                      "height": 52.0
                    },
                    "side": {
                      "color": "{{appColors.current.input.borderEnabled}}",
                      "width": 1.0
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
                    "mainAxisAlignment": "center",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "src": "assets/icons/ic_share.svg",
                        "imageType": "asset",
                        "color": "{{appColors.current.text.title}}",
                        "width": 20.0,
                        "height": 20.0,
                        "type": "image"
                      },
                      {
                        "width": 6.0,
                        "type": "sizedBox"
                      },
                      {
                        "data": "Ø§Ø´ØªØ±Ø§Ú©â€ŒÚ¯Ø°Ø§Ø±ÛŒ",
                        "style": {
                          "type": "custom",
                          "color": "{{appColors.current.text.title}}",
                          "fontSize": 16.0,
                          "fontWeight": "w500"
                        },
                        "textDirection": "rtl",
                        "type": "text"
                      }
                    ],
                    "type": "row"
                  },
                  "type": "outlinedButton"
                },
                "type": "expanded"
              },
              {
                "width": 10.0,
                "type": "sizedBox"
              },
              {
                "child": {
                  "onPressed": {
                    "actionType": "transferReceipt",
                    "mode": "shareImage",
                    "title": "Ø±Ø³ÛŒØ¯ Ø®Ø±ÛŒØ¯ Ø¨Ø³ØªÙ‡",
                    "pixelRatio": 3.0,
                    "boundaryKey": "packageRealReceiptContent"
                  },
                  "style": {
                    "fixedSize": {
                      "width": 999999.0,
                      "height": 52.0
                    },
                    "side": {
                      "color": "{{appColors.current.input.borderEnabled}}",
                      "width": 1.0
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
                    "mainAxisAlignment": "center",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "src": "assets/icons/ic_download.svg",
                        "imageType": "asset",
                        "color": "{{appColors.current.text.title}}",
                        "width": 20.0,
                        "height": 20.0,
                        "type": "image"
                      },
                      {
                        "width": 6.0,
                        "type": "sizedBox"
                      },
                      {
                        "data": "Ø°Ø®ÛŒØ±Ù‡ Ø¯Ø± Ú¯Ø§Ù„Ø±ÛŒ",
                        "style": {
                          "type": "custom",
                          "color": "{{appColors.current.text.title}}",
                          "fontSize": 16.0,
                          "fontWeight": "w500"
                        },
                        "textDirection": "rtl",
                        "type": "text"
                      }
                    ],
                    "type": "row"
                  },
                  "type": "outlinedButton"
                },
                "type": "expanded"
              }
            ],
            "type": "row"
          },
          {
            "height": 8.0,
            "type": "sizedBox"
          }
        ],
        "type": "column"
      },
      "type": "padding"
    },
    "type": "safeArea"
  },
  "type": "scaffold"
}
```
