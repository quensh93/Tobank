# flows/gift_card_real/json/gift_card_real_custom_select_design.json

Source: lib/stac/tobank/flows/gift_card_real/json/gift_card_real_custom_select_design.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "type": "stateFull",
  "onInit": {
    "values": [
      {
        "key": "giftCardRealSelectedPlanId",
        "value": ""
      },
      {
        "key": "giftCardRealSelectedPlanTitle",
        "value": ""
      },
      {
        "key": "giftCardRealSelectedPlanPrimaryColor",
        "value": ""
      },
      {
        "key": "giftCardRealSelectedPlanSecondaryColor",
        "value": ""
      },
      {
        "key": "giftCardRealSelectedPlanAccentColor",
        "value": ""
      },
      {
        "key": "giftCardRealSelectedPlanImageUrl",
        "value": ""
      },
      {
        "key": "giftCardRealSelectedCategory",
        "value": ""
      },
      {
        "key": "giftCardRealCustomHasReplacementMessage",
        "value": false
      },
      {
        "key": "giftCardRealCustomReplacementMessage",
        "value": ""
      },
      {
        "key": "giftCardRealCustomReplacementMessageOptionId",
        "value": ""
      }
    ],
    "actionType": "setValue"
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
        "data": "Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
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
              "actionType": "sequence",
              "actions": [
                {
                  "values": [
                    {
                      "key": "giftCardRealSelectedPlanId",
                      "value": ""
                    },
                    {
                      "key": "giftCardRealSelectedPlanTitle",
                      "value": ""
                    },
                    {
                      "key": "giftCardRealSelectedPlanPrimaryColor",
                      "value": ""
                    },
                    {
                      "key": "giftCardRealSelectedPlanSecondaryColor",
                      "value": ""
                    },
                    {
                      "key": "giftCardRealSelectedPlanAccentColor",
                      "value": ""
                    },
                    {
                      "key": "giftCardRealSelectedPlanImageUrl",
                      "value": ""
                    },
                    {
                      "key": "giftCardRealSelectedCategory",
                      "value": ""
                    },
                    {
                      "key": "giftCardRealCustomHasReplacementMessage",
                      "value": false
                    },
                    {
                      "key": "giftCardRealCustomReplacementMessage",
                      "value": ""
                    },
                    {
                      "key": "giftCardRealCustomReplacementMessageOptionId",
                      "value": ""
                    }
                  ],
                  "actionType": "setValue"
                },
                {
                  "navigationStyle": "pop",
                  "actionType": "navigate"
                }
              ]
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
        "top": 22.0,
        "right": 16.0,
        "bottom": 20.0
      },
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
                "topLeft": 10.0,
                "topRight": 10.0,
                "bottomLeft": 10.0,
                "bottomRight": 10.0
              }
            },
            "child": {
              "padding": {
                "left": 14.0,
                "top": 14.0,
                "right": 14.0,
                "bottom": 14.0
              },
              "child": {
                "data": "Ù„Ø·ÙØ§ ÛŒÚ©ÛŒ Ø§Ø² Ø·Ø±Ø­â€ŒÙ‡Ø§ÛŒ Ù¾ÛŒØ´â€ŒÙØ±Ø¶ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯ ØªØ§ Ø¯Ø± ØµÙˆØ±Øª Ø¹Ø¯Ù… Ù…ÙˆØ§ÙÙ‚Øª Ø¨Ø§Ù†Ú© Ø¨Ø§ Ø¹Ú©Ø³ Ø¯Ù„Ø®ÙˆØ§Ù‡ Ø´Ù…Ø§ØŒ Ø·Ø±Ø­ Ù¾ÛŒØ´â€ŒÙØ±Ø¶ Ø¬Ø§ÛŒÚ¯Ø²ÛŒÙ† Ø¢Ù† Ø´ÙˆØ¯",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.text.subtitle}}",
                  "fontSize": 15.0,
                  "fontWeight": "w500",
                  "height": 1.6
                },
                "textDirection": "rtl",
                "type": "text"
              },
              "type": "padding"
            },
            "type": "container"
          },
          {
            "height": 18.0,
            "type": "sizedBox"
          },
          {
            "children": [
              {
                "child": {
                  "child": {
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
                    "height": 190.0,
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "decoration": {
                            "borderRadius": {
                              "topLeft": 12.0,
                              "topRight": 12.0,
                              "bottomLeft": 0.0,
                              "bottomRight": 0.0
                            },
                            "gradient": {
                              "gradientType": "linear",
                              "colors": [
                                "#1C4A95",
                                "#5A39A5"
                              ],
                              "begin": "centerLeft",
                              "end": "centerRight"
                            }
                          },
                          "height": 102.0,
                          "child": {
                            "children": [
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "bottom": 0.0,
                                "child": {
                                  "src": "https://picsum.photos/seed/gift-category-nowruz/1200/560",
                                  "imageType": "network",
                                  "fit": "cover",
                                  "type": "image"
                                },
                                "type": "positioned"
                              },
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "child": {
                                  "padding": {
                                    "left": 8.0,
                                    "right": 8.0
                                  },
                                  "color": "#F7FAFD",
                                  "height": 30.0,
                                  "child": {
                                    "mainAxisAlignment": "spaceBetween",
                                    "crossAxisAlignment": "center",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "src": "assets/icons/shetab.svg",
                                        "imageType": "asset",
                                        "width": 66.0,
                                        "height": 20.0,
                                        "fit": "contain",
                                        "type": "image"
                                      },
                                      {
                                        "src": "assets/icons/gardeshgary.svg",
                                        "imageType": "asset",
                                        "width": 64.0,
                                        "height": 18.0,
                                        "fit": "contain",
                                        "type": "image"
                                      }
                                    ],
                                    "type": "row"
                                  },
                                  "type": "container"
                                },
                                "type": "positioned"
                              }
                            ],
                            "type": "stack"
                          },
                          "clipBehavior": "hardEdge",
                          "type": "container"
                        },
                        {
                          "child": {
                            "child": {
                              "padding": {
                                "left": 8.0,
                                "right": 8.0
                              },
                              "child": {
                                "data": "ØªØ¨Ø±ÛŒÚ© Ù†ÙˆØ±ÙˆØ²",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 16.0,
                                  "fontWeight": "w600"
                                },
                                "textAlign": "center",
                                "textDirection": "rtl",
                                "overflow": "ellipsis",
                                "maxLines": 2,
                                "type": "text"
                              },
                              "type": "padding"
                            },
                            "type": "center"
                          },
                          "type": "expanded"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "showGiftCardPlanSelectorBottomSheet",
                    "title": "Ù„Ø·ÙØ§ Ø·Ø±Ø­ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                    "categoryTitle": "ØªØ¨Ø±ÛŒÚ© Ù†ÙˆØ±ÙˆØ²",
                    "selectedPlanIdKey": "giftCardRealSelectedPlanId",
                    "selectedPlanTitleKey": "giftCardRealSelectedPlanTitle",
                    "selectedCategoryKey": "giftCardRealSelectedCategory",
                    "plans": [
                      {
                        "id": "nowruz-1",
                        "title": "Ø¨Ù‡Ø§Ø± Ø³Ø¨Ø²",
                        "primaryColor": "#3A6BC4",
                        "secondaryColor": "#4E78C8",
                        "accentColor": "#6A4CBC",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-nowruz-1/1200/560"
                      },
                      {
                        "id": "nowruz-2",
                        "title": "ØªØ¨Ø±ÛŒÚ© Ù†ÙˆØ±ÙˆØ²",
                        "primaryColor": "#334FA1",
                        "secondaryColor": "#515DBD",
                        "accentColor": "#7147AF",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-nowruz-2/1200/560"
                      },
                      {
                        "id": "nowruz-3",
                        "title": "Ù‡ÙØªâ€ŒØ³ÛŒÙ†",
                        "primaryColor": "#235D9C",
                        "secondaryColor": "#426FBB",
                        "accentColor": "#6D50B4",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-nowruz-3/1200/560"
                      },
                      {
                        "id": "nowruz-4",
                        "title": "Ø³Ø§Ù„ Ù†Ùˆ Ù…Ø¨Ø§Ø±Ú©",
                        "primaryColor": "#2D5B9F",
                        "secondaryColor": "#4C66B3",
                        "accentColor": "#6B58B2",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-nowruz-4/1200/560"
                      },
                      {
                        "id": "nowruz-5",
                        "title": "Ù†ÙˆØ±ÙˆØ²ÛŒ",
                        "primaryColor": "#2E59AA",
                        "secondaryColor": "#4B68B7",
                        "accentColor": "#744CB4",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-nowruz-5/1200/560"
                      },
                      {
                        "id": "nowruz-6",
                        "title": "Ø¨Ù‡Ø§Ø±ÛŒÙ‡",
                        "primaryColor": "#3B62AA",
                        "secondaryColor": "#5A6EC0",
                        "accentColor": "#7B56BB",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-nowruz-6/1200/560"
                      }
                    ],
                    "onPlanSelectedAction": {
                      "routeName": "gift_card_real_custom_message",
                      "navigationStyle": "push",
                      "actionType": "navigate"
                    }
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
                    "height": 190.0,
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "decoration": {
                            "borderRadius": {
                              "topLeft": 12.0,
                              "topRight": 12.0,
                              "bottomLeft": 0.0,
                              "bottomRight": 0.0
                            },
                            "gradient": {
                              "gradientType": "linear",
                              "colors": [
                                "#2BA76E",
                                "#2E7CC7"
                              ],
                              "begin": "centerLeft",
                              "end": "centerRight"
                            }
                          },
                          "height": 102.0,
                          "child": {
                            "children": [
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "bottom": 0.0,
                                "child": {
                                  "src": "https://picsum.photos/seed/gift-category-birth-months/1200/560",
                                  "imageType": "network",
                                  "fit": "cover",
                                  "type": "image"
                                },
                                "type": "positioned"
                              },
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "child": {
                                  "padding": {
                                    "left": 8.0,
                                    "right": 8.0
                                  },
                                  "color": "#F7FAFD",
                                  "height": 30.0,
                                  "child": {
                                    "mainAxisAlignment": "spaceBetween",
                                    "crossAxisAlignment": "center",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "src": "assets/icons/shetab.svg",
                                        "imageType": "asset",
                                        "width": 66.0,
                                        "height": 20.0,
                                        "fit": "contain",
                                        "type": "image"
                                      },
                                      {
                                        "src": "assets/icons/gardeshgary.svg",
                                        "imageType": "asset",
                                        "width": 64.0,
                                        "height": 18.0,
                                        "fit": "contain",
                                        "type": "image"
                                      }
                                    ],
                                    "type": "row"
                                  },
                                  "type": "container"
                                },
                                "type": "positioned"
                              }
                            ],
                            "type": "stack"
                          },
                          "clipBehavior": "hardEdge",
                          "type": "container"
                        },
                        {
                          "child": {
                            "child": {
                              "padding": {
                                "left": 8.0,
                                "right": 8.0
                              },
                              "child": {
                                "data": "Ù…Ø§Ù‡â€ŒÙ‡Ø§ÛŒ ØªÙˆÙ„Ø¯",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 16.0,
                                  "fontWeight": "w600"
                                },
                                "textAlign": "center",
                                "textDirection": "rtl",
                                "overflow": "ellipsis",
                                "maxLines": 2,
                                "type": "text"
                              },
                              "type": "padding"
                            },
                            "type": "center"
                          },
                          "type": "expanded"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "showGiftCardPlanSelectorBottomSheet",
                    "title": "Ù„Ø·ÙØ§ Ø·Ø±Ø­ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                    "categoryTitle": "Ù…Ø§Ù‡â€ŒÙ‡Ø§ÛŒ ØªÙˆÙ„Ø¯",
                    "selectedPlanIdKey": "giftCardRealSelectedPlanId",
                    "selectedPlanTitleKey": "giftCardRealSelectedPlanTitle",
                    "selectedCategoryKey": "giftCardRealSelectedCategory",
                    "plans": [
                      {
                        "id": "birth-month-farvardin",
                        "title": "ÙØ±ÙˆØ±Ø¯ÛŒÙ†",
                        "primaryColor": "#BBE86A",
                        "secondaryColor": "#79D070",
                        "accentColor": "#5CBFA2",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-birth-month-farvardin/1200/560"
                      },
                      {
                        "id": "birth-month-ordibehesht",
                        "title": "Ø§Ø±Ø¯ÛŒØ¨Ù‡Ø´Øª",
                        "primaryColor": "#B2E27D",
                        "secondaryColor": "#85CF78",
                        "accentColor": "#44B39C",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-birth-month-ordibehesht/1200/560"
                      },
                      {
                        "id": "birth-month-khordad",
                        "title": "Ø®Ø±Ø¯Ø§Ø¯",
                        "primaryColor": "#B5E67D",
                        "secondaryColor": "#78D07A",
                        "accentColor": "#53B7A7",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-birth-month-khordad/1200/560"
                      },
                      {
                        "id": "birth-month-tir",
                        "title": "ØªÛŒØ±",
                        "primaryColor": "#BEE56C",
                        "secondaryColor": "#87CE77",
                        "accentColor": "#43AB9D",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-birth-month-tir/1200/560"
                      },
                      {
                        "id": "birth-month-mordad",
                        "title": "Ù…Ø±Ø¯Ø§Ø¯",
                        "primaryColor": "#CAE178",
                        "secondaryColor": "#89CB73",
                        "accentColor": "#41A69A",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-birth-month-mordad/1200/560"
                      },
                      {
                        "id": "birth-month-shahrivar",
                        "title": "Ø´Ù‡Ø±ÛŒÙˆØ±",
                        "primaryColor": "#BAE981",
                        "secondaryColor": "#72CC77",
                        "accentColor": "#45A79E",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-birth-month-shahrivar/1200/560"
                      }
                    ],
                    "onPlanSelectedAction": {
                      "routeName": "gift_card_real_custom_message",
                      "navigationStyle": "push",
                      "actionType": "navigate"
                    }
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              }
            ],
            "type": "row"
          },
          {
            "height": 8.0,
            "type": "sizedBox"
          },
          {
            "children": [
              {
                "child": {
                  "child": {
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
                    "height": 190.0,
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "decoration": {
                            "borderRadius": {
                              "topLeft": 12.0,
                              "topRight": 12.0,
                              "bottomLeft": 0.0,
                              "bottomRight": 0.0
                            },
                            "gradient": {
                              "gradientType": "linear",
                              "colors": [
                                "#3866B4",
                                "#E8A82B"
                              ],
                              "begin": "centerLeft",
                              "end": "centerRight"
                            }
                          },
                          "height": 102.0,
                          "child": {
                            "children": [
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "bottom": 0.0,
                                "child": {
                                  "src": "https://picsum.photos/seed/gift-category-national-events/1200/560",
                                  "imageType": "network",
                                  "fit": "cover",
                                  "type": "image"
                                },
                                "type": "positioned"
                              },
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "child": {
                                  "padding": {
                                    "left": 8.0,
                                    "right": 8.0
                                  },
                                  "color": "#F7FAFD",
                                  "height": 30.0,
                                  "child": {
                                    "mainAxisAlignment": "spaceBetween",
                                    "crossAxisAlignment": "center",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "src": "assets/icons/shetab.svg",
                                        "imageType": "asset",
                                        "width": 66.0,
                                        "height": 20.0,
                                        "fit": "contain",
                                        "type": "image"
                                      },
                                      {
                                        "src": "assets/icons/gardeshgary.svg",
                                        "imageType": "asset",
                                        "width": 64.0,
                                        "height": 18.0,
                                        "fit": "contain",
                                        "type": "image"
                                      }
                                    ],
                                    "type": "row"
                                  },
                                  "type": "container"
                                },
                                "type": "positioned"
                              }
                            ],
                            "type": "stack"
                          },
                          "clipBehavior": "hardEdge",
                          "type": "container"
                        },
                        {
                          "child": {
                            "child": {
                              "padding": {
                                "left": 8.0,
                                "right": 8.0
                              },
                              "child": {
                                "data": "Ø§Ø¹ÛŒØ§Ø¯ Ù…Ø°Ù‡Ø¨ÛŒØŒ Ù…Ù„ÛŒØŒ ÙØ±Ù‡Ù†Ú¯ÛŒ",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 16.0,
                                  "fontWeight": "w600"
                                },
                                "textAlign": "center",
                                "textDirection": "rtl",
                                "overflow": "ellipsis",
                                "maxLines": 2,
                                "type": "text"
                              },
                              "type": "padding"
                            },
                            "type": "center"
                          },
                          "type": "expanded"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "showGiftCardPlanSelectorBottomSheet",
                    "title": "Ù„Ø·ÙØ§ Ø·Ø±Ø­ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                    "categoryTitle": "Ø§Ø¹ÛŒØ§Ø¯ Ù…Ø°Ù‡Ø¨ÛŒØŒ Ù…Ù„ÛŒØŒ ÙØ±Ù‡Ù†Ú¯ÛŒ",
                    "selectedPlanIdKey": "giftCardRealSelectedPlanId",
                    "selectedPlanTitleKey": "giftCardRealSelectedPlanTitle",
                    "selectedCategoryKey": "giftCardRealSelectedCategory",
                    "plans": [
                      {
                        "id": "national-1",
                        "title": "Ø¹ÛŒØ¯ ÙØ·Ø±",
                        "primaryColor": "#3B73B8",
                        "secondaryColor": "#5D8EC2",
                        "accentColor": "#D8A63F",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-national-1/1200/560"
                      },
                      {
                        "id": "national-2",
                        "title": "Ø±ÙˆØ² Ù…Ø¹Ù„Ù…",
                        "primaryColor": "#4478B7",
                        "secondaryColor": "#6696CB",
                        "accentColor": "#E1B54E",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-national-2/1200/560"
                      },
                      {
                        "id": "national-3",
                        "title": "Ø±ÙˆØ² Ù¾Ø¯Ø±",
                        "primaryColor": "#4572B5",
                        "secondaryColor": "#5B8DC4",
                        "accentColor": "#DCA64A",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-national-3/1200/560"
                      },
                      {
                        "id": "national-4",
                        "title": "Ø±ÙˆØ² Ù…Ø§Ø¯Ø±",
                        "primaryColor": "#3A67A8",
                        "secondaryColor": "#6392C4",
                        "accentColor": "#D9A04B",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-national-4/1200/560"
                      },
                      {
                        "id": "national-5",
                        "title": "Ø±ÙˆØ² Ø¯Ø§Ù†Ø´Ø¬Ùˆ",
                        "primaryColor": "#3F6CAF",
                        "secondaryColor": "#6695C8",
                        "accentColor": "#E2A931",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-national-5/1200/560"
                      },
                      {
                        "id": "national-6",
                        "title": "Ø¬Ø´Ù† Ù…Ù„ÛŒ",
                        "primaryColor": "#3F6FAF",
                        "secondaryColor": "#6791C1",
                        "accentColor": "#D6A841",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-national-6/1200/560"
                      }
                    ],
                    "onPlanSelectedAction": {
                      "routeName": "gift_card_real_custom_message",
                      "navigationStyle": "push",
                      "actionType": "navigate"
                    }
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
                    "height": 190.0,
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "decoration": {
                            "borderRadius": {
                              "topLeft": 12.0,
                              "topRight": 12.0,
                              "bottomLeft": 0.0,
                              "bottomRight": 0.0
                            },
                            "gradient": {
                              "gradientType": "linear",
                              "colors": [
                                "#C48A3C",
                                "#8E4A7A"
                              ],
                              "begin": "centerLeft",
                              "end": "centerRight"
                            }
                          },
                          "height": 102.0,
                          "child": {
                            "children": [
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "bottom": 0.0,
                                "child": {
                                  "src": "https://picsum.photos/seed/gift-category-wedding/1200/560",
                                  "imageType": "network",
                                  "fit": "cover",
                                  "type": "image"
                                },
                                "type": "positioned"
                              },
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "child": {
                                  "padding": {
                                    "left": 8.0,
                                    "right": 8.0
                                  },
                                  "color": "#F7FAFD",
                                  "height": 30.0,
                                  "child": {
                                    "mainAxisAlignment": "spaceBetween",
                                    "crossAxisAlignment": "center",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "src": "assets/icons/shetab.svg",
                                        "imageType": "asset",
                                        "width": 66.0,
                                        "height": 20.0,
                                        "fit": "contain",
                                        "type": "image"
                                      },
                                      {
                                        "src": "assets/icons/gardeshgary.svg",
                                        "imageType": "asset",
                                        "width": 64.0,
                                        "height": 18.0,
                                        "fit": "contain",
                                        "type": "image"
                                      }
                                    ],
                                    "type": "row"
                                  },
                                  "type": "container"
                                },
                                "type": "positioned"
                              }
                            ],
                            "type": "stack"
                          },
                          "clipBehavior": "hardEdge",
                          "type": "container"
                        },
                        {
                          "child": {
                            "child": {
                              "padding": {
                                "left": 8.0,
                                "right": 8.0
                              },
                              "child": {
                                "data": "ØªØ¨Ø±ÛŒÚ© Ø§Ø²Ø¯ÙˆØ§Ø¬",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 16.0,
                                  "fontWeight": "w600"
                                },
                                "textAlign": "center",
                                "textDirection": "rtl",
                                "overflow": "ellipsis",
                                "maxLines": 2,
                                "type": "text"
                              },
                              "type": "padding"
                            },
                            "type": "center"
                          },
                          "type": "expanded"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "showGiftCardPlanSelectorBottomSheet",
                    "title": "Ù„Ø·ÙØ§ Ø·Ø±Ø­ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                    "categoryTitle": "ØªØ¨Ø±ÛŒÚ© Ø§Ø²Ø¯ÙˆØ§Ø¬",
                    "selectedPlanIdKey": "giftCardRealSelectedPlanId",
                    "selectedPlanTitleKey": "giftCardRealSelectedPlanTitle",
                    "selectedCategoryKey": "giftCardRealSelectedCategory",
                    "plans": [
                      {
                        "id": "wedding-1",
                        "title": "ØªØ¨Ø±ÛŒÚ© Ø§Ø²Ø¯ÙˆØ§Ø¬",
                        "primaryColor": "#D09D52",
                        "secondaryColor": "#AE7C77",
                        "accentColor": "#86578A",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-wedding-1/1200/560"
                      },
                      {
                        "id": "wedding-2",
                        "title": "Ø³Ø§Ù„Ú¯Ø±Ø¯",
                        "primaryColor": "#C79A66",
                        "secondaryColor": "#A77A7E",
                        "accentColor": "#8A538A",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-wedding-2/1200/560"
                      },
                      {
                        "id": "wedding-3",
                        "title": "Ø¹Ø´Ù‚ Ù…Ø§Ù†Ø¯Ú¯Ø§Ø±",
                        "primaryColor": "#C49358",
                        "secondaryColor": "#A4707A",
                        "accentColor": "#7A4F81",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-wedding-3/1200/560"
                      },
                      {
                        "id": "wedding-4",
                        "title": "Ù‡Ø¯ÛŒÙ‡ Ø²ÙˆØ¬",
                        "primaryColor": "#D39A5A",
                        "secondaryColor": "#B07883",
                        "accentColor": "#8D5185",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-wedding-4/1200/560"
                      },
                      {
                        "id": "wedding-5",
                        "title": "Ø®Ø§Ù†Ù‡ Ø¨Ø®Øª",
                        "primaryColor": "#CB9B60",
                        "secondaryColor": "#A87E79",
                        "accentColor": "#855888",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-wedding-5/1200/560"
                      },
                      {
                        "id": "wedding-6",
                        "title": "Ù¾ÛŒÙ…Ø§Ù† Ø¹Ø§Ø´Ù‚ÛŒ",
                        "primaryColor": "#C69863",
                        "secondaryColor": "#A57573",
                        "accentColor": "#875C88",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-wedding-6/1200/560"
                      }
                    ],
                    "onPlanSelectedAction": {
                      "routeName": "gift_card_real_custom_message",
                      "navigationStyle": "push",
                      "actionType": "navigate"
                    }
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              }
            ],
            "type": "row"
          },
          {
            "height": 8.0,
            "type": "sizedBox"
          },
          {
            "children": [
              {
                "child": {
                  "child": {
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
                    "height": 190.0,
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "decoration": {
                            "borderRadius": {
                              "topLeft": 12.0,
                              "topRight": 12.0,
                              "bottomLeft": 0.0,
                              "bottomRight": 0.0
                            },
                            "gradient": {
                              "gradientType": "linear",
                              "colors": [
                                "#DB4CB5",
                                "#48BDD7"
                              ],
                              "begin": "centerLeft",
                              "end": "centerRight"
                            }
                          },
                          "height": 102.0,
                          "child": {
                            "children": [
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "bottom": 0.0,
                                "child": {
                                  "src": "https://picsum.photos/seed/gift-category-mouse/1200/560",
                                  "imageType": "network",
                                  "fit": "cover",
                                  "type": "image"
                                },
                                "type": "positioned"
                              },
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "child": {
                                  "padding": {
                                    "left": 8.0,
                                    "right": 8.0
                                  },
                                  "color": "#F7FAFD",
                                  "height": 30.0,
                                  "child": {
                                    "mainAxisAlignment": "spaceBetween",
                                    "crossAxisAlignment": "center",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "src": "assets/icons/shetab.svg",
                                        "imageType": "asset",
                                        "width": 66.0,
                                        "height": 20.0,
                                        "fit": "contain",
                                        "type": "image"
                                      },
                                      {
                                        "src": "assets/icons/gardeshgary.svg",
                                        "imageType": "asset",
                                        "width": 64.0,
                                        "height": 18.0,
                                        "fit": "contain",
                                        "type": "image"
                                      }
                                    ],
                                    "type": "row"
                                  },
                                  "type": "container"
                                },
                                "type": "positioned"
                              }
                            ],
                            "type": "stack"
                          },
                          "clipBehavior": "hardEdge",
                          "type": "container"
                        },
                        {
                          "child": {
                            "child": {
                              "padding": {
                                "left": 8.0,
                                "right": 8.0
                              },
                              "child": {
                                "data": "Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡ Ù…ÙˆØ´ÛŒ Û²",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 16.0,
                                  "fontWeight": "w600"
                                },
                                "textAlign": "center",
                                "textDirection": "rtl",
                                "overflow": "ellipsis",
                                "maxLines": 2,
                                "type": "text"
                              },
                              "type": "padding"
                            },
                            "type": "center"
                          },
                          "type": "expanded"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "showGiftCardPlanSelectorBottomSheet",
                    "title": "Ù„Ø·ÙØ§ Ø·Ø±Ø­ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                    "categoryTitle": "Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡ Ù…ÙˆØ´ÛŒ Û²",
                    "selectedPlanIdKey": "giftCardRealSelectedPlanId",
                    "selectedPlanTitleKey": "giftCardRealSelectedPlanTitle",
                    "selectedCategoryKey": "giftCardRealSelectedCategory",
                    "plans": [
                      {
                        "id": "mouse2-1",
                        "title": "Ù…ÙˆØ´ÛŒ ØµÙˆØ±ØªÛŒ",
                        "primaryColor": "#DD67BE",
                        "secondaryColor": "#C54BB4",
                        "accentColor": "#53B8D7",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-mouse2-1/1200/560"
                      },
                      {
                        "id": "mouse2-2",
                        "title": "Ù…ÙˆØ´ÛŒ Ø¢Ø¨ÛŒ",
                        "primaryColor": "#CC5EC1",
                        "secondaryColor": "#B94BC6",
                        "accentColor": "#48B2D4",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-mouse2-2/1200/560"
                      },
                      {
                        "id": "mouse2-3",
                        "title": "Ù…ÙˆØ´ÛŒ Ø±Ù†Ú¯ÛŒ",
                        "primaryColor": "#DB67B3",
                        "secondaryColor": "#B457C7",
                        "accentColor": "#4AC0CD",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-mouse2-3/1200/560"
                      },
                      {
                        "id": "mouse2-4",
                        "title": "Ù‡Ø¯ÛŒÙ‡ Ú©ÙˆØ¯Ú©",
                        "primaryColor": "#D652B7",
                        "secondaryColor": "#C45FC2",
                        "accentColor": "#52B7DB",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-mouse2-4/1200/560"
                      },
                      {
                        "id": "mouse2-5",
                        "title": "Ø´Ø§Ø¯ Ùˆ Ø±Ù†Ú¯ÛŒ",
                        "primaryColor": "#D85ABF",
                        "secondaryColor": "#BF56BE",
                        "accentColor": "#5ABFD5",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-mouse2-5/1200/560"
                      },
                      {
                        "id": "mouse2-6",
                        "title": "Ø¹Ø±ÙˆØ³Ú©ÛŒ",
                        "primaryColor": "#D367BA",
                        "secondaryColor": "#BD58C5",
                        "accentColor": "#59B6CF",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-mouse2-6/1200/560"
                      }
                    ],
                    "onPlanSelectedAction": {
                      "routeName": "gift_card_real_custom_message",
                      "navigationStyle": "push",
                      "actionType": "navigate"
                    }
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
                    "height": 190.0,
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "decoration": {
                            "borderRadius": {
                              "topLeft": 12.0,
                              "topRight": 12.0,
                              "bottomLeft": 0.0,
                              "bottomRight": 0.0
                            },
                            "gradient": {
                              "gradientType": "linear",
                              "colors": [
                                "#2E8D53",
                                "#D08D2E"
                              ],
                              "begin": "centerLeft",
                              "end": "centerRight"
                            }
                          },
                          "height": 102.0,
                          "child": {
                            "children": [
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "bottom": 0.0,
                                "child": {
                                  "src": "https://picsum.photos/seed/gift-category-seasons/1200/560",
                                  "imageType": "network",
                                  "fit": "cover",
                                  "type": "image"
                                },
                                "type": "positioned"
                              },
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "child": {
                                  "padding": {
                                    "left": 8.0,
                                    "right": 8.0
                                  },
                                  "color": "#F7FAFD",
                                  "height": 30.0,
                                  "child": {
                                    "mainAxisAlignment": "spaceBetween",
                                    "crossAxisAlignment": "center",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "src": "assets/icons/shetab.svg",
                                        "imageType": "asset",
                                        "width": 66.0,
                                        "height": 20.0,
                                        "fit": "contain",
                                        "type": "image"
                                      },
                                      {
                                        "src": "assets/icons/gardeshgary.svg",
                                        "imageType": "asset",
                                        "width": 64.0,
                                        "height": 18.0,
                                        "fit": "contain",
                                        "type": "image"
                                      }
                                    ],
                                    "type": "row"
                                  },
                                  "type": "container"
                                },
                                "type": "positioned"
                              }
                            ],
                            "type": "stack"
                          },
                          "clipBehavior": "hardEdge",
                          "type": "container"
                        },
                        {
                          "child": {
                            "child": {
                              "padding": {
                                "left": 8.0,
                                "right": 8.0
                              },
                              "child": {
                                "data": "ÙØµÙ„â€ŒÙ‡Ø§ÛŒ ØªÙˆÙ„Ø¯",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 16.0,
                                  "fontWeight": "w600"
                                },
                                "textAlign": "center",
                                "textDirection": "rtl",
                                "overflow": "ellipsis",
                                "maxLines": 2,
                                "type": "text"
                              },
                              "type": "padding"
                            },
                            "type": "center"
                          },
                          "type": "expanded"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "showGiftCardPlanSelectorBottomSheet",
                    "title": "Ù„Ø·ÙØ§ Ø·Ø±Ø­ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                    "categoryTitle": "ÙØµÙ„â€ŒÙ‡Ø§ÛŒ ØªÙˆÙ„Ø¯",
                    "selectedPlanIdKey": "giftCardRealSelectedPlanId",
                    "selectedPlanTitleKey": "giftCardRealSelectedPlanTitle",
                    "selectedCategoryKey": "giftCardRealSelectedCategory",
                    "plans": [
                      {
                        "id": "season-1",
                        "title": "Ø¨Ù‡Ø§Ø±",
                        "primaryColor": "#2C8F53",
                        "secondaryColor": "#5DAA57",
                        "accentColor": "#D39B3B",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-season-1/1200/560"
                      },
                      {
                        "id": "season-2",
                        "title": "ØªØ§Ø¨Ø³ØªØ§Ù†",
                        "primaryColor": "#4E9A4D",
                        "secondaryColor": "#80AF4B",
                        "accentColor": "#DE9B2C",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-season-2/1200/560"
                      },
                      {
                        "id": "season-3",
                        "title": "Ù¾Ø§ÛŒÛŒØ²",
                        "primaryColor": "#5E8E4A",
                        "secondaryColor": "#A08A46",
                        "accentColor": "#CF7C31",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-season-3/1200/560"
                      },
                      {
                        "id": "season-4",
                        "title": "Ø²Ù…Ø³ØªØ§Ù†",
                        "primaryColor": "#3E7E69",
                        "secondaryColor": "#4D9CA6",
                        "accentColor": "#91A9D9",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-season-4/1200/560"
                      },
                      {
                        "id": "season-5",
                        "title": "ØªÙˆÙ„Ø¯ Ø¨Ù‡Ø§Ø±ÛŒ",
                        "primaryColor": "#348F62",
                        "secondaryColor": "#63B969",
                        "accentColor": "#D2A44D",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-season-5/1200/560"
                      },
                      {
                        "id": "season-6",
                        "title": "ØªÙˆÙ„Ø¯ Ø²Ù…Ø³ØªØ§Ù†ÛŒ",
                        "primaryColor": "#407697",
                        "secondaryColor": "#5A93B8",
                        "accentColor": "#9BB3D5",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-season-6/1200/560"
                      }
                    ],
                    "onPlanSelectedAction": {
                      "routeName": "gift_card_real_custom_message",
                      "navigationStyle": "push",
                      "actionType": "navigate"
                    }
                  },
                  "type": "gestureDetector"
                },
                "type": "expanded"
              }
            ],
            "type": "row"
          },
          {
            "height": 8.0,
            "type": "sizedBox"
          },
          {
            "children": [
              {
                "child": {
                  "child": {
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
                    "height": 190.0,
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "decoration": {
                            "borderRadius": {
                              "topLeft": 12.0,
                              "topRight": 12.0,
                              "bottomLeft": 0.0,
                              "bottomRight": 0.0
                            },
                            "gradient": {
                              "gradientType": "linear",
                              "colors": [
                                "#7E8A94",
                                "#3A4C5C"
                              ],
                              "begin": "centerLeft",
                              "end": "centerRight"
                            }
                          },
                          "height": 102.0,
                          "child": {
                            "children": [
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "bottom": 0.0,
                                "child": {
                                  "src": "https://picsum.photos/seed/gift-category-special-days/1200/560",
                                  "imageType": "network",
                                  "fit": "cover",
                                  "type": "image"
                                },
                                "type": "positioned"
                              },
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "child": {
                                  "padding": {
                                    "left": 8.0,
                                    "right": 8.0
                                  },
                                  "color": "#F7FAFD",
                                  "height": 30.0,
                                  "child": {
                                    "mainAxisAlignment": "spaceBetween",
                                    "crossAxisAlignment": "center",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "src": "assets/icons/shetab.svg",
                                        "imageType": "asset",
                                        "width": 66.0,
                                        "height": 20.0,
                                        "fit": "contain",
                                        "type": "image"
                                      },
                                      {
                                        "src": "assets/icons/gardeshgary.svg",
                                        "imageType": "asset",
                                        "width": 64.0,
                                        "height": 18.0,
                                        "fit": "contain",
                                        "type": "image"
                                      }
                                    ],
                                    "type": "row"
                                  },
                                  "type": "container"
                                },
                                "type": "positioned"
                              }
                            ],
                            "type": "stack"
                          },
                          "clipBehavior": "hardEdge",
                          "type": "container"
                        },
                        {
                          "child": {
                            "child": {
                              "padding": {
                                "left": 8.0,
                                "right": 8.0
                              },
                              "child": {
                                "data": "Ø±ÙˆØ²Ù‡Ø§ÛŒ Ø®Ø§Øµ",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 16.0,
                                  "fontWeight": "w600"
                                },
                                "textAlign": "center",
                                "textDirection": "rtl",
                                "overflow": "ellipsis",
                                "maxLines": 2,
                                "type": "text"
                              },
                              "type": "padding"
                            },
                            "type": "center"
                          },
                          "type": "expanded"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "showGiftCardPlanSelectorBottomSheet",
                    "title": "Ù„Ø·ÙØ§ Ø·Ø±Ø­ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                    "categoryTitle": "Ø±ÙˆØ²Ù‡Ø§ÛŒ Ø®Ø§Øµ",
                    "selectedPlanIdKey": "giftCardRealSelectedPlanId",
                    "selectedPlanTitleKey": "giftCardRealSelectedPlanTitle",
                    "selectedCategoryKey": "giftCardRealSelectedCategory",
                    "plans": [
                      {
                        "id": "special-day-1",
                        "title": "Ø±ÙˆØ² Ù…Ø§Ø¯Ø±",
                        "primaryColor": "#8494A0",
                        "secondaryColor": "#6C7E8D",
                        "accentColor": "#42556A",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-special-day-1/1200/560"
                      },
                      {
                        "id": "special-day-2",
                        "title": "Ø±ÙˆØ² Ù¾Ø¯Ø±",
                        "primaryColor": "#768A9A",
                        "secondaryColor": "#617483",
                        "accentColor": "#364A5E",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-special-day-2/1200/560"
                      },
                      {
                        "id": "special-day-3",
                        "title": "Ø±ÙˆØ² Ù…Ø¹Ù„Ù…",
                        "primaryColor": "#7C93A1",
                        "secondaryColor": "#647A8A",
                        "accentColor": "#3E5668",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-special-day-3/1200/560"
                      },
                      {
                        "id": "special-day-4",
                        "title": "ØªØ´Ú©Ø±",
                        "primaryColor": "#8897A2",
                        "secondaryColor": "#6B7A88",
                        "accentColor": "#45576A",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-special-day-4/1200/560"
                      },
                      {
                        "id": "special-day-5",
                        "title": "ØªÙ‚Ø¯ÛŒØ±",
                        "primaryColor": "#798A96",
                        "secondaryColor": "#5F7381",
                        "accentColor": "#394D61",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-special-day-5/1200/560"
                      },
                      {
                        "id": "special-day-6",
                        "title": "Ø±ÙˆØ² Ø®Ø§Øµ",
                        "primaryColor": "#7F8C99",
                        "secondaryColor": "#607484",
                        "accentColor": "#3D4F61",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-special-day-6/1200/560"
                      }
                    ],
                    "onPlanSelectedAction": {
                      "routeName": "gift_card_real_custom_message",
                      "navigationStyle": "push",
                      "actionType": "navigate"
                    }
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
                    "height": 190.0,
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "decoration": {
                            "borderRadius": {
                              "topLeft": 12.0,
                              "topRight": 12.0,
                              "bottomLeft": 0.0,
                              "bottomRight": 0.0
                            },
                            "gradient": {
                              "gradientType": "linear",
                              "colors": [
                                "#8E4D66",
                                "#A98941"
                              ],
                              "begin": "centerLeft",
                              "end": "centerRight"
                            }
                          },
                          "height": 102.0,
                          "child": {
                            "children": [
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "bottom": 0.0,
                                "child": {
                                  "src": "https://picsum.photos/seed/gift-category-historical-places/1200/560",
                                  "imageType": "network",
                                  "fit": "cover",
                                  "type": "image"
                                },
                                "type": "positioned"
                              },
                              {
                                "left": 0.0,
                                "top": 0.0,
                                "right": 0.0,
                                "child": {
                                  "padding": {
                                    "left": 8.0,
                                    "right": 8.0
                                  },
                                  "color": "#F7FAFD",
                                  "height": 30.0,
                                  "child": {
                                    "mainAxisAlignment": "spaceBetween",
                                    "crossAxisAlignment": "center",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "src": "assets/icons/shetab.svg",
                                        "imageType": "asset",
                                        "width": 66.0,
                                        "height": 20.0,
                                        "fit": "contain",
                                        "type": "image"
                                      },
                                      {
                                        "src": "assets/icons/gardeshgary.svg",
                                        "imageType": "asset",
                                        "width": 64.0,
                                        "height": 18.0,
                                        "fit": "contain",
                                        "type": "image"
                                      }
                                    ],
                                    "type": "row"
                                  },
                                  "type": "container"
                                },
                                "type": "positioned"
                              }
                            ],
                            "type": "stack"
                          },
                          "clipBehavior": "hardEdge",
                          "type": "container"
                        },
                        {
                          "child": {
                            "child": {
                              "padding": {
                                "left": 8.0,
                                "right": 8.0
                              },
                              "child": {
                                "data": "Ù…Ú©Ø§Ù†â€ŒÙ‡Ø§ÛŒ ØªØ§Ø±ÛŒØ®ÛŒ",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 16.0,
                                  "fontWeight": "w600"
                                },
                                "textAlign": "center",
                                "textDirection": "rtl",
                                "overflow": "ellipsis",
                                "maxLines": 2,
                                "type": "text"
                              },
                              "type": "padding"
                            },
                            "type": "center"
                          },
                          "type": "expanded"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
                  },
                  "onTap": {
                    "actionType": "showGiftCardPlanSelectorBottomSheet",
                    "title": "Ù„Ø·ÙØ§ Ø·Ø±Ø­ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                    "categoryTitle": "Ù…Ú©Ø§Ù†â€ŒÙ‡Ø§ÛŒ ØªØ§Ø±ÛŒØ®ÛŒ",
                    "selectedPlanIdKey": "giftCardRealSelectedPlanId",
                    "selectedPlanTitleKey": "giftCardRealSelectedPlanTitle",
                    "selectedCategoryKey": "giftCardRealSelectedCategory",
                    "plans": [
                      {
                        "id": "history-1",
                        "title": "Ø¨Ø§ÙØª ØªØ§Ø±ÛŒØ®ÛŒ",
                        "primaryColor": "#98536C",
                        "secondaryColor": "#A27553",
                        "accentColor": "#B99945",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-history-1/1200/560"
                      },
                      {
                        "id": "history-2",
                        "title": "Ø·Ø§Ù‚ Ø§ÛŒØ±Ø§Ù†ÛŒ",
                        "primaryColor": "#92566A",
                        "secondaryColor": "#9C7A53",
                        "accentColor": "#AA8F49",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-history-2/1200/560"
                      },
                      {
                        "id": "history-3",
                        "title": "Ú©Ø§Ø´ÛŒâ€ŒÚ©Ø§Ø±ÛŒ",
                        "primaryColor": "#8B4D67",
                        "secondaryColor": "#9C724F",
                        "accentColor": "#B48943",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-history-3/1200/560"
                      },
                      {
                        "id": "history-4",
                        "title": "Ù…ÙˆØ²Ù‡",
                        "primaryColor": "#9A5A73",
                        "secondaryColor": "#A07D56",
                        "accentColor": "#B9944F",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-history-4/1200/560"
                      },
                      {
                        "id": "history-5",
                        "title": "Ù…ÛŒØ±Ø§Ø« Ú©Ù‡Ù†",
                        "primaryColor": "#8C4E63",
                        "secondaryColor": "#9A7651",
                        "accentColor": "#AE8F4B",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-history-5/1200/560"
                      },
                      {
                        "id": "history-6",
                        "title": "Ù…Ø¹Ù…Ø§Ø±ÛŒ Ø§ÛŒØ±Ø§Ù†ÛŒ",
                        "primaryColor": "#8E5772",
                        "secondaryColor": "#A27651",
                        "accentColor": "#B48D42",
                        "imageUrl": "https://picsum.photos/seed/gift-plan-history-6/1200/560"
                      }
                    ],
                    "onPlanSelectedAction": {
                      "routeName": "gift_card_real_custom_message",
                      "navigationStyle": "push",
                      "actionType": "navigate"
                    }
                  },
                  "type": "gestureDetector"
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
    "type": "scaffold"
  }
}
```
