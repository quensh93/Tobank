# flows/transfer_real/json/transfer_real_amount.json

Source: lib/stac/tobank/flows/transfer_real/json/transfer_real_amount.json

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
        "key": "transferApiTabIban",
        "value": true
      },
      {
        "key": "transferApiTabInBank",
        "value": false
      },
      {
        "key": "transferApiTabCard",
        "value": false
      },
      {
        "key": "transferApiContinueEnabled",
        "value": false
      },
      {
        "key": "transferApiIsSearching",
        "value": false
      },
      {
        "key": "transferApiIbanVisible1",
        "value": true
      },
      {
        "key": "transferApiIbanVisible2",
        "value": true
      },
      {
        "key": "transferApiIbanVisible3",
        "value": true
      },
      {
        "key": "transferApiIbanVisible4",
        "value": true
      },
      {
        "key": "transferApiIbanVisible5",
        "value": true
      },
      {
        "key": "transferApiInBankMyTab",
        "value": true
      },
      {
        "key": "transferApiInBankOthersTab",
        "value": false
      },
      {
        "key": "transferApiInBankHasText",
        "value": false
      },
      {
        "key": "transferApiCardHasText",
        "value": false
      },
      {
        "key": "transferApiCardVisible1",
        "value": true
      },
      {
        "key": "transferApiCardVisible2",
        "value": true
      },
      {
        "key": "transferApiCardVisible3",
        "value": true
      },
      {
        "key": "transferApiCardVisible4",
        "value": true
      },
      {
        "key": "transferApiCardVisible5",
        "value": true
      },
      {
        "key": "transferApiCardSourceName",
        "value": "Ø³Ø¬Ø§Ø¯ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±"
      },
      {
        "key": "transferApiCardSourceNumber",
        "value": "ÛµÛ°ÛµÛ´ Û±Û¶Û±Û· Û°Û²Û¹Û¹ Û´Û·Û±Û°"
      },
      {
        "key": "transferApiCardSourceIcon",
        "value": "assets/icons/ic_gardeshgari.svg"
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
          "src": "{{appAssets.icons.arrowRight}}",
          "imageType": "asset",
          "color": "{{appColors.current.text.title}}",
          "width": 24.0,
          "height": 24.0,
          "type": "image"
        },
        "type": "iconButton"
      },
      "title": {
        "data": "Ø§Ù†ØªÙ‚Ø§Ù„ ÙˆØ¬Ù‡",
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
    "backgroundColor": "{{appColors.current.background.surface}}",
    "body": {
      "padding": {
        "left": 16.0,
        "top": 16.0,
        "right": 16.0,
        "bottom": 23.0
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
              "color": "{{appColors.current.background.surfaceContainer}}",
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
                            "visible": "[[transferApiTabIban]]",
                            "child": {
                              "data": "Ø¨ÛŒÙ† Ø¨Ø§Ù†Ú©ÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 17.0,
                                "fontWeight": "w800"
                              },
                              "textAlign": "center",
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "replacement": {
                              "data": "Ø¨ÛŒÙ† Ø¨Ø§Ù†Ú©ÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 17.0,
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
                            "visible": "[[transferApiTabIban]]",
                            "child": {
                              "decoration": {
                                "color": "{{appColors.current.primary.color}}",
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
                              "color": "#00000000",
                              "width": 56.0,
                              "height": 3.0,
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
                          "key": "transferApiTabIban",
                          "value": true
                        },
                        {
                          "key": "transferApiTabInBank",
                          "value": false
                        },
                        {
                          "key": "transferApiTabCard",
                          "value": false
                        },
                        {
                          "key": "transferApiContinueEnabled",
                          "value": false
                        },
                        {
                          "key": "transferApiInBankHasText",
                          "value": false
                        },
                        {
                          "key": "transferApiCardHasText",
                          "value": false
                        },
                        {
                          "key": "transferApiCardInput",
                          "value": ""
                        },
                        {
                          "key": "transferApiCardVisible1",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible2",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible3",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible4",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible5",
                          "value": true
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
                            "visible": "[[transferApiTabInBank]]",
                            "child": {
                              "data": "Ø¯Ø±ÙˆÙ† Ø¨Ø§Ù†Ú©ÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 17.0,
                                "fontWeight": "w800"
                              },
                              "textAlign": "center",
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "replacement": {
                              "data": "Ø¯Ø±ÙˆÙ† Ø¨Ø§Ù†Ú©ÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 17.0,
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
                            "visible": "[[transferApiTabInBank]]",
                            "child": {
                              "decoration": {
                                "color": "{{appColors.current.primary.color}}",
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
                              "color": "#00000000",
                              "width": 56.0,
                              "height": 3.0,
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
                          "key": "transferApiTabIban",
                          "value": false
                        },
                        {
                          "key": "transferApiTabInBank",
                          "value": true
                        },
                        {
                          "key": "transferApiTabCard",
                          "value": false
                        },
                        {
                          "key": "transferApiInBankMyTab",
                          "value": true
                        },
                        {
                          "key": "transferApiInBankOthersTab",
                          "value": false
                        },
                        {
                          "key": "transferApiContinueEnabled",
                          "value": false
                        },
                        {
                          "key": "transferApiCardHasText",
                          "value": false
                        },
                        {
                          "key": "transferApiCardInput",
                          "value": ""
                        },
                        {
                          "key": "transferApiCardVisible1",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible2",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible3",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible4",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible5",
                          "value": true
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
                            "visible": "[[transferApiTabCard]]",
                            "child": {
                              "data": "Ú©Ø§Ø±Øª",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 17.0,
                                "fontWeight": "w800"
                              },
                              "textAlign": "center",
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "replacement": {
                              "data": "Ú©Ø§Ø±Øª",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 17.0,
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
                            "visible": "[[transferApiTabCard]]",
                            "child": {
                              "decoration": {
                                "color": "{{appColors.current.primary.color}}",
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
                              "color": "#00000000",
                              "width": 56.0,
                              "height": 3.0,
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
                          "key": "transferApiTabIban",
                          "value": false
                        },
                        {
                          "key": "transferApiTabInBank",
                          "value": false
                        },
                        {
                          "key": "transferApiTabCard",
                          "value": true
                        },
                        {
                          "key": "transferApiContinueEnabled",
                          "value": false
                        },
                        {
                          "key": "transferApiInBankHasText",
                          "value": false
                        },
                        {
                          "key": "transferApiCardHasText",
                          "value": false
                        },
                        {
                          "key": "transferApiCardInput",
                          "value": ""
                        },
                        {
                          "key": "transferApiCardVisible1",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible2",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible3",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible4",
                          "value": true
                        },
                        {
                          "key": "transferApiCardVisible5",
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
            "height": 18.0,
            "type": "sizedBox"
          },
          {
            "type": "visibility",
            "visible": "[[transferApiTabIban]]",
            "child": {
              "crossAxisAlignment": "stretch",
              "children": [
                {
                  "data": "Ø´Ù…Ø§Ø±Ù‡ Ø´Ø¨Ø§",
                  "style": {
                    "type": "custom",
                    "color": "{{appColors.current.text.title}}",
                    "fontSize": 19.0,
                    "fontWeight": "w700"
                  },
                  "textAlign": "right",
                  "textDirection": "rtl",
                  "type": "text"
                },
                {
                  "height": 10.0,
                  "type": "sizedBox"
                },
                {
                  "type": "textFormField",
                  "id": "transferApiIbanInput",
                  "textDirection": "ltr",
                  "textAlign": "left",
                  "keyboardType": "number",
                  "maxLength": 24,
                  "inputFormatters": [
                    {
                      "type": "allow",
                      "rule": "[0-9]"
                    }
                  ],
                  "onChanged": {
                    "actionType": "filterTransferIbanList",
                    "fieldId": "transferApiIbanInput",
                    "ibanValues": [
                      "830700001000117894304001",
                      "490100000000340340070004",
                      "980640011070075034070001",
                      "240750005151124000000156",
                      "860130100000003318427752"
                    ],
                    "visibleKeys": [
                      "transferApiIbanVisible1",
                      "transferApiIbanVisible2",
                      "transferApiIbanVisible3",
                      "transferApiIbanVisible4",
                      "transferApiIbanVisible5"
                    ],
                    "continueEnabledKey": "transferApiContinueEnabled",
                    "isSearchingKey": "transferApiIsSearching"
                  },
                  "style": {
                    "type": "custom",
                    "color": "{{appColors.current.text.title}}",
                    "fontSize": 16.0,
                    "fontWeight": "w600"
                  },
                  "decoration": {
                    "hintText": "Ø´Ù…Ø§Ø±Ù‡ Ø´Ø¨Ø§ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                    "hintStyle": {
                      "type": "custom",
                      "color": "{{appColors.current.text.hint}}",
                      "fontSize": 16.0,
                      "fontWeight": "w500"
                    },
                    "prefixIcon": {
                      "width": 74.0,
                      "child": {
                        "padding": {
                          "left": 4.0,
                          "top": 10.0,
                          "right": 2.0,
                          "bottom": 10.0
                        },
                        "child": {
                          "mainAxisAlignment": "center",
                          "textDirection": "ltr",
                          "children": [
                            {
                              "data": "IR",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 22.0,
                                "fontWeight": "w700"
                              },
                              "textDirection": "ltr",
                              "type": "text"
                            }
                          ],
                          "type": "row"
                        },
                        "type": "padding"
                      },
                      "type": "sizedBox"
                    },
                    "suffixIcon": {
                      "type": "visibility",
                      "visible": "[[transferApiIsSearching]]",
                      "child": {
                        "child": {
                          "padding": {
                            "left": 10.0,
                            "right": 10.0
                          },
                          "child": {
                            "icon": "close",
                            "iconType": "material",
                            "size": 19.0,
                            "color": "{{appColors.current.text.subtitle}}",
                            "type": "icon"
                          },
                          "type": "padding"
                        },
                        "onTap": {
                          "actionType": "sequence",
                          "actions": [
                            {
                              "actionType": "setValue",
                              "values": [
                                {
                                  "key": "transferApiIbanInput",
                                  "value": ""
                                },
                                {
                                  "key": "transferApiDestinationIban",
                                  "value": ""
                                },
                                {
                                  "key": "transferApiDestinationName",
                                  "value": ""
                                }
                              ]
                            },
                            {
                              "actionType": "filterTransferIbanList",
                              "fieldId": "transferApiIbanInput",
                              "ibanValues": [
                                "830700001000117894304001",
                                "490100000000340340070004",
                                "980640011070075034070001",
                                "240750005151124000000156",
                                "860130100000003318427752"
                              ],
                              "visibleKeys": [
                                "transferApiIbanVisible1",
                                "transferApiIbanVisible2",
                                "transferApiIbanVisible3",
                                "transferApiIbanVisible4",
                                "transferApiIbanVisible5"
                              ],
                              "continueEnabledKey": "transferApiContinueEnabled",
                              "isSearchingKey": "transferApiIsSearching"
                            }
                          ]
                        },
                        "type": "gestureDetector"
                      },
                      "replacement": {
                        "width": 24.0,
                        "type": "sizedBox"
                      }
                    },
                    "contentPadding": {
                      "left": 8.0,
                      "top": 19.5,
                      "right": 16.0,
                      "bottom": 19.5
                    },
                    "filled": false,
                    "hintTextDirection": "rtl",
                    "hintTextAlign": "right"
                  }
                }
              ],
              "type": "column"
            },
            "replacement": {
              "type": "sizedBox"
            }
          },
          {
            "type": "visibility",
            "visible": "[[transferApiTabInBank]]",
            "child": {
              "crossAxisAlignment": "stretch",
              "children": [
                {
                  "data": "Ø´Ù…Ø§Ø±Ù‡ Ø­Ø³Ø§Ø¨",
                  "style": {
                    "type": "custom",
                    "color": "{{appColors.current.text.title}}",
                    "fontSize": 19.0,
                    "fontWeight": "w700"
                  },
                  "textAlign": "right",
                  "textDirection": "rtl",
                  "type": "text"
                },
                {
                  "height": 10.0,
                  "type": "sizedBox"
                },
                {
                  "type": "textFormField",
                  "id": "transferApiInBankAccountInput",
                  "textDirection": "ltr",
                  "textAlign": "right",
                  "decoration": {
                    "hintText": "Ø´Ù…Ø§Ø±Ù‡ Ø­Ø³Ø§Ø¨ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                    "hintStyle": {
                      "type": "custom",
                      "color": "{{appColors.current.text.hint}}",
                      "fontSize": 16.0,
                      "fontWeight": "w500"
                    },
                    "prefixIcon": {
                      "type": "visibility",
                      "visible": "[[transferApiInBankHasText]]",
                      "child": {
                        "child": {
                          "padding": {
                            "left": 12.0,
                            "top": 12.0,
                            "right": 12.0,
                            "bottom": 12.0
                          },
                          "child": {
                            "icon": "close",
                            "iconType": "material",
                            "size": 20.0,
                            "color": "{{appColors.current.text.subtitle}}",
                            "type": "icon"
                          },
                          "type": "padding"
                        },
                        "onTap": {
                          "actionType": "sequence",
                          "actions": [
                            {
                              "actionType": "setValue",
                              "values": [
                                {
                                  "key": "transferApiInBankAccountInput",
                                  "value": ""
                                },
                                {
                                  "key": "transferApiInBankAccountRaw",
                                  "value": ""
                                },
                                {
                                  "key": "transferApiInBankHasText",
                                  "value": false
                                },
                                {
                                  "key": "transferApiContinueEnabled",
                                  "value": false
                                },
                                {
                                  "key": "transferApiDestinationIban",
                                  "value": ""
                                }
                              ]
                            },
                            {
                              "actionType": "setTransferInBankContinueEnabled",
                              "fieldId": "transferApiInBankAccountInput",
                              "rawValueKey": "transferApiInBankAccountRaw",
                              "continueEnabledKey": "transferApiContinueEnabled",
                              "hasTextKey": "transferApiInBankHasText",
                              "destinationIbanKey": "transferApiDestinationIban",
                              "minLengthExclusive": 15,
                              "maxLength": 18
                            }
                          ]
                        },
                        "type": "gestureDetector"
                      }
                    },
                    "contentPadding": {
                      "left": 16.0,
                      "top": 19.5,
                      "right": 16.0,
                      "bottom": 19.5
                    },
                    "filled": false
                  },
                  "style": {
                    "type": "custom",
                    "color": "{{appColors.current.text.title}}",
                    "fontSize": 16.0,
                    "fontWeight": "w600"
                  },
                  "keyboardType": "number",
                  "maxLength": 18,
                  "inputFormatters": [
                    {
                      "type": "allow",
                      "rule": "[0-9.]"
                    }
                  ],
                  "onChanged": {
                    "actionType": "setTransferInBankContinueEnabled",
                    "fieldId": "transferApiInBankAccountInput",
                    "rawValueKey": "transferApiInBankAccountRaw",
                    "continueEnabledKey": "transferApiContinueEnabled",
                    "hasTextKey": "transferApiInBankHasText",
                    "destinationIbanKey": "transferApiDestinationIban",
                    "minLengthExclusive": 15,
                    "maxLength": 18
                  }
                }
              ],
              "type": "column"
            },
            "replacement": {
              "type": "sizedBox"
            }
          },
          {
            "type": "visibility",
            "visible": "[[transferApiTabCard]]",
            "child": {
              "crossAxisAlignment": "stretch",
              "children": [
                {
                  "data": "Ø´Ù…Ø§Ø±Ù‡ Ú©Ø§Ø±Øª Ù…Ù‚ØµØ¯",
                  "style": {
                    "type": "custom",
                    "color": "{{appColors.current.text.title}}",
                    "fontSize": 19.0,
                    "fontWeight": "w700"
                  },
                  "textAlign": "right",
                  "textDirection": "rtl",
                  "type": "text"
                },
                {
                  "height": 10.0,
                  "type": "sizedBox"
                },
                {
                  "type": "textFormField",
                  "id": "transferApiCardInput",
                  "textDirection": "ltr",
                  "textAlign": "right",
                  "decoration": {
                    "hintText": "Ø´Ù…Ø§Ø±Ù‡ Ú©Ø§Ø±Øª Ù…Ù‚ØµØ¯ Ø±Ø§ ÙˆØ§Ø±Ø¯ ÛŒØ§ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                    "hintStyle": {
                      "type": "custom",
                      "color": "{{appColors.current.text.hint}}",
                      "fontSize": 16.0,
                      "fontWeight": "w500"
                    },
                    "contentPadding": {
                      "left": 16.0,
                      "top": 19.5,
                      "right": 16.0,
                      "bottom": 19.5
                    },
                    "filled": false
                  },
                  "style": {
                    "type": "custom",
                    "color": "{{appColors.current.text.title}}",
                    "fontSize": 18.0,
                    "fontWeight": "w600"
                  },
                  "keyboardType": "number",
                  "maxLength": 16,
                  "inputFormatters": [
                    {
                      "type": "allow",
                      "rule": "[0-9]"
                    }
                  ],
                  "onChanged": {
                    "actionType": "filterTransferIbanList",
                    "fieldId": "transferApiCardInput",
                    "ibanValues": [
                      "5054161018168058",
                      "5054161702844691",
                      "5054161702994710",
                      "5022913100939467",
                      "5041771080766026"
                    ],
                    "visibleKeys": [
                      "transferApiCardVisible1",
                      "transferApiCardVisible2",
                      "transferApiCardVisible3",
                      "transferApiCardVisible4",
                      "transferApiCardVisible5"
                    ],
                    "isSearchingKey": "transferApiCardHasText"
                  }
                }
              ],
              "type": "column"
            },
            "replacement": {
              "type": "sizedBox"
            }
          },
          {
            "height": 22.0,
            "type": "sizedBox"
          },
          {
            "child": {
              "type": "visibility",
              "visible": "[[transferApiTabIban]]",
              "child": {
                "child": {
                  "crossAxisAlignment": "stretch",
                  "children": [
                    {
                      "type": "visibility",
                      "visible": "[[transferApiIbanVisible1]]",
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
                                  "topLeft": 11.0,
                                  "topRight": 11.0,
                                  "bottomLeft": 11.0,
                                  "bottomRight": 11.0
                                }
                              },
                              "child": {
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "decoration": {
                                      "color": "{{appColors.current.background.surfaceContainer}}",
                                      "borderRadius": {
                                        "topLeft": 999.0,
                                        "topRight": 999.0,
                                        "bottomLeft": 999.0,
                                        "bottomRight": 999.0
                                      }
                                    },
                                    "width": 34.0,
                                    "height": 34.0,
                                    "child": {
                                      "child": {
                                        "src": "assets/icons/ic_gardeshgari.svg",
                                        "imageType": "asset",
                                        "width": 24.0,
                                        "height": 24.0,
                                        "type": "image"
                                      },
                                      "type": "center"
                                    },
                                    "type": "container"
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
                                          "data": "IRÛ¸Û³Û°Û·Û°Û°Û°Û°Û±Û°Û°Û°Û±Û±Û·Û¸Û¹Û´Û³Û°Û´Û°Û°Û±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w700"
                                          },
                                          "textAlign": "right",
                                          "textDirection": "ltr",
                                          "type": "text"
                                        },
                                        {
                                          "height": 8.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "Ø³Ø¬Ø§Ø¯ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 15.0,
                                            "fontWeight": "w500"
                                          },
                                          "textAlign": "right",
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
                              "actionType": "sequence",
                              "actions": [
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiIbanInput",
                                  "value": "830700001000117894304001"
                                },
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiDestinationName",
                                  "value": "Ø³Ø¬Ø§Ø¯ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±"
                                },
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiDestinationIban",
                                  "value": "830700001000117894304001"
                                },
                                {
                                  "actionType": "filterTransferIbanList",
                                  "fieldId": "transferApiIbanInput",
                                  "ibanValues": [
                                    "830700001000117894304001",
                                    "490100000000340340070004",
                                    "980640011070075034070001",
                                    "240750005151124000000156",
                                    "860130100000003318427752"
                                  ],
                                  "visibleKeys": [
                                    "transferApiIbanVisible1",
                                    "transferApiIbanVisible2",
                                    "transferApiIbanVisible3",
                                    "transferApiIbanVisible4",
                                    "transferApiIbanVisible5"
                                  ],
                                  "continueEnabledKey": "transferApiContinueEnabled",
                                  "isSearchingKey": "transferApiIsSearching"
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          },
                          {
                            "height": 12.0,
                            "type": "sizedBox"
                          }
                        ],
                        "type": "column"
                      }
                    },
                    {
                      "type": "visibility",
                      "visible": "[[transferApiIbanVisible2]]",
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
                                  "topLeft": 11.0,
                                  "topRight": 11.0,
                                  "bottomLeft": 11.0,
                                  "bottomRight": 11.0
                                }
                              },
                              "child": {
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "decoration": {
                                      "color": "{{appColors.current.background.surfaceContainer}}",
                                      "borderRadius": {
                                        "topLeft": 999.0,
                                        "topRight": 999.0,
                                        "bottomLeft": 999.0,
                                        "bottomRight": 999.0
                                      }
                                    },
                                    "width": 34.0,
                                    "height": 34.0,
                                    "child": {
                                      "child": {
                                        "src": "assets/icons/ic_gardeshgari.svg",
                                        "imageType": "asset",
                                        "width": 24.0,
                                        "height": 24.0,
                                        "type": "image"
                                      },
                                      "type": "center"
                                    },
                                    "type": "container"
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
                                          "data": "IRÛ´Û¹Û°Û±Û°Û°Û°Û°Û°Û°Û°Û°Û³Û´Û°Û³Û´Û°Û°Û·Û°Û°Û°Û´",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w700"
                                          },
                                          "textAlign": "right",
                                          "textDirection": "ltr",
                                          "type": "text"
                                        },
                                        {
                                          "height": 8.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "Ù…ÛŒÙ†Ø§ Ø¹Ø§Ø´ÙˆØ±ÛŒ",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 15.0,
                                            "fontWeight": "w500"
                                          },
                                          "textAlign": "right",
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
                              "actionType": "sequence",
                              "actions": [
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiIbanInput",
                                  "value": "490100000000340340070004"
                                },
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiDestinationName",
                                  "value": "Ù…ÛŒÙ†Ø§ Ø¹Ø§Ø´ÙˆØ±ÛŒ"
                                },
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiDestinationIban",
                                  "value": "490100000000340340070004"
                                },
                                {
                                  "actionType": "filterTransferIbanList",
                                  "fieldId": "transferApiIbanInput",
                                  "ibanValues": [
                                    "830700001000117894304001",
                                    "490100000000340340070004",
                                    "980640011070075034070001",
                                    "240750005151124000000156",
                                    "860130100000003318427752"
                                  ],
                                  "visibleKeys": [
                                    "transferApiIbanVisible1",
                                    "transferApiIbanVisible2",
                                    "transferApiIbanVisible3",
                                    "transferApiIbanVisible4",
                                    "transferApiIbanVisible5"
                                  ],
                                  "continueEnabledKey": "transferApiContinueEnabled",
                                  "isSearchingKey": "transferApiIsSearching"
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          },
                          {
                            "height": 12.0,
                            "type": "sizedBox"
                          }
                        ],
                        "type": "column"
                      }
                    },
                    {
                      "type": "visibility",
                      "visible": "[[transferApiIbanVisible3]]",
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
                                  "topLeft": 11.0,
                                  "topRight": 11.0,
                                  "bottomLeft": 11.0,
                                  "bottomRight": 11.0
                                }
                              },
                              "child": {
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "decoration": {
                                      "color": "{{appColors.current.background.surfaceContainer}}",
                                      "borderRadius": {
                                        "topLeft": 999.0,
                                        "topRight": 999.0,
                                        "bottomLeft": 999.0,
                                        "bottomRight": 999.0
                                      }
                                    },
                                    "width": 34.0,
                                    "height": 34.0,
                                    "child": {
                                      "child": {
                                        "src": "assets/icons/ic_gardeshgari.svg",
                                        "imageType": "asset",
                                        "width": 24.0,
                                        "height": 24.0,
                                        "type": "image"
                                      },
                                      "type": "center"
                                    },
                                    "type": "container"
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
                                          "data": "IRÛ¹Û¸Û°Û¶Û´Û°Û°Û±Û±Û°Û·Û°Û°Û·ÛµÛ°Û³Û´Û°Û·Û°Û°Û±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w700"
                                          },
                                          "textAlign": "right",
                                          "textDirection": "ltr",
                                          "type": "text"
                                        },
                                        {
                                          "height": 8.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "Ù…Ø­Ø³Ù† Ù…Ù‚Ø¯Ù…",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 15.0,
                                            "fontWeight": "w500"
                                          },
                                          "textAlign": "right",
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
                              "actionType": "sequence",
                              "actions": [
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiIbanInput",
                                  "value": "980640011070075034070001"
                                },
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiDestinationName",
                                  "value": "Ù…Ø­Ø³Ù† Ù…Ù‚Ø¯Ù…"
                                },
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiDestinationIban",
                                  "value": "980640011070075034070001"
                                },
                                {
                                  "actionType": "filterTransferIbanList",
                                  "fieldId": "transferApiIbanInput",
                                  "ibanValues": [
                                    "830700001000117894304001",
                                    "490100000000340340070004",
                                    "980640011070075034070001",
                                    "240750005151124000000156",
                                    "860130100000003318427752"
                                  ],
                                  "visibleKeys": [
                                    "transferApiIbanVisible1",
                                    "transferApiIbanVisible2",
                                    "transferApiIbanVisible3",
                                    "transferApiIbanVisible4",
                                    "transferApiIbanVisible5"
                                  ],
                                  "continueEnabledKey": "transferApiContinueEnabled",
                                  "isSearchingKey": "transferApiIsSearching"
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          },
                          {
                            "height": 12.0,
                            "type": "sizedBox"
                          }
                        ],
                        "type": "column"
                      }
                    },
                    {
                      "type": "visibility",
                      "visible": "[[transferApiIbanVisible4]]",
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
                                  "topLeft": 11.0,
                                  "topRight": 11.0,
                                  "bottomLeft": 11.0,
                                  "bottomRight": 11.0
                                }
                              },
                              "child": {
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "decoration": {
                                      "color": "{{appColors.current.background.surfaceContainer}}",
                                      "borderRadius": {
                                        "topLeft": 999.0,
                                        "topRight": 999.0,
                                        "bottomLeft": 999.0,
                                        "bottomRight": 999.0
                                      }
                                    },
                                    "width": 34.0,
                                    "height": 34.0,
                                    "child": {
                                      "child": {
                                        "src": "assets/icons/ic_gardeshgari.svg",
                                        "imageType": "asset",
                                        "width": 24.0,
                                        "height": 24.0,
                                        "type": "image"
                                      },
                                      "type": "center"
                                    },
                                    "type": "container"
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
                                          "data": "IRÛ²Û´Û°Û·ÛµÛ°Û°Û°ÛµÛ±ÛµÛ±Û±Û²Û´Û°Û°Û°Û°Û°Û°Û±ÛµÛ¶",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w700"
                                          },
                                          "textAlign": "right",
                                          "textDirection": "ltr",
                                          "type": "text"
                                        },
                                        {
                                          "height": 8.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "ÛŒÚ©Ø§Ù†Ù‡ Ø³Ø§Ø¯Ø§Øª ØªØ±Ø§Ø¨ÛŒ Ø®Ø±Ù‚",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 15.0,
                                            "fontWeight": "w500"
                                          },
                                          "textAlign": "right",
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
                              "actionType": "sequence",
                              "actions": [
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiIbanInput",
                                  "value": "240750005151124000000156"
                                },
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiDestinationName",
                                  "value": "ÛŒÚ©Ø§Ù†Ù‡ Ø³Ø§Ø¯Ø§Øª ØªØ±Ø§Ø¨ÛŒ Ø®Ø±Ù‚"
                                },
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiDestinationIban",
                                  "value": "240750005151124000000156"
                                },
                                {
                                  "actionType": "filterTransferIbanList",
                                  "fieldId": "transferApiIbanInput",
                                  "ibanValues": [
                                    "830700001000117894304001",
                                    "490100000000340340070004",
                                    "980640011070075034070001",
                                    "240750005151124000000156",
                                    "860130100000003318427752"
                                  ],
                                  "visibleKeys": [
                                    "transferApiIbanVisible1",
                                    "transferApiIbanVisible2",
                                    "transferApiIbanVisible3",
                                    "transferApiIbanVisible4",
                                    "transferApiIbanVisible5"
                                  ],
                                  "continueEnabledKey": "transferApiContinueEnabled",
                                  "isSearchingKey": "transferApiIsSearching"
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          },
                          {
                            "height": 12.0,
                            "type": "sizedBox"
                          }
                        ],
                        "type": "column"
                      }
                    },
                    {
                      "type": "visibility",
                      "visible": "[[transferApiIbanVisible5]]",
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
                                  "topLeft": 11.0,
                                  "topRight": 11.0,
                                  "bottomLeft": 11.0,
                                  "bottomRight": 11.0
                                }
                              },
                              "child": {
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "decoration": {
                                      "color": "{{appColors.current.background.surfaceContainer}}",
                                      "borderRadius": {
                                        "topLeft": 999.0,
                                        "topRight": 999.0,
                                        "bottomLeft": 999.0,
                                        "bottomRight": 999.0
                                      }
                                    },
                                    "width": 34.0,
                                    "height": 34.0,
                                    "child": {
                                      "child": {
                                        "src": "assets/icons/ic_gardeshgari.svg",
                                        "imageType": "asset",
                                        "width": 24.0,
                                        "height": 24.0,
                                        "type": "image"
                                      },
                                      "type": "center"
                                    },
                                    "type": "container"
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
                                          "data": "IRÛ¸Û¶Û°Û±Û³Û°Û±Û°Û°Û°Û°Û°Û°Û°Û³Û³Û±Û¸Û´Û²Û·ÛµÛ²",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w700"
                                          },
                                          "textAlign": "right",
                                          "textDirection": "ltr",
                                          "type": "text"
                                        },
                                        {
                                          "height": 8.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "Ø³ÛŒØ¯ Ù¾Ø§Ø±Ø³Ø§ Ø¨Ù†ÛŒ Ø·Ø¨Ø§",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 15.0,
                                            "fontWeight": "w500"
                                          },
                                          "textAlign": "right",
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
                              "actionType": "sequence",
                              "actions": [
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiIbanInput",
                                  "value": "860130100000003318427752"
                                },
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiDestinationName",
                                  "value": "Ø³ÛŒØ¯ Ù¾Ø§Ø±Ø³Ø§ Ø¨Ù†ÛŒ Ø·Ø¨Ø§"
                                },
                                {
                                  "actionType": "setValue",
                                  "key": "transferApiDestinationIban",
                                  "value": "860130100000003318427752"
                                },
                                {
                                  "actionType": "filterTransferIbanList",
                                  "fieldId": "transferApiIbanInput",
                                  "ibanValues": [
                                    "830700001000117894304001",
                                    "490100000000340340070004",
                                    "980640011070075034070001",
                                    "240750005151124000000156",
                                    "860130100000003318427752"
                                  ],
                                  "visibleKeys": [
                                    "transferApiIbanVisible1",
                                    "transferApiIbanVisible2",
                                    "transferApiIbanVisible3",
                                    "transferApiIbanVisible4",
                                    "transferApiIbanVisible5"
                                  ],
                                  "continueEnabledKey": "transferApiContinueEnabled",
                                  "isSearchingKey": "transferApiIsSearching"
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          },
                          {
                            "height": 12.0,
                            "type": "sizedBox"
                          }
                        ],
                        "type": "column"
                      }
                    }
                  ],
                  "type": "column"
                },
                "type": "singleChildScrollView"
              },
              "replacement": {
                "type": "visibility",
                "visible": "[[transferApiTabInBank]]",
                "child": {
                  "crossAxisAlignment": "stretch",
                  "children": [
                    {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "child": {
                                  "children": [
                                    {
                                      "mainAxisAlignment": "center",
                                      "children": [
                                        {
                                          "src": "assets/icons/ic_person.svg",
                                          "imageType": "asset",
                                          "color": "{{appColors.current.text.title}}",
                                          "width": 16.0,
                                          "height": 16.0,
                                          "type": "image"
                                        },
                                        {
                                          "width": 6.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "Ø­Ø³Ø§Ø¨â€ŒÙ‡Ø§ÛŒ Ø®ÙˆØ¯Ù…",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 17.0,
                                            "fontWeight": "w600"
                                          },
                                          "textAlign": "center",
                                          "textDirection": "rtl",
                                          "type": "text"
                                        }
                                      ],
                                      "type": "row"
                                    },
                                    {
                                      "height": 10.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "type": "visibility",
                                      "visible": "[[transferApiInBankMyTab]]",
                                      "child": {
                                        "color": "{{appColors.current.primary.color}}",
                                        "height": 3.0,
                                        "type": "container"
                                      },
                                      "replacement": {
                                        "color": "#00000000",
                                        "height": 3.0,
                                        "type": "container"
                                      }
                                    }
                                  ],
                                  "type": "column"
                                },
                                "onTap": {
                                  "actionType": "setValue",
                                  "values": [
                                    {
                                      "key": "transferApiInBankMyTab",
                                      "value": true
                                    },
                                    {
                                      "key": "transferApiInBankOthersTab",
                                      "value": false
                                    }
                                  ]
                                },
                                "type": "gestureDetector"
                              },
                              "type": "expanded"
                            },
                            {
                              "child": {
                                "child": {
                                  "children": [
                                    {
                                      "mainAxisAlignment": "center",
                                      "children": [
                                        {
                                          "src": "assets/icons/ic_others.svg",
                                          "imageType": "asset",
                                          "color": "{{appColors.current.text.title}}",
                                          "width": 16.0,
                                          "height": 16.0,
                                          "type": "image"
                                        },
                                        {
                                          "width": 6.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "Ø­Ø³Ø§Ø¨â€ŒÙ‡Ø§ÛŒ Ø¯ÛŒÚ¯Ø±Ø§Ù†",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 17.0,
                                            "fontWeight": "w600"
                                          },
                                          "textAlign": "center",
                                          "textDirection": "rtl",
                                          "type": "text"
                                        }
                                      ],
                                      "type": "row"
                                    },
                                    {
                                      "height": 10.0,
                                      "type": "sizedBox"
                                    },
                                    {
                                      "type": "visibility",
                                      "visible": "[[transferApiInBankOthersTab]]",
                                      "child": {
                                        "color": "{{appColors.current.primary.color}}",
                                        "height": 3.0,
                                        "type": "container"
                                      },
                                      "replacement": {
                                        "color": "#00000000",
                                        "height": 3.0,
                                        "type": "container"
                                      }
                                    }
                                  ],
                                  "type": "column"
                                },
                                "onTap": {
                                  "actionType": "setValue",
                                  "values": [
                                    {
                                      "key": "transferApiInBankMyTab",
                                      "value": false
                                    },
                                    {
                                      "key": "transferApiInBankOthersTab",
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
                        {
                          "color": "{{appColors.current.input.borderEnabled}}",
                          "height": 1.0,
                          "type": "container"
                        }
                      ],
                      "type": "column"
                    },
                    {
                      "height": 16.0,
                      "type": "sizedBox"
                    },
                    {
                      "child": {
                        "child": {
                          "type": "visibility",
                          "visible": "[[transferApiInBankMyTab]]",
                          "child": {
                            "crossAxisAlignment": "stretch",
                            "children": [
                              {
                                "child": {
                                  "padding": {
                                    "left": 14.0,
                                    "top": 18.0,
                                    "right": 14.0,
                                    "bottom": 18.0
                                  },
                                  "decoration": {
                                    "color": "{{appColors.current.background.surface}}",
                                    "border": {
                                      "color": "{{appColors.current.input.borderEnabled}}",
                                      "width": 1.0
                                    },
                                    "borderRadius": {
                                      "topLeft": 11.0,
                                      "topRight": 11.0,
                                      "bottomLeft": 11.0,
                                      "bottomRight": 11.0
                                    }
                                  },
                                  "child": {
                                    "crossAxisAlignment": "start",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "child": {
                                          "data": "Û±Û±Û°.Û¹Û¹Û¹Û².Û±Û·Û¹Û³Û¸ÛµÛ¸.Û±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 17.0,
                                            "fontWeight": "w700"
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
                                          "data": "Ø³Ù¾Ø±Ø¯Ù‡ Ø³Ø±Ù…Ø§ÛŒÙ‡ Ú¯Ø°Ø§Ø±ÛŒ Ú©ÙˆØªØ§Ù‡ Ù…Ø¯Øª",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w500",
                                            "height": 1.4
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
                                  "actionType": "sequence",
                                  "actions": [
                                    {
                                      "actionType": "setValue",
                                      "values": [
                                        {
                                          "key": "transferApiInBankAccountInput",
                                          "value": "Û±Û±Û°.Û¹Û¹Û¹Û².Û±Û·Û¹Û³Û¸ÛµÛ¸.Û±"
                                        },
                                        {
                                          "key": "transferApiDestinationIban",
                                          "value": "Û±Û±Û°.Û¹Û¹Û¹Û².Û±Û·Û¹Û³Û¸ÛµÛ¸.Û±"
                                        },
                                        {
                                          "key": "transferApiDestinationName",
                                          "value": "Ø³Ù¾Ø±Ø¯Ù‡ Ø³Ø±Ù…Ø§ÛŒÙ‡ Ú¯Ø°Ø§Ø±ÛŒ Ú©ÙˆØªØ§Ù‡ Ù…Ø¯Øª"
                                        }
                                      ]
                                    },
                                    {
                                      "actionType": "setTransferInBankContinueEnabled",
                                      "fieldId": "transferApiInBankAccountInput",
                                      "rawValueKey": "transferApiInBankAccountRaw",
                                      "continueEnabledKey": "transferApiContinueEnabled",
                                      "hasTextKey": "transferApiInBankHasText",
                                      "destinationIbanKey": "transferApiDestinationIban",
                                      "minLengthExclusive": 15,
                                      "maxLength": 18
                                    }
                                  ]
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
                                    "left": 14.0,
                                    "top": 18.0,
                                    "right": 14.0,
                                    "bottom": 18.0
                                  },
                                  "decoration": {
                                    "color": "{{appColors.current.background.surface}}",
                                    "border": {
                                      "color": "{{appColors.current.input.borderEnabled}}",
                                      "width": 1.0
                                    },
                                    "borderRadius": {
                                      "topLeft": 11.0,
                                      "topRight": 11.0,
                                      "bottomLeft": 11.0,
                                      "bottomRight": 11.0
                                    }
                                  },
                                  "child": {
                                    "crossAxisAlignment": "start",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "child": {
                                          "data": "Û±Û±Û°.Û·Û¹Û±.Û±Û·Û¹Û³Û¸ÛµÛ¸.Û±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 17.0,
                                            "fontWeight": "w700"
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
                                          "data": "Ø­Ø³Ø§Ø¨ Ù‚Ø±Ø¶ Ø§Ù„Ø­Ø³Ù†Ù‡ Ø¬Ø§Ø±ÛŒ Ø­Ù‚ÛŒÙ‚ÛŒ ØªÙˆØ¨Ø§Ù†Ú©",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w500",
                                            "height": 1.4
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
                                  "actionType": "sequence",
                                  "actions": [
                                    {
                                      "actionType": "setValue",
                                      "values": [
                                        {
                                          "key": "transferApiInBankAccountInput",
                                          "value": "Û±Û±Û°.Û·Û¹Û±.Û±Û·Û¹Û³Û¸ÛµÛ¸.Û±"
                                        },
                                        {
                                          "key": "transferApiDestinationIban",
                                          "value": "Û±Û±Û°.Û·Û¹Û±.Û±Û·Û¹Û³Û¸ÛµÛ¸.Û±"
                                        },
                                        {
                                          "key": "transferApiDestinationName",
                                          "value": "Ø­Ø³Ø§Ø¨ Ù‚Ø±Ø¶ Ø§Ù„Ø­Ø³Ù†Ù‡ Ø¬Ø§Ø±ÛŒ Ø­Ù‚ÛŒÙ‚ÛŒ ØªÙˆØ¨Ø§Ù†Ú©"
                                        }
                                      ]
                                    },
                                    {
                                      "actionType": "setTransferInBankContinueEnabled",
                                      "fieldId": "transferApiInBankAccountInput",
                                      "rawValueKey": "transferApiInBankAccountRaw",
                                      "continueEnabledKey": "transferApiContinueEnabled",
                                      "hasTextKey": "transferApiInBankHasText",
                                      "destinationIbanKey": "transferApiDestinationIban",
                                      "minLengthExclusive": 15,
                                      "maxLength": 18
                                    }
                                  ]
                                },
                                "type": "gestureDetector"
                              }
                            ],
                            "type": "column"
                          },
                          "replacement": {
                            "crossAxisAlignment": "stretch",
                            "children": [
                              {
                                "child": {
                                  "padding": {
                                    "left": 14.0,
                                    "top": 18.0,
                                    "right": 14.0,
                                    "bottom": 18.0
                                  },
                                  "decoration": {
                                    "color": "{{appColors.current.background.surface}}",
                                    "border": {
                                      "color": "{{appColors.current.input.borderEnabled}}",
                                      "width": 1.0
                                    },
                                    "borderRadius": {
                                      "topLeft": 11.0,
                                      "topRight": 11.0,
                                      "bottomLeft": 11.0,
                                      "bottomRight": 11.0
                                    }
                                  },
                                  "child": {
                                    "crossAxisAlignment": "start",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "child": {
                                          "data": "Û±Û±Û°.Û¹Û¹Û¹Û³.Û·Û¶Û³Û´Û°ÛµÛ°.Û±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 17.0,
                                            "fontWeight": "w700"
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
                                          "data": "Ø¹Ù„ÛŒØ±Ø¶Ø§ Ø­ÛŒØ¯Ø±ÛŒØ§Ù†",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w500",
                                            "height": 1.4
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
                                  "actionType": "sequence",
                                  "actions": [
                                    {
                                      "actionType": "setValue",
                                      "values": [
                                        {
                                          "key": "transferApiInBankAccountInput",
                                          "value": "Û±Û±Û°.Û¹Û¹Û¹Û³.Û·Û¶Û³Û´Û°ÛµÛ°.Û±"
                                        },
                                        {
                                          "key": "transferApiDestinationIban",
                                          "value": "Û±Û±Û°.Û¹Û¹Û¹Û³.Û·Û¶Û³Û´Û°ÛµÛ°.Û±"
                                        },
                                        {
                                          "key": "transferApiDestinationName",
                                          "value": "Ø¹Ù„ÛŒØ±Ø¶Ø§ Ø­ÛŒØ¯Ø±ÛŒØ§Ù†"
                                        }
                                      ]
                                    },
                                    {
                                      "actionType": "setTransferInBankContinueEnabled",
                                      "fieldId": "transferApiInBankAccountInput",
                                      "rawValueKey": "transferApiInBankAccountRaw",
                                      "continueEnabledKey": "transferApiContinueEnabled",
                                      "hasTextKey": "transferApiInBankHasText",
                                      "destinationIbanKey": "transferApiDestinationIban",
                                      "minLengthExclusive": 15,
                                      "maxLength": 18
                                    }
                                  ]
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
                                    "left": 14.0,
                                    "top": 18.0,
                                    "right": 14.0,
                                    "bottom": 18.0
                                  },
                                  "decoration": {
                                    "color": "{{appColors.current.background.surface}}",
                                    "border": {
                                      "color": "{{appColors.current.input.borderEnabled}}",
                                      "width": 1.0
                                    },
                                    "borderRadius": {
                                      "topLeft": 11.0,
                                      "topRight": 11.0,
                                      "bottomLeft": 11.0,
                                      "bottomRight": 11.0
                                    }
                                  },
                                  "child": {
                                    "crossAxisAlignment": "start",
                                    "textDirection": "rtl",
                                    "children": [
                                      {
                                        "child": {
                                          "data": "Û±Û±Û°.Û¹Û¹Û¹Û².Û±Û·Û¹Û´Û¸Û¸Ûµ.Û±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 17.0,
                                            "fontWeight": "w700"
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
                                          "data": "Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯ Ù¾ÙˆØ±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 16.0,
                                            "fontWeight": "w500",
                                            "height": 1.4
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
                                  "actionType": "sequence",
                                  "actions": [
                                    {
                                      "actionType": "setValue",
                                      "values": [
                                        {
                                          "key": "transferApiInBankAccountInput",
                                          "value": "Û±Û±Û°.Û¹Û¹Û¹Û².Û±Û·Û¹Û´Û¸Û¸Ûµ.Û±"
                                        },
                                        {
                                          "key": "transferApiDestinationIban",
                                          "value": "Û±Û±Û°.Û¹Û¹Û¹Û².Û±Û·Û¹Û´Û¸Û¸Ûµ.Û±"
                                        },
                                        {
                                          "key": "transferApiDestinationName",
                                          "value": "Ù…Ù‡Ø¯ÛŒ Ø¬Ù…Ø´ÛŒØ¯ Ù¾ÙˆØ±"
                                        }
                                      ]
                                    },
                                    {
                                      "actionType": "setTransferInBankContinueEnabled",
                                      "fieldId": "transferApiInBankAccountInput",
                                      "rawValueKey": "transferApiInBankAccountRaw",
                                      "continueEnabledKey": "transferApiContinueEnabled",
                                      "hasTextKey": "transferApiInBankHasText",
                                      "destinationIbanKey": "transferApiDestinationIban",
                                      "minLengthExclusive": 15,
                                      "maxLength": 18
                                    }
                                  ]
                                },
                                "type": "gestureDetector"
                              }
                            ],
                            "type": "column"
                          }
                        },
                        "type": "singleChildScrollView"
                      },
                      "type": "expanded"
                    }
                  ],
                  "type": "column"
                },
                "replacement": {
                  "type": "visibility",
                  "visible": "[[transferApiTabCard]]",
                  "child": {
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "type": "visibility",
                          "visible": "[[transferApiCardVisible1]]",
                          "child": {
                            "child": {
                              "padding": {
                                "left": 14.0,
                                "top": 16.0,
                                "right": 14.0,
                                "bottom": 16.0
                              },
                              "decoration": {
                                "color": "{{appColors.current.background.surface}}",
                                "border": {
                                  "color": "{{appColors.current.input.borderEnabled}}",
                                  "width": 1.0
                                },
                                "borderRadius": {
                                  "topLeft": 11.0,
                                  "topRight": 11.0,
                                  "bottomLeft": 11.0,
                                  "bottomRight": 11.0
                                }
                              },
                              "child": {
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "src": "assets/icons/ic_gardeshgari.svg",
                                    "imageType": "asset",
                                    "width": 26.0,
                                    "height": 26.0,
                                    "type": "image"
                                  },
                                  {
                                    "width": 12.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "child": {
                                      "crossAxisAlignment": "stretch",
                                      "children": [
                                        {
                                          "data": "ÛµÛ°ÛµÛ´ Û±Û¶Û±Û° Û±Û¸Û±Û¶ Û¸Û°ÛµÛ¸",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 17.0,
                                            "fontWeight": "w700"
                                          },
                                          "textAlign": "right",
                                          "textDirection": "ltr",
                                          "type": "text"
                                        },
                                        {
                                          "height": 6.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "Ø³ÛŒØ¯Ø¹Ù„ÛŒØ±Ø¶Ø§ Ù†Ø¹Ù…ØªÛŒ Ø´ÛŒÙ„ Ø³Ø±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 15.0,
                                            "fontWeight": "w500"
                                          },
                                          "textAlign": "right",
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
                              "actionType": "sequence",
                              "actions": [
                                {
                                  "actionType": "setValue",
                                  "values": [
                                    {
                                      "key": "transferApiCardInput",
                                      "value": "5054161018168058"
                                    },
                                    {
                                      "key": "transferApiCardHasText",
                                      "value": true
                                    },
                                    {
                                      "key": "transferApiDestinationIban",
                                      "value": "5054161018168058"
                                    },
                                    {
                                      "key": "transferApiCardDestinationNumber",
                                      "value": "ÛµÛ°ÛµÛ´ Û±Û¶Û±Û° Û±Û¸Û±Û¶ Û¸Û°ÛµÛ¸"
                                    },
                                    {
                                      "key": "transferApiCardDestinationName",
                                      "value": "Ø³ÛŒØ¯Ø¹Ù„ÛŒØ±Ø¶Ø§ Ù†Ø¹Ù…ØªÛŒ Ø´ÛŒÙ„ Ø³Ø±"
                                    },
                                    {
                                      "key": "transferApiCardDestinationIcon",
                                      "value": "assets/icons/ic_gardeshgari.svg"
                                    }
                                  ]
                                },
                                {
                                  "actionType": "filterTransferIbanList",
                                  "fieldId": "transferApiCardInput",
                                  "ibanValues": [
                                    "5054161018168058",
                                    "5054161702844691",
                                    "5054161702994710",
                                    "5022913100939467",
                                    "5041771080766026"
                                  ],
                                  "visibleKeys": [
                                    "transferApiCardVisible1",
                                    "transferApiCardVisible2",
                                    "transferApiCardVisible3",
                                    "transferApiCardVisible4",
                                    "transferApiCardVisible5"
                                  ],
                                  "isSearchingKey": "transferApiCardHasText"
                                },
                                {
                                  "routeName": "transfer_real_card_details",
                                  "navigationStyle": "push",
                                  "actionType": "navigate"
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          },
                          "replacement": {
                            "type": "sizedBox"
                          }
                        },
                        {
                          "height": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "type": "visibility",
                          "visible": "[[transferApiCardVisible2]]",
                          "child": {
                            "child": {
                              "padding": {
                                "left": 14.0,
                                "top": 16.0,
                                "right": 14.0,
                                "bottom": 16.0
                              },
                              "decoration": {
                                "color": "{{appColors.current.background.surface}}",
                                "border": {
                                  "color": "{{appColors.current.input.borderEnabled}}",
                                  "width": 1.0
                                },
                                "borderRadius": {
                                  "topLeft": 11.0,
                                  "topRight": 11.0,
                                  "bottomLeft": 11.0,
                                  "bottomRight": 11.0
                                }
                              },
                              "child": {
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "src": "assets/icons/ic_gardeshgari.svg",
                                    "imageType": "asset",
                                    "width": 26.0,
                                    "height": 26.0,
                                    "type": "image"
                                  },
                                  {
                                    "width": 12.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "child": {
                                      "crossAxisAlignment": "stretch",
                                      "children": [
                                        {
                                          "data": "ÛµÛ°ÛµÛ´ Û±Û¶Û±Û· Û°Û²Û¸Û´ Û´Û¶Û¹Û±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 17.0,
                                            "fontWeight": "w700"
                                          },
                                          "textAlign": "right",
                                          "textDirection": "ltr",
                                          "type": "text"
                                        },
                                        {
                                          "height": 6.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "Ø¹Ù„ÛŒ Ø³ÛŒÙ†Ø§ÛŒÛŒ Ø§ØµÙ„",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 15.0,
                                            "fontWeight": "w500"
                                          },
                                          "textAlign": "right",
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
                              "actionType": "sequence",
                              "actions": [
                                {
                                  "actionType": "setValue",
                                  "values": [
                                    {
                                      "key": "transferApiCardInput",
                                      "value": "5054161702844691"
                                    },
                                    {
                                      "key": "transferApiCardHasText",
                                      "value": true
                                    },
                                    {
                                      "key": "transferApiDestinationIban",
                                      "value": "5054161702844691"
                                    },
                                    {
                                      "key": "transferApiCardDestinationNumber",
                                      "value": "ÛµÛ°ÛµÛ´ Û±Û¶Û±Û· Û°Û²Û¸Û´ Û´Û¶Û¹Û±"
                                    },
                                    {
                                      "key": "transferApiCardDestinationName",
                                      "value": "Ø¹Ù„ÛŒ Ø³ÛŒÙ†Ø§ÛŒÛŒ Ø§ØµÙ„"
                                    },
                                    {
                                      "key": "transferApiCardDestinationIcon",
                                      "value": "assets/icons/ic_gardeshgari.svg"
                                    }
                                  ]
                                },
                                {
                                  "actionType": "filterTransferIbanList",
                                  "fieldId": "transferApiCardInput",
                                  "ibanValues": [
                                    "5054161018168058",
                                    "5054161702844691",
                                    "5054161702994710",
                                    "5022913100939467",
                                    "5041771080766026"
                                  ],
                                  "visibleKeys": [
                                    "transferApiCardVisible1",
                                    "transferApiCardVisible2",
                                    "transferApiCardVisible3",
                                    "transferApiCardVisible4",
                                    "transferApiCardVisible5"
                                  ],
                                  "isSearchingKey": "transferApiCardHasText"
                                },
                                {
                                  "routeName": "transfer_real_card_details",
                                  "navigationStyle": "push",
                                  "actionType": "navigate"
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          },
                          "replacement": {
                            "type": "sizedBox"
                          }
                        },
                        {
                          "height": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "type": "visibility",
                          "visible": "[[transferApiCardVisible3]]",
                          "child": {
                            "child": {
                              "padding": {
                                "left": 14.0,
                                "top": 16.0,
                                "right": 14.0,
                                "bottom": 16.0
                              },
                              "decoration": {
                                "color": "{{appColors.current.background.surface}}",
                                "border": {
                                  "color": "{{appColors.current.input.borderEnabled}}",
                                  "width": 1.0
                                },
                                "borderRadius": {
                                  "topLeft": 11.0,
                                  "topRight": 11.0,
                                  "bottomLeft": 11.0,
                                  "bottomRight": 11.0
                                }
                              },
                              "child": {
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "src": "assets/icons/ic_gardeshgari.svg",
                                    "imageType": "asset",
                                    "width": 26.0,
                                    "height": 26.0,
                                    "type": "image"
                                  },
                                  {
                                    "width": 12.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "child": {
                                      "crossAxisAlignment": "stretch",
                                      "children": [
                                        {
                                          "data": "ÛµÛ°ÛµÛ´ Û±Û¶Û±Û· Û°Û²Û¹Û¹ Û´Û·Û±Û°",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 17.0,
                                            "fontWeight": "w700"
                                          },
                                          "textAlign": "right",
                                          "textDirection": "ltr",
                                          "type": "text"
                                        },
                                        {
                                          "height": 6.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ - Ø´Ø¹Ø¨Ù‡ Ù…Ø¬Ø§Ø²ÛŒ",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 15.0,
                                            "fontWeight": "w500"
                                          },
                                          "textAlign": "right",
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
                              "actionType": "sequence",
                              "actions": [
                                {
                                  "actionType": "setValue",
                                  "values": [
                                    {
                                      "key": "transferApiCardInput",
                                      "value": "5054161702994710"
                                    },
                                    {
                                      "key": "transferApiCardHasText",
                                      "value": true
                                    },
                                    {
                                      "key": "transferApiDestinationIban",
                                      "value": "5054161702994710"
                                    },
                                    {
                                      "key": "transferApiCardDestinationNumber",
                                      "value": "ÛµÛ°ÛµÛ´ Û±Û¶Û±Û· Û°Û²Û¹Û¹ Û´Û·Û±Û°"
                                    },
                                    {
                                      "key": "transferApiCardDestinationName",
                                      "value": "Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ - Ø´Ø¹Ø¨Ù‡ Ù…Ø¬Ø§Ø²ÛŒ"
                                    },
                                    {
                                      "key": "transferApiCardDestinationIcon",
                                      "value": "assets/icons/ic_gardeshgari.svg"
                                    }
                                  ]
                                },
                                {
                                  "actionType": "filterTransferIbanList",
                                  "fieldId": "transferApiCardInput",
                                  "ibanValues": [
                                    "5054161018168058",
                                    "5054161702844691",
                                    "5054161702994710",
                                    "5022913100939467",
                                    "5041771080766026"
                                  ],
                                  "visibleKeys": [
                                    "transferApiCardVisible1",
                                    "transferApiCardVisible2",
                                    "transferApiCardVisible3",
                                    "transferApiCardVisible4",
                                    "transferApiCardVisible5"
                                  ],
                                  "isSearchingKey": "transferApiCardHasText"
                                },
                                {
                                  "routeName": "transfer_real_card_details",
                                  "navigationStyle": "push",
                                  "actionType": "navigate"
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          },
                          "replacement": {
                            "type": "sizedBox"
                          }
                        },
                        {
                          "height": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "type": "visibility",
                          "visible": "[[transferApiCardVisible4]]",
                          "child": {
                            "child": {
                              "padding": {
                                "left": 14.0,
                                "top": 16.0,
                                "right": 14.0,
                                "bottom": 16.0
                              },
                              "decoration": {
                                "color": "{{appColors.current.background.surface}}",
                                "border": {
                                  "color": "{{appColors.current.input.borderEnabled}}",
                                  "width": 1.0
                                },
                                "borderRadius": {
                                  "topLeft": 11.0,
                                  "topRight": 11.0,
                                  "bottomLeft": 11.0,
                                  "bottomRight": 11.0
                                }
                              },
                              "child": {
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "src": "assets/icons/ic_iranconcert_dark.svg",
                                    "imageType": "asset",
                                    "width": 26.0,
                                    "height": 26.0,
                                    "type": "image"
                                  },
                                  {
                                    "width": 12.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "child": {
                                      "crossAxisAlignment": "stretch",
                                      "children": [
                                        {
                                          "data": "ÛµÛ°Û²Û² Û¹Û±Û³Û± Û°Û°Û¹Û³ Û¹Û´Û¶Û·",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 17.0,
                                            "fontWeight": "w700"
                                          },
                                          "textAlign": "right",
                                          "textDirection": "ltr",
                                          "type": "text"
                                        },
                                        {
                                          "height": 6.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "Ù†Ø¯Ø§ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 15.0,
                                            "fontWeight": "w500"
                                          },
                                          "textAlign": "right",
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
                              "actionType": "sequence",
                              "actions": [
                                {
                                  "actionType": "setValue",
                                  "values": [
                                    {
                                      "key": "transferApiCardInput",
                                      "value": "5022913100939467"
                                    },
                                    {
                                      "key": "transferApiCardHasText",
                                      "value": true
                                    },
                                    {
                                      "key": "transferApiDestinationIban",
                                      "value": "5022913100939467"
                                    },
                                    {
                                      "key": "transferApiCardDestinationNumber",
                                      "value": "ÛµÛ°Û²Û² Û¹Û±Û³Û± Û°Û°Û¹Û³ Û¹Û´Û¶Û·"
                                    },
                                    {
                                      "key": "transferApiCardDestinationName",
                                      "value": "Ù†Ø¯Ø§ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±"
                                    },
                                    {
                                      "key": "transferApiCardDestinationIcon",
                                      "value": "assets/icons/ic_iranconcert_dark.svg"
                                    }
                                  ]
                                },
                                {
                                  "actionType": "filterTransferIbanList",
                                  "fieldId": "transferApiCardInput",
                                  "ibanValues": [
                                    "5054161018168058",
                                    "5054161702844691",
                                    "5054161702994710",
                                    "5022913100939467",
                                    "5041771080766026"
                                  ],
                                  "visibleKeys": [
                                    "transferApiCardVisible1",
                                    "transferApiCardVisible2",
                                    "transferApiCardVisible3",
                                    "transferApiCardVisible4",
                                    "transferApiCardVisible5"
                                  ],
                                  "isSearchingKey": "transferApiCardHasText"
                                },
                                {
                                  "routeName": "transfer_real_card_details",
                                  "navigationStyle": "push",
                                  "actionType": "navigate"
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          },
                          "replacement": {
                            "type": "sizedBox"
                          }
                        },
                        {
                          "height": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "type": "visibility",
                          "visible": "[[transferApiCardVisible5]]",
                          "child": {
                            "child": {
                              "padding": {
                                "left": 14.0,
                                "top": 16.0,
                                "right": 14.0,
                                "bottom": 16.0
                              },
                              "decoration": {
                                "color": "{{appColors.current.background.surface}}",
                                "border": {
                                  "color": "{{appColors.current.input.borderEnabled}}",
                                  "width": 1.0
                                },
                                "borderRadius": {
                                  "topLeft": 11.0,
                                  "topRight": 11.0,
                                  "bottomLeft": 11.0,
                                  "bottomRight": 11.0
                                }
                              },
                              "child": {
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "src": "assets/icons/ic_in.svg",
                                    "imageType": "asset",
                                    "width": 26.0,
                                    "height": 26.0,
                                    "type": "image"
                                  },
                                  {
                                    "width": 12.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "child": {
                                      "crossAxisAlignment": "stretch",
                                      "children": [
                                        {
                                          "data": "ÛµÛ°Û´Û± Û·Û·Û±Û° Û¸Û°Û·Û¶ Û¶Û°Û²Û¶",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.title}}",
                                            "fontSize": 17.0,
                                            "fontWeight": "w700"
                                          },
                                          "textAlign": "right",
                                          "textDirection": "ltr",
                                          "type": "text"
                                        },
                                        {
                                          "height": 6.0,
                                          "type": "sizedBox"
                                        },
                                        {
                                          "data": "Ø³Ø¬Ø§Ø¯ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±",
                                          "style": {
                                            "type": "custom",
                                            "color": "{{appColors.current.text.subtitle}}",
                                            "fontSize": 15.0,
                                            "fontWeight": "w500"
                                          },
                                          "textAlign": "right",
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
                              "actionType": "sequence",
                              "actions": [
                                {
                                  "actionType": "setValue",
                                  "values": [
                                    {
                                      "key": "transferApiCardInput",
                                      "value": "5041771080766026"
                                    },
                                    {
                                      "key": "transferApiCardHasText",
                                      "value": true
                                    },
                                    {
                                      "key": "transferApiDestinationIban",
                                      "value": "5041771080766026"
                                    },
                                    {
                                      "key": "transferApiCardDestinationNumber",
                                      "value": "ÛµÛ°Û´Û± Û·Û·Û±Û° Û¸Û°Û·Û¶ Û¶Û°Û²Û¶"
                                    },
                                    {
                                      "key": "transferApiCardDestinationName",
                                      "value": "Ø³Ø¬Ø§Ø¯ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±"
                                    },
                                    {
                                      "key": "transferApiCardDestinationIcon",
                                      "value": "assets/icons/ic_in.svg"
                                    }
                                  ]
                                },
                                {
                                  "actionType": "filterTransferIbanList",
                                  "fieldId": "transferApiCardInput",
                                  "ibanValues": [
                                    "5054161018168058",
                                    "5054161702844691",
                                    "5054161702994710",
                                    "5022913100939467",
                                    "5041771080766026"
                                  ],
                                  "visibleKeys": [
                                    "transferApiCardVisible1",
                                    "transferApiCardVisible2",
                                    "transferApiCardVisible3",
                                    "transferApiCardVisible4",
                                    "transferApiCardVisible5"
                                  ],
                                  "isSearchingKey": "transferApiCardHasText"
                                },
                                {
                                  "routeName": "transfer_real_card_details",
                                  "navigationStyle": "push",
                                  "actionType": "navigate"
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          },
                          "replacement": {
                            "type": "sizedBox"
                          }
                        }
                      ],
                      "type": "column"
                    },
                    "type": "singleChildScrollView"
                  },
                  "replacement": {
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
                      "child": {
                        "data": "Ø§ÛŒÙ† Ø¨Ø®Ø´ Ø¯Ø± Ø­Ø§Ù„ ØªÚ©Ù…ÛŒÙ„ Ø§Ø³Øª",
                        "style": {
                          "type": "custom",
                          "color": "{{appColors.current.text.subtitle}}",
                          "fontSize": 14.0,
                          "fontWeight": "w500"
                        },
                        "textDirection": "rtl",
                        "type": "text"
                      },
                      "type": "center"
                    },
                    "type": "container"
                  }
                }
              }
            },
            "type": "expanded"
          },
          {
            "height": 12.0,
            "type": "sizedBox"
          },
          {
            "type": "visibility",
            "visible": "[[transferApiTabCard]]",
            "child": {
              "type": "visibility",
              "visible": "[[transferApiCardHasText]]",
              "child": {
                "onPressed": {
                  "actionType": "sequence",
                  "actions": [
                    {
                      "actionType": "setValue",
                      "values": [
                        {
                          "key": "transferApiCardDestinationNumber",
                          "value": {
                            "actionType": "getFormValue",
                            "id": "transferApiCardInput"
                          }
                        },
                        {
                          "key": "transferApiCardDestinationName",
                          "value": "Ú©Ø§Ø±Øª Ù…Ù‚ØµØ¯"
                        },
                        {
                          "key": "transferApiCardDestinationIcon",
                          "value": "assets/icons/ic_gardeshgari.svg"
                        }
                      ]
                    },
                    {
                      "actionType": "validateTransferCardContinue",
                      "fieldId": "transferApiCardInput",
                      "requiredLength": 16,
                      "destinationCardKey": "transferApiDestinationIban",
                      "destinationDisplayNumberKey": "transferApiCardDestinationNumber",
                      "destinationNameKey": "transferApiCardDestinationName",
                      "destinationIconKey": "transferApiCardDestinationIcon",
                      "cardValues": [
                        "5054161018168058",
                        "5054161702844691",
                        "5054161702994710",
                        "5022913100939467",
                        "5041771080766026"
                      ],
                      "cardDisplayValues": [
                        "ÛµÛ°ÛµÛ´ Û±Û¶Û±Û° Û±Û¸Û±Û¶ Û¸Û°ÛµÛ¸",
                        "ÛµÛ°ÛµÛ´ Û±Û¶Û±Û· Û°Û²Û¸Û´ Û´Û¶Û¹Û±",
                        "ÛµÛ°ÛµÛ´ Û±Û¶Û±Û· Û°Û²Û¹Û¹ Û´Û·Û±Û°",
                        "ÛµÛ°Û²Û² Û¹Û±Û³Û± Û°Û°Û¹Û³ Û¹Û´Û¶Û·",
                        "ÛµÛ°Û´Û± Û·Û·Û±Û° Û¸Û°Û·Û¶ Û¶Û°Û²Û¶"
                      ],
                      "cardNames": [
                        "Ø³ÛŒØ¯Ø¹Ù„ÛŒØ±Ø¶Ø§ Ù†Ø¹Ù…ØªÛŒ Ø´ÛŒÙ„ Ø³Ø±",
                        "Ø¹Ù„ÛŒ Ø³ÛŒÙ†Ø§ÛŒÛŒ Ø§ØµÙ„",
                        "Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ - Ø´Ø¹Ø¨Ù‡ Ù…Ø¬Ø§Ø²ÛŒ",
                        "Ù†Ø¯Ø§ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±",
                        "Ø³Ø¬Ø§Ø¯ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±"
                      ],
                      "cardIcons": [
                        "assets/icons/ic_gardeshgari.svg",
                        "assets/icons/ic_gardeshgari.svg",
                        "assets/icons/ic_gardeshgari.svg",
                        "assets/icons/ic_iranconcert_dark.svg",
                        "assets/icons/ic_in.svg"
                      ],
                      "validAction": {
                        "routeName": "transfer_real_card_details",
                        "navigationStyle": "push",
                        "actionType": "navigate"
                      },
                      "invalidAction": {
                        "actionType": "customSnackBar",
                        "message": "Ø´Ù…Ø§Ø±Ù‡ Ú©Ø§Ø±Øª Ù…Ù‚ØµØ¯ Ø¨Ø§ÛŒØ¯ Û±Û¶ Ø±Ù‚Ù… Ø¨Ø§Ø´Ø¯.",
                        "backgroundColor": "#D32F2F",
                        "duration": 2600
                      }
                    }
                  ]
                },
                "style": {
                  "foregroundColor": "{{appColors.current.text.onPrimary}}",
                  "backgroundColor": "{{appColors.current.primary.color}}",
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 57.0
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
                  "data": "Ø§Ø¯Ø§Ù…Ù‡",
                  "style": {
                    "type": "custom",
                    "color": "{{appColors.current.text.onPrimary}}",
                    "fontSize": 19.0,
                    "fontWeight": "w700"
                  },
                  "textDirection": "rtl",
                  "type": "text"
                },
                "type": "filledButton"
              },
              "replacement": {
                "onPressed": {
                  "actionType": "showTransferCardScanner",
                  "fieldId": "transferApiCardInput",
                  "successAction": {
                    "actionType": "filterTransferIbanList",
                    "fieldId": "transferApiCardInput",
                    "ibanValues": [
                      "5054161018168058",
                      "5054161702844691",
                      "5054161702994710",
                      "5022913100939467",
                      "5041771080766026"
                    ],
                    "visibleKeys": [
                      "transferApiCardVisible1",
                      "transferApiCardVisible2",
                      "transferApiCardVisible3",
                      "transferApiCardVisible4",
                      "transferApiCardVisible5"
                    ],
                    "isSearchingKey": "transferApiCardHasText"
                  },
                  "failedAction": {
                    "actionType": "customSnackBar",
                    "message": "Ø§Ø³Ú©Ù† Ú©Ø§Ø±Øª Ù†Ø§Ù…ÙˆÙÙ‚ Ø¨ÙˆØ¯.",
                    "backgroundColor": "#D32F2F",
                    "duration": 2600
                  }
                },
                "style": {
                  "foregroundColor": "{{appColors.current.text.title}}",
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 57.0
                  },
                  "side": {
                    "color": "{{appColors.current.text.title}}"
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
                  "mainAxisAlignment": "center",
                  "children": [
                    {
                      "data": "Ø§Ø³Ú©Ù† Ú©Ø§Ø±Øª",
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
                      "width": 10.0,
                      "type": "sizedBox"
                    },
                    {
                      "src": "assets/icons/ic_card_default.svg",
                      "imageType": "asset",
                      "color": "{{appColors.current.text.title}}",
                      "width": 24.0,
                      "height": 24.0,
                      "type": "image"
                    }
                  ],
                  "type": "row"
                },
                "type": "outlinedButton"
              }
            },
            "replacement": {
              "type": "visibility",
              "visible": "[[transferApiTabIban]]",
              "child": {
                "type": "reactiveElevatedButton",
                "enabledKey": "transferApiContinueEnabled",
                "onPressed": {
                  "actionType": "sequence",
                  "actions": [
                    {
                      "actionType": "setTransferDestinationFromIban",
                      "fieldId": "transferApiIbanInput",
                      "ibanValues": [
                        "830700001000117894304001",
                        "490100000000340340070004",
                        "980640011070075034070001",
                        "240750005151124000000156",
                        "860130100000003318427752"
                      ],
                      "destinationNames": [
                        "Ø³Ø¬Ø§Ø¯ Ø±Ø­Ù…Ø§Ù†ÛŒ Ù¾ÙˆØ±",
                        "Ù…ÛŒÙ†Ø§ Ø¹Ø§Ø´ÙˆØ±ÛŒ",
                        "Ù…Ø­Ø³Ù† Ù…Ù‚Ø¯Ù…",
                        "ÛŒÚ©Ø§Ù†Ù‡ Ø³Ø§Ø¯Ø§Øª ØªØ±Ø§Ø¨ÛŒ Ø®Ø±Ù‚",
                        "Ø³ÛŒØ¯ Ù¾Ø§Ø±Ø³Ø§ Ø¨Ù†ÛŒ Ø·Ø¨Ø§"
                      ],
                      "destinationIbanKey": "transferApiDestinationIban",
                      "destinationNameKey": "transferApiDestinationName"
                    },
                    {
                      "actionType": "setValue",
                      "key": "transferApiTransferTypeTitle",
                      "value": ""
                    },
                    {
                      "routeName": "transfer_real_details",
                      "navigationStyle": "push",
                      "actionType": "navigate"
                    }
                  ]
                },
                "style": {
                  "foregroundColor": "{{appColors.current.button.primary.foregroundColor}}",
                  "backgroundColor": "{{appColors.current.button.primary.backgroundColor}}",
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 57.0
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
                "disabledStyle": {
                  "foregroundColor": "{{appColors.current.text.hint}}",
                  "backgroundColor": "{{appColors.current.background.surfaceContainerHigh}}",
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 57.0
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
                    "color": "{{appColors.current.button.primary.foregroundColor}}",
                    "fontSize": 18.0,
                    "fontWeight": "w700"
                  },
                  "type": "text"
                }
              },
              "replacement": {
                "type": "reactiveElevatedButton",
                "enabledKey": "transferApiContinueEnabled",
                "onPressed": {
                  "actionType": "sequence",
                  "actions": [
                    {
                      "actionType": "setValue",
                      "key": "transferApiTransferTypeTitle",
                      "value": "Ø¯Ø±ÙˆÙ† Ø¨Ø§Ù†Ú©ÛŒ"
                    },
                    {
                      "routeName": "transfer_real_in_bank_details",
                      "navigationStyle": "push",
                      "actionType": "navigate"
                    }
                  ]
                },
                "style": {
                  "foregroundColor": "{{appColors.current.button.primary.foregroundColor}}",
                  "backgroundColor": "{{appColors.current.button.primary.backgroundColor}}",
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 57.0
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
                "disabledStyle": {
                  "foregroundColor": "{{appColors.current.text.hint}}",
                  "backgroundColor": "{{appColors.current.background.surfaceContainerHigh}}",
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 57.0
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
                    "color": "{{appColors.current.button.primary.foregroundColor}}",
                    "fontSize": 18.0,
                    "fontWeight": "w700"
                  },
                  "type": "text"
                }
              }
            }
          }
        ],
        "type": "column"
      },
      "type": "padding"
    },
    "type": "scaffold"
  }
}
```
