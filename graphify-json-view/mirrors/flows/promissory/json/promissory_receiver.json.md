# flows/promissory/json/promissory_receiver.json

Source: lib/stac/tobank/flows/promissory/json/promissory_receiver.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "type": "stateFull",
  "onInit": {
    "actions": [
      {
        "actionType": "setValue",
        "key": "isIndividualSelected",
        "value": true
      },
      {
        "actionType": "setValue",
        "key": "isLegalSelected",
        "value": false
      },
      {
        "actionType": "setValue",
        "key": "isReceiverFormValid",
        "value": false
      }
    ],
    "sync": false,
    "actionType": "multiAction"
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
        "data": "Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ø°ÛŒÙ†ÙØ¹ JSON",
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
      "autovalidateMode": "onUserInteraction",
      "child": {
        "crossAxisAlignment": "stretch",
        "children": [
          {
            "child": {
              "padding": {
                "left": 16.0,
                "right": 16.0
              },
              "child": {
                "crossAxisAlignment": "stretch",
                "textDirection": "rtl",
                "children": [
                  {
                    "height": 16.0,
                    "type": "sizedBox"
                  },
                  {
                    "data": "Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ø°ÛŒÙ†ÙØ¹ (Ø¯Ø±ÛŒØ§ÙØªâ€ŒÚ©Ù†Ù†Ø¯Ù‡)",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.text.title}}",
                      "fontSize": 16.0,
                      "fontWeight": "w700"
                    },
                    "textDirection": "rtl",
                    "type": "text"
                  },
                  {
                    "height": 16.0,
                    "type": "sizedBox"
                  },
                  {
                    "textDirection": "rtl",
                    "children": [
                      {
                        "child": {
                          "child": {
                            "padding": {
                              "top": 12.0,
                              "bottom": 12.0
                            },
                            "decoration": {
                              "color": "{{isIndividualSelected ? appColors.current.primary.color : appColors.current.background.surfaceContainer}}",
                              "border": {
                                "color": "{{isIndividualSelected ? appColors.current.primary.color : appColors.current.input.borderEnabled}}",
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
                              "child": {
                                "data": "Ø­Ù‚ÛŒÙ‚ÛŒ",
                                "style": {
                                  "type": "custom",
                                  "color": "{{isIndividualSelected ? appColors.current.primary.onPrimary : appColors.current.text.title}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "center"
                            },
                            "type": "container"
                          },
                          "onTap": {
                            "actions": [
                              {
                                "actionType": "setValue",
                                "key": "isIndividualSelected",
                                "value": true
                              },
                              {
                                "actionType": "setValue",
                                "key": "isLegalSelected",
                                "value": false
                              }
                            ],
                            "sync": false,
                            "actionType": "multiAction"
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
                            "padding": {
                              "top": 12.0,
                              "bottom": 12.0
                            },
                            "decoration": {
                              "color": "{{isLegalSelected ? appColors.current.primary.color : appColors.current.background.surfaceContainer}}",
                              "border": {
                                "color": "{{isLegalSelected ? appColors.current.primary.color : appColors.current.input.borderEnabled}}",
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
                              "child": {
                                "data": "Ø­Ù‚ÙˆÙ‚ÛŒ",
                                "style": {
                                  "type": "custom",
                                  "color": "{{isLegalSelected ? appColors.current.primary.onPrimary : appColors.current.text.title}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "center"
                            },
                            "type": "container"
                          },
                          "onTap": {
                            "actions": [
                              {
                                "actionType": "setValue",
                                "key": "isLegalSelected",
                                "value": true
                              },
                              {
                                "actionType": "setValue",
                                "key": "isIndividualSelected",
                                "value": false
                              }
                            ],
                            "sync": false,
                            "actionType": "multiAction"
                          },
                          "type": "gestureDetector"
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
                    "data": "Ú©Ø¯ Ù…Ù„ÛŒ",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.text.title}}",
                      "fontSize": 14.0,
                      "fontWeight": "w600"
                    },
                    "textDirection": "rtl",
                    "type": "text"
                  },
                  {
                    "height": 8.0,
                    "type": "sizedBox"
                  },
                  {
                    "type": "textFormField",
                    "id": "receiver_national_code",
                    "textDirection": "rtl",
                    "textAlign": "right",
                    "maxLength": 10,
                    "inputFormatters": [
                      {
                        "type": "allow",
                        "rule": "[0-9]"
                      }
                    ],
                    "decoration": {
                      "hintText": "Ú©Ø¯ Ù…Ù„ÛŒ Ø°ÛŒÙ†ÙØ¹ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯",
                      "contentPadding": {
                        "left": 16.0,
                        "top": 16.0,
                        "right": 16.0,
                        "bottom": 16.0
                      },
                      "filled": false
                    },
                    "keyboardType": "number",
                    "textInputAction": "next",
                    "validatorRules": [
                      {
                        "rule": "^\\d{10}$",
                        "message": "Ú©Ø¯ Ù…Ù„ÛŒ Ù…Ø¹ØªØ¨Ø± ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯"
                      }
                    ],
                    "onChanged": {
                      "actionType": "validateFields",
                      "resultKey": "isReceiverFormValid",
                      "fields": [
                        {
                          "id": "receiver_national_code",
                          "rule": "^\\d{10}$"
                        },
                        {
                          "id": "receiver_mobile",
                          "rule": "^09\\d{9}$"
                        },
                        {
                          "id": "receiver_birthdate",
                          "rule": "^\\d{4}/\\d{2}/\\d{2}$"
                        }
                      ]
                    }
                  },
                  {
                    "height": 16.0,
                    "type": "sizedBox"
                  },
                  {
                    "data": "Ø´Ù…Ø§Ø±Ù‡ Ù‡Ù…Ø±Ø§Ù‡",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.text.title}}",
                      "fontSize": 14.0,
                      "fontWeight": "w600"
                    },
                    "textDirection": "rtl",
                    "type": "text"
                  },
                  {
                    "height": 8.0,
                    "type": "sizedBox"
                  },
                  {
                    "type": "textFormField",
                    "id": "receiver_mobile",
                    "textDirection": "rtl",
                    "textAlign": "right",
                    "maxLength": 11,
                    "inputFormatters": [
                      {
                        "type": "allow",
                        "rule": "[0-9]"
                      }
                    ],
                    "decoration": {
                      "hintText": "Ø´Ù…Ø§Ø±Ù‡ Ù‡Ù…Ø±Ø§Ù‡ Ø°ÛŒÙ†ÙØ¹ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯",
                      "contentPadding": {
                        "left": 16.0,
                        "top": 16.0,
                        "right": 16.0,
                        "bottom": 16.0
                      },
                      "filled": false
                    },
                    "keyboardType": "phone",
                    "textInputAction": "next",
                    "validatorRules": [
                      {
                        "rule": "^09\\d{9}$",
                        "message": "Ø´Ù…Ø§Ø±Ù‡ Ù‡Ù…Ø±Ø§Ù‡ Ù…Ø¹ØªØ¨Ø± ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯"
                      }
                    ],
                    "onChanged": {
                      "actionType": "validateFields",
                      "resultKey": "isReceiverFormValid",
                      "fields": [
                        {
                          "id": "receiver_national_code",
                          "rule": "^\\d{10}$"
                        },
                        {
                          "id": "receiver_mobile",
                          "rule": "^09\\d{9}$"
                        },
                        {
                          "id": "receiver_birthdate",
                          "rule": "^\\d{4}/\\d{2}/\\d{2}$"
                        }
                      ]
                    }
                  },
                  {
                    "height": 16.0,
                    "type": "sizedBox"
                  },
                  {
                    "data": "ØªØ§Ø±ÛŒØ® ØªÙˆÙ„Ø¯",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.text.title}}",
                      "fontSize": 14.0,
                      "fontWeight": "w600"
                    },
                    "textDirection": "rtl",
                    "type": "text"
                  },
                  {
                    "height": 8.0,
                    "type": "sizedBox"
                  },
                  {
                    "child": {
                      "id": "receiver_birthdate",
                      "decoration": {
                        "hintText": "ØªØ§Ø±ÛŒØ® ØªÙˆÙ„Ø¯ Ø°ÛŒÙ†ÙØ¹ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ù†Ù…Ø§ÛŒÛŒØ¯",
                        "hintStyle": {
                          "type": "custom",
                          "color": "{{appColors.current.text.subtitle}}",
                          "fontSize": 14.0,
                          "fontWeight": "w500"
                        },
                        "prefixIcon": {
                          "padding": {
                            "left": 8.0,
                            "top": 8.0,
                            "right": 8.0,
                            "bottom": 8.0
                          },
                          "child": {
                            "src": "assets/icons/ic_calendar.svg",
                            "imageType": "asset",
                            "color": "{{appColors.current.text.subtitle}}",
                            "width": 24.0,
                            "height": 24.0,
                            "fit": "scaleDown",
                            "type": "image"
                          },
                          "type": "padding"
                        },
                        "contentPadding": {
                          "left": 16.0,
                          "top": 16.0,
                          "right": 16.0,
                          "bottom": 16.0
                        },
                        "filled": false
                      },
                      "keyboardType": "text",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "readOnly": true,
                      "enabled": false,
                      "validatorRules": [
                        {
                          "rule": "^\\d{4}/\\d{2}/\\d{2}$",
                          "message": "ØªØ§Ø±ÛŒØ® ØªÙˆÙ„Ø¯ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ù†Ù…Ø§ÛŒÛŒØ¯"
                        }
                      ],
                      "type": "textFormField"
                    },
                    "onTap": {
                      "actionType": "persianDatePicker",
                      "formFieldId": "receiver_birthdate",
                      "firstDate": "1350/01/01",
                      "lastDate": "1450/12/29",
                      "onDateSelected": {
                        "actionType": "validateFields",
                        "resultKey": "isReceiverFormValid",
                        "fields": [
                          {
                            "id": "receiver_national_code",
                            "rule": "^\\d{10}$"
                          },
                          {
                            "id": "receiver_mobile",
                            "rule": "^09\\d{9}$"
                          },
                          {
                            "id": "receiver_birthdate",
                            "rule": "^\\d{4}/\\d{2}/\\d{2}$"
                          }
                        ]
                      }
                    },
                    "type": "gestureDetector"
                  },
                  {
                    "height": 40.0,
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
              "top": 16.0,
              "right": 16.0,
              "bottom": 16.0
            },
            "child": {
              "type": "reactiveElevatedButton",
              "enabledKey": "isReceiverFormValid",
              "onPressed": {
                "actionType": "navigate",
                "assetPath": "lib/stac/tobank/flows/promissory/json/promissory_data.json",
                "navigationStyle": "push"
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
              "child": {
                "data": "{{appStrings.common.continue}}",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.primary.onPrimary}}",
                  "fontSize": 18.0,
                  "fontWeight": "bold"
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
