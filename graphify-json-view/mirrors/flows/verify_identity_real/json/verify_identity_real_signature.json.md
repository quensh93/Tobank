# flows/verify_identity_real/json/verify_identity_real_signature.json

Source: lib/stac/tobank/flows/verify_identity_real/json/verify_identity_real_signature.json

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
        "key": "verifyIdentitySignatureImage",
        "value": ""
      },
      {
        "key": "verifyIdentityHasSignature",
        "value": false
      },
      {
        "key": "verifyIdentitySignatureClearVersion",
        "value": 0
      }
    ]
  },
  "onDispose": {
    "actionType": "sequence",
    "actions": [
      {
        "actionType": "stopAudioUrl"
      },
      {
        "actionType": "setValue",
        "values": [
          {
            "key": "verifyIdentitySignatureImage",
            "value": ""
          },
          {
            "key": "verifyIdentityHasSignature",
            "value": false
          },
          {
            "key": "verifyIdentitySignatureClearVersion",
            "value": 0
          }
        ]
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
              "actionType": "sequence",
              "actions": [
                {
                  "actionType": "stopAudioUrl"
                },
                {
                  "actionType": "navigate",
                  "navigationStyle": "pop"
                }
              ]
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
                    "mainAxisAlignment": "spaceBetween",
                    "crossAxisAlignment": "center",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "data": "Ø¯Ø±ÛŒØ§ÙØª Ø§Ù…Ø¶Ø§",
                        "style": {
                          "type": "custom",
                          "color": "{{appColors.current.text.title}}",
                          "fontSize": 18.0,
                          "fontWeight": "w700"
                        },
                        "textDirection": "rtl",
                        "type": "text"
                      },
                      {
                        "onPressed": {
                          "actionType": "showGuideOptionsBottomSheet",
                          "title": "Ø±Ø§Ù‡Ù†Ù…Ø§",
                          "options": [
                            {
                              "title": "Ø±Ø§Ù‡Ù†Ù…Ø§ÛŒ ØªØµÙˆÛŒØ±ÛŒ",
                              "iconAsset": "{{appAssets.icons.visualTutorialCurrent}}",
                              "onTap": {
                                "actionType": "launchUrl",
                                "url": "https://tobank.ir/app/signature-template/",
                                "mode": "inAppWebView"
                              }
                            },
                            {
                              "title": "Ø±Ø§Ù‡Ù†Ù…Ø§ÛŒ ØµÙˆØªÛŒ",
                              "iconAsset": "{{appAssets.icons.voiceTutorialCurrent}}",
                              "onTap": {
                                "actionType": "playAudioUrl",
                                "url": "https://appapi.tobank.ir/api/v1.0/media/ekyc/signature_page.mp3",
                                "stopPrevious": true
                              }
                            }
                          ]
                        },
                        "style": {
                          "foregroundColor": "{{appColors.current.text.title}}",
                          "padding": {
                            "left": 12.0,
                            "top": 12.0,
                            "right": 12.0,
                            "bottom": 12.0
                          },
                          "minimumSize": {
                            "width": 88.0,
                            "height": 38.0
                          },
                          "side": {
                            "color": "{{appColors.current.input.borderEnabled}}",
                            "width": 1.0
                          },
                          "shape": {
                            "type": "roundedRectangleBorder",
                            "borderRadius": {
                              "topLeft": 8.0,
                              "topRight": 8.0,
                              "bottomLeft": 8.0,
                              "bottomRight": 8.0
                            }
                          }
                        },
                        "child": {
                          "mainAxisSize": "min",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "src": "{{appAssets.icons.info}}",
                              "imageType": "asset",
                              "color": "{{appColors.current.text.subtitle}}",
                              "width": 21.0,
                              "height": 21.0,
                              "type": "image"
                            },
                            {
                              "width": 8.0,
                              "type": "sizedBox"
                            },
                            {
                              "data": "Ø±Ø§Ù‡Ù†Ù…Ø§",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 17.0,
                                "fontWeight": "w600"
                              },
                              "textDirection": "rtl",
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
                    "data": "Ù„Ø·ÙØ§ Ù†Ù…ÙˆÙ†Ù‡ Ø§Ù…Ø¶Ø§ Ø®ÙˆØ¯ Ø±Ø§ Ø¯Ø± Ú©Ø§Ø¯Ø± Ø²ÛŒØ± ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯ Ùˆ Ù¾Ø³ Ø§Ø² ØªØ§ÛŒÛŒØ¯ØŒ Ø¯Ú©Ù…Ù‡ ØªØ§ÛŒÛŒØ¯ Ùˆ Ø§Ø¯Ø§Ù…Ù‡ Ø±Ø§ ÙØ´Ø§Ø± Ø¯Ù‡ÛŒØ¯.",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.text.subtitle}}",
                      "fontSize": 17.0,
                      "fontWeight": "w500",
                      "height": 1.8
                    },
                    "textAlign": "right",
                    "textDirection": "rtl",
                    "type": "text"
                  },
                  {
                    "height": 16.0,
                    "type": "sizedBox"
                  },
                  {
                    "decoration": {
                      "color": "{{appColors.current.background.surface}}",
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
                    "height": 360.0,
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
                            "alignment": "centerEnd",
                            "child": {
                              "data": "Ù…Ø­Ù„ Ø§Ù…Ø¶Ø§",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 16.0,
                                "fontWeight": "w700"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "type": "align"
                          },
                          "type": "padding"
                        },
                        {
                          "child": {
                            "padding": {
                              "left": 12.0,
                              "right": 12.0,
                              "bottom": 12.0
                            },
                            "child": {
                              "type": "signaturePad",
                              "valueKey": "verifyIdentitySignatureImage",
                              "hasSignatureKey": "verifyIdentityHasSignature",
                              "clearKey": "verifyIdentitySignatureClearVersion",
                              "strokeColor": "#111111",
                              "backgroundColor": "#00000000",
                              "strokeWidth": 3.2
                            },
                            "type": "padding"
                          },
                          "type": "expanded"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  {
                    "height": 18.0,
                    "type": "sizedBox"
                  },
                  {
                    "alignment": "center",
                    "child": {
                      "onPressed": {
                        "actionType": "setValue",
                        "key": "verifyIdentitySignatureClearVersion",
                        "value": "{{now()}}"
                      },
                      "style": {
                        "foregroundColor": "{{appColors.current.text.title}}",
                        "padding": {
                          "left": 18.0,
                          "top": 8.0,
                          "right": 18.0,
                          "bottom": 8.0
                        },
                        "minimumSize": {
                          "width": 124.0,
                          "height": 42.0
                        },
                        "side": {
                          "color": "{{appColors.current.input.borderEnabled}}",
                          "width": 1.0
                        },
                        "shape": {
                          "type": "roundedRectangleBorder",
                          "borderRadius": {
                            "topLeft": 48.0,
                            "topRight": 48.0,
                            "bottomLeft": 48.0,
                            "bottomRight": 48.0
                          }
                        }
                      },
                      "child": {
                        "mainAxisSize": "min",
                        "textDirection": "rtl",
                        "children": [
                          {
                            "src": "{{appAssets.icons.deleteCurrent}}",
                            "imageType": "asset",
                            "width": 20.0,
                            "height": 20.0,
                            "type": "image"
                          },
                          {
                            "width": 8.0,
                            "type": "sizedBox"
                          },
                          {
                            "data": "Ø­Ø°Ù",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 17.0,
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
                    "type": "align"
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
              "enabledKey": "verifyIdentityHasSignature",
              "enabled": false,
              "onPressed": {
                "actionType": "sequence",
                "actions": [
                  {
                    "actionType": "stopAudioUrl"
                  },
                  {
                    "actionType": "navigate",
                    "navigationStyle": "push",
                    "request": {
                      "url": "http://192.168.179.21:8101/api/configurations/v1.0/configs/resolve/ipaam.builder.form.form.verify_identity_real_certificate_generator/1",
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
                ]
              },
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
                "data": "ØªØ§ÛŒÛŒØ¯ Ùˆ Ø§Ø¯Ø§Ù…Ù‡",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.primary.onPrimary}}",
                  "fontSize": 18.0,
                  "fontWeight": "w700"
                },
                "textDirection": "rtl",
                "type": "text"
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
