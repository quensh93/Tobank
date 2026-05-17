# flows/verify_identity_real/json/verify_identity_real_old_national_card.json

Source: lib/stac/tobank/flows/verify_identity_real/json/verify_identity_real_old_national_card.json

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
        "key": "oldCardTrackingCode",
        "value": ""
      },
      {
        "key": "oldCardPhoto",
        "value": ""
      },
      {
        "key": "oldCardVideo",
        "value": ""
      },
      {
        "key": "oldCardVideoName",
        "value": ""
      },
      {
        "key": "hasOldCardPhoto",
        "value": false
      },
      {
        "key": "hasOldCardVideo",
        "value": false
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
            "key": "oldCardTrackingCode",
            "value": ""
          },
          {
            "key": "oldCardPhoto",
            "value": ""
          },
          {
            "key": "oldCardVideo",
            "value": ""
          },
          {
            "key": "oldCardVideoName",
            "value": ""
          },
          {
            "key": "hasOldCardPhoto",
            "value": false
          },
          {
            "key": "hasOldCardVideo",
            "value": false
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
                    "crossAxisAlignment": "start",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "child": {
                          "data": "{{appStrings.authentication.oldCardTrackingCodeDescription}}",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 15.0,
                            "fontWeight": "w600",
                            "height": 1.8
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
                        "child": {
                          "padding": {
                            "left": 16.0,
                            "top": 8.0,
                            "right": 16.0,
                            "bottom": 8.0
                          },
                          "decoration": {
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
                            "mainAxisSize": "min",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "icon": "info_outline",
                                "iconType": "material",
                                "size": 23.0,
                                "color": "{{appColors.current.text.title}}",
                                "type": "icon"
                              },
                              {
                                "width": 6.0,
                                "type": "sizedBox"
                              },
                              {
                                "data": "{{appStrings.authentication.guideLabel}}",
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
                          "type": "container"
                        },
                        "onTap": {
                          "actionType": "showGuideOptionsBottomSheet",
                          "title": "Ø±Ø§Ù‡Ù†Ù…Ø§",
                          "options": [
                            {
                              "title": "Ø±Ø§Ù‡Ù†Ù…Ø§ÛŒ ØªØµÙˆÛŒØ±ÛŒ",
                              "iconAsset": "{{appAssets.icons.visualTutorialCurrent}}",
                              "onTap": {
                                "actionType": "launchUrl",
                                "url": "https://appapi.tobank.ir/api/v1.0/media/ekyc/face_movement_video.mp4",
                                "mode": "inAppWebView"
                              }
                            },
                            {
                              "title": "Ø±Ø§Ù‡Ù†Ù…Ø§ÛŒ ØµÙˆØªÛŒ",
                              "iconAsset": "{{appAssets.icons.voiceTutorialCurrent}}",
                              "onTap": {
                                "actionType": "playAudioUrl",
                                "url": "https://appapi.tobank.ir/api/v1.0/media/ekyc/personal_photo_video_receipt_serial.mp3",
                                "stopPrevious": true
                              }
                            }
                          ]
                        },
                        "type": "gestureDetector"
                      }
                    ],
                    "type": "row"
                  },
                  {
                    "height": 24.0,
                    "type": "sizedBox"
                  },
                  {
                    "crossAxisAlignment": "stretch",
                    "children": [
                      {
                        "data": "{{appStrings.authentication.trackingCodeLabel}}",
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
                        "height": 12.0,
                        "type": "sizedBox"
                      },
                      {
                        "id": "oldCardTrackingCode",
                        "decoration": {
                          "hintText": "{{appStrings.authentication.trackingCodeHint}}",
                          "hintStyle": {
                            "type": "custom",
                            "color": "{{appColors.current.text.hint}}",
                            "fontSize": 14.0,
                            "fontWeight": "w500"
                          },
                          "contentPadding": {
                            "left": 18.0,
                            "top": 18.0,
                            "right": 18.0,
                            "bottom": 18.0
                          },
                          "filled": false
                        },
                        "style": {
                          "type": "custom",
                          "color": "{{appColors.current.text.title}}",
                          "fontSize": 17.0,
                          "fontWeight": "w600"
                        },
                        "textAlign": "right",
                        "textDirection": "rtl",
                        "type": "textFormField"
                      }
                    ],
                    "type": "column"
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
                            "data": "{{appStrings.authentication.capturePhotoTitle}}",
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
                            "top": 16.0,
                            "right": 16.0,
                            "bottom": 16.0
                          },
                          "child": {
                            "crossAxisAlignment": "stretch",
                            "children": [
                              {
                                "type": "visibility",
                                "visible": "[[!hasOldCardPhoto]]",
                                "child": {
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
                                        "data": "{{appStrings.authentication.capturePhotoButton}}",
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
                                  "onTap": {
                                    "actionType": "showPhotoTipsBottomSheet",
                                    "title": "Ù†Ú©Ø§Øª Ù‚Ø§Ø¨Ù„ ØªÙˆØ¬Ù‡ Ø¹Ú©Ø³",
                                    "iconAsset": "{{appAssets.icons.cameraCurrent}}",
                                    "tips": [
                                      "Ù¾ÙˆØ´Ø´ Ù…Ù†Ø§Ø³Ø¨ Ø±Ø¹Ø§ÛŒØª Ø´ÙˆØ¯",
                                      "Ø¹Ú©Ø³ Ø¨Ø§ÛŒØ¯ ÙˆØ§Ø¶Ø­ Ùˆ Ø¨Ø¯ÙˆÙ† ØªØ§Ø±ÛŒ Ø¨Ø§Ø´Ø¯",
                                      "Ù¾Ø³ Ø²Ù…ÛŒÙ†Ù‡ ÛŒÚ©Ù†ÙˆØ§Ø®Øª Ø¨Ø§Ø´Ø¯",
                                      "Ø¹Ø¯Ù… ÙˆØ¬ÙˆØ¯ Ù‡Ø±Ú¯ÙˆÙ†Ù‡ ÙØ±Ø¯ Ø¯ÛŒÚ¯Ø± Ø¯Ø± ØªØµÙˆÛŒØ±",
                                      "ØªØµÙˆÛŒØ± Ø±Ø® Ú©Ø§Ù…Ù„ ØµÙˆØ±Øª ÙØ±Ø¯ Ø±Ø§ Ù†Ø´Ø§Ù† Ø¯Ù‡Ø¯ (Ø¨Ø¯ÙˆÙ† Ø¹ÛŒÙ†Ú© Ø¢ÙØªØ§Ø¨ÛŒØŒ Ù…Ø§Ø³Ú© ÛŒØ§ Ø³Ø§ÛŒÙ‡â€ŒÙ‡Ø§ÛŒ Ø´Ø¯ÛŒØ¯)"
                                    ],
                                    "previewAsset": "https://appapi.tobank.ir/api/v1.0/media/ekyc/personal_picture_sample.png",
                                    "continueAction": {
                                      "actionType": "pickFile",
                                      "fileType": "image",
                                      "targetKey": "oldCardPhoto",
                                      "hasValueKey": "hasOldCardPhoto",
                                      "source": "camera",
                                      "cameraDevice": "front",
                                      "cropImage": true,
                                      "cropAspectRatioX": 3.0,
                                      "cropAspectRatioY": 4.0,
                                      "previewBeforeConfirm": true,
                                      "previewSheetTitle": "Ø¹Ú©Ø³ Ú¯Ø±ÙØªÙ‡ Ø´Ø¯Ù‡ Ù…ÙˆØ±Ø¯ ØªØ§ÛŒÛŒØ¯ Ø´Ù…Ø§ Ø§Ø³ØªØŸ",
                                      "confirmButtonText": "ØªØ§ÛŒÛŒØ¯",
                                      "retryButtonText": "Ø¨Ø§Ø²Ú¯Ø´Øª"
                                    },
                                    "continueText": "Ø§Ø¯Ø§Ù…Ù‡",
                                    "cancelText": "Ø¨Ø§Ø²Ú¯Ø´Øª"
                                  },
                                  "type": "gestureDetector"
                                }
                              },
                              {
                                "type": "visibility",
                                "visible": "[[hasOldCardPhoto]]",
                                "child": {
                                  "crossAxisAlignment": "center",
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "decoration": {
                                        "color": "{{appColors.current.background.surface}}",
                                        "borderRadius": {
                                          "topLeft": 8.0,
                                          "topRight": 8.0,
                                          "bottomLeft": 8.0,
                                          "bottomRight": 8.0
                                        }
                                      },
                                      "width": 36.0,
                                      "height": 48.0,
                                      "child": {
                                        "borderRadius": {
                                          "topLeft": 8.0,
                                          "topRight": 8.0,
                                          "bottomLeft": 8.0,
                                          "bottomRight": 8.0
                                        },
                                        "child": {
                                          "type": "registryReactive",
                                          "child": {
                                            "type": "image",
                                            "src": "{{oldCardPhoto}}",
                                            "registryKey": "oldCardPhoto",
                                            "fit": "cover",
                                            "width": 36,
                                            "height": 48,
                                            "errorBuilder": {
                                              "type": "center",
                                              "child": {
                                                "type": "icon",
                                                "icon": "image_outlined",
                                                "size": 18,
                                                "color": "{{appColors.current.text.subtitle}}"
                                              }
                                            }
                                          }
                                        },
                                        "type": "clipRRect"
                                      },
                                      "type": "container"
                                    },
                                    {
                                      "child": {
                                        "type": "sizedBox"
                                      },
                                      "type": "expanded"
                                    },
                                    {
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
                                            "width": 6.0,
                                            "type": "sizedBox"
                                          },
                                          {
                                            "data": "Ø­Ø°Ù",
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
                                      "onTap": {
                                        "actionType": "setValue",
                                        "values": [
                                          {
                                            "key": "oldCardPhoto",
                                            "value": ""
                                          },
                                          {
                                            "key": "hasOldCardPhoto",
                                            "value": false
                                          }
                                        ]
                                      },
                                      "type": "gestureDetector"
                                    }
                                  ],
                                  "type": "row"
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
                            "data": "{{appStrings.authentication.captureVideoTitle}}",
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
                            "top": 16.0,
                            "right": 16.0,
                            "bottom": 16.0
                          },
                          "child": {
                            "crossAxisAlignment": "stretch",
                            "children": [
                              {
                                "type": "visibility",
                                "visible": "[[!hasOldCardVideo]]",
                                "child": {
                                  "child": {
                                    "mainAxisAlignment": "center",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "src": "{{appAssets.icons.videoCurrent}}",
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
                                        "data": "{{appStrings.authentication.captureVideoButton}}",
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
                                  "onTap": {
                                    "actionType": "showPhotoTipsBottomSheet",
                                    "title": "Ù†Ú©Ø§Øª Ù‚Ø§Ø¨Ù„ ØªÙˆØ¬Ù‡ ÙˆÛŒØ¯ÛŒÙˆ",
                                    "iconAsset": "{{appAssets.icons.videoCurrent}}",
                                    "tips": [
                                      "Ù¾ÙˆØ´Ø´ Ù…Ù†Ø§Ø³Ø¨ Ø±Ø¹Ø§ÛŒØª Ø´ÙˆØ¯",
                                      "ÙÛŒÙ„Ù… Ø¨Ø§ÛŒØ¯ ÙˆØ§Ø¶Ø­ Ùˆ Ø¨Ø¯ÙˆÙ† ØªØ§Ø±ÛŒ Ø¨Ø§Ø´Ø¯",
                                      "Ù¾Ø³â€ŒØ²Ù…ÛŒÙ†Ù‡ ÛŒÚ©Ø¯Ø³Øª (ØªØ±Ø¬ÛŒØ­Ø§ Ø³ÙÛŒØ¯ ÛŒØ§ Ø±ÙˆØ´Ù†)",
                                      "ØªÙ†Ù‡Ø§ ÛŒÚ© Ù†ÙØ± Ø¯Ø± ØªØµÙˆÛŒØ± Ø­Ø¶ÙˆØ± Ø¯Ø§Ø´ØªÙ‡ Ø¨Ø§Ø´Ø¯",
                                      "ÙˆÛŒØ¯ÛŒÙˆ Ø¨Ø§ÛŒØ¯ Ú©Ø§Ù…Ù„ ØµÙˆØ±Øª Ú©Ø§Ø±Ø¨Ø± Ø±Ø§ Ù¾ÙˆØ´Ø´ Ø¯Ù‡Ø¯ (Ø¨Ø¯ÙˆÙ† Ø¹ÛŒÙ†Ú© Ø§ÙØªØ§Ø¨ÛŒØŒ Ù…Ø§Ø³Ú© ÛŒØ§ Ø³Ø§ÛŒÙ‡ Ù‡Ø§ÛŒ Ø´Ø¯ÛŒØ¯)"
                                    ],
                                    "previewAsset": "https://appapi.tobank.ir/api/v1.0/media/ekyc/face_movement_video.mp4",
                                    "continueAction": {
                                      "actionType": "pickFile",
                                      "fileType": "video",
                                      "targetKey": "oldCardVideo",
                                      "hasValueKey": "hasOldCardVideo",
                                      "fileNameKey": "oldCardVideoName",
                                      "source": "camera",
                                      "cameraDevice": "front",
                                      "previewBeforeConfirm": true,
                                      "previewSheetTitle": "ÙˆÛŒØ¯ÛŒÙˆÛŒ Ú¯Ø±ÙØªÙ‡ Ø´Ø¯Ù‡ Ù…ÙˆØ±Ø¯ ØªØ§ÛŒÛŒØ¯ Ø´Ù…Ø§ Ø§Ø³ØªØŸ",
                                      "confirmButtonText": "ØªØ§ÛŒÛŒØ¯",
                                      "retryButtonText": "Ø¨Ø§Ø²Ú¯Ø´Øª"
                                    },
                                    "continueText": "Ø§Ø¯Ø§Ù…Ù‡",
                                    "cancelText": "Ø¨Ø§Ø²Ú¯Ø´Øª"
                                  },
                                  "type": "gestureDetector"
                                }
                              },
                              {
                                "type": "visibility",
                                "visible": "[[hasOldCardVideo]]",
                                "child": {
                                  "crossAxisAlignment": "center",
                                  "textDirection": "rtl",
                                  "children": [
                                    {
                                      "child": {
                                        "data": "{{oldCardVideoName}}",
                                        "style": {
                                          "type": "custom",
                                          "color": "{{appColors.current.primary.color}}",
                                          "fontSize": 12.0,
                                          "fontWeight": "w500"
                                        },
                                        "textAlign": "right",
                                        "textDirection": "ltr",
                                        "type": "text"
                                      },
                                      "type": "expanded"
                                    },
                                    {
                                      "width": 12.0,
                                      "type": "sizedBox"
                                    },
                                    {
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
                                            "width": 6.0,
                                            "type": "sizedBox"
                                          },
                                          {
                                            "data": "Ø­Ø°Ù",
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
                                      "onTap": {
                                        "actionType": "setValue",
                                        "values": [
                                          {
                                            "key": "oldCardVideo",
                                            "value": ""
                                          },
                                          {
                                            "key": "oldCardVideoName",
                                            "value": ""
                                          },
                                          {
                                            "key": "hasOldCardVideo",
                                            "value": false
                                          }
                                        ]
                                      },
                                      "type": "gestureDetector"
                                    }
                                  ],
                                  "type": "row"
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
              "onPressed": {
                "actionType": "sequence",
                "actions": [
                  {
                    "actionType": "stopAudioUrl"
                  },
                  {
                    "actionType": "showResult",
                    "title": "{{appStrings.common.comingSoon}}",
                    "content": "{{appStrings.common.comingSoon}}"
                  }
                ]
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
                    "topLeft": 12.0,
                    "topRight": 12.0,
                    "bottomLeft": 12.0,
                    "bottomRight": 12.0
                  }
                }
              },
              "child": {
                "data": "{{appStrings.authentication.confirmLabel}}",
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
