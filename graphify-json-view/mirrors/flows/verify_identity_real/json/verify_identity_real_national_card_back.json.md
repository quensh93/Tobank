# flows/verify_identity_real/json/verify_identity_real_national_card_back.json

Source: lib/stac/tobank/flows/verify_identity_real/json/verify_identity_real_national_card_back.json

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
        "key": "verifyIdentityBackImage",
        "value": ""
      },
      {
        "key": "verifyIdentityBackHasImage",
        "value": false
      }
    ]
  },
  "onDispose": {
    "actionType": "setValue",
    "values": [
      {
        "key": "verifyIdentityBackImage",
        "value": ""
      },
      {
        "key": "verifyIdentityBackHasImage",
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
            "width": 42.0,
            "height": 42.0,
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
            "type": "container"
          },
          "type": "center"
        },
        "type": "padding"
      },
      "title": {
        "data": "{{appStrings.menu.items.verifyIdentity}}",
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
            "right": 15.0
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
              "width": 30.0,
              "height": 30.0,
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
      "type": "safeArea",
      "top": false,
      "bottom": true,
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
                        "topLeft": 16.0,
                        "topRight": 16.0,
                        "bottomLeft": 16.0,
                        "bottomRight": 16.0
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
                          "decoration": {
                            "color": "{{appColors.current.background.surfaceContainer}}",
                            "borderRadius": {
                              "topLeft": 16.0,
                              "topRight": 16.0
                            }
                          },
                          "child": {
                            "data": "{{appStrings.authentication.backNationalCardTitle}}",
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
                          "type": "container"
                        },
                        {
                          "padding": {
                            "left": 16.0,
                            "right": 16.0,
                            "bottom": 16.0
                          },
                          "child": {
                            "crossAxisAlignment": "stretch",
                            "children": [
                              {
                                "type": "visibility",
                                "visible": "[[!verifyIdentityBackHasImage]]",
                                "child": {
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "child": {
                                        "child": {
                                          "padding": {
                                            "left": 12.0,
                                            "top": 8.0,
                                            "right": 12.0,
                                            "bottom": 8.0
                                          },
                                          "child": {
                                            "mainAxisAlignment": "center",
                                            "textDirection": "rtl",
                                            "children": [
                                              {
                                                "src": "{{appAssets.icons.cameraCurrent}}",
                                                "imageType": "asset",
                                                "width": 32.0,
                                                "height": 32.0,
                                                "type": "image"
                                              },
                                              {
                                                "width": 8.0,
                                                "type": "sizedBox"
                                              },
                                              {
                                                "data": "{{appStrings.authentication.cameraLabel}}",
                                                "style": {
                                                  "type": "custom",
                                                  "color": "{{appColors.current.text.subtitle}}",
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
                                        "onTap": {
                                          "actionType": "pickFile",
                                          "fileType": "image",
                                          "allowMultiple": false,
                                          "targetKey": "verifyIdentityBackImage",
                                          "hasValueKey": "verifyIdentityBackHasImage",
                                          "source": "camera",
                                          "cropImage": true,
                                          "cropAspectRatioX": 85.6,
                                          "cropAspectRatioY": 54.0,
                                          "previewBeforeConfirm": true,
                                          "previewSheetTitle": "Ù¾ÛŒØ´ Ù†Ù…Ø§ÛŒØ´ ØªØµÙˆÛŒØ± Ú©Ø§Ø±Øª Ù…Ù„ÛŒ",
                                          "confirmButtonText": "ØªØ§ÛŒÛŒØ¯",
                                          "retryButtonText": "Ø¨Ø§Ø²Ú¯Ø´Øª"
                                        },
                                        "type": "gestureDetector"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "color": "{{appColors.current.input.borderEnabled}}",
                                      "width": 1.0,
                                      "height": 28.0,
                                      "type": "container"
                                    },
                                    {
                                      "child": {
                                        "child": {
                                          "padding": {
                                            "left": 12.0,
                                            "top": 8.0,
                                            "right": 12.0,
                                            "bottom": 8.0
                                          },
                                          "child": {
                                            "mainAxisAlignment": "center",
                                            "textDirection": "rtl",
                                            "children": [
                                              {
                                                "src": "{{appAssets.icons.galleryCurrent}}",
                                                "imageType": "asset",
                                                "width": 32.0,
                                                "height": 32.0,
                                                "type": "image"
                                              },
                                              {
                                                "width": 8.0,
                                                "type": "sizedBox"
                                              },
                                              {
                                                "data": "{{appStrings.authentication.galleryLabel}}",
                                                "style": {
                                                  "type": "custom",
                                                  "color": "{{appColors.current.text.subtitle}}",
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
                                        "onTap": {
                                          "actionType": "pickFile",
                                          "fileType": "image",
                                          "allowMultiple": false,
                                          "targetKey": "verifyIdentityBackImage",
                                          "hasValueKey": "verifyIdentityBackHasImage",
                                          "source": "gallery",
                                          "cropImage": true,
                                          "cropAspectRatioX": 85.6,
                                          "cropAspectRatioY": 54.0,
                                          "previewBeforeConfirm": true,
                                          "previewSheetTitle": "Ù¾ÛŒØ´ Ù†Ù…Ø§ÛŒØ´ ØªØµÙˆÛŒØ± Ú©Ø§Ø±Øª Ù…Ù„ÛŒ",
                                          "confirmButtonText": "ØªØ§ÛŒÛŒØ¯",
                                          "retryButtonText": "Ø¨Ø§Ø²Ú¯Ø´Øª"
                                        },
                                        "type": "gestureDetector"
                                      },
                                      "type": "expanded"
                                    }
                                  ],
                                  "type": "row"
                                }
                              },
                              {
                                "type": "visibility",
                                "visible": "[[verifyIdentityBackHasImage]]",
                                "child": {
                                  "crossAxisAlignment": "stretch",
                                  "children": [
                                    {
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
                                      "height": 190.0,
                                      "child": {
                                        "borderRadius": {
                                          "topLeft": 14.0,
                                          "topRight": 14.0,
                                          "bottomLeft": 14.0,
                                          "bottomRight": 14.0
                                        },
                                        "child": {
                                          "type": "registryReactive",
                                          "child": {
                                            "type": "image",
                                            "src": "{{verifyIdentityBackImage}}",
                                            "registryKey": "verifyIdentityBackImage",
                                            "fit": "cover",
                                            "width": 999999,
                                            "height": 190,
                                            "errorBuilder": {
                                              "type": "center",
                                              "child": {
                                                "type": "text",
                                                "data": "{{appStrings.authentication.imagePreviewUnavailable}}",
                                                "textDirection": "rtl",
                                                "style": {
                                                  "type": "custom",
                                                  "fontSize": 14,
                                                  "fontWeight": "w500",
                                                  "color": "{{appColors.current.text.subtitle}}"
                                                }
                                              }
                                            }
                                          }
                                        },
                                        "type": "clipRRect"
                                      },
                                      "type": "container"
                                    },
                                    {
                                      "height": 12.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "mainAxisAlignment": "center",
                                      "children": [
                                        {
                                          "child": {
                                            "data": "Ø¹Ú©Ø³Ø¨Ø±Ø¯Ø§Ø±ÛŒ Ù…Ø¬Ø¯Ø¯",
                                            "style": {
                                              "type": "custom",
                                              "color": "{{appColors.current.text.title}}",
                                              "fontSize": 14.0,
                                              "fontWeight": "w700"
                                            },
                                            "textDirection": "rtl",
                                            "type": "text"
                                          },
                                          "onTap": {
                                            "actionType": "setValue",
                                            "values": [
                                              {
                                                "key": "verifyIdentityBackImage",
                                                "value": ""
                                              },
                                              {
                                                "key": "verifyIdentityBackHasImage",
                                                "value": false
                                              }
                                            ]
                                          },
                                          "type": "gestureDetector"
                                        },
                                        {
                                          "width": 3.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "src": "{{appAssets.icons.refresh}}",
                                          "imageType": "asset",
                                          "width": 24.0,
                                          "height": 24.0,
                                          "type": "image"
                                        }
                                      ],
                                      "type": "row"
                                    }
                                  ],
                                  "type": "column"
                                }
                              }
                            ],
                            "type": "column"
                          },
                          "type": "padding"
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
                        "topLeft": 16.0,
                        "topRight": 16.0,
                        "bottomLeft": 16.0,
                        "bottomRight": 16.0
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
                          "decoration": {
                            "color": "{{appColors.current.background.surfaceContainer}}",
                            "borderRadius": {
                              "topLeft": 16.0,
                              "topRight": 16.0
                            }
                          },
                          "child": {
                            "data": "{{appStrings.authentication.correctBackNationalCardSampleTitle}}",
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
                          "type": "container"
                        },
                        {
                          "padding": {
                            "left": 16.0,
                            "top": 8.0,
                            "right": 16.0,
                            "bottom": 16.0
                          },
                          "child": {
                            "child": {
                              "src": "{{appAssets.images.backNationalSample}}",
                              "imageType": "asset",
                              "width": 240.0,
                              "fit": "contain",
                              "type": "image"
                            },
                            "type": "center"
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
                  },
                  {
                    "crossAxisAlignment": "stretch",
                    "children": [
                      {
                        "crossAxisAlignment": "start",
                        "textDirection": "rtl",
                        "children": [
                          {
                            "data": "â€¢",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 18.0,
                              "fontWeight": "w700"
                            },
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          {
                            "width": 8.0,
                            "type": "sizedBox"
                          },
                          {
                            "child": {
                              "data": "{{appStrings.authentication.tipHoldPhoneVertical}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500",
                                "height": 1.7
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
                      {
                        "height": 6.0,
                        "type": "sizedBox"
                      },
                      {
                        "crossAxisAlignment": "start",
                        "textDirection": "rtl",
                        "children": [
                          {
                            "data": "â€¢",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 18.0,
                              "fontWeight": "w700"
                            },
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          {
                            "width": 8.0,
                            "type": "sizedBox"
                          },
                          {
                            "child": {
                              "data": "{{appStrings.authentication.tipNoReflection}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 14.0,
                                "fontWeight": "w500",
                                "height": 1.7
                              },
                              "textAlign": "right",
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "type": "expanded"
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
              "type": "singleChildScrollView"
            },
            "type": "expanded"
          },
          {
            "padding": {
              "left": 16.0,
              "right": 16.0,
              "bottom": 24.0
            },
            "child": {
              "type": "reactiveElevatedButton",
              "enabledKey": "verifyIdentityBackHasImage",
              "enabled": false,
              "style": {
                "backgroundColor": "{{appColors.current.primary.color}}",
                "elevation": 0.0,
                "fixedSize": {
                  "width": 999999.0,
                  "height": 56.0
                },
                "shape": {
                  "type": "roundedRectangleBorder",
                  "borderRadius": {
                    "topLeft": 12.0,
                    "topRight": 12.0,
                    "bottomLeft": 12.0,
                    "bottomRight": 12.0
                  }
                }
              },
              "disabledStyle": {
                "backgroundColor": "{{appColors.current.background.surfaceContainerHigh}}",
                "elevation": 0.0,
                "fixedSize": {
                  "width": 999999.0,
                  "height": 56.0
                },
                "shape": {
                  "type": "roundedRectangleBorder",
                  "borderRadius": {
                    "topLeft": 12.0,
                    "topRight": 12.0,
                    "bottomLeft": 12.0,
                    "bottomRight": 12.0
                  }
                }
              },
              "child": {
                "data": "{{appStrings.authentication.continueLabel}}",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.primary.onPrimary}}",
                  "fontSize": 18.0,
                  "fontWeight": "w700"
                },
                "textDirection": "rtl",
                "type": "text"
              },
              "onPressed": {
                "actionType": "navigate",
                "navigationStyle": "push",
                "request": {
                  "url": "http://192.168.179.21:8101/api/configurations/v1.0/configs/resolve/ipaam.builder.form.form.verify_identity_real_selfie/1",
                  "method": "post",
                  "headers": {
                    "Content-Type": "application/json",
                    "Accept": "*/*"
                  },
                  "body": {
                    "operator": "is",
                    "dimension": {
                      "app": "mobile"
                    }
                  }
                }
              }
            },
            "type": "padding"
          }
        ],
        "type": "column"
      }
    },
    "type": "scaffold"
  }
}
```
