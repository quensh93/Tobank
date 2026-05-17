# flows/gift_card_real/json/gift_card_real_confirm.json

Source: lib/stac/tobank/flows/gift_card_real/json/gift_card_real_confirm.json

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
    "crossAxisAlignment": "stretch",
    "children": [
      {
        "child": {
          "padding": {
            "left": 16.0,
            "top": 14.0,
            "right": 16.0
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
                "child": {
                  "crossAxisAlignment": "stretch",
                  "children": [
                    {
                      "mainAxisAlignment": "spaceBetween",
                      "crossAxisAlignment": "end",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "crossAxisAlignment": "end",
                          "children": [
                            {
                              "data": "Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 16.0,
                                "fontWeight": "w500"
                              },
                              "textAlign": "right",
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            {
                              "height": 7.0,
                              "type": "sizedBox"
                            },
                            {
                              "data": "{{giftCardRealAmountLabel1}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 18.0,
                                "fontWeight": "w600"
                              },
                              "textAlign": "right",
                              "textDirection": "rtl",
                              "type": "text"
                            }
                          ],
                          "type": "column"
                        },
                        {
                          "data": "{{giftCardRealCardCount1}} Ø¹Ø¯Ø¯",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 17.0,
                            "fontWeight": "w700"
                          },
                          "textDirection": "rtl",
                          "type": "text"
                        }
                      ],
                      "type": "row"
                    },
                    {
                      "type": "visibility",
                      "visible": "[[giftCardRealShowSecondAmountCard]]",
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
                            "mainAxisAlignment": "spaceBetween",
                            "crossAxisAlignment": "end",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "crossAxisAlignment": "end",
                                "children": [
                                  {
                                    "data": "Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
                                      "fontWeight": "w500"
                                    },
                                    "textAlign": "right",
                                    "textDirection": "rtl",
                                    "type": "text"
                                  },
                                  {
                                    "height": 7.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "data": "{{giftCardRealAmountLabel2}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.title}}",
                                      "fontSize": 18.0,
                                      "fontWeight": "w600"
                                    },
                                    "textAlign": "right",
                                    "textDirection": "rtl",
                                    "type": "text"
                                  }
                                ],
                                "type": "column"
                              },
                              {
                                "data": "{{giftCardRealCardCount2}} Ø¹Ø¯Ø¯",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 17.0,
                                  "fontWeight": "w700"
                                },
                                "textDirection": "rtl",
                                "type": "text"
                              }
                            ],
                            "type": "row"
                          }
                        ],
                        "type": "column"
                      }
                    },
                    {
                      "type": "visibility",
                      "visible": "[[giftCardRealShowThirdAmountCard]]",
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
                            "mainAxisAlignment": "spaceBetween",
                            "crossAxisAlignment": "end",
                            "textDirection": "rtl",
                            "children": [
                              {
                                "crossAxisAlignment": "end",
                                "children": [
                                  {
                                    "data": "Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.subtitle}}",
                                      "fontSize": 16.0,
                                      "fontWeight": "w500"
                                    },
                                    "textAlign": "right",
                                    "textDirection": "rtl",
                                    "type": "text"
                                  },
                                  {
                                    "height": 7.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "data": "{{giftCardRealAmountLabel3}}",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.title}}",
                                      "fontSize": 18.0,
                                      "fontWeight": "w600"
                                    },
                                    "textAlign": "right",
                                    "textDirection": "rtl",
                                    "type": "text"
                                  }
                                ],
                                "type": "column"
                              },
                              {
                                "data": "{{giftCardRealCardCount3}} Ø¹Ø¯Ø¯",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 17.0,
                                  "fontWeight": "w700"
                                },
                                "textDirection": "rtl",
                                "type": "text"
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
                "type": "container"
              },
              {
                "height": 18.0,
                "type": "sizedBox"
              },
              {
                "padding": {
                  "left": 16.0,
                  "top": 16.0,
                  "right": 16.0,
                  "bottom": 16.0
                },
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
                "child": {
                  "crossAxisAlignment": "stretch",
                  "children": [
                    {
                      "mainAxisAlignment": "spaceBetween",
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "data": "Ù…Ø¨Ù„Øº Ú©Ø§Ø±Øª(Ù‡Ø§ÛŒ) Ù‡Ø¯ÛŒÙ‡",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "data": "{{giftCardRealSummaryCardsAmountLabel}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 18.0,
                              "fontWeight": "w700"
                            },
                            "textAlign": "left",
                            "textDirection": "rtl",
                            "type": "text"
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
                      "mainAxisAlignment": "spaceBetween",
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "data": "Ù‡Ø²ÛŒÙ†Ù‡ ØµØ¯ÙˆØ± Ù‡Ø± Ú©Ø§Ø±Øª",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "data": "{{giftCardRealSummaryIssuanceFeeLabel}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 18.0,
                              "fontWeight": "w700"
                            },
                            "textAlign": "left",
                            "textDirection": "rtl",
                            "type": "text"
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
                      "mainAxisAlignment": "spaceBetween",
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "data": "Ù‡Ø²ÛŒÙ†Ù‡ Ø§Ø±Ø³Ø§Ù„",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "data": "{{giftCardRealSummaryDeliveryFeeLabel}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 18.0,
                              "fontWeight": "w700"
                            },
                            "textAlign": "left",
                            "textDirection": "rtl",
                            "type": "text"
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
                      "mainAxisAlignment": "spaceBetween",
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "data": "Ù†ÙˆØ¹ Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "data": "{{giftCardRealSummaryType}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 18.0,
                              "fontWeight": "w700"
                            },
                            "textAlign": "left",
                            "textDirection": "rtl",
                            "type": "text"
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
                      "mainAxisAlignment": "spaceBetween",
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "data": "Ù†Ø§Ù… ØªØ­ÙˆÛŒÙ„ Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "data": "{{giftCardRealSummaryReceiverName}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 18.0,
                              "fontWeight": "w700"
                            },
                            "textAlign": "left",
                            "textDirection": "rtl",
                            "type": "text"
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
                      "mainAxisAlignment": "spaceBetween",
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "data": "Ù…ÙˆØ¨Ø§ÛŒÙ„ ØªØ­ÙˆÛŒÙ„ Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "data": "{{giftCardRealSummaryReceiverMobile}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 18.0,
                              "fontWeight": "w700"
                            },
                            "textAlign": "left",
                            "textDirection": "rtl",
                            "type": "text"
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
                      "mainAxisAlignment": "spaceBetween",
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "data": "ØªØ§Ø±ÛŒØ® ØªØ­ÙˆÛŒÙ„",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "data": "{{giftCardRealSummaryDeliveryDate}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 18.0,
                              "fontWeight": "w700"
                            },
                            "textAlign": "left",
                            "textDirection": "rtl",
                            "type": "text"
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
                      "mainAxisAlignment": "spaceBetween",
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "data": "Ø³Ø§Ø¹Øª ØªØ­ÙˆÛŒÙ„",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "data": "{{giftCardRealSummaryDeliveryTime}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 18.0,
                              "fontWeight": "w700"
                            },
                            "textAlign": "left",
                            "textDirection": "rtl",
                            "type": "text"
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
                      "mainAxisAlignment": "spaceBetween",
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "data": "Ø´Ù‡Ø± ØªØ­ÙˆÛŒÙ„ Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.subtitle}}",
                            "fontSize": 16.0,
                            "fontWeight": "w500"
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "data": "{{giftCardRealSummaryReceiverCity}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 18.0,
                              "fontWeight": "w700"
                            },
                            "textAlign": "left",
                            "textDirection": "rtl",
                            "type": "text"
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
                      "data": "Ø¢Ø¯Ø±Ø³ ØªØ­ÙˆÛŒÙ„ Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.subtitle}}",
                        "fontSize": 16.0,
                        "fontWeight": "w500"
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
                      "data": "{{giftCardRealSummaryReceiverAddress}}",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 18.0,
                        "fontWeight": "w700"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    }
                  ],
                  "type": "column"
                },
                "type": "container"
              },
              {
                "height": 20.0,
                "type": "sizedBox"
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
            "actionType": "showGiftCardPaymentAccountsBottomSheet",
            "title": "Ú©Ø§Ø±Øª Ù‡Ø¯ÛŒÙ‡",
            "paymentAmountKey": "giftCardRealSummaryPaymentAmount",
            "walletLabel": "Ú©ÛŒÙ Ù¾ÙˆÙ„",
            "walletBalance": 226600,
            "accountsTitle": "Ø­Ø³Ø§Ø¨â€ŒÙ‡Ø§",
            "insufficientText": "Ù…ÙˆØ¬ÙˆØ¯ÛŒ Ù†Ø§Ú©Ø§ÙÛŒ",
            "sufficientText": "Ù…ÙˆØ¬ÙˆØ¯ÛŒ Ú©Ø§ÙÛŒ",
            "chargeButtonText": "Ø´Ø§Ø±Ú˜ Ø­Ø³Ø§Ø¨",
            "continueButtonText": "Ø§Ø¯Ø§Ù…Ù‡",
            "accounts": [
              {
                "id": "acc_1",
                "title": "Ø³Ù¾Ø±Ø¯Ù‡ Ø­Ù‚ÛŒÙ‚ÛŒ Ø­Ø³Ø§Ø¨ Ù‚Ø±Ø¶ Ø§Ù„Ø­Ø³Ù†Ù‡ Ø¬Ø§Ø±ÛŒ Ø­Ù‚ÛŒÙ‚ÛŒ- Ø±ÛŒØ§Ù„ÛŒ",
                "ownerName": "Ø³ÛŒØ¯ Ù¾Ø§Ø±Ø³Ø§ Ø¨Ù†ÛŒ Ø·Ø¨Ø§",
                "depositNumber": "Û±Û±Û°.Û·Û°.Û±Û¶/Û²Û¹Û¸Û¸.Û±",
                "availableAmount": 66770
              },
              {
                "id": "acc_2",
                "title": "Ø³Ù¾Ø±Ø¯Ù‡ Ø­Ù‚ÛŒÙ‚ÛŒ Ø³Ù¾Ø±Ø¯Ù‡ Ø³Ø±Ù…Ø§ÛŒÙ‡ Ú¯Ø°Ø§Ø±ÛŒ Ú©ÙˆØªØ§Ù‡ Ù…Ø¯Øª",
                "ownerName": "ØªÙˆØ¨Ø§Ù†Ú©- Ø­Ù‚ÛŒÙ‚ÛŒ Ø±ÛŒØ§Ù„ÛŒ Ø³ÛŒØ¯ Ù¾Ø§Ø±Ø³Ø§ Ø¨Ù†ÛŒ Ø·Ø¨Ø§",
                "depositNumber": "Û±Û±Û°.Û¹Û¹Û¹Û².Û±Û¶/Û²Û¹Û¸Û¸.Û±",
                "availableAmount": 39148
              },
              {
                "id": "acc_3",
                "title": "Ø³Ù¾Ø±Ø¯Ù‡ Ø­Ù‚ÛŒÙ‚ÛŒ Ø³Ù¾Ø±Ø¯Ù‡ Ø³Ø±Ù…Ø§ÛŒÙ‡ Ú¯Ø°Ø§Ø±ÛŒ ÙˆÛŒÚ˜Ù‡",
                "ownerName": "ØªÙˆØ¨Ø§Ù†Ú©- Ø­Ù‚ÛŒÙ‚ÛŒ Ø±ÛŒØ§Ù„ÛŒ Ø³ÛŒØ¯ Ù¾Ø§Ø±Ø³Ø§ Ø¨Ù†ÛŒ Ø·Ø¨Ø§",
                "depositNumber": "Û±Û±Û¹.Û¹Û²Û¹Û°.Û±Û¶/Û²Û¹Û¸Û¸.Û±",
                "availableAmount": 9200000
              }
            ],
            "continueAction": {
              "actionType": "showResult",
              "title": "Ù¾Ø±Ø¯Ø§Ø®Øª",
              "content": "Ù¾Ø±Ø¯Ø§Ø®Øª Ø¨Ø§ Ù…ÙˆÙÙ‚ÛŒØª Ø§Ù†Ø¬Ø§Ù… Ø´Ø¯."
            },
            "chargeAction": {
              "actionType": "showResult",
              "title": "Ø´Ø§Ø±Ú˜ Ø­Ø³Ø§Ø¨",
              "content": "Ø¨Ø±Ø§ÛŒ Ø§Ø¯Ø§Ù…Ù‡ØŒ Ø­Ø³Ø§Ø¨ Ø®ÙˆØ¯ Ø±Ø§ Ø´Ø§Ø±Ú˜ Ú©Ù†ÛŒØ¯."
            }
          },
          "style": {
            "foregroundColor": "{{appColors.current.primary.onPrimary}}",
            "backgroundColor": "{{appColors.current.primary.color}}",
            "elevation": 0.0,
            "fixedSize": {
              "width": 999999.0,
              "height": 62.0
            },
            "shape": {
              "type": "roundedRectangleBorder",
              "borderRadius": {
                "topLeft": 14.0,
                "topRight": 14.0,
                "bottomLeft": 14.0,
                "bottomRight": 14.0
              }
            }
          },
          "child": {
            "data": "Ù¾Ø±Ø¯Ø§Ø®Øª {{giftCardRealSummaryPaymentLabel}}",
            "style": {
              "type": "custom",
              "color": "{{appColors.current.primary.onPrimary}}",
              "fontSize": 19.0,
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
  },
  "type": "scaffold"
}
```
