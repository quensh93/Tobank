# flows/cartable_real/json/cartable_real_detail.json

Source: lib/stac/tobank/flows/cartable_real/json/cartable_real_detail.json

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
        "data": "Ø¬Ø²Ø¦ÛŒØ§Øª ÙØ±Ø¢ÛŒÙ†Ø¯",
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
        "top": 12.0,
        "right": 16.0,
        "bottom": 12.0
      },
      "child": {
        "type": "visibility",
        "visible": "[[crDetailVariantChildLoan]]",
        "child": {
          "crossAxisAlignment": "stretch",
          "children": [
            {
              "crossAxisAlignment": "stretch",
              "children": [
                {
                  "data": "ÙˆØ§Ù… Ù‚Ø±Ø¶ Ø§Ù„Ø­Ø³Ù†Ù‡ ÙØ±Ø²Ù†Ø¯Ø¢ÙˆØ±ÛŒ",
                  "style": {
                    "type": "custom",
                    "color": "{{appColors.current.text.title}}",
                    "fontSize": 16.0,
                    "fontWeight": "w700"
                  },
                  "textAlign": "center",
                  "textDirection": "rtl",
                  "type": "text"
                },
                {
                  "height": 20.0,
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
                          "data": "Ø´Ø±ÙˆØ¹ ÙØ±Ø¢ÛŒÙ†Ø¯",
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
                      "data": "Û±Û´Û°Û´/Û±Û°/Û°Û¶ - Û±Û±:Û±Û±",
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
                  "height": 14.0,
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
                          "data": "ÙˆØ¶Ø¹ÛŒØª ÙØ±Ø¢ÛŒÙ†Ø¯",
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
                "left": 14.0,
                "top": 14.0,
                "right": 14.0,
                "bottom": 14.0
              },
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
                    "mainAxisAlignment": "spaceBetween",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "child": {
                          "data": "Ù…Ø¯Ø§Ø±Ú© Ù…ØªÙ‚Ø§Ø¶ÛŒ",
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
                        "type": "expanded"
                      },
                      {
                        "width": 12.0,
                        "type": "sizedBox"
                      },
                      {
                        "padding": {
                          "left": 10.0,
                          "top": 4.0,
                          "right": 10.0,
                          "bottom": 4.0
                        },
                        "decoration": {
                          "color": "#D3F2F4",
                          "borderRadius": {
                            "topLeft": 8.0,
                            "topRight": 8.0,
                            "bottomLeft": 8.0,
                            "bottomRight": 8.0
                          }
                        },
                        "child": {
                          "data": "Ø¯Ø± Ø§Ù†ØªØ¸Ø§Ø± ØªÚ©Ù…ÛŒÙ„",
                          "style": {
                            "type": "custom",
                            "color": "#33A8B2",
                            "fontSize": 14.0,
                            "fontWeight": "w700"
                          },
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "type": "container"
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
                            "data": "Ø²Ù…Ø§Ù† Ø§ÛŒØ¬Ø§Ø¯",
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
                        "data": "Û±Û´Û°Û´/Û±Û°/Û°Û¶ - Û±Û±:Û±Û±",
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
                    "height": 12.0,
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
                            "data": "Ø²Ù…Ø§Ù† Ø§ØªÙ…Ø§Ù…",
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
                        "data": "Û±Û´Û°Û´/Û±Û°/Û°Û¶ - Û±Û±:Û´Û¸",
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
              "type": "container"
            },
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
                    "mainAxisAlignment": "spaceBetween",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "child": {
                          "data": "Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ù…Ø­Ù„ Ø³Ú©ÙˆÙ†Øª Ù…ØªÙ‚Ø§Ø¶ÛŒ",
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
                        "type": "expanded"
                      },
                      {
                        "width": 12.0,
                        "type": "sizedBox"
                      },
                      {
                        "padding": {
                          "left": 10.0,
                          "top": 4.0,
                          "right": 10.0,
                          "bottom": 4.0
                        },
                        "decoration": {
                          "color": "#D3F2F4",
                          "borderRadius": {
                            "topLeft": 8.0,
                            "topRight": 8.0,
                            "bottomLeft": 8.0,
                            "bottomRight": 8.0
                          }
                        },
                        "child": {
                          "data": "Ø¯Ø± Ø§Ù†ØªØ¸Ø§Ø± ØªÚ©Ù…ÛŒÙ„",
                          "style": {
                            "type": "custom",
                            "color": "#33A8B2",
                            "fontSize": 14.0,
                            "fontWeight": "w700"
                          },
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "type": "container"
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
                            "data": "Ø²Ù…Ø§Ù† Ø§ÛŒØ¬Ø§Ø¯",
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
                        "data": "Û±Û´Û°Û´/Û±Û°/Û°Û¶ - Û±Û±:Û±Û±",
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
                    "height": 12.0,
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
                            "data": "Ø²Ù…Ø§Ù† Ø§ØªÙ…Ø§Ù…",
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
                        "data": "Û±Û´Û°Û´/Û±Û°/Û°Û¶ - Û±Û±:Û´Û¸",
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
              "type": "container"
            },
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
                    "mainAxisAlignment": "spaceBetween",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "child": {
                          "data": "Ø§Ø·Ù„Ø§Ø¹Ø§Øª ÙØ±Ø²Ù†Ø¯ Ù…ØªÙ‚Ø§Ø¶ÛŒ",
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
                        "type": "expanded"
                      },
                      {
                        "width": 12.0,
                        "type": "sizedBox"
                      },
                      {
                        "padding": {
                          "left": 10.0,
                          "top": 4.0,
                          "right": 10.0,
                          "bottom": 4.0
                        },
                        "decoration": {
                          "color": "#D3F2F4",
                          "borderRadius": {
                            "topLeft": 8.0,
                            "topRight": 8.0,
                            "bottomLeft": 8.0,
                            "bottomRight": 8.0
                          }
                        },
                        "child": {
                          "data": "Ø¯Ø± Ø§Ù†ØªØ¸Ø§Ø± ØªÚ©Ù…ÛŒÙ„",
                          "style": {
                            "type": "custom",
                            "color": "#33A8B2",
                            "fontSize": 14.0,
                            "fontWeight": "w700"
                          },
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "type": "container"
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
                            "data": "Ø²Ù…Ø§Ù† Ø§ÛŒØ¬Ø§Ø¯",
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
                        "data": "Û±Û´Û°Û´/Û±Û°/Û°Û¶ - Û±Û±:Û±Û±",
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
                    "height": 12.0,
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
                            "data": "Ø²Ù…Ø§Ù† Ø§ØªÙ…Ø§Ù…",
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
                        "data": "Û±Û´Û°Û´/Û±Û°/Û°Û¶ - Û±Û±:Û´Û¸",
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
              "type": "container"
            }
          ],
          "type": "column"
        },
        "replacement": {
          "type": "visibility",
          "visible": "[[crDetailVariantCompleteDocsDone]]",
          "child": {
            "crossAxisAlignment": "stretch",
            "children": [
              {
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
                    "textAlign": "center",
                    "textDirection": "rtl",
                    "type": "text"
                  },
                  {
                    "height": 20.0,
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
                            "data": "Ø´Ø±ÙˆØ¹ ÙØ±Ø¢ÛŒÙ†Ø¯",
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
                        "data": "Û±Û´Û°Ûµ/Û°Û±/Û²Û´ - Û±Ûµ:Û³Ûµ",
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
                    "height": 14.0,
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
                            "data": "ÙˆØ¶Ø¹ÛŒØª ÙØ±Ø¢ÛŒÙ†Ø¯",
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
                  "left": 14.0,
                  "top": 14.0,
                  "right": 14.0,
                  "bottom": 14.0
                },
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
                      "mainAxisAlignment": "spaceBetween",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "child": {
                            "data": "Ø¨Ø±Ø±Ø³ÛŒ Ù…Ø¯Ø§Ø±Ú© Ù…Ø´ØªØ±ÛŒ",
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
                          "type": "expanded"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "padding": {
                            "left": 10.0,
                            "top": 4.0,
                            "right": 10.0,
                            "bottom": 4.0
                          },
                          "decoration": {
                            "color": "#DDF3E8",
                            "borderRadius": {
                              "topLeft": 8.0,
                              "topRight": 8.0,
                              "bottomLeft": 8.0,
                              "bottomRight": 8.0
                            }
                          },
                          "child": {
                            "data": "ØªÚ©Ù…ÛŒÙ„â€ŒØ´Ø¯Ù‡",
                            "style": {
                              "type": "custom",
                              "color": "#5DA181",
                              "fontSize": 14.0,
                              "fontWeight": "w700"
                            },
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "container"
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
                              "data": "Ø²Ù…Ø§Ù† Ø§ÛŒØ¬Ø§Ø¯",
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
                          "data": "Û±Û´Û°Ûµ/Û°Û±/Û²Û´ - Û±Ûµ:Û³Ûµ",
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
                      "height": 12.0,
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
                              "data": "Ø²Ù…Ø§Ù† Ø§ØªÙ…Ø§Ù…",
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
                          "data": "Û±Û´Û°Ûµ/Û°Û±/Û²Û¶ - Û°Û·:Û±Û·",
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
                "type": "container"
              }
            ],
            "type": "column"
          },
          "replacement": {
            "type": "visibility",
            "visible": "[[crDetailVariantCompleteDocsEmpty]]",
            "child": {
              "crossAxisAlignment": "stretch",
              "children": [
                {
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
                      "textAlign": "center",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    {
                      "height": 20.0,
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
                              "data": "Ø´Ø±ÙˆØ¹ ÙØ±Ø¢ÛŒÙ†Ø¯",
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
                          "data": "Û±Û´Û°Ûµ/Û°Û±/Û²Û³ - Û±Û°:ÛµÛµ",
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
                      "height": 14.0,
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
                              "data": "ÙˆØ¶Ø¹ÛŒØª ÙØ±Ø¢ÛŒÙ†Ø¯",
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
                    }
                  ],
                  "type": "column"
                }
              ],
              "type": "column"
            },
            "replacement": {
              "crossAxisAlignment": "stretch",
              "children": [
                {
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
                      "textAlign": "center",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    {
                      "height": 20.0,
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
                              "data": "Ø´Ø±ÙˆØ¹ ÙØ±Ø¢ÛŒÙ†Ø¯",
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
                          "data": "Û±Û´Û°Û´/Û±Û°/Û°Û¶ - Û±Û³:Û´Û¶",
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
                      "height": 14.0,
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
                              "data": "ÙˆØ¶Ø¹ÛŒØª ÙØ±Ø¢ÛŒÙ†Ø¯",
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
                      "height": 14.0,
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
                              "data": "Ù…Ø¨Ù„Øº ØªØ³Ù‡ÛŒÙ„Ø§Øª Ø§Ø²Ø¯ÙˆØ§Ø¬",
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
                          "data": "Û³,Û°Û°Û°,Û°Û°Û°,Û°Û°Û° Ø±ÛŒØ§Ù„",
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
                {
                  "height": 18.0,
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
                        "mainAxisAlignment": "spaceBetween",
                        "textDirection": "rtl",
                        "children": [
                          {
                            "child": {
                              "data": "Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ø¹Ù‚Ø¯ Ù†Ø§Ù…Ù‡ Ù…ØªÙ‚Ø§Ø¶ÛŒ",
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
                            "type": "expanded"
                          },
                          {
                            "width": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "padding": {
                              "left": 10.0,
                              "top": 4.0,
                              "right": 10.0,
                              "bottom": 4.0
                            },
                            "decoration": {
                              "color": "#DDF3E8",
                              "borderRadius": {
                                "topLeft": 8.0,
                                "topRight": 8.0,
                                "bottomLeft": 8.0,
                                "bottomRight": 8.0
                              }
                            },
                            "child": {
                              "data": "ØªÚ©Ù…ÛŒÙ„â€ŒØ´Ø¯Ù‡",
                              "style": {
                                "type": "custom",
                                "color": "#5DA181",
                                "fontSize": 14.0,
                                "fontWeight": "w700"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "type": "container"
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
                                "data": "Ø²Ù…Ø§Ù† Ø§ÛŒØ¬Ø§Ø¯",
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
                            "data": "Û±Û´Û°Û´/Û±Û°/Û°Û¶ - Û±Û³:Û´Û¶",
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
                        "height": 12.0,
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
                                "data": "Ø²Ù…Ø§Ù† Ø§ØªÙ…Ø§Ù…",
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
                            "data": "Û±Û´Û°Û´/Û±Û²/Û³Û° - Û±Û°:ÛµÛµ",
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
                  "type": "container"
                },
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
                        "mainAxisAlignment": "spaceBetween",
                        "textDirection": "rtl",
                        "children": [
                          {
                            "child": {
                              "data": "Ù…Ø¯Ø§Ø±Ú© Ù…ØªÙ‚Ø§Ø¶ÛŒ",
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
                            "type": "expanded"
                          },
                          {
                            "width": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "padding": {
                              "left": 10.0,
                              "top": 4.0,
                              "right": 10.0,
                              "bottom": 4.0
                            },
                            "decoration": {
                              "color": "#DDF3E8",
                              "borderRadius": {
                                "topLeft": 8.0,
                                "topRight": 8.0,
                                "bottomLeft": 8.0,
                                "bottomRight": 8.0
                              }
                            },
                            "child": {
                              "data": "ØªÚ©Ù…ÛŒÙ„â€ŒØ´Ø¯Ù‡",
                              "style": {
                                "type": "custom",
                                "color": "#5DA181",
                                "fontSize": 14.0,
                                "fontWeight": "w700"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "type": "container"
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
                                "data": "Ø²Ù…Ø§Ù† Ø§ÛŒØ¬Ø§Ø¯",
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
                            "data": "Û±Û´Û°Û´/Û±Û°/Û°Û¶ - Û±Û³:Û´Û¶",
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
                        "height": 12.0,
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
                                "data": "Ø²Ù…Ø§Ù† Ø§ØªÙ…Ø§Ù…",
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
                            "data": "Û±Û´Û°Û´/Û±Û²/Û³Û° - Û±Û°:ÛµÛ¶",
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
                  "type": "container"
                },
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
                        "mainAxisAlignment": "spaceBetween",
                        "textDirection": "rtl",
                        "children": [
                          {
                            "child": {
                              "data": "Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ù…Ø­Ù„ Ø³Ú©ÙˆÙ†Øª Ù…ØªÙ‚Ø§Ø¶ÛŒ",
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
                            "type": "expanded"
                          },
                          {
                            "width": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "padding": {
                              "left": 10.0,
                              "top": 4.0,
                              "right": 10.0,
                              "bottom": 4.0
                            },
                            "decoration": {
                              "color": "#DDF3E8",
                              "borderRadius": {
                                "topLeft": 8.0,
                                "topRight": 8.0,
                                "bottomLeft": 8.0,
                                "bottomRight": 8.0
                              }
                            },
                            "child": {
                              "data": "ØªÚ©Ù…ÛŒÙ„â€ŒØ´Ø¯Ù‡",
                              "style": {
                                "type": "custom",
                                "color": "#5DA181",
                                "fontSize": 14.0,
                                "fontWeight": "w700"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "type": "container"
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
                                "data": "Ø²Ù…Ø§Ù† Ø§ÛŒØ¬Ø§Ø¯",
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
                            "data": "Û±Û´Û°Û´/Û±Û°/Û°Û¶ - Û±Û³:Û´Û¶",
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
                        "height": 12.0,
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
                                "data": "Ø²Ù…Ø§Ù† Ø§ØªÙ…Ø§Ù…",
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
                            "data": "Û±Û´Û°Û´/Û±Û²/Û³Û° - Û±Û°:ÛµÛ¶",
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
                  "type": "container"
                }
              ],
              "type": "column"
            }
          }
        }
      },
      "type": "singleChildScrollView"
    },
    "type": "scaffold"
  }
}
```
