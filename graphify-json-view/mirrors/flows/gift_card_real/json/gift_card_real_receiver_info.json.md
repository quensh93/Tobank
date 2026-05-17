# flows/gift_card_real/json/gift_card_real_receiver_info.json

Source: lib/stac/tobank/flows/gift_card_real/json/gift_card_real_receiver_info.json

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
        "key": "giftCardRealReceiverIsOwner",
        "value": false
      },
      {
        "key": "giftCardRealReceiverContinueEnabled",
        "value": false
      },
      {
        "key": "giftCardRealReceiverProvince",
        "value": "ØªÙ‡Ø±Ø§Ù†"
      },
      {
        "key": "giftCardRealReceiverCity",
        "value": "ØªÙ‡Ø±Ø§Ù†"
      },
      {
        "key": "giftCardRealDeliveryDate",
        "value": ""
      },
      {
        "key": "giftCardRealDeliveryTime",
        "value": ""
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
      "child": {
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
                    "mainAxisAlignment": "spaceBetween",
                    "crossAxisAlignment": "center",
                    "textDirection": "rtl",
                    "children": [
                      {
                        "data": "Ú¯ÛŒØ±Ù†Ø¯Ù‡ Ø®ÙˆØ¯Ù… Ù‡Ø³ØªÙ…",
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
                        "type": "reactiveSwitch",
                        "valueKey": "giftCardRealReceiverIsOwner",
                        "initialValue": false,
                        "onChanged": {
                          "actionType": "validateFields",
                          "resultKey": "giftCardRealReceiverContinueEnabled",
                          "fields": [
                            {
                              "id": "gift_card_real_receiver_name",
                              "optional": "giftCardRealReceiverIsOwner"
                            },
                            {
                              "id": "gift_card_real_receiver_mobile",
                              "rule": "^[0-9]{11}$",
                              "optional": "giftCardRealReceiverIsOwner"
                            },
                            {
                              "id": "gift_card_real_receiver_postal_code",
                              "rule": "^[0-9]{10}$"
                            },
                            {
                              "id": "gift_card_real_receiver_address"
                            }
                          ]
                        },
                        "activeColor": "{{appColors.current.secondary.color}}",
                        "scale": 0.95
                      }
                    ],
                    "type": "row"
                  },
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
                    "height": 20.0,
                    "type": "sizedBox"
                  },
                  {
                    "type": "visibility",
                    "visible": "[[!giftCardRealReceiverIsOwner]]",
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "Ù†Ø§Ù… Ùˆ Ù†Ø§Ù…â€ŒØ®Ø§Ù†ÙˆØ§Ø¯Ú¯ÛŒ",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 18.0,
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
                          "decoration": {
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
                            "type": "textFormField",
                            "id": "gift_card_real_receiver_name",
                            "textDirection": "rtl",
                            "textAlign": "right",
                            "decoration": {
                              "hintText": "Ù†Ø§Ù… Ùˆ Ù†Ø§Ù…â€ŒØ®Ø§Ù†ÙˆØ§Ø¯Ú¯ÛŒ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                              "hintStyle": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 16.0,
                                "fontWeight": "w500"
                              },
                              "contentPadding": {
                                "left": 18.0,
                                "top": 16.0,
                                "right": 18.0,
                                "bottom": 16.0
                              },
                              "filled": false
                            },
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 17.0,
                              "fontWeight": "w600"
                            },
                            "minLines": 1,
                            "maxLines": 1,
                            "onChanged": {
                              "actionType": "validateFields",
                              "resultKey": "giftCardRealReceiverContinueEnabled",
                              "fields": [
                                {
                                  "id": "gift_card_real_receiver_name",
                                  "optional": "giftCardRealReceiverIsOwner"
                                },
                                {
                                  "id": "gift_card_real_receiver_mobile",
                                  "rule": "^[0-9]{11}$",
                                  "optional": "giftCardRealReceiverIsOwner"
                                },
                                {
                                  "id": "gift_card_real_receiver_postal_code",
                                  "rule": "^[0-9]{10}$"
                                },
                                {
                                  "id": "gift_card_real_receiver_address"
                                }
                              ]
                            }
                          },
                          "type": "container"
                        },
                        {
                          "height": 24.0,
                          "type": "sizedBox"
                        },
                        {
                          "data": "Ø´Ù…Ø§Ø±Ù‡ Ù‡Ù…Ø±Ø§Ù‡ Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 18.0,
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
                          "decoration": {
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
                            "type": "textFormField",
                            "id": "gift_card_real_receiver_mobile",
                            "textDirection": "rtl",
                            "textAlign": "right",
                            "decoration": {
                              "hintText": "ØªÙ„ÙÙ† Ù‡Ù…Ø±Ø§Ù‡ ØªØ­ÙˆÛŒÙ„ Ú¯ÛŒØ±Ù†Ø¯Ù‡ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                              "hintStyle": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 16.0,
                                "fontWeight": "w500"
                              },
                              "contentPadding": {
                                "left": 18.0,
                                "top": 16.0,
                                "right": 18.0,
                                "bottom": 16.0
                              },
                              "filled": false
                            },
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 17.0,
                              "fontWeight": "w600"
                            },
                            "keyboardType": "number",
                            "maxLength": 11,
                            "minLines": 1,
                            "maxLines": 1,
                            "inputFormatters": [
                              {
                                "type": "allow",
                                "rule": "[0-9]"
                              }
                            ],
                            "onChanged": {
                              "actionType": "validateFields",
                              "resultKey": "giftCardRealReceiverContinueEnabled",
                              "fields": [
                                {
                                  "id": "gift_card_real_receiver_name",
                                  "optional": "giftCardRealReceiverIsOwner"
                                },
                                {
                                  "id": "gift_card_real_receiver_mobile",
                                  "rule": "^[0-9]{11}$",
                                  "optional": "giftCardRealReceiverIsOwner"
                                },
                                {
                                  "id": "gift_card_real_receiver_postal_code",
                                  "rule": "^[0-9]{10}$"
                                },
                                {
                                  "id": "gift_card_real_receiver_address"
                                }
                              ]
                            }
                          },
                          "type": "container"
                        },
                        {
                          "height": 24.0,
                          "type": "sizedBox"
                        }
                      ],
                      "type": "column"
                    }
                  },
                  {
                    "data": "Ø§Ø³ØªØ§Ù†",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.text.title}}",
                      "fontSize": 18.0,
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
                    "child": {
                      "padding": {
                        "left": 16.0,
                        "right": 16.0
                      },
                      "decoration": {
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
                      "height": 56.0,
                      "child": {
                        "type": "registryReactive",
                        "child": {
                          "mainAxisAlignment": "spaceBetween",
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "data": "{{giftCardRealReceiverProvince}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 18.0,
                                "fontWeight": "w600"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            {
                              "icon": "keyboard_arrow_down",
                              "iconType": "material",
                              "size": 30.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        }
                      },
                      "type": "container"
                    },
                    "onTap": {
                      "actionType": "sequence",
                      "actions": [
                        {
                          "actionType": "showGiftCardLocationSelectorBottomSheet",
                          "title": "Ø§Ù†ØªØ®Ø§Ø¨ Ø§Ø³ØªØ§Ù†",
                          "selectedKey": "giftCardRealReceiverProvince",
                          "options": [
                            "ØªÙ‡Ø±Ø§Ù†",
                            "Ø§ØµÙÙ‡Ø§Ù†",
                            "ÙØ§Ø±Ø³",
                            "Ø®Ø±Ø§Ø³Ø§Ù† Ø±Ø¶ÙˆÛŒ",
                            "Ø¢Ø°Ø±Ø¨Ø§ÛŒØ¬Ø§Ù† Ø´Ø±Ù‚ÛŒ",
                            "Ø®ÙˆØ²Ø³ØªØ§Ù†",
                            "Ú¯ÛŒÙ„Ø§Ù†",
                            "Ù…Ø§Ø²Ù†Ø¯Ø±Ø§Ù†",
                            "Ø§Ù„Ø¨Ø±Ø²",
                            "Ú©Ø±Ù…Ø§Ù†",
                            "ÛŒØ²Ø¯",
                            "Ù‚Ù…",
                            "Ú©Ø±Ù…Ø§Ù†Ø´Ø§Ù‡",
                            "Ù‡Ù…Ø¯Ø§Ù†",
                            "Ú¯Ù„Ø³ØªØ§Ù†",
                            "Ù…Ø±Ú©Ø²ÛŒ",
                            "Ø²Ù†Ø¬Ø§Ù†",
                            "Ø§Ø±Ø¯Ø¨ÛŒÙ„",
                            "Ù‚Ø²ÙˆÛŒÙ†",
                            "Ø³Ù…Ù†Ø§Ù†"
                          ]
                        },
                        {
                          "actionType": "validateFields",
                          "resultKey": "giftCardRealReceiverContinueEnabled",
                          "fields": [
                            {
                              "id": "gift_card_real_receiver_name",
                              "optional": "giftCardRealReceiverIsOwner"
                            },
                            {
                              "id": "gift_card_real_receiver_mobile",
                              "rule": "^[0-9]{11}$",
                              "optional": "giftCardRealReceiverIsOwner"
                            },
                            {
                              "id": "gift_card_real_receiver_postal_code",
                              "rule": "^[0-9]{10}$"
                            },
                            {
                              "id": "gift_card_real_receiver_address"
                            }
                          ]
                        }
                      ]
                    },
                    "type": "gestureDetector"
                  },
                  {
                    "height": 24.0,
                    "type": "sizedBox"
                  },
                  {
                    "data": "Ø´Ù‡Ø±",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.text.title}}",
                      "fontSize": 18.0,
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
                    "child": {
                      "padding": {
                        "left": 16.0,
                        "right": 16.0
                      },
                      "decoration": {
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
                      "height": 56.0,
                      "child": {
                        "type": "registryReactive",
                        "child": {
                          "mainAxisAlignment": "spaceBetween",
                          "crossAxisAlignment": "center",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "data": "{{giftCardRealReceiverCity}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 18.0,
                                "fontWeight": "w600"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            {
                              "icon": "keyboard_arrow_down",
                              "iconType": "material",
                              "size": 30.0,
                              "color": "{{appColors.current.text.title}}",
                              "type": "icon"
                            }
                          ],
                          "type": "row"
                        }
                      },
                      "type": "container"
                    },
                    "onTap": {
                      "actionType": "sequence",
                      "actions": [
                        {
                          "actionType": "showGiftCardLocationSelectorBottomSheet",
                          "title": "Ø§Ù†ØªØ®Ø§Ø¨ Ø´Ù‡Ø±",
                          "selectedKey": "giftCardRealReceiverCity",
                          "options": [
                            "ØªÙ‡Ø±Ø§Ù†",
                            "Ù…Ø´Ù‡Ø¯",
                            "Ø§ØµÙÙ‡Ø§Ù†",
                            "Ø´ÛŒØ±Ø§Ø²",
                            "ØªØ¨Ø±ÛŒØ²",
                            "Ø§Ù‡ÙˆØ§Ø²",
                            "Ø±Ø´Øª",
                            "Ú©Ø±Ø¬",
                            "Ù‚Ù…",
                            "Ú©Ø±Ù…Ø§Ù†Ø´Ø§Ù‡",
                            "Ø§Ø±ÙˆÙ…ÛŒÙ‡",
                            "ÛŒØ²Ø¯",
                            "Ù‡Ù…Ø¯Ø§Ù†",
                            "Ù‚Ø²ÙˆÛŒÙ†",
                            "Ø§Ø±Ø¯Ø¨ÛŒÙ„",
                            "Ø²Ø§Ù‡Ø¯Ø§Ù†",
                            "Ø¨Ù†Ø¯Ø±Ø¹Ø¨Ø§Ø³",
                            "Ú¯Ø±Ú¯Ø§Ù†",
                            "Ø²Ù†Ø¬Ø§Ù†",
                            "Ø§Ø±Ø§Ú©"
                          ]
                        },
                        {
                          "actionType": "validateFields",
                          "resultKey": "giftCardRealReceiverContinueEnabled",
                          "fields": [
                            {
                              "id": "gift_card_real_receiver_name",
                              "optional": "giftCardRealReceiverIsOwner"
                            },
                            {
                              "id": "gift_card_real_receiver_mobile",
                              "rule": "^[0-9]{11}$",
                              "optional": "giftCardRealReceiverIsOwner"
                            },
                            {
                              "id": "gift_card_real_receiver_postal_code",
                              "rule": "^[0-9]{10}$"
                            },
                            {
                              "id": "gift_card_real_receiver_address"
                            }
                          ]
                        }
                      ]
                    },
                    "type": "gestureDetector"
                  },
                  {
                    "height": 24.0,
                    "type": "sizedBox"
                  },
                  {
                    "data": "Ú©Ø¯ Ù¾Ø³ØªÛŒ Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.text.title}}",
                      "fontSize": 18.0,
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
                    "decoration": {
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
                      "type": "textFormField",
                      "id": "gift_card_real_receiver_postal_code",
                      "textDirection": "rtl",
                      "textAlign": "right",
                      "decoration": {
                        "hintText": "Ú©Ø¯ Ù¾Ø³ØªÛŒ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                        "hintStyle": {
                          "type": "custom",
                          "color": "{{appColors.current.text.hint}}",
                          "fontSize": 16.0,
                          "fontWeight": "w500"
                        },
                        "contentPadding": {
                          "left": 18.0,
                          "top": 16.0,
                          "right": 18.0,
                          "bottom": 16.0
                        },
                        "filled": false
                      },
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 17.0,
                        "fontWeight": "w600"
                      },
                      "keyboardType": "number",
                      "maxLength": 10,
                      "minLines": 1,
                      "maxLines": 1,
                      "inputFormatters": [
                        {
                          "type": "allow",
                          "rule": "[0-9]"
                        }
                      ],
                      "onChanged": {
                        "actionType": "validateFields",
                        "resultKey": "giftCardRealReceiverContinueEnabled",
                        "fields": [
                          {
                            "id": "gift_card_real_receiver_name",
                            "optional": "giftCardRealReceiverIsOwner"
                          },
                          {
                            "id": "gift_card_real_receiver_mobile",
                            "rule": "^[0-9]{11}$",
                            "optional": "giftCardRealReceiverIsOwner"
                          },
                          {
                            "id": "gift_card_real_receiver_postal_code",
                            "rule": "^[0-9]{10}$"
                          },
                          {
                            "id": "gift_card_real_receiver_address"
                          }
                        ]
                      }
                    },
                    "type": "container"
                  },
                  {
                    "height": 24.0,
                    "type": "sizedBox"
                  },
                  {
                    "data": "Ø¢Ø¯Ø±Ø³ Ù¾Ø³ØªÛŒ Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.text.title}}",
                      "fontSize": 18.0,
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
                    "decoration": {
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
                      "type": "textFormField",
                      "id": "gift_card_real_receiver_address",
                      "textDirection": "rtl",
                      "textAlign": "right",
                      "decoration": {
                        "hintText": "Ø¢Ø¯Ø±Ø³ Ù¾Ø³ØªÛŒ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                        "hintStyle": {
                          "type": "custom",
                          "color": "{{appColors.current.text.hint}}",
                          "fontSize": 16.0,
                          "fontWeight": "w500"
                        },
                        "contentPadding": {
                          "left": 18.0,
                          "top": 16.0,
                          "right": 18.0,
                          "bottom": 16.0
                        },
                        "filled": false
                      },
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 17.0,
                        "fontWeight": "w600"
                      },
                      "minLines": 4,
                      "maxLines": 4,
                      "onChanged": {
                        "actionType": "validateFields",
                        "resultKey": "giftCardRealReceiverContinueEnabled",
                        "fields": [
                          {
                            "id": "gift_card_real_receiver_name",
                            "optional": "giftCardRealReceiverIsOwner"
                          },
                          {
                            "id": "gift_card_real_receiver_mobile",
                            "rule": "^[0-9]{11}$",
                            "optional": "giftCardRealReceiverIsOwner"
                          },
                          {
                            "id": "gift_card_real_receiver_postal_code",
                            "rule": "^[0-9]{10}$"
                          },
                          {
                            "id": "gift_card_real_receiver_address"
                          }
                        ]
                      }
                    },
                    "type": "container"
                  },
                  {
                    "height": 24.0,
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
              "type": "reactiveElevatedButton",
              "enabledKey": "giftCardRealReceiverContinueEnabled",
              "onPressed": {
                "actionType": "showGiftCardSelectDateBottomSheet",
                "title": "Ù„Ø·ÙØ§ ØªØ§Ø±ÛŒØ® Ùˆ Ø¨Ø§Ø²Ù‡â€ŒØ²Ù…Ø§Ù†ÛŒ ØªØ­ÙˆÛŒÙ„ Ù‡Ø¯ÛŒÙ‡ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                "dateTitle": "ØªØ§Ø±ÛŒØ® ØªØ­ÙˆÛŒÙ„",
                "timeTitle": "Ù…Ø­Ø¯ÙˆØ¯Ù‡ Ø³Ø§Ø¹ØªÛŒ ØªØ­ÙˆÛŒÙ„",
                "confirmText": "ØªØ§ÛŒÛŒØ¯",
                "noDateSelectedText": "ØªØ§Ø±ÛŒØ®ÛŒ Ø§Ù†ØªØ®Ø§Ø¨ Ù†Ø´Ø¯Ù‡ Ø§Ø³Øª",
                "dateOptions": [
                  "Ù¾Ù†Ø¬â€ŒØ´Ù†Ø¨Ù‡ Û±Û´Û°Ûµ/Û°Û²/Û°Û³",
                  "Ø¬Ù…Ø¹Ù‡ Û±Û´Û°Ûµ/Û°Û²/Û°Û´",
                  "Ø´Ù†Ø¨Ù‡ Û±Û´Û°Ûµ/Û°Û²/Û°Ûµ"
                ],
                "timeOptions": [
                  "Û±Û³ - Û±Û¸",
                  "Û±Û° - Û±Û³",
                  "Û±Û¸ - Û²Û±"
                ],
                "selectedDateKey": "giftCardRealDeliveryDate",
                "selectedTimeKey": "giftCardRealDeliveryTime",
                "confirmAssetPath": "lib/stac/tobank/flows/gift_card_real/json/gift_card_real_confirm.json"
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
              "disabledStyle": {
                "foregroundColor": "{{appColors.current.button.disabled.foregroundColor}}",
                "backgroundColor": "{{appColors.current.button.disabled.backgroundColor}}",
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
                "data": "Ø§Ø¯Ø§Ù…Ù‡",
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
      },
      "type": "form"
    },
    "type": "scaffold"
  }
}
```
