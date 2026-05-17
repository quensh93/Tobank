# flows/package_real/json/package_real_package_list.json

Source: lib/stac/tobank/flows/package_real/json/package_real_package_list.json

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
        "key": "crPkgTabDaily",
        "value": false
      },
      {
        "key": "crPkgTabWeekly",
        "value": false
      },
      {
        "key": "crPkgTabMonthly",
        "value": false
      },
      {
        "key": "crPkgTabOther",
        "value": true
      },
      {
        "key": "crPkgContinueEnabled",
        "value": false
      },
      {
        "key": "crPkgSel1",
        "value": false
      },
      {
        "key": "crPkgSel2",
        "value": false
      },
      {
        "key": "crPkgSel3",
        "value": false
      },
      {
        "key": "crPkgSel4",
        "value": false
      },
      {
        "key": "crPkgSel5",
        "value": false
      },
      {
        "key": "crPkgSel6",
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
              "textDirection": "rtl",
              "children": [
                {
                  "child": {
                    "child": {
                      "type": "visibility",
                      "visible": "[[crPkgTabDaily]]",
                      "child": {
                        "padding": {
                          "top": 10.0,
                          "bottom": 10.0
                        },
                        "decoration": {
                          "color": "#EAFBFD",
                          "border": {
                            "color": "#20C4D8",
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
                          "data": "Ø±ÙˆØ²Ø§Ù†Ù‡",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w600"
                          },
                          "textAlign": "center",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "type": "container"
                      },
                      "replacement": {
                        "padding": {
                          "top": 10.0,
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
                          "data": "Ø±ÙˆØ²Ø§Ù†Ù‡",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "center",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "type": "container"
                      }
                    },
                    "onTap": {
                      "actionType": "setValue",
                      "values": [
                        {
                          "key": "crPkgTabDaily",
                          "value": true
                        },
                        {
                          "key": "crPkgTabWeekly",
                          "value": false
                        },
                        {
                          "key": "crPkgTabMonthly",
                          "value": false
                        },
                        {
                          "key": "crPkgTabOther",
                          "value": false
                        },
                        {
                          "key": "crPkgContinueEnabled",
                          "value": false
                        },
                        {
                          "key": "crPkgSel1",
                          "value": false
                        },
                        {
                          "key": "crPkgSel2",
                          "value": false
                        },
                        {
                          "key": "crPkgSel3",
                          "value": false
                        },
                        {
                          "key": "crPkgSel4",
                          "value": false
                        },
                        {
                          "key": "crPkgSel5",
                          "value": false
                        },
                        {
                          "key": "crPkgSel6",
                          "value": false
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
                      "visible": "[[crPkgTabWeekly]]",
                      "child": {
                        "padding": {
                          "top": 10.0,
                          "bottom": 10.0
                        },
                        "decoration": {
                          "color": "#EAFBFD",
                          "border": {
                            "color": "#20C4D8",
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
                          "data": "Ù‡ÙØªÚ¯ÛŒ",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w600"
                          },
                          "textAlign": "center",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "type": "container"
                      },
                      "replacement": {
                        "padding": {
                          "top": 10.0,
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
                          "data": "Ù‡ÙØªÚ¯ÛŒ",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "center",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "type": "container"
                      }
                    },
                    "onTap": {
                      "actionType": "setValue",
                      "values": [
                        {
                          "key": "crPkgTabDaily",
                          "value": false
                        },
                        {
                          "key": "crPkgTabWeekly",
                          "value": true
                        },
                        {
                          "key": "crPkgTabMonthly",
                          "value": false
                        },
                        {
                          "key": "crPkgTabOther",
                          "value": false
                        },
                        {
                          "key": "crPkgContinueEnabled",
                          "value": false
                        },
                        {
                          "key": "crPkgSel1",
                          "value": false
                        },
                        {
                          "key": "crPkgSel2",
                          "value": false
                        },
                        {
                          "key": "crPkgSel3",
                          "value": false
                        },
                        {
                          "key": "crPkgSel4",
                          "value": false
                        },
                        {
                          "key": "crPkgSel5",
                          "value": false
                        },
                        {
                          "key": "crPkgSel6",
                          "value": false
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
                      "visible": "[[crPkgTabMonthly]]",
                      "child": {
                        "padding": {
                          "top": 10.0,
                          "bottom": 10.0
                        },
                        "decoration": {
                          "color": "#EAFBFD",
                          "border": {
                            "color": "#20C4D8",
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
                          "data": "Ù…Ø§Ù‡Ø§Ù†Ù‡",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w600"
                          },
                          "textAlign": "center",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "type": "container"
                      },
                      "replacement": {
                        "padding": {
                          "top": 10.0,
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
                          "data": "Ù…Ø§Ù‡Ø§Ù†Ù‡",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "center",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "type": "container"
                      }
                    },
                    "onTap": {
                      "actionType": "setValue",
                      "values": [
                        {
                          "key": "crPkgTabDaily",
                          "value": false
                        },
                        {
                          "key": "crPkgTabWeekly",
                          "value": false
                        },
                        {
                          "key": "crPkgTabMonthly",
                          "value": true
                        },
                        {
                          "key": "crPkgTabOther",
                          "value": false
                        },
                        {
                          "key": "crPkgContinueEnabled",
                          "value": false
                        },
                        {
                          "key": "crPkgSel1",
                          "value": false
                        },
                        {
                          "key": "crPkgSel2",
                          "value": false
                        },
                        {
                          "key": "crPkgSel3",
                          "value": false
                        },
                        {
                          "key": "crPkgSel4",
                          "value": false
                        },
                        {
                          "key": "crPkgSel5",
                          "value": false
                        },
                        {
                          "key": "crPkgSel6",
                          "value": false
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
                      "visible": "[[crPkgTabOther]]",
                      "child": {
                        "padding": {
                          "top": 10.0,
                          "bottom": 10.0
                        },
                        "decoration": {
                          "color": "#EAFBFD",
                          "border": {
                            "color": "#20C4D8",
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
                          "data": "Ø³Ø§ÛŒØ±",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w600"
                          },
                          "textAlign": "center",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "type": "container"
                      },
                      "replacement": {
                        "padding": {
                          "top": 10.0,
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
                          "data": "Ø³Ø§ÛŒØ±",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "center",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "type": "container"
                      }
                    },
                    "onTap": {
                      "actionType": "setValue",
                      "values": [
                        {
                          "key": "crPkgTabDaily",
                          "value": false
                        },
                        {
                          "key": "crPkgTabWeekly",
                          "value": false
                        },
                        {
                          "key": "crPkgTabMonthly",
                          "value": false
                        },
                        {
                          "key": "crPkgTabOther",
                          "value": true
                        },
                        {
                          "key": "crPkgContinueEnabled",
                          "value": false
                        },
                        {
                          "key": "crPkgSel1",
                          "value": false
                        },
                        {
                          "key": "crPkgSel2",
                          "value": false
                        },
                        {
                          "key": "crPkgSel3",
                          "value": false
                        },
                        {
                          "key": "crPkgSel4",
                          "value": false
                        },
                        {
                          "key": "crPkgSel5",
                          "value": false
                        },
                        {
                          "key": "crPkgSel6",
                          "value": false
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
              "height": 16.0,
              "type": "sizedBox"
            },
            {
              "child": {
                "type": "visibility",
                "visible": "[[crPkgTabMonthly]]",
                "child": {
                  "child": {
                    "mainAxisSize": "min",
                    "children": [
                      {
                        "src": "assets/icons/ic_package_empty_list_light.svg",
                        "imageType": "asset",
                        "width": 144.0,
                        "height": 144.0,
                        "fit": "contain",
                        "type": "image"
                      },
                      {
                        "data": "Ø¨Ø³ØªÙ‡â€ŒÛŒ Ø§ÛŒÙ†ØªØ±Ù†ØªÛŒ Ù…Ø§Ù‡Ø§Ù†Ù‡ Ø¯Ø± Ø­Ø§Ù„ Ù…ÙˆØ¬ÙˆØ¯ Ù†Ù…ÛŒâ€ŒØ¨Ø§Ø´Ø¯",
                        "style": {
                          "type": "custom",
                          "color": "{{appColors.current.text.title}}",
                          "fontSize": 18.0,
                          "fontWeight": "w600"
                        },
                        "textAlign": "center",
                        "textDirection": "rtl",
                        "type": "text"
                      }
                    ],
                    "type": "column"
                  },
                  "type": "center"
                },
                "replacement": {
                  "child": {
                    "crossAxisAlignment": "stretch",
                    "children": [
                      {
                        "child": {
                          "padding": {
                            "bottom": 10.0
                          },
                          "child": {
                            "type": "visibility",
                            "visible": "[[crPkgSel1]]",
                            "child": {
                              "decoration": {
                                "color": "#F4FDFF",
                                "border": {
                                  "color": "#20C4D8",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            },
                            "replacement": {
                              "decoration": {
                                "color": "{{appColors.current.background.surfaceContainer}}",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            }
                          },
                          "type": "padding"
                        },
                        "onTap": {
                          "actionType": "setValue",
                          "values": [
                            {
                              "key": "crPkgSel1",
                              "value": true
                            },
                            {
                              "key": "crPkgSel2",
                              "value": false
                            },
                            {
                              "key": "crPkgSel3",
                              "value": false
                            },
                            {
                              "key": "crPkgSel4",
                              "value": false
                            },
                            {
                              "key": "crPkgSel5",
                              "value": false
                            },
                            {
                              "key": "crPkgSel6",
                              "value": false
                            },
                            {
                              "key": "crPkgContinueEnabled",
                              "value": true
                            },
                            {
                              "key": "crPkgSelectedAmount",
                              "value": "Û±ÛµÛ°,Û°Û°Û°"
                            },
                            {
                              "key": "crPkgSelectedName",
                              "value": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª"
                            }
                          ]
                        },
                        "type": "gestureDetector"
                      },
                      {
                        "child": {
                          "padding": {
                            "bottom": 10.0
                          },
                          "child": {
                            "type": "visibility",
                            "visible": "[[crPkgSel2]]",
                            "child": {
                              "decoration": {
                                "color": "#F4FDFF",
                                "border": {
                                  "color": "#20C4D8",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            },
                            "replacement": {
                              "decoration": {
                                "color": "{{appColors.current.background.surfaceContainer}}",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            }
                          },
                          "type": "padding"
                        },
                        "onTap": {
                          "actionType": "setValue",
                          "values": [
                            {
                              "key": "crPkgSel1",
                              "value": false
                            },
                            {
                              "key": "crPkgSel2",
                              "value": true
                            },
                            {
                              "key": "crPkgSel3",
                              "value": false
                            },
                            {
                              "key": "crPkgSel4",
                              "value": false
                            },
                            {
                              "key": "crPkgSel5",
                              "value": false
                            },
                            {
                              "key": "crPkgSel6",
                              "value": false
                            },
                            {
                              "key": "crPkgContinueEnabled",
                              "value": true
                            },
                            {
                              "key": "crPkgSelectedAmount",
                              "value": "Û±ÛµÛ°,Û°Û°Û°"
                            },
                            {
                              "key": "crPkgSelectedName",
                              "value": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª"
                            }
                          ]
                        },
                        "type": "gestureDetector"
                      },
                      {
                        "child": {
                          "padding": {
                            "bottom": 10.0
                          },
                          "child": {
                            "type": "visibility",
                            "visible": "[[crPkgSel3]]",
                            "child": {
                              "decoration": {
                                "color": "#F4FDFF",
                                "border": {
                                  "color": "#20C4D8",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            },
                            "replacement": {
                              "decoration": {
                                "color": "{{appColors.current.background.surfaceContainer}}",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            }
                          },
                          "type": "padding"
                        },
                        "onTap": {
                          "actionType": "setValue",
                          "values": [
                            {
                              "key": "crPkgSel1",
                              "value": false
                            },
                            {
                              "key": "crPkgSel2",
                              "value": false
                            },
                            {
                              "key": "crPkgSel3",
                              "value": true
                            },
                            {
                              "key": "crPkgSel4",
                              "value": false
                            },
                            {
                              "key": "crPkgSel5",
                              "value": false
                            },
                            {
                              "key": "crPkgSel6",
                              "value": false
                            },
                            {
                              "key": "crPkgContinueEnabled",
                              "value": true
                            },
                            {
                              "key": "crPkgSelectedAmount",
                              "value": "Û±ÛµÛ°,Û°Û°Û°"
                            },
                            {
                              "key": "crPkgSelectedName",
                              "value": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª"
                            }
                          ]
                        },
                        "type": "gestureDetector"
                      },
                      {
                        "child": {
                          "padding": {
                            "bottom": 10.0
                          },
                          "child": {
                            "type": "visibility",
                            "visible": "[[crPkgSel4]]",
                            "child": {
                              "decoration": {
                                "color": "#F4FDFF",
                                "border": {
                                  "color": "#20C4D8",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            },
                            "replacement": {
                              "decoration": {
                                "color": "{{appColors.current.background.surfaceContainer}}",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            }
                          },
                          "type": "padding"
                        },
                        "onTap": {
                          "actionType": "setValue",
                          "values": [
                            {
                              "key": "crPkgSel1",
                              "value": false
                            },
                            {
                              "key": "crPkgSel2",
                              "value": false
                            },
                            {
                              "key": "crPkgSel3",
                              "value": false
                            },
                            {
                              "key": "crPkgSel4",
                              "value": true
                            },
                            {
                              "key": "crPkgSel5",
                              "value": false
                            },
                            {
                              "key": "crPkgSel6",
                              "value": false
                            },
                            {
                              "key": "crPkgContinueEnabled",
                              "value": true
                            },
                            {
                              "key": "crPkgSelectedAmount",
                              "value": "Û±ÛµÛ°,Û°Û°Û°"
                            },
                            {
                              "key": "crPkgSelectedName",
                              "value": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª"
                            }
                          ]
                        },
                        "type": "gestureDetector"
                      },
                      {
                        "child": {
                          "padding": {
                            "bottom": 10.0
                          },
                          "child": {
                            "type": "visibility",
                            "visible": "[[crPkgSel5]]",
                            "child": {
                              "decoration": {
                                "color": "#F4FDFF",
                                "border": {
                                  "color": "#20C4D8",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            },
                            "replacement": {
                              "decoration": {
                                "color": "{{appColors.current.background.surfaceContainer}}",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            }
                          },
                          "type": "padding"
                        },
                        "onTap": {
                          "actionType": "setValue",
                          "values": [
                            {
                              "key": "crPkgSel1",
                              "value": false
                            },
                            {
                              "key": "crPkgSel2",
                              "value": false
                            },
                            {
                              "key": "crPkgSel3",
                              "value": false
                            },
                            {
                              "key": "crPkgSel4",
                              "value": false
                            },
                            {
                              "key": "crPkgSel5",
                              "value": true
                            },
                            {
                              "key": "crPkgSel6",
                              "value": false
                            },
                            {
                              "key": "crPkgContinueEnabled",
                              "value": true
                            },
                            {
                              "key": "crPkgSelectedAmount",
                              "value": "Û±ÛµÛ°,Û°Û°Û°"
                            },
                            {
                              "key": "crPkgSelectedName",
                              "value": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª"
                            }
                          ]
                        },
                        "type": "gestureDetector"
                      },
                      {
                        "child": {
                          "padding": {
                            "bottom": 10.0
                          },
                          "child": {
                            "type": "visibility",
                            "visible": "[[crPkgSel6]]",
                            "child": {
                              "decoration": {
                                "color": "#F4FDFF",
                                "border": {
                                  "color": "#20C4D8",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            },
                            "replacement": {
                              "decoration": {
                                "color": "{{appColors.current.background.surfaceContainer}}",
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
                                  "top": 12.0,
                                  "right": 12.0,
                                  "bottom": 12.0
                                },
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "src": "assets/icons/ic_package.svg",
                                      "imageType": "asset",
                                      "color": "{{appColors.current.text.disable}}",
                                      "width": 34.0,
                                      "height": 34.0,
                                      "type": "image"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "child": {
                                        "data": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª +\nÙ…Ø§Ù„ÛŒØ§Øª",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.text.title}}",
                                          "fontSize": 14.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "rtl",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "data": "ÛµÛ³,Û±Û¶Û°",
                                      "style": {
                                        "type": "custom",
                                        "color": "{{appColors.current.text.title}}",
                                        "fontSize": 16.0,
                                        "fontWeight": "w600"
                                      },
                                      "textDirection": "ltr",
                                      "type": "text"
                                    },
                                    {
                                      "width": 8.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "icon": "chevron_left",
                                      "iconType": "material",
                                      "size": 24.0,
                                      "color": "{{appColors.current.text.title}}",
                                      "type": "icon"
                                    }
                                  ],
                                  "type": "row"
                                },
                                "type": "container"
                              },
                              "type": "container"
                            }
                          },
                          "type": "padding"
                        },
                        "onTap": {
                          "actionType": "setValue",
                          "values": [
                            {
                              "key": "crPkgSel1",
                              "value": false
                            },
                            {
                              "key": "crPkgSel2",
                              "value": false
                            },
                            {
                              "key": "crPkgSel3",
                              "value": false
                            },
                            {
                              "key": "crPkgSel4",
                              "value": false
                            },
                            {
                              "key": "crPkgSel5",
                              "value": false
                            },
                            {
                              "key": "crPkgSel6",
                              "value": true
                            },
                            {
                              "key": "crPkgContinueEnabled",
                              "value": true
                            },
                            {
                              "key": "crPkgSelectedAmount",
                              "value": "Û±ÛµÛ°,Û°Û°Û°"
                            },
                            {
                              "key": "crPkgSelectedName",
                              "value": "Ø¨Ø³ØªÙ‡ Ø§ÛŒÙ†ØªØ±Ù†Øª Û³Ûµ Ø±ÙˆØ²Ù‡ Û²ÛµÛ°Û° Ù…Ú¯Ø§Ø¨Ø§ÛŒØª"
                            }
                          ]
                        },
                        "type": "gestureDetector"
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
              "type": "visibility",
              "visible": "[[!crPkgContinueEnabled]]",
              "child": {
                "padding": {
                  "bottom": 6.0
                },
                "child": {
                  "style": {
                    "foregroundColor": "#667085",
                    "backgroundColor": "#D0D5DD",
                    "elevation": 0.0,
                    "fixedSize": {
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
                    "data": "Ø§Ø¯Ø§Ù…Ù‡",
                    "style": {
                      "type": "custom",
                      "color": "#667085",
                      "fontSize": 16.0,
                      "fontWeight": "w700"
                    },
                    "textDirection": "rtl",
                    "type": "text"
                  },
                  "type": "filledButton"
                },
                "type": "padding"
              },
              "replacement": {
                "padding": {
                  "bottom": 6.0
                },
                "child": {
                  "onPressed": {
                    "routeName": "package_real_payment",
                    "navigationStyle": "push",
                    "actionType": "navigate"
                  },
                  "style": {
                    "foregroundColor": "{{appColors.current.primary.onPrimary}}",
                    "backgroundColor": "{{appColors.current.primary.color}}",
                    "elevation": 0.0,
                    "fixedSize": {
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
                    "data": "Ø§Ø¯Ø§Ù…Ù‡",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.primary.onPrimary}}",
                      "fontSize": 16.0,
                      "fontWeight": "w700"
                    },
                    "textDirection": "rtl",
                    "type": "text"
                  },
                  "type": "filledButton"
                },
                "type": "padding"
              }
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
}
```
