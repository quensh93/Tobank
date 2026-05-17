# flows/promissory_real/json/promissory_real_intro.json

Source: lib/stac/tobank/flows/promissory_real/json/promissory_real_intro.json

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
        "key": "isMyPromissoryTab",
        "value": false
      },
      {
        "key": "isElectronicPromissoryExpanded",
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
          "src": "assets/icons/ic_right_arrow.svg",
          "imageType": "asset",
          "color": "{{appColors.current.text.title}}",
          "width": 24.0,
          "height": 24.0,
          "type": "image"
        },
        "type": "iconButton"
      },
      "title": {
        "data": "{{appStrings.promissory.PromissoryTitle}}",
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
    "body": {
      "children": [
        {
          "height": 16.0,
          "type": "sizedBox"
        },
        {
          "padding": {
            "left": 16.0,
            "right": 16.0
          },
          "child": {
            "textDirection": "rtl",
            "children": [
              {
                "child": {
                  "child": {
                    "children": [
                      {
                        "type": "visibility",
                        "visible": "[[!isMyPromissoryTab]]",
                        "child": {
                          "data": "{{appStrings.promissory.servicesTab}}",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 14.0,
                            "fontWeight": "w700"
                          },
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "replacement": {
                          "data": "{{appStrings.promissory.servicesTab}}",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 14.0,
                            "fontWeight": "w500"
                          },
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
                        "visible": "[[!isMyPromissoryTab]]",
                        "child": {
                          "decoration": {
                            "color": "#D32F2F",
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
                  "onTap": {
                    "actionType": "setValue",
                    "key": "isMyPromissoryTab",
                    "value": false
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
                    "children": [
                      {
                        "type": "visibility",
                        "visible": "[[isMyPromissoryTab]]",
                        "child": {
                          "data": "{{appStrings.promissory.myNotesTab}}",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 14.0,
                            "fontWeight": "w700"
                          },
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        "replacement": {
                          "data": "{{appStrings.promissory.myNotesTab}}",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 14.0,
                            "fontWeight": "w500"
                          },
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
                        "visible": "[[isMyPromissoryTab]]",
                        "child": {
                          "decoration": {
                            "color": "#D32F2F",
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
                  "onTap": {
                    "actionType": "setValue",
                    "key": "isMyPromissoryTab",
                    "value": true
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              }
            ],
            "type": "row"
          },
          "type": "padding"
        },
        {
          "height": 8.0,
          "type": "sizedBox"
        },
        {
          "color": "{{appColors.current.input.borderEnabled}}",
          "height": 1.0,
          "type": "container"
        },
        {
          "height": 16.0,
          "type": "sizedBox"
        },
        {
          "child": {
            "padding": {
              "left": 16.0,
              "right": 16.0
            },
            "child": {
              "type": "visibility",
              "visible": "[[isMyPromissoryTab]]",
              "child": {
                "child": {
                  "crossAxisAlignment": "stretch",
                  "children": [
                    {
                      "child": {
                        "padding": {
                          "left": 16.0,
                          "top": 18.0,
                          "right": 16.0,
                          "bottom": 18.0
                        },
                        "decoration": {
                          "color": "{{appColors.current.background.surfaceContainer}}",
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_promissory_request_history.svg",
                              "imageType": "asset",
                              "width": 21.0,
                              "height": 21.0,
                              "type": "image"
                            },
                            {
                              "width": 9.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "data": "ØªÚ©Ù…ÛŒÙ„ Ø´Ø¯Ù‡",
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
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.common.comingSoon}}",
                        "content": "{{appStrings.promissory.comingSoonMessage}}"
                      },
                      "type": "gestureDetector"
                    },
                    {
                      "height": 12.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "padding": {
                          "left": 16.0,
                          "top": 18.0,
                          "right": 16.0,
                          "bottom": 18.0
                        },
                        "decoration": {
                          "color": "{{appColors.current.background.surfaceContainer}}",
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
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "assets/icons/ic_promissory_finalize_history.svg",
                              "imageType": "asset",
                              "width": 21.0,
                              "height": 21.0,
                              "type": "image"
                            },
                            {
                              "width": 9.0,
                              "type": "sizedBox"
                            },
                            {
                              "child": {
                                "data": "Ø¯Ø± Ø§Ù†ØªØ¸Ø§Ø± ØªÚ©Ù…ÛŒÙ„",
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
                            }
                          ],
                          "type": "row"
                        },
                        "type": "container"
                      },
                      "onTap": {
                        "actionType": "showResult",
                        "title": "{{appStrings.common.comingSoon}}",
                        "content": "{{appStrings.promissory.comingSoonMessage}}"
                      },
                      "type": "gestureDetector"
                    }
                  ],
                  "type": "column"
                },
                "type": "singleChildScrollView"
              },
              "replacement": {
                "crossAxisAlignment": "stretch",
                "children": [
                  {
                    "child": {
                      "padding": {
                        "left": 16.0,
                        "top": 16.0,
                        "right": 16.0,
                        "bottom": 16.0
                      },
                      "decoration": {
                        "color": "{{appColors.current.background.surfaceContainer}}",
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
                            "textDirection": "rtl",
                            "children": [
                              {
                                "child": {
                                  "data": "{{appStrings.promissory.title}}",
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
                                "width": 8.0,
                                "type": "sizedBox"
                              },
                              {
                                "type": "visibility",
                                "visible": "[[isElectronicPromissoryExpanded]]",
                                "child": {
                                  "src": "assets/icons/ic_arrow_circle_up.svg",
                                  "imageType": "asset",
                                  "width": 23.0,
                                  "height": 23.0,
                                  "type": "image"
                                },
                                "replacement": {
                                  "src": "assets/icons/ic_arrow_circle_down.svg",
                                  "imageType": "asset",
                                  "width": 23.0,
                                  "height": 23.0,
                                  "type": "image"
                                }
                              }
                            ],
                            "type": "row"
                          },
                          {
                            "type": "visibility",
                            "visible": "[[isElectronicPromissoryExpanded]]",
                            "child": {
                              "crossAxisAlignment": "stretch",
                              "children": [
                                {
                                  "height": 12.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "color": "{{appColors.current.input.borderEnabled}}",
                                  "height": 1.0,
                                  "type": "container"
                                },
                                {
                                  "height": 12.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "data": "Ø³ÙØªÙ‡ Ø§Ù„Ú©ØªØ±ÙˆÙ†ÛŒÚ©ÛŒØŒ ÛŒÚ© Ø³Ù†Ø¯ ØªØ¬Ø§Ø±ÛŒ Ø§Ø³Øª Ú©Ù‡ Ø¨Ù‡ ØµÙˆØ±Øª Ø§Ù„Ú©ØªØ±ÙˆÙ†ÛŒÚ©ÛŒØŒ ØµØ§Ø¯Ø± Ø´Ø¯Ù‡ Ùˆ Ø¨Ù‡ Ù…ÙˆØ¬Ø¨ Ø¢Ù†ØŒ ØµØ§Ø¯Ø±â€ŒÚ©Ù†Ù†Ø¯Ù‡ØŒ Ù¾Ø±Ø¯Ø§Ø®Øª Ù…Ø¨Ù„ØºÛŒ Ø±Ø§ Ø¯Ø± Ù‚Ø¨Ø§Ù„ Ø´Ø®Øµ Ø¯ÛŒÚ¯Ø±ØŒ Ù…ØªØ¹Ù‡Ø¯ Ù…ÛŒØ´ÙˆØ¯",
                                  "style": {
                                    "type": "custom",
                                    "color": "{{appColors.current.text.subtitle}}",
                                    "fontSize": 13.0
                                  },
                                  "textAlign": "right",
                                  "textDirection": "rtl",
                                  "type": "text"
                                }
                              ],
                              "type": "column"
                            }
                          }
                        ],
                        "type": "column"
                      },
                      "type": "container"
                    },
                    "onTap": {
                      "actionType": "setValue",
                      "key": "isElectronicPromissoryExpanded",
                      "value": "{{isElectronicPromissoryExpanded ? false : true}}"
                    },
                    "type": "gestureDetector"
                  },
                  {
                    "height": 12.0,
                    "type": "sizedBox"
                  },
                  {
                    "child": {
                      "child": {
                        "crossAxisAlignment": "stretch",
                        "children": [
                          {
                            "child": {
                              "padding": {
                                "left": 16.0,
                                "top": 16.0,
                                "right": 16.0,
                                "bottom": 16.0
                              },
                              "decoration": {
                                "color": "{{appColors.current.background.surfaceContainer}}",
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
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "decoration": {
                                      "borderRadius": {
                                        "topLeft": 8.0,
                                        "topRight": 8.0,
                                        "bottomLeft": 8.0,
                                        "bottomRight": 8.0
                                      }
                                    },
                                    "width": 48.0,
                                    "height": 48.0,
                                    "child": {
                                      "child": {
                                        "src": "assets/icons/ic_promissory_request.svg",
                                        "imageType": "asset",
                                        "width": 30.0,
                                        "height": 30.0,
                                        "type": "image"
                                      },
                                      "type": "center"
                                    },
                                    "type": "container"
                                  },
                                  {
                                    "width": 12.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "child": {
                                      "crossAxisAlignment": "end",
                                      "children": [
                                        {
                                          "data": "{{appStrings.promissory.requestPromissory}}",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w600"
                                          },
                                          "textDirection": "rtl",
                                          "type": "text"
                                        },
                                        {
                                          "height": 4.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "{{appStrings.promissory.requestPromissoryDesc}}",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 12.0
                                          },
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
                            "onTap": {
                              "assetPath": "lib/stac/tobank/flows/promissory_real/json/promissory_real_rules.json",
                              "navigationStyle": "push",
                              "actionType": "navigate"
                            },
                            "type": "gestureDetector"
                          },
                          {
                            "height": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "child": {
                              "padding": {
                                "left": 16.0,
                                "top": 16.0,
                                "right": 16.0,
                                "bottom": 16.0
                              },
                              "decoration": {
                                "color": "{{appColors.current.background.surfaceContainer}}",
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
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "decoration": {
                                      "borderRadius": {
                                        "topLeft": 8.0,
                                        "topRight": 8.0,
                                        "bottomLeft": 8.0,
                                        "bottomRight": 8.0
                                      }
                                    },
                                    "width": 48.0,
                                    "height": 48.0,
                                    "child": {
                                      "child": {
                                        "src": "assets/icons/ic_promissory_guarantee.svg",
                                        "imageType": "asset",
                                        "width": 30.0,
                                        "height": 30.0,
                                        "type": "image"
                                      },
                                      "type": "center"
                                    },
                                    "type": "container"
                                  },
                                  {
                                    "width": 12.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "child": {
                                      "crossAxisAlignment": "end",
                                      "children": [
                                        {
                                          "data": "{{appStrings.promissory.guaranteePromissory}}",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w600"
                                          },
                                          "textDirection": "rtl",
                                          "type": "text"
                                        },
                                        {
                                          "height": 4.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "{{appStrings.promissory.guaranteePromissoryDesc}}",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 12.0
                                          },
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
                            "onTap": {
                              "actionType": "showResult",
                              "title": "{{appStrings.common.comingSoon}}",
                              "content": "{{appStrings.promissory.comingSoonMessage}}"
                            },
                            "type": "gestureDetector"
                          },
                          {
                            "height": 12.0,
                            "type": "sizedBox"
                          },
                          {
                            "child": {
                              "padding": {
                                "left": 16.0,
                                "top": 16.0,
                                "right": 16.0,
                                "bottom": 16.0
                              },
                              "decoration": {
                                "color": "{{appColors.current.background.surfaceContainer}}",
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
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "decoration": {
                                      "borderRadius": {
                                        "topLeft": 8.0,
                                        "topRight": 8.0,
                                        "bottomLeft": 8.0,
                                        "bottomRight": 8.0
                                      }
                                    },
                                    "width": 48.0,
                                    "height": 48.0,
                                    "child": {
                                      "child": {
                                        "src": "assets/icons/ic_promissory_inquiry.svg",
                                        "imageType": "asset",
                                        "width": 30.0,
                                        "height": 30.0,
                                        "type": "image"
                                      },
                                      "type": "center"
                                    },
                                    "type": "container"
                                  },
                                  {
                                    "width": 12.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "child": {
                                      "crossAxisAlignment": "end",
                                      "children": [
                                        {
                                          "data": "{{appStrings.promissory.viewPromissory}}",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w600"
                                          },
                                          "textDirection": "rtl",
                                          "type": "text"
                                        },
                                        {
                                          "height": 4.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "{{appStrings.promissory.viewPromissoryDesc}}",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 12.0
                                          },
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
                            "onTap": {
                              "actionType": "showResult",
                              "title": "{{appStrings.common.comingSoon}}",
                              "content": "{{appStrings.promissory.comingSoonMessage}}"
                            },
                            "type": "gestureDetector"
                          }
                        ],
                        "type": "column"
                      },
                      "type": "singleChildScrollView"
                    },
                    "type": "expanded"
                  }
                ],
                "type": "column"
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
