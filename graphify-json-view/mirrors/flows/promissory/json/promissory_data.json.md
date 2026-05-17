# flows/promissory/json/promissory_data.json

Source: lib/stac/tobank/flows/promissory/json/promissory_data.json

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
        "key": "isDataFormValid",
        "value": false
      },
      {
        "actionType": "setValue",
        "key": "isOnDemand",
        "value": false
      },
      {
        "actionType": "setValue",
        "key": "isTransferable",
        "value": true
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
        "data": "Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ø³ÙØªÙ‡ JSON",
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
                "children": [
                  {
                    "height": 16.0,
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
                      "color": "{{appColors.current.background.surfaceContainer}}",
                      "border": {
                        "color": "{{appColors.current.input.borderEnabled}}",
                        "width": 0.5
                      },
                      "borderRadius": {
                        "topLeft": 8.0,
                        "topRight": 8.0,
                        "bottomLeft": 8.0,
                        "bottomRight": 8.0
                      }
                    },
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
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
                          "height": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "mainAxisAlignment": "spaceBetween",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "data": "Ú©Ø¯ Ù…Ù„ÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 14.0
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            {
                              "data": "{{form.receiver_national_code}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 14.0,
                                "fontWeight": "w600"
                              },
                              "textDirection": "ltr",
                              "type": "text"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "height": 8.0,
                          "type": "sizedBox"
                        },
                        {
                          "mainAxisAlignment": "spaceBetween",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "data": "Ø´Ù…Ø§Ø±Ù‡ Ù‡Ù…Ø±Ø§Ù‡",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 14.0
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            {
                              "data": "{{form.receiver_mobile}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 14.0,
                                "fontWeight": "w600"
                              },
                              "textDirection": "ltr",
                              "type": "text"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "height": 8.0,
                          "type": "sizedBox"
                        },
                        {
                          "mainAxisAlignment": "spaceBetween",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "data": "Ù†Ø§Ù… Ùˆ Ù†Ø§Ù… Ø®Ø§Ù†ÙˆØ§Ø¯Ú¯ÛŒ",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 14.0
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            {
                              "data": "{{receiverData.fullName}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 14.0,
                                "fontWeight": "w600"
                              },
                              "textDirection": "ltr",
                              "type": "text"
                            }
                          ],
                          "type": "row"
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
                        "width": 0.5
                      },
                      "borderRadius": {
                        "topLeft": 8.0,
                        "topRight": 8.0,
                        "bottomLeft": 8.0,
                        "bottomRight": 8.0
                      }
                    },
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ø³ÙØªÙ‡",
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
                          "mainAxisAlignment": "spaceBetween",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "data": "Ù…Ø¨Ù„Øº Ø³ÙØªÙ‡",
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
                              "data": "",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 12.0,
                                "fontWeight": "w400"
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "height": 8.0,
                          "type": "sizedBox"
                        },
                        {
                          "type": "textFormField",
                          "id": "promissory_amount",
                          "keyboardType": "number",
                          "textInputAction": "next",
                          "textDirection": "ltr",
                          "textAlign": "right",
                          "inputFormatters": [
                            {
                              "type": "allow",
                              "rule": "[0-9]"
                            }
                          ],
                          "decoration": {
                            "hintText": "Ù…Ø¨Ù„Øº Ø³ÙØªÙ‡ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯",
                            "suffixText": "{{appStrings.common.rial}}",
                            "contentPadding": {
                              "left": 16.0,
                              "top": 16.0,
                              "right": 16.0,
                              "bottom": 16.0
                            },
                            "filled": false
                          },
                          "validatorRules": [
                            {
                              "rule": "^\\d+$",
                              "message": "Ù…Ø¨Ù„Øº Ø³ÙØªÙ‡ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯"
                            }
                          ],
                          "onChanged": {
                            "actionType": "validateFields",
                            "resultKey": "isDataFormValid",
                            "fields": [
                              {
                                "id": "promissory_amount",
                                "rule": "^\\d+$"
                              },
                              {
                                "id": "promissory_due_date",
                                "rule": "^\\d{4}/\\d{2}/\\d{2}$",
                                "optional": "isOnDemand"
                              },
                              {
                                "id": "promissory_payment_place",
                                "rule": "^.{1,200}$"
                              }
                            ]
                          }
                        },
                        {
                          "height": 16.0,
                          "type": "sizedBox"
                        },
                        {
                          "mainAxisAlignment": "spaceBetween",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "data": "ØªØ§Ø±ÛŒØ® Ø³Ø±Ø±Ø³ÛŒØ¯",
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
                              "mainAxisSize": "min",
                              "textDirection": "rtl",
                              "children": [
                                {
                                  "data": "Ø¹Ù†Ø¯Ø§Ù„Ù…Ø·Ø§Ù„Ø¨Ù‡",
                                  "style": {
                                    "type": "custom",
                                    "fontSize": 12.0,
                                    "fontWeight": "w500"
                                  },
                                  "textDirection": "rtl",
                                  "type": "text"
                                },
                                {
                                  "width": 8.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "type": "reactiveSwitch",
                                  "id": "dueDateSwitch",
                                  "valueKey": "isOnDemand",
                                  "activeColor": "{{appColors.current.primary.color}}",
                                  "onChanged": {
                                    "actionType": "validateFields",
                                    "resultKey": "isDataFormValid",
                                    "fields": [
                                      {
                                        "id": "promissory_amount",
                                        "rule": "^\\d+$"
                                      },
                                      {
                                        "id": "promissory_due_date",
                                        "rule": "^\\d{4}/\\d{2}/\\d{2}$",
                                        "optional": "isOnDemand"
                                      },
                                      {
                                        "id": "promissory_payment_place",
                                        "rule": "^.{1,200}$"
                                      }
                                    ]
                                  }
                                }
                              ],
                              "type": "row"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "height": 8.0,
                          "type": "sizedBox"
                        },
                        {
                          "type": "visibility",
                          "visible": "{{!isOnDemand}}",
                          "child": {
                            "child": {
                              "id": "promissory_due_date",
                              "decoration": {
                                "hintText": "ØªØ§Ø±ÛŒØ® Ø³Ø±Ø±Ø³ÛŒØ¯ Ø³ÙØªÙ‡ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ù†Ù…Ø§ÛŒÛŒØ¯",
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
                              "textAlign": "right",
                              "textDirection": "ltr",
                              "readOnly": true,
                              "enabled": false,
                              "validatorRules": [
                                {
                                  "rule": "^\\d{4}/\\d{2}/\\d{2}$",
                                  "message": "ØªØ§Ø±ÛŒØ® Ø³Ø±Ø±Ø³ÛŒØ¯ Ø±Ø§ Ø§Ù†ØªØ®Ø§Ø¨ Ù†Ù…Ø§ÛŒÛŒØ¯"
                                }
                              ],
                              "type": "textFormField"
                            },
                            "onTap": {
                              "actionType": "persianDatePicker",
                              "formFieldId": "promissory_due_date",
                              "firstDate": "1403/01/01",
                              "lastDate": "1420/12/29",
                              "onDateSelected": {
                                "actionType": "validateFields",
                                "resultKey": "isDataFormValid",
                                "fields": [
                                  {
                                    "id": "promissory_amount",
                                    "rule": "^\\d+$"
                                  },
                                  {
                                    "id": "promissory_due_date",
                                    "rule": "^\\d{4}/\\d{2}/\\d{2}$",
                                    "optional": "isOnDemand"
                                  },
                                  {
                                    "id": "promissory_payment_place",
                                    "rule": "^.{1,200}$"
                                  }
                                ]
                              }
                            },
                            "type": "gestureDetector"
                          }
                        },
                        {
                          "height": 16.0,
                          "type": "sizedBox"
                        },
                        {
                          "mainAxisAlignment": "spaceBetween",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "data": "Ù‚Ø§Ø¨Ù„ Ø§Ù†ØªÙ‚Ø§Ù„ Ø¨Ù‡ Ø´Ø®Øµ Ø«Ø§Ù„Ø« (Ø­ÙˆØ§Ù„Ù‡ Ú©Ø±Ø¯)",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 14.0,
                                  "fontWeight": "w600"
                                },
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "expanded"
                            },
                            {
                              "type": "reactiveSwitch",
                              "id": "transferableSwitch",
                              "valueKey": "isTransferable",
                              "activeColor": "{{appColors.current.primary.color}}"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "height": 16.0,
                          "type": "sizedBox"
                        },
                        {
                          "data": "Ù…Ø­Ù„ Ù¾Ø±Ø¯Ø§Ø®Øª",
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
                          "id": "promissory_payment_place",
                          "textInputAction": "next",
                          "textDirection": "rtl",
                          "textAlign": "right",
                          "maxLines": 3,
                          "minLines": 2,
                          "decoration": {
                            "hintText": "Ù…Ø­Ù„ Ù¾Ø±Ø¯Ø§Ø®Øª Ø³ÙØªÙ‡ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯",
                            "contentPadding": {
                              "left": 16.0,
                              "top": 16.0,
                              "right": 16.0,
                              "bottom": 16.0
                            },
                            "filled": false
                          },
                          "validatorRules": [
                            {
                              "rule": "^.{1,200}$",
                              "message": "Ù…Ø­Ù„ Ù¾Ø±Ø¯Ø§Ø®Øª Ø±Ø§ ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯"
                            }
                          ],
                          "onChanged": {
                            "actionType": "validateFields",
                            "resultKey": "isDataFormValid",
                            "fields": [
                              {
                                "id": "promissory_amount",
                                "rule": "^\\d+$"
                              },
                              {
                                "id": "promissory_due_date",
                                "rule": "^\\d{4}/\\d{2}/\\d{2}$",
                                "optional": "isOnDemand"
                              },
                              {
                                "id": "promissory_payment_place",
                                "rule": "^.{1,200}$"
                              }
                            ]
                          }
                        },
                        {
                          "height": 16.0,
                          "type": "sizedBox"
                        },
                        {
                          "data": "ØªÙˆØ¶ÛŒØ­Ø§Øª (Ø§Ø®ØªÛŒØ§Ø±ÛŒ)",
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
                          "id": "promissory_description",
                          "decoration": {
                            "hintText": "ØªÙˆØ¶ÛŒØ­Ø§Øª Ù…ÙˆØ±Ø¯ Ù†Ø¸Ø± Ø±Ø§ ÙˆØ§Ø±Ø¯ Ù†Ù…Ø§ÛŒÛŒØ¯",
                            "contentPadding": {
                              "left": 16.0,
                              "top": 16.0,
                              "right": 16.0,
                              "bottom": 16.0
                            },
                            "filled": false
                          },
                          "textInputAction": "done",
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "maxLines": 4,
                          "minLines": 2,
                          "type": "textFormField"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "container"
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
              "enabledKey": "isDataFormValid",
              "enabled": false,
              "onPressed": {
                "actions": [
                  {
                    "actionType": "setValue",
                    "key": "form.promissory_amount",
                    "value": {
                      "actionType": "getFormValue",
                      "id": "promissory_amount"
                    }
                  },
                  {
                    "actionType": "setValue",
                    "key": "form.promissory_due_date",
                    "value": {
                      "actionType": "getFormValue",
                      "id": "promissory_due_date"
                    }
                  },
                  {
                    "actionType": "setValue",
                    "key": "form.promissory_payment_place",
                    "value": {
                      "actionType": "getFormValue",
                      "id": "promissory_payment_place"
                    }
                  },
                  {
                    "actionType": "setValue",
                    "key": "form.promissory_description",
                    "value": {
                      "actionType": "getFormValue",
                      "id": "promissory_description"
                    }
                  },
                  {
                    "actionType": "setValue",
                    "key": "form.isOnDemand",
                    "value": "{{isOnDemand}}"
                  },
                  {
                    "actionType": "setValue",
                    "key": "form.isTransferable",
                    "value": "{{isTransferable}}"
                  },
                  {
                    "actionType": "navigate",
                    "assetPath": "lib/stac/tobank/flows/promissory/json/promissory_confirm.json",
                    "navigationStyle": "push"
                  }
                ],
                "sync": false,
                "actionType": "multiAction"
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
                "data": "Ø§Ø¯Ø§Ù…Ù‡",
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
