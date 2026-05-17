# home_page/json/tobank_special_services_page.json

Source: lib/stac/tobank/home_page/json/tobank_special_services_page.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "backgroundColor": "{{appColors.current.background.surface}}",
  "appBar": {
    "title": {
      "data": "Ø®Ø¯Ù…Ø§Øª ÙˆÛŒÚ˜Ù‡ ØªÙˆØ¨Ø§Ù†Ú©",
      "textDirection": "rtl",
      "style": {
        "type": "alias",
        "value": "{{appStyles.appbarStyle}}"
      },
      "type": "text"
    },
    "centerTitle": true,
    "leading": {
      "padding": {
        "left": 12
      },
      "child": {
        "type": "center",
        "child": {
          "width": 42,
          "height": 42,
          "type": "container",
          "child": {
            "type": "center",
            "child": {
              "src": "{{appAssets.icons.support}}",
              "imageType": "asset",
              "width": 24,
              "height": 24,
              "color": "{{appColors.current.text.title}}",
              "type": "image"
            }
          }
        }
      },
      "type": "padding"
    },
    "actions": [
      {
        "padding": {
          "right": 15
        },
        "child": {
          "onPressed": {
            "navigationStyle": "pop",
            "actionType": "navigate"
          },
          "icon": {
            "src": "{{appAssets.icons.arrowBack}}",
            "imageType": "asset",
            "width": 30,
            "height": 30,
            "color": "{{appColors.current.text.title}}",
            "type": "image"
          },
          "type": "iconButton"
        },
        "type": "padding"
      }
    ],
    "type": "appBar"
  },
  "body": {
    "padding": {
      "left": 16,
      "top": 24,
      "right": 16,
      "bottom": 24
    },
    "child": {
      "child": {
        "crossAxisAlignment": "stretch",
        "children": [
          {
            "textDirection": "rtl",
            "crossAxisAlignment": "start",
            "children": [
              {
                "child": {
                  "onTap": {
                    "actionType": "showBottomSheet",
                    "backgroundColor": "#00000000",
                    "sheet": {
                      "type": "container",
                      "decoration": {
                        "color": "{{appColors.current.background.surface}}",
                        "borderRadius": {
                          "topLeft": 18,
                          "topRight": 18
                        }
                      },
                      "child": {
                        "type": "padding",
                        "padding": {
                          "left": 16,
                          "top": 10,
                          "right": 16,
                          "bottom": 16
                        },
                        "child": {
                          "type": "column",
                          "mainAxisSize": "min",
                          "crossAxisAlignment": "stretch",
                          "children": [
                            {
                              "type": "center",
                              "child": {
                                "type": "container",
                                "width": 46,
                                "height": 6,
                                "decoration": {
                                  "color": "{{appColors.current.input.borderEnabled}}",
                                  "borderRadius": {
                                    "topLeft": 999,
                                    "topRight": 999,
                                    "bottomLeft": 999,
                                    "bottomRight": 999
                                  }
                                }
                              }
                            },
                            {
                              "type": "sizedBox",
                              "height": 20
                            },
                            {
                              "type": "text",
                              "data": "Ø®Ø¯Ù…Ø§Øª Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú©",
                              "textDirection": "rtl",
                              "textAlign": "right",
                              "style": {
                                "type": "custom",
                                "fontSize": 16,
                                "fontWeight": "w800",
                                "color": "{{appColors.current.text.title}}"
                              }
                            },
                            {
                              "type": "sizedBox",
                              "height": 16
                            },
                            {
                              "type": "gestureDetector",
                              "onTap": {
                                "actionType": "closeDialog",
                                "result": {
                                  "actionType": "fingerPrint",
                                  "title": "Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª",
                                  "description": "Ø¨Ø±Ø§ÛŒ ØµØ¯ÙˆØ± Ø§ÙˆÙ„ÛŒÙ‡ Ø±Ù…Ø² Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú© Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª Ú©Ù†ÛŒØ¯",
                                  "onSuccess": {
                                    "actionType": "customSnackBar",
                                    "backgroundColor": "#00000000",
                                    "duration": 10000,
                                    "child": {
                                      "type": "container",
                                      "decoration": {
                                        "color": "{{appColors.current.background.surfaceContainer}}",
                                        "borderRadius": {
                                          "topLeft": 8,
                                          "topRight": 8,
                                          "bottomLeft": 8,
                                          "bottomRight": 8
                                        },
                                        "border": {
                                          "color": "{{appColors.current.input.borderEnabled}}",
                                          "width": 1
                                        }
                                      },
                                      "padding": {
                                        "left": 12,
                                        "top": 10,
                                        "right": 12,
                                        "bottom": 10
                                      },
                                      "child": {
                                        "type": "row",
                                        "textDirection": "ltr",
                                        "crossAxisAlignment": "center",
                                        "children": [
                                          {
                                            "type": "gestureDetector",
                                            "onTap": {
                                              "actionType": "hideSnackBar"
                                            },
                                            "child": {
                                              "type": "container",
                                              "padding": {
                                                "left": 10,
                                                "top": 5,
                                                "right": 10,
                                                "bottom": 5
                                              },
                                              "decoration": {
                                                "color": "#E31A2F",
                                                "borderRadius": {
                                                  "topLeft": 8,
                                                  "topRight": 8,
                                                  "bottomLeft": 8,
                                                  "bottomRight": 8
                                                }
                                              },
                                              "child": {
                                                "type": "text",
                                                "data": "Ø¨Ø³ØªÙ†",
                                                "textDirection": "rtl",
                                                "style": {
                                                  "type": "custom",
                                                  "fontSize": 12,
                                                  "fontWeight": "w700",
                                                  "color": "#FFFFFF"
                                                }
                                              }
                                            }
                                          },
                                          {
                                            "type": "sizedBox",
                                            "width": 10
                                          },
                                          {
                                            "type": "expanded",
                                            "child": {
                                              "type": "column",
                                              "mainAxisSize": "min",
                                              "crossAxisAlignment": "end",
                                              "children": [
                                                {
                                                  "type": "text",
                                                  "data": "Ø¯Ø±Ø®ÙˆØ§Ø³Øª Ø´Ù…Ø§ Ø¨Ø§ Ù…ÙˆÙÙ‚ÛŒØª Ø«Ø¨Øª Ø´Ø¯!",
                                                  "textDirection": "rtl",
                                                  "textAlign": "right",
                                                  "style": {
                                                    "type": "custom",
                                                    "fontSize": 14,
                                                    "fontWeight": "w700",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "height": 1.45
                                                  }
                                                },
                                                {
                                                  "type": "sizedBox",
                                                  "height": 4
                                                },
                                                {
                                                  "type": "text",
                                                  "data": "Ù…Ø±Ø§ØªØ¨ Ø§Ø² Ø·Ø±ÛŒÙ‚ Ù¾ÛŒØ§Ù…Ú© Ø¨Ù‡ Ø´Ù…Ø§ Ø§Ø·Ù„Ø§Ø¹ Ø¯Ø§Ø¯Ù‡ Ø®ÙˆØ§Ù‡Ø¯ Ø´Ø¯.",
                                                  "textDirection": "rtl",
                                                  "textAlign": "right",
                                                  "style": {
                                                    "type": "custom",
                                                    "fontSize": 13,
                                                    "fontWeight": "w500",
                                                    "color": "{{appColors.current.text.subtitle}}",
                                                    "height": 1.45
                                                  }
                                                }
                                              ]
                                            }
                                          },
                                          {
                                            "type": "sizedBox",
                                            "width": 10
                                          },
                                          {
                                            "type": "container",
                                            "width": 1,
                                            "height": 20,
                                            "decoration": {
                                              "color": "{{appColors.current.input.borderEnabled}}",
                                              "borderRadius": {
                                                "topLeft": 999,
                                                "topRight": 999,
                                                "bottomLeft": 999,
                                                "bottomRight": 999
                                              }
                                            }
                                          },
                                          {
                                            "type": "sizedBox",
                                            "width": 8
                                          },
                                          {
                                            "type": "image",
                                            "src": "assets/icons/ic_info.svg",
                                            "imageType": "asset",
                                            "width": 20,
                                            "height": 20,
                                            "color": "{{appColors.current.text.subtitle}}"
                                          }
                                        ]
                                      }
                                    }
                                  },
                                  "onFailure": {
                                    "actionType": "customSnackBar",
                                    "backgroundColor": "#00000000",
                                    "duration": 10000,
                                    "child": {
                                      "type": "container",
                                      "decoration": {
                                        "color": "{{appColors.current.background.surfaceContainer}}",
                                        "borderRadius": {
                                          "topLeft": 8,
                                          "topRight": 8,
                                          "bottomLeft": 8,
                                          "bottomRight": 8
                                        },
                                        "border": {
                                          "color": "{{appColors.current.input.borderEnabled}}",
                                          "width": 1
                                        }
                                      },
                                      "padding": {
                                        "left": 12,
                                        "top": 10,
                                        "right": 12,
                                        "bottom": 10
                                      },
                                      "child": {
                                        "type": "row",
                                        "textDirection": "ltr",
                                        "crossAxisAlignment": "center",
                                        "children": [
                                          {
                                            "type": "gestureDetector",
                                            "onTap": {
                                              "actionType": "hideSnackBar"
                                            },
                                            "child": {
                                              "type": "container",
                                              "padding": {
                                                "left": 10,
                                                "top": 5,
                                                "right": 10,
                                                "bottom": 5
                                              },
                                              "decoration": {
                                                "color": "#E31A2F",
                                                "borderRadius": {
                                                  "topLeft": 8,
                                                  "topRight": 8,
                                                  "bottomLeft": 8,
                                                  "bottomRight": 8
                                                }
                                              },
                                              "child": {
                                                "type": "text",
                                                "data": "Ø¨Ø³ØªÙ†",
                                                "textDirection": "rtl",
                                                "style": {
                                                  "type": "custom",
                                                  "fontSize": 12,
                                                  "fontWeight": "w700",
                                                  "color": "#FFFFFF"
                                                }
                                              }
                                            }
                                          },
                                          {
                                            "type": "sizedBox",
                                            "width": 10
                                          },
                                          {
                                            "type": "expanded",
                                            "child": {
                                              "type": "column",
                                              "mainAxisSize": "min",
                                              "crossAxisAlignment": "end",
                                              "children": [
                                                {
                                                  "type": "text",
                                                  "data": "Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª Ù†Ø§Ù…ÙˆÙÙ‚ Ø¨ÙˆØ¯.",
                                                  "textDirection": "rtl",
                                                  "textAlign": "right",
                                                  "style": {
                                                    "type": "custom",
                                                    "fontSize": 14,
                                                    "fontWeight": "w700",
                                                    "color": "{{appColors.current.text.title}}",
                                                    "height": 1.45
                                                  }
                                                },
                                                {
                                                  "type": "sizedBox",
                                                  "height": 4
                                                },
                                                {
                                                  "type": "text",
                                                  "data": "Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª Ù†Ø§Ù…ÙˆÙÙ‚ Ø¨ÙˆØ¯. Ø¹Ù…Ù„ÛŒØ§Øª \"ØµØ¯ÙˆØ± Ø§ÙˆÙ„ÛŒÙ‡ Ø±Ù…Ø² Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú©\" Ø§Ù†Ø¬Ø§Ù… Ù†Ø´Ø¯.",
                                                  "textDirection": "rtl",
                                                  "textAlign": "right",
                                                  "style": {
                                                    "type": "custom",
                                                    "fontSize": 13,
                                                    "fontWeight": "w500",
                                                    "color": "{{appColors.current.text.subtitle}}",
                                                    "height": 1.45
                                                  }
                                                }
                                              ]
                                            }
                                          },
                                          {
                                            "type": "sizedBox",
                                            "width": 10
                                          },
                                          {
                                            "type": "container",
                                            "width": 1,
                                            "height": 20,
                                            "decoration": {
                                              "color": "{{appColors.current.input.borderEnabled}}",
                                              "borderRadius": {
                                                "topLeft": 999,
                                                "topRight": 999,
                                                "bottomLeft": 999,
                                                "bottomRight": 999
                                              }
                                            }
                                          },
                                          {
                                            "type": "sizedBox",
                                            "width": 8
                                          },
                                          {
                                            "type": "image",
                                            "src": "assets/icons/ic_info.svg",
                                            "imageType": "asset",
                                            "width": 20,
                                            "height": 20,
                                            "color": "{{appColors.current.text.subtitle}}"
                                          }
                                        ]
                                      }
                                    }
                                  }
                                }
                              },
                              "child": {
                                "type": "container",
                                "decoration": {
                                  "color": "{{appColors.current.background.surfaceContainerLowest}}",
                                  "borderRadius": {
                                    "topLeft": 14,
                                    "topRight": 14,
                                    "bottomLeft": 14,
                                    "bottomRight": 14
                                  },
                                  "border": {
                                    "color": "{{appColors.current.input.borderEnabled}}",
                                    "width": 1
                                  }
                                },
                                "child": {
                                  "type": "padding",
                                  "padding": {
                                    "left": 16,
                                    "top": 8,
                                    "right": 16,
                                    "bottom": 8
                                  },
                                  "child": {
                                    "type": "row",
                                    "textDirection": "rtl",
                                    "crossAxisAlignment": "center",
                                    "children": [
                                      {
                                        "type": "container",
                                        "width": 44,
                                        "height": 44,
                                        "decoration": {
                                          "color": "{{appColors.current.background.surfaceContainer}}",
                                          "shape": "circle"
                                        },
                                        "child": {
                                          "type": "center",
                                          "child": {
                                            "type": "image",
                                            "src": "assets/icons/ic_bank_lock.svg",
                                            "imageType": "asset",
                                            "width": 28,
                                            "height": 28
                                          }
                                        }
                                      },
                                      {
                                        "type": "sizedBox",
                                        "width": 12
                                      },
                                      {
                                        "type": "expanded",
                                        "child": {
                                          "type": "text",
                                          "data": "ØµØ¯ÙˆØ± Ø§ÙˆÙ„ÛŒÙ‡ Ø±Ù…Ø² Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú©",
                                          "textDirection": "rtl",
                                          "textAlign": "right",
                                          "style": {
                                            "type": "custom",
                                            "fontSize": 14,
                                            "fontWeight": "w700",
                                            "color": "{{appColors.current.text.title}}",
                                            "height": 1.5
                                          }
                                        }
                                      }
                                    ]
                                  }
                                }
                              }
                            },
                            {
                              "type": "sizedBox",
                              "height": 12
                            },
                            {
                              "type": "gestureDetector",
                              "onTap": {
                                "actionType": "closeDialog",
                                "result": {
                                  "actionType": "showBottomSheet",
                                  "backgroundColor": "#00000000",
                                  "sheet": {
                                    "type": "container",
                                    "decoration": {
                                      "color": "{{appColors.current.background.surface}}",
                                      "borderRadius": {
                                        "topLeft": 18,
                                        "topRight": 18
                                      }
                                    },
                                    "child": {
                                      "type": "padding",
                                      "padding": {
                                        "left": 16,
                                        "top": 10,
                                        "right": 16,
                                        "bottom": 16
                                      },
                                      "child": {
                                        "type": "column",
                                        "mainAxisSize": "min",
                                        "crossAxisAlignment": "stretch",
                                        "children": [
                                          {
                                            "type": "center",
                                            "child": {
                                              "type": "container",
                                              "width": 46,
                                              "height": 6,
                                              "decoration": {
                                                "color": "{{appColors.current.input.borderEnabled}}",
                                                "borderRadius": {
                                                  "topLeft": 999,
                                                  "topRight": 999,
                                                  "bottomLeft": 999,
                                                  "bottomRight": 999
                                                }
                                              }
                                            }
                                          },
                                          {
                                            "type": "sizedBox",
                                            "height": 20
                                          },
                                          {
                                            "type": "text",
                                            "data": "Ø®Ø¯Ù…Ø§Øª Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú©",
                                            "textDirection": "rtl",
                                            "textAlign": "right",
                                            "style": {
                                              "type": "custom",
                                              "fontSize": 16,
                                              "fontWeight": "w800",
                                              "color": "{{appColors.current.text.title}}"
                                            }
                                          },
                                          {
                                            "type": "sizedBox",
                                            "height": 16
                                          },
                                          {
                                            "type": "text",
                                            "data": "Ù†Ø§Ù… Ú©Ø§Ø±Ø¨Ø±ÛŒ Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú©",
                                            "textDirection": "rtl",
                                            "textAlign": "right",
                                            "style": {
                                              "type": "custom",
                                              "fontSize": 16,
                                              "fontWeight": "w700",
                                              "color": "{{appColors.current.text.title}}"
                                            }
                                          },
                                          {
                                            "type": "sizedBox",
                                            "height": 8
                                          },
                                          {
                                            "type": "container",
                                            "decoration": {
                                              "color": "{{appColors.current.background.surfaceContainerLowest}}",
                                              "border": {
                                                "color": "{{appColors.current.input.borderEnabled}}",
                                                "width": 1
                                              },
                                              "borderRadius": {
                                                "topLeft": 12,
                                                "topRight": 12,
                                                "bottomLeft": 12,
                                                "bottomRight": 12
                                              }
                                            },
                                            "child": {
                                              "type": "textFormField",
                                              "id": "mobileBankRecoveryUsername",
                                              "textDirection": "ltr",
                                              "textAlign": "right",
                                              "keyboardType": "number",
                                              "decoration": {
                                                "hintText": "Ù†Ø§Ù… Ú©Ø§Ø±Ø¨Ø±ÛŒ Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú©",
                                                "hintStyle": {
                                                  "type": "custom",
                                                  "fontSize": 14,
                                                  "fontWeight": "w400",
                                                  "color": "{{appColors.current.text.hint}}"
                                                },
                                                "filled": false,
                                                "contentPadding": {
                                                  "left": 16,
                                                  "right": 16,
                                                  "top": 20,
                                                  "bottom": 20
                                                },
                                                "border": {
                                                  "type": "none"
                                                },
                                                "enabledBorder": {
                                                  "type": "none"
                                                },
                                                "focusedBorder": {
                                                  "type": "none"
                                                },
                                                "errorBorder": {
                                                  "type": "none"
                                                },
                                                "focusedErrorBorder": {
                                                  "type": "none"
                                                },
                                                "disabledBorder": {
                                                  "type": "none"
                                                },
                                                "prefixIcon": {
                                                  "type": "padding",
                                                  "padding": {
                                                    "left": 8,
                                                    "right": 8,
                                                    "top": 8,
                                                    "bottom": 8
                                                  },
                                                  "child": {
                                                    "type": "icon",
                                                    "icon": "close",
                                                    "size": 18,
                                                    "color": "{{appColors.current.text.subtitle}}"
                                                  }
                                                }
                                              }
                                            }
                                          },
                                          {
                                            "type": "sizedBox",
                                            "height": 24
                                          },
                                          {
                                            "type": "filledButton",
                                            "onPressed": {
                                              "actionType": "closeDialog",
                                              "result": {
                                                "actionType": "fingerPrint",
                                                "title": "Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª",
                                                "description": "Ø¨Ø±Ø§ÛŒ Ø¨Ø§Ø²ÛŒØ§Ø¨ÛŒ Ø±Ù…Ø² Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú© Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª Ú©Ù†ÛŒØ¯",
                                                "onSuccess": {
                                                  "actionType": "customSnackBar",
                                                  "backgroundColor": "#00000000",
                                                  "duration": 10000,
                                                  "child": {
                                                    "type": "container",
                                                    "decoration": {
                                                      "color": "{{appColors.current.background.surfaceContainer}}",
                                                      "borderRadius": {
                                                        "topLeft": 8,
                                                        "topRight": 8,
                                                        "bottomLeft": 8,
                                                        "bottomRight": 8
                                                      },
                                                      "border": {
                                                        "color": "{{appColors.current.input.borderEnabled}}",
                                                        "width": 1
                                                      }
                                                    },
                                                    "padding": {
                                                      "left": 12,
                                                      "top": 10,
                                                      "right": 12,
                                                      "bottom": 10
                                                    },
                                                    "child": {
                                                      "type": "row",
                                                      "textDirection": "ltr",
                                                      "crossAxisAlignment": "center",
                                                      "children": [
                                                        {
                                                          "type": "gestureDetector",
                                                          "onTap": {
                                                            "actionType": "hideSnackBar"
                                                          },
                                                          "child": {
                                                            "type": "container",
                                                            "padding": {
                                                              "left": 10,
                                                              "top": 5,
                                                              "right": 10,
                                                              "bottom": 5
                                                            },
                                                            "decoration": {
                                                              "color": "#E31A2F",
                                                              "borderRadius": {
                                                                "topLeft": 8,
                                                                "topRight": 8,
                                                                "bottomLeft": 8,
                                                                "bottomRight": 8
                                                              }
                                                            },
                                                            "child": {
                                                              "type": "text",
                                                              "data": "Ø¨Ø³ØªÙ†",
                                                              "textDirection": "rtl",
                                                              "style": {
                                                                "type": "custom",
                                                                "fontSize": 12,
                                                                "fontWeight": "w700",
                                                                "color": "#FFFFFF"
                                                              }
                                                            }
                                                          }
                                                        },
                                                        {
                                                          "type": "sizedBox",
                                                          "width": 10
                                                        },
                                                        {
                                                          "type": "expanded",
                                                          "child": {
                                                            "type": "column",
                                                            "mainAxisSize": "min",
                                                            "crossAxisAlignment": "end",
                                                            "children": [
                                                              {
                                                                "type": "text",
                                                                "data": "Ø¯Ø±Ø®ÙˆØ§Ø³Øª Ø´Ù…Ø§ Ø¨Ø§ Ù…ÙˆÙÙ‚ÛŒØª Ø«Ø¨Øª Ø´Ø¯!",
                                                                "textDirection": "rtl",
                                                                "textAlign": "right",
                                                                "style": {
                                                                  "type": "custom",
                                                                  "fontSize": 14,
                                                                  "fontWeight": "w700",
                                                                  "color": "{{appColors.current.text.title}}",
                                                                  "height": 1.45
                                                                }
                                                              },
                                                              {
                                                                "type": "sizedBox",
                                                                "height": 4
                                                              },
                                                              {
                                                                "type": "text",
                                                                "data": "Ù…Ø±Ø§ØªØ¨ Ø§Ø² Ø·Ø±ÛŒÙ‚ Ù¾ÛŒØ§Ù…Ú© Ø¨Ù‡ Ø´Ù…Ø§ Ø§Ø·Ù„Ø§Ø¹ Ø¯Ø§Ø¯Ù‡ Ø®ÙˆØ§Ù‡Ø¯ Ø´Ø¯.",
                                                                "textDirection": "rtl",
                                                                "textAlign": "right",
                                                                "style": {
                                                                  "type": "custom",
                                                                  "fontSize": 13,
                                                                  "fontWeight": "w500",
                                                                  "color": "{{appColors.current.text.subtitle}}",
                                                                  "height": 1.45
                                                                }
                                                              }
                                                            ]
                                                          }
                                                        },
                                                        {
                                                          "type": "sizedBox",
                                                          "width": 10
                                                        },
                                                        {
                                                          "type": "container",
                                                          "width": 1,
                                                          "height": 20,
                                                          "decoration": {
                                                            "color": "{{appColors.current.input.borderEnabled}}",
                                                            "borderRadius": {
                                                              "topLeft": 999,
                                                              "topRight": 999,
                                                              "bottomLeft": 999,
                                                              "bottomRight": 999
                                                            }
                                                          }
                                                        },
                                                        {
                                                          "type": "sizedBox",
                                                          "width": 8
                                                        },
                                                        {
                                                          "type": "image",
                                                          "src": "assets/icons/ic_info.svg",
                                                          "imageType": "asset",
                                                          "width": 20,
                                                          "height": 20,
                                                          "color": "{{appColors.current.text.subtitle}}"
                                                        }
                                                      ]
                                                    }
                                                  }
                                                },
                                                "onFailure": {
                                                  "actionType": "customSnackBar",
                                                  "backgroundColor": "#00000000",
                                                  "duration": 10000,
                                                  "child": {
                                                    "type": "container",
                                                    "decoration": {
                                                      "color": "{{appColors.current.background.surfaceContainer}}",
                                                      "borderRadius": {
                                                        "topLeft": 8,
                                                        "topRight": 8,
                                                        "bottomLeft": 8,
                                                        "bottomRight": 8
                                                      },
                                                      "border": {
                                                        "color": "{{appColors.current.input.borderEnabled}}",
                                                        "width": 1
                                                      }
                                                    },
                                                    "padding": {
                                                      "left": 12,
                                                      "top": 10,
                                                      "right": 12,
                                                      "bottom": 10
                                                    },
                                                    "child": {
                                                      "type": "row",
                                                      "textDirection": "ltr",
                                                      "crossAxisAlignment": "center",
                                                      "children": [
                                                        {
                                                          "type": "gestureDetector",
                                                          "onTap": {
                                                            "actionType": "hideSnackBar"
                                                          },
                                                          "child": {
                                                            "type": "container",
                                                            "padding": {
                                                              "left": 10,
                                                              "top": 5,
                                                              "right": 10,
                                                              "bottom": 5
                                                            },
                                                            "decoration": {
                                                              "color": "#E31A2F",
                                                              "borderRadius": {
                                                                "topLeft": 8,
                                                                "topRight": 8,
                                                                "bottomLeft": 8,
                                                                "bottomRight": 8
                                                              }
                                                            },
                                                            "child": {
                                                              "type": "text",
                                                              "data": "Ø¨Ø³ØªÙ†",
                                                              "textDirection": "rtl",
                                                              "style": {
                                                                "type": "custom",
                                                                "fontSize": 12,
                                                                "fontWeight": "w700",
                                                                "color": "#FFFFFF"
                                                              }
                                                            }
                                                          }
                                                        },
                                                        {
                                                          "type": "sizedBox",
                                                          "width": 10
                                                        },
                                                        {
                                                          "type": "expanded",
                                                          "child": {
                                                            "type": "column",
                                                            "mainAxisSize": "min",
                                                            "crossAxisAlignment": "end",
                                                            "children": [
                                                              {
                                                                "type": "text",
                                                                "data": "Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª Ù†Ø§Ù…ÙˆÙÙ‚ Ø¨ÙˆØ¯.",
                                                                "textDirection": "rtl",
                                                                "textAlign": "right",
                                                                "style": {
                                                                  "type": "custom",
                                                                  "fontSize": 14,
                                                                  "fontWeight": "w700",
                                                                  "color": "{{appColors.current.text.title}}",
                                                                  "height": 1.45
                                                                }
                                                              },
                                                              {
                                                                "type": "sizedBox",
                                                                "height": 4
                                                              },
                                                              {
                                                                "type": "text",
                                                                "data": "Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª Ù†Ø§Ù…ÙˆÙÙ‚ Ø¨ÙˆØ¯. Ø¹Ù…Ù„ÛŒØ§Øª \"Ø¨Ø§Ø²ÛŒØ§Ø¨ÛŒ Ø±Ù…Ø² Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú©\" Ø§Ù†Ø¬Ø§Ù… Ù†Ø´Ø¯.",
                                                                "textDirection": "rtl",
                                                                "textAlign": "right",
                                                                "style": {
                                                                  "type": "custom",
                                                                  "fontSize": 13,
                                                                  "fontWeight": "w500",
                                                                  "color": "{{appColors.current.text.subtitle}}",
                                                                  "height": 1.45
                                                                }
                                                              }
                                                            ]
                                                          }
                                                        },
                                                        {
                                                          "type": "sizedBox",
                                                          "width": 10
                                                        },
                                                        {
                                                          "type": "container",
                                                          "width": 1,
                                                          "height": 20,
                                                          "decoration": {
                                                            "color": "{{appColors.current.input.borderEnabled}}",
                                                            "borderRadius": {
                                                              "topLeft": 999,
                                                              "topRight": 999,
                                                              "bottomLeft": 999,
                                                              "bottomRight": 999
                                                            }
                                                          }
                                                        },
                                                        {
                                                          "type": "sizedBox",
                                                          "width": 8
                                                        },
                                                        {
                                                          "type": "image",
                                                          "src": "assets/icons/ic_info.svg",
                                                          "imageType": "asset",
                                                          "width": 20,
                                                          "height": 20,
                                                          "color": "{{appColors.current.text.subtitle}}"
                                                        }
                                                      ]
                                                    }
                                                  }
                                                }
                                              }
                                            },
                                            "style": {
                                              "backgroundColor": "#E31A2F",
                                              "foregroundColor": "#FFFFFF",
                                              "minimumSize": {
                                                "width": 0,
                                                "height": 56
                                              },
                                              "shape": {
                                                "type": "roundedRectangleBorder",
                                                "borderRadius": {
                                                  "topLeft": 8,
                                                  "topRight": 8,
                                                  "bottomLeft": 8,
                                                  "bottomRight": 8
                                                }
                                              },
                                              "elevation": 0
                                            },
                                            "child": {
                                              "type": "text",
                                              "data": "ØªØ§ÛŒÛŒØ¯ Ùˆ Ø¨Ø§Ø²ÛŒØ§Ø¨ÛŒ Ø±Ù…Ø² Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú©",
                                              "textDirection": "rtl",
                                              "style": {
                                                "type": "custom",
                                                "fontSize": 16,
                                                "fontWeight": "w600",
                                                "color": "#FFFFFF"
                                              }
                                            }
                                          }
                                        ]
                                      }
                                    }
                                  }
                                }
                              },
                              "child": {
                                "type": "container",
                                "decoration": {
                                  "color": "{{appColors.current.background.surfaceContainerLowest}}",
                                  "borderRadius": {
                                    "topLeft": 14,
                                    "topRight": 14,
                                    "bottomLeft": 14,
                                    "bottomRight": 14
                                  },
                                  "border": {
                                    "color": "{{appColors.current.input.borderEnabled}}",
                                    "width": 1
                                  }
                                },
                                "child": {
                                  "type": "padding",
                                  "padding": {
                                    "left": 16,
                                    "top": 8,
                                    "right": 16,
                                    "bottom": 8
                                  },
                                  "child": {
                                    "type": "row",
                                    "textDirection": "rtl",
                                    "crossAxisAlignment": "center",
                                    "children": [
                                      {
                                        "type": "container",
                                        "width": 44,
                                        "height": 44,
                                        "decoration": {
                                          "color": "{{appColors.current.background.surfaceContainer}}",
                                          "shape": "circle"
                                        },
                                        "child": {
                                          "type": "center",
                                          "child": {
                                            "type": "image",
                                            "src": "assets/icons/ic_lock_retrieval.svg",
                                            "imageType": "asset",
                                            "width": 28,
                                            "height": 28
                                          }
                                        }
                                      },
                                      {
                                        "type": "sizedBox",
                                        "width": 12
                                      },
                                      {
                                        "type": "expanded",
                                        "child": {
                                          "type": "text",
                                          "data": "Ø¨Ø§Ø²ÛŒØ§Ø¨ÛŒ Ø±Ù…Ø² Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú©",
                                          "textDirection": "rtl",
                                          "textAlign": "right",
                                          "style": {
                                            "type": "custom",
                                            "fontSize": 14,
                                            "fontWeight": "w700",
                                            "color": "{{appColors.current.text.title}}",
                                            "height": 1.5
                                          }
                                        }
                                      }
                                    ]
                                  }
                                }
                              }
                            },
                            {
                              "type": "sizedBox",
                              "height": 8
                            }
                          ]
                        }
                      }
                    }
                  },
                  "child": {
                    "height": 176,
                    "decoration": {
                      "color": "{{appColors.current.background.surfaceContainerLowest}}",
                      "borderRadius": {
                        "topLeft": 16,
                        "topRight": 16,
                        "bottomLeft": 16,
                        "bottomRight": 16
                      },
                      "border": {
                        "color": "{{appColors.current.input.borderEnabled}}",
                        "width": 1
                      }
                    },
                    "child": {
                      "padding": {
                        "left": 16,
                        "top": 16,
                        "right": 16,
                        "bottom": 16
                      },
                      "child": {
                        "mainAxisAlignment": "center",
                        "crossAxisAlignment": "center",
                        "children": [
                          {
                            "src": "assets/icons/ic_menu_mobile.svg",
                            "imageType": "asset",
                            "width": 32,
                            "height": 32,
                            "type": "image"
                          },
                          {
                            "height": 18,
                            "type": "sizedBox"
                          },
                          {
                            "data": "Ø®Ø¯Ù…Ø§Øª Ù…ÙˆØ¨Ø§ÛŒÙ„ Ø¨Ø§Ù†Ú©",
                            "textDirection": "rtl",
                            "textAlign": "center",
                            "style": {
                              "type": "custom",
                              "fontSize": 14,
                              "fontWeight": "w700",
                              "color": "{{appColors.current.text.title}}",
                              "height": 1.5
                            },
                            "type": "text"
                          },
                          {
                            "height": 12,
                            "type": "sizedBox"
                          },
                          {
                            "data": "ÙØ¹Ø§Ù„ Ø³Ø§Ø²ÛŒ Ø®Ø¯Ù…Ø§Øª Ùˆ ØµØ¯ÙˆØ± Ø±Ù…Ø²",
                            "textDirection": "rtl",
                            "textAlign": "center",
                            "style": {
                              "type": "custom",
                              "fontSize": 12,
                              "fontWeight": "w500",
                              "color": "{{appColors.current.text.subtitle}}",
                              "height": 1.65
                            },
                            "type": "text"
                          }
                        ],
                        "type": "column"
                      },
                      "type": "padding"
                    },
                    "type": "container"
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              },
              {
                "width": 16,
                "type": "sizedBox"
              },
              {
                "child": {
                  "height": 176,
                  "decoration": {
                    "color": "{{appColors.current.background.surfaceContainerLowest}}",
                    "borderRadius": {
                      "topLeft": 16,
                      "topRight": 16,
                      "bottomLeft": 16,
                      "bottomRight": 16
                    },
                    "border": {
                      "color": "{{appColors.current.input.borderEnabled}}",
                      "width": 1
                    }
                  },
                  "child": {
                    "padding": {
                      "left": 16,
                      "top": 16,
                      "right": 16,
                      "bottom": 16
                    },
                    "child": {
                      "mainAxisAlignment": "center",
                      "crossAxisAlignment": "center",
                      "children": [
                        {
                          "src": "assets/icons/ic_menu_internet.svg",
                          "imageType": "asset",
                          "width": 32,
                          "height": 32,
                          "type": "image"
                        },
                        {
                          "height": 18,
                          "type": "sizedBox"
                        },
                        {
                          "data": "Ø®Ø¯Ù…Ø§Øª Ø§ÛŒÙ†ØªØ±Ù†Øª Ø¨Ø§Ù†Ú©",
                          "textDirection": "rtl",
                          "textAlign": "center",
                          "style": {
                            "type": "custom",
                            "fontSize": 14,
                            "fontWeight": "w700",
                            "color": "{{appColors.current.text.title}}",
                            "height": 1.5
                          },
                          "type": "text"
                        },
                        {
                          "height": 12,
                          "type": "sizedBox"
                        },
                        {
                          "data": "ÙØ¹Ø§Ù„ Ø³Ø§Ø²ÛŒ Ø®Ø¯Ù…Ø§Øª Ùˆ ØµØ¯ÙˆØ± Ø±Ù…Ø²",
                          "textDirection": "rtl",
                          "textAlign": "center",
                          "style": {
                            "type": "custom",
                            "fontSize": 12,
                            "fontWeight": "w500",
                            "color": "{{appColors.current.text.subtitle}}",
                            "height": 1.65
                          },
                          "type": "text"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  "type": "container"
                },
                "type": "expanded"
              }
            ],
            "type": "row"
          },
          {
            "height": 16,
            "type": "sizedBox"
          },
          {
            "textDirection": "rtl",
            "crossAxisAlignment": "start",
            "children": [
              {
                "child": {
                  "height": 176,
                  "decoration": {
                    "color": "{{appColors.current.background.surfaceContainerLowest}}",
                    "borderRadius": {
                      "topLeft": 16,
                      "topRight": 16,
                      "bottomLeft": 16,
                      "bottomRight": 16
                    },
                    "border": {
                      "color": "{{appColors.current.input.borderEnabled}}",
                      "width": 1
                    }
                  },
                  "child": {
                    "padding": {
                      "left": 16,
                      "top": 16,
                      "right": 16,
                      "bottom": 16
                    },
                    "child": {
                      "mainAxisAlignment": "center",
                      "crossAxisAlignment": "center",
                      "children": [
                        {
                          "src": "assets/icons/ic_safe_box.svg",
                          "imageType": "asset",
                          "width": 32,
                          "height": 32,
                          "type": "image"
                        },
                        {
                          "height": 18,
                          "type": "sizedBox"
                        },
                        {
                          "data": "ØµÙ†Ø¯ÙˆÙ‚ Ø§Ù…Ø§Ù†Ø§Øª",
                          "textDirection": "rtl",
                          "textAlign": "center",
                          "style": {
                            "type": "custom",
                            "fontSize": 14,
                            "fontWeight": "w700",
                            "color": "{{appColors.current.text.title}}",
                            "height": 1.5
                          },
                          "type": "text"
                        },
                        {
                          "height": 12,
                          "type": "sizedBox"
                        },
                        {
                          "data": "Ø§Ø¬Ø§Ø±Ù‡ ØµÙ†Ø¯ÙˆÙ‚ØŒ Ø±Ø²Ø±Ùˆ Ø²Ù…Ø§Ù† Ø¨Ø§Ø²Ø¯ÛŒØ¯",
                          "textDirection": "rtl",
                          "textAlign": "center",
                          "style": {
                            "type": "custom",
                            "fontSize": 12,
                            "fontWeight": "w500",
                            "color": "{{appColors.current.text.subtitle}}",
                            "height": 1.65
                          },
                          "type": "text"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  "type": "container"
                },
                "type": "expanded"
              },
              {
                "width": 16,
                "type": "sizedBox"
              },
              {
                "child": {
                  "height": 176,
                  "decoration": {
                    "color": "{{appColors.current.background.surfaceContainerLowest}}",
                    "borderRadius": {
                      "topLeft": 16,
                      "topRight": 16,
                      "bottomLeft": 16,
                      "bottomRight": 16
                    },
                    "border": {
                      "color": "{{appColors.current.input.borderEnabled}}",
                      "width": 1
                    }
                  },
                  "child": {
                    "padding": {
                      "left": 16,
                      "top": 16,
                      "right": 16,
                      "bottom": 16
                    },
                    "child": {
                      "mainAxisAlignment": "center",
                      "crossAxisAlignment": "center",
                      "children": [
                        {
                          "src": "assets/icons/ic_military_guarantee.svg",
                          "imageType": "asset",
                          "width": 32,
                          "height": 32,
                          "type": "image"
                        },
                        {
                          "height": 18,
                          "type": "sizedBox"
                        },
                        {
                          "data": "Ø¶Ù…Ø§Ù†Øª Ù†Ø§Ù…Ù‡ Ù†Ø¸Ø§Ù… ÙˆØ¸ÛŒÙÙ‡",
                          "textDirection": "rtl",
                          "textAlign": "center",
                          "style": {
                            "type": "custom",
                            "fontSize": 14,
                            "fontWeight": "w700",
                            "color": "{{appColors.current.text.title}}",
                            "height": 1.5
                          },
                          "type": "text"
                        },
                        {
                          "height": 12,
                          "type": "sizedBox"
                        },
                        {
                          "data": "Ø«Ø¨Øª Ø¶Ù…Ø§Ù†ØªÙ†Ø§Ù…Ù‡",
                          "textDirection": "rtl",
                          "textAlign": "center",
                          "style": {
                            "type": "custom",
                            "fontSize": 12,
                            "fontWeight": "w500",
                            "color": "{{appColors.current.text.subtitle}}",
                            "height": 1.65
                          },
                          "type": "text"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  "type": "container"
                },
                "type": "expanded"
              }
            ],
            "type": "row"
          },
          {
            "height": 16,
            "type": "sizedBox"
          },
          {
            "textDirection": "rtl",
            "crossAxisAlignment": "start",
            "children": [
              {
                "child": {
                  "onTap": {
                    "routeName": "promissory_real_intro",
                    "navigationStyle": "push",
                    "actionType": "navigate"
                  },
                  "child": {
                    "height": 176,
                    "decoration": {
                      "color": "{{appColors.current.background.surfaceContainerLowest}}",
                      "borderRadius": {
                        "topLeft": 16,
                        "topRight": 16,
                        "bottomLeft": 16,
                        "bottomRight": 16
                      },
                      "border": {
                        "color": "{{appColors.current.input.borderEnabled}}",
                        "width": 1
                      }
                    },
                    "child": {
                      "padding": {
                        "left": 16,
                        "top": 16,
                        "right": 16,
                        "bottom": 16
                      },
                      "child": {
                        "mainAxisAlignment": "center",
                        "crossAxisAlignment": "center",
                        "children": [
                          {
                            "src": "assets/icons/ic_promissory.svg",
                            "imageType": "asset",
                            "width": 32,
                            "height": 32,
                            "type": "image"
                          },
                          {
                            "height": 18,
                            "type": "sizedBox"
                          },
                          {
                            "data": "Ø³ÙØªÙ‡ Ø¢Ù†Ù„Ø§ÛŒÙ†",
                            "textDirection": "rtl",
                            "textAlign": "center",
                            "style": {
                              "type": "custom",
                              "fontSize": 14,
                              "fontWeight": "w700",
                              "color": "{{appColors.current.text.title}}",
                              "height": 1.5
                            },
                            "type": "text"
                          },
                          {
                            "height": 12,
                            "type": "sizedBox"
                          },
                          {
                            "data": "ØµØ¯ÙˆØ± Ùˆ Ø®Ø¯Ù…Ø§Øª",
                            "textDirection": "rtl",
                            "textAlign": "center",
                            "style": {
                              "type": "custom",
                              "fontSize": 12,
                              "fontWeight": "w500",
                              "color": "{{appColors.current.text.subtitle}}",
                              "height": 1.65
                            },
                            "type": "text"
                          }
                        ],
                        "type": "column"
                      },
                      "type": "padding"
                    },
                    "type": "container"
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              },
              {
                "width": 16,
                "type": "sizedBox"
              },
              {
                "child": {
                  "height": 176,
                  "decoration": {
                    "color": "{{appColors.current.background.surfaceContainerLowest}}",
                    "borderRadius": {
                      "topLeft": 16,
                      "topRight": 16,
                      "bottomLeft": 16,
                      "bottomRight": 16
                    },
                    "border": {
                      "color": "{{appColors.current.input.borderEnabled}}",
                      "width": 1
                    }
                  },
                  "child": {
                    "padding": {
                      "left": 16,
                      "top": 16,
                      "right": 16,
                      "bottom": 16
                    },
                    "child": {
                      "mainAxisAlignment": "center",
                      "crossAxisAlignment": "center",
                      "children": [
                        {
                          "src": "assets/icons/ic_cbs_search.svg",
                          "imageType": "asset",
                          "width": 32,
                          "height": 32,
                          "type": "image"
                        },
                        {
                          "height": 18,
                          "type": "sizedBox"
                        },
                        {
                          "data": "Ø§Ø¹ØªØ¨Ø§Ø±Ø³Ù†Ø¬ÛŒ",
                          "textDirection": "rtl",
                          "textAlign": "center",
                          "style": {
                            "type": "custom",
                            "fontSize": 14,
                            "fontWeight": "w700",
                            "color": "{{appColors.current.text.title}}",
                            "height": 1.5
                          },
                          "type": "text"
                        },
                        {
                          "height": 12,
                          "type": "sizedBox"
                        },
                        {
                          "data": "Ø§Ø¹ØªØ¨Ø§Ø±Ø³Ù†Ø¬ÛŒ Ø®ÙˆØ¯ Ùˆ Ø³Ø§ÛŒØ±ÛŒÙ†",
                          "textDirection": "rtl",
                          "textAlign": "center",
                          "style": {
                            "type": "custom",
                            "fontSize": 12,
                            "fontWeight": "w500",
                            "color": "{{appColors.current.text.subtitle}}",
                            "height": 1.65
                          },
                          "type": "text"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  "type": "container"
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
    "type": "padding"
  },
  "type": "scaffold"
}
```
