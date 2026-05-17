# flows/profile_real/json/profile_real_destinations.json

Source: lib/stac/tobank/flows/profile_real/json/profile_real_destinations.json

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
        "key": "profileRealDestTabCard",
        "value": true
      },
      {
        "key": "profileRealDestTabDeposit",
        "value": false
      },
      {
        "key": "profileRealDestTabIban",
        "value": false
      },
      {
        "key": "profileRealShowAddCardSheet",
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
        "data": "{{appStrings.profile.real.destinations.title}}",
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
                "padding": {
                  "left": 8.0,
                  "top": 4.0,
                  "right": 8.0,
                  "bottom": 4.0
                },
                "decoration": {
                  "color": "{{appColors.current.background.surface}}",
                  "borderRadius": {
                    "topLeft": 8.0,
                    "topRight": 8.0,
                    "bottomLeft": 8.0,
                    "bottomRight": 8.0
                  }
                },
                "child": {
                  "textDirection": "rtl",
                  "children": [
                    {
                      "child": {
                        "child": {
                          "padding": {
                            "top": 10.0,
                            "bottom": 10.0
                          },
                          "child": {
                            "mainAxisSize": "min",
                            "children": [
                              {
                                "type": "visibility",
                                "visible": "[[profileRealDestTabCard]]",
                                "child": {
                                  "data": "{{appStrings.profile.real.destinations.tabCard}}",
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
                                "replacement": {
                                  "data": "{{appStrings.profile.real.destinations.tabCard}}",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
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
                                "visible": "[[profileRealDestTabCard]]",
                                "child": {
                                  "color": "{{appColors.current.primary.color}}",
                                  "width": 52.0,
                                  "height": 2.0,
                                  "type": "container"
                                },
                                "replacement": {
                                  "color": "#00000000",
                                  "width": 52.0,
                                  "height": 2.0,
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
                          "values": [
                            {
                              "key": "profileRealDestTabCard",
                              "value": true
                            },
                            {
                              "key": "profileRealDestTabDeposit",
                              "value": false
                            },
                            {
                              "key": "profileRealDestTabIban",
                              "value": false
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
                      "height": 24.0,
                      "type": "container"
                    },
                    {
                      "child": {
                        "child": {
                          "padding": {
                            "top": 10.0,
                            "bottom": 10.0
                          },
                          "child": {
                            "mainAxisSize": "min",
                            "children": [
                              {
                                "type": "visibility",
                                "visible": "[[profileRealDestTabDeposit]]",
                                "child": {
                                  "data": "{{appStrings.profile.real.destinations.tabDeposit}}",
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
                                "replacement": {
                                  "data": "{{appStrings.profile.real.destinations.tabDeposit}}",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
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
                                "visible": "[[profileRealDestTabDeposit]]",
                                "child": {
                                  "color": "{{appColors.current.primary.color}}",
                                  "width": 52.0,
                                  "height": 2.0,
                                  "type": "container"
                                },
                                "replacement": {
                                  "color": "#00000000",
                                  "width": 52.0,
                                  "height": 2.0,
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
                          "values": [
                            {
                              "key": "profileRealDestTabCard",
                              "value": false
                            },
                            {
                              "key": "profileRealDestTabDeposit",
                              "value": true
                            },
                            {
                              "key": "profileRealDestTabIban",
                              "value": false
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
                      "height": 24.0,
                      "type": "container"
                    },
                    {
                      "child": {
                        "child": {
                          "padding": {
                            "top": 10.0,
                            "bottom": 10.0
                          },
                          "child": {
                            "mainAxisSize": "min",
                            "children": [
                              {
                                "type": "visibility",
                                "visible": "[[profileRealDestTabIban]]",
                                "child": {
                                  "data": "{{appStrings.profile.real.destinations.tabIban}}",
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
                                "replacement": {
                                  "data": "{{appStrings.profile.real.destinations.tabIban}}",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
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
                                "visible": "[[profileRealDestTabIban]]",
                                "child": {
                                  "color": "{{appColors.current.primary.color}}",
                                  "width": 52.0,
                                  "height": 2.0,
                                  "type": "container"
                                },
                                "replacement": {
                                  "color": "#00000000",
                                  "width": 52.0,
                                  "height": 2.0,
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
                          "values": [
                            {
                              "key": "profileRealDestTabCard",
                              "value": false
                            },
                            {
                              "key": "profileRealDestTabDeposit",
                              "value": false
                            },
                            {
                              "key": "profileRealDestTabIban",
                              "value": true
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
                "type": "container"
              },
              {
                "height": 16.0,
                "type": "sizedBox"
              },
              {
                "type": "visibility",
                "visible": "[[profileRealDestTabCard]]",
                "child": {
                  "children": [
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.cardItem1Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.cardItem1Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.cardItem2Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.cardItem2Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.cardItem3Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.cardItem3Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.cardItem4Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.cardItem4Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.cardItem5Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.cardItem5Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    }
                  ],
                  "type": "column"
                }
              },
              {
                "type": "visibility",
                "visible": "[[profileRealDestTabDeposit]]",
                "child": {
                  "children": [
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.depositItem1Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.depositItem1Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_success_new.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.depositItem2Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.depositItem2Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.depositItem3Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.depositItem3Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.depositItem4Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.depositItem4Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    }
                  ],
                  "type": "column"
                }
              },
              {
                "type": "visibility",
                "visible": "[[profileRealDestTabIban]]",
                "child": {
                  "children": [
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem1Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem1Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem2Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem2Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem3Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem3Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem4Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem4Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_gardeshgari.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem5Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem5Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 14.0,
                          "top": 14.0,
                          "right": 14.0,
                          "bottom": 14.0
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_success_new.svg",
                              "imageType": "asset",
                              "width": 24.0,
                              "height": 24.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem6Title}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
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
                                    "data": "{{appStrings.profile.real.destinations.ibanItem6Subtitle}}",
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
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "color": "{{appColors.current.input.borderEnabled}}",
                              "width": 1.0,
                              "height": 16.0,
                              "type": "container"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "icon": "more_vert",
                              "iconType": "material",
                              "size": 20.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.profile.real.destinations.optionsTitle}}",
                        "content": "{{appStrings.profile.real.destinations.optionsContent}}"
                      },
                      "type": "gestureDetector"
                    }
                  ],
                  "type": "column"
                }
              },
              {
                "height": 96.0,
                "type": "sizedBox"
              }
            ],
            "type": "column"
          },
          "type": "singleChildScrollView"
        },
        {
          "alignment": "bottomCenter",
          "child": {
            "type": "visibility",
            "visible": "[[profileRealDestTabCard]]",
            "child": {
              "padding": {
                "bottom": 16.0
              },
              "child": {
                "onPressed": {
                  "actionType": "setValue",
                  "key": "profileRealShowAddCardSheet",
                  "value": true
                },
                "style": {
                  "backgroundColor": "{{appColors.current.button.primary.backgroundColor}}",
                  "elevation": 6.0,
                  "padding": {
                    "left": 12.0,
                    "right": 12.0
                  },
                  "fixedSize": {
                    "width": 175.0,
                    "height": 56.0
                  },
                  "shape": {
                    "type": "roundedRectangleBorder",
                    "borderRadius": {
                      "topLeft": 16.0,
                      "topRight": 16.0,
                      "bottomLeft": 16.0,
                      "bottomRight": 16.0
                    }
                  }
                },
                "child": {
                  "mainAxisAlignment": "center",
                  "mainAxisSize": "min",
                  "textDirection": "rtl",
                  "children": [
                    {
                      "decoration": {
                        "border": {
                          "color": "{{appColors.current.button.primary.foregroundColor}}",
                          "width": 1.0
                        },
                        "borderRadius": {
                          "topLeft": 6.0,
                          "topRight": 6.0,
                          "bottomLeft": 6.0,
                          "bottomRight": 6.0
                        }
                      },
                      "width": 24.0,
                      "height": 24.0,
                      "child": {
                        "child": {
                          "icon": "add",
                          "iconType": "material",
                          "size": 15.0,
                          "color": "{{appColors.current.button.primary.foregroundColor}}",
                          "type": "icon"
                        },
                        "type": "center"
                      },
                      "type": "container"
                    },
                    {
                      "width": 7.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "{{appStrings.profile.real.destinations.addDestinationButton}}",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.button.primary.foregroundColor}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "type": "text"
                    }
                  ],
                  "type": "row"
                },
                "type": "filledButton"
              },
              "type": "padding"
            }
          },
          "type": "align"
        },
        {
          "type": "visibility",
          "visible": "[[profileRealShowAddCardSheet]]",
          "child": {
            "children": [
              {
                "child": {
                  "color": "#9F000000",
                  "width": 999999.0,
                  "height": 999999.0,
                  "type": "container"
                },
                "onTap": {
                  "actionType": "setValue",
                  "key": "profileRealShowAddCardSheet",
                  "value": false
                },
                "type": "gestureDetector"
              },
              {
                "alignment": "bottomCenter",
                "child": {
                  "padding": {
                    "left": 16.0,
                    "top": 10.0,
                    "right": 16.0,
                    "bottom": 16.0
                  },
                  "decoration": {
                    "color": "{{appColors.current.background.surface}}",
                    "borderRadius": {
                      "topLeft": 16.0,
                      "topRight": 16.0
                    }
                  },
                  "width": 999999.0,
                  "child": {
                    "mainAxisSize": "min",
                    "crossAxisAlignment": "stretch",
                    "children": [
                      {
                        "child": {
                          "decoration": {
                            "color": "#668790A3",
                            "borderRadius": {
                              "topLeft": 999.0,
                              "topRight": 999.0,
                              "bottomLeft": 999.0,
                              "bottomRight": 999.0
                            }
                          },
                          "width": 44.0,
                          "height": 5.0,
                          "type": "container"
                        },
                        "type": "center"
                      },
                      {
                        "height": 24.0,
                        "type": "sizedBox"
                      },
                      {
                        "textDirection": "rtl",
                        "children": [
                          {
                            "child": {
                              "data": "{{appStrings.profile.real.destinations.addCardTitle}}",
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
                            "onPressed": {
                              "actionType": "showResult",
                              "title": "{{appStrings.profile.real.destinations.scanCard}}",
                              "content": "{{appStrings.profile.real.destinations.scanCardSoon}}"
                            },
                            "style": {
                              "minimumSize": {
                                "width": 125.0,
                                "height": 50.0
                              },
                              "side": {
                                "color": "{{appColors.current.text.title}}",
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
                              "mainAxisSize": "min",
                              "textDirection": "rtl",
                              "children": [
                                {
                                  "src": "assets/icons/ic_scanner.svg",
                                  "imageType": "asset",
                                  "color": "{{appColors.current.text.title}}",
                                  "width": 23.0,
                                  "height": 23.0,
                                  "type": "image"
                                },
                                {
                                  "width": 6.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "data": "{{appStrings.profile.real.destinations.scanCard}}",
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
                            "type": "outlinedButton"
                          }
                        ],
                        "type": "row"
                      },
                      {
                        "height": 16.0,
                        "type": "sizedBox"
                      },
                      {
                        "data": "{{appStrings.profile.real.destinations.cardNumberLabel}}",
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
                        "height": 8.0,
                        "type": "sizedBox"
                      },
                      {
                        "id": "profileRealDestinationCardNumber",
                        "decoration": {
                          "hintText": "{{appStrings.profile.real.destinations.cardNumberHint}}",
                          "hintStyle": {
                            "type": "custom",
                            "color": "{{appColors.current.text.hint}}",
                            "fontSize": 14.0,
                            "fontWeight": "w500"
                          },
                          "contentPadding": {
                            "left": 16.0,
                            "top": 19.0,
                            "right": 16.0,
                            "bottom": 19.0
                          },
                          "filled": false
                        },
                        "keyboardType": "number",
                        "textAlign": "right",
                        "textDirection": "ltr",
                        "type": "textFormField"
                      },
                      {
                        "height": 16.0,
                        "type": "sizedBox"
                      },
                      {
                        "data": "{{appStrings.profile.real.destinations.cardTitleLabel}}",
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
                        "height": 8.0,
                        "type": "sizedBox"
                      },
                      {
                        "id": "profileRealDestinationCardTitle",
                        "decoration": {
                          "hintText": "{{appStrings.profile.real.destinations.cardTitleHint}}",
                          "hintStyle": {
                            "type": "custom",
                            "color": "{{appColors.current.text.hint}}",
                            "fontSize": 14.0,
                            "fontWeight": "w500"
                          },
                          "contentPadding": {
                            "left": 16.0,
                            "top": 19.0,
                            "right": 16.0,
                            "bottom": 19.0
                          },
                          "filled": false
                        },
                        "keyboardType": "text",
                        "textAlign": "right",
                        "textDirection": "rtl",
                        "type": "textFormField"
                      },
                      {
                        "height": 24.0,
                        "type": "sizedBox"
                      },
                      {
                        "onPressed": {
                          "actionType": "sequence",
                          "actions": [
                            {
                              "actionType": "setValue",
                              "key": "profileRealShowAddCardSheet",
                              "value": false
                            },
                            {
                              "actionType": "showResult",
                              "title": "{{appStrings.profile.real.destinations.submitTitle}}",
                              "content": "{{appStrings.profile.real.destinations.submitContent}}"
                            }
                          ]
                        },
                        "style": {
                          "backgroundColor": "{{appColors.current.button.primary.backgroundColor}}",
                          "fixedSize": {
                            "width": 999999.0,
                            "height": 52.0
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
                          "data": "{{appStrings.profile.real.destinations.submitButton}}",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.button.primary.foregroundColor}}",
                            "fontSize": 16.0,
                            "fontWeight": "w700"
                          },
                          "type": "text"
                        },
                        "type": "filledButton"
                      }
                    ],
                    "type": "column"
                  },
                  "type": "container"
                },
                "type": "align"
              }
            ],
            "type": "stack"
          }
        }
      ],
      "type": "stack"
    },
    "type": "scaffold"
  }
}
```
