# flows/promissory_real/json/promissory_real_receiver.json

Source: lib/stac/tobank/flows/promissory_real/json/promissory_real_receiver.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "type": "stateFull",
  "onInit": {
    "actionType": "sequence",
    "actions": [
      {
        "actionType": "setValue",
        "key": "recipientType",
        "value": true
      },
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
        "data": "{{appStrings.promissory.issuanceTitle}}",
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
                    "data": "{{appStrings.promissory.receiveInfo}}",
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
                              "border": {
                                "color": "{{isIndividualSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}",
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
                              "padding": {
                                "left": 16.0,
                                "top": 6.0,
                                "right": 16.0,
                                "bottom": 6.0
                              },
                              "child": {
                                "crossAxisAlignment": "center",
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "decoration": {
                                      "color": "transparent",
                                      "border": {
                                        "color": "{{isIndividualSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}",
                                        "width": 2.0
                                      },
                                      "borderRadius": {
                                        "topLeft": 9999.0,
                                        "topRight": 9999.0,
                                        "bottomLeft": 9999.0,
                                        "bottomRight": 9999.0
                                      }
                                    },
                                    "width": 20.0,
                                    "height": 20.0,
                                    "child": {
                                      "child": {
                                        "decoration": {
                                          "color": "{{isIndividualSelected ? appColors.current.secondary.color : \"transparent\"}}",
                                          "borderRadius": {
                                            "topLeft": 9999.0,
                                            "topRight": 9999.0,
                                            "bottomLeft": 9999.0,
                                            "bottomRight": 9999.0
                                          }
                                        },
                                        "width": 10.0,
                                        "height": 10.0,
                                        "type": "container"
                                      },
                                      "type": "center"
                                    },
                                    "type": "container"
                                  },
                                  {
                                    "width": 8.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "child": {
                                      "data": "{{appStrings.promissory.receiverTypeIndividual}}",
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
                                  }
                                ],
                                "type": "row"
                              },
                              "type": "padding"
                            },
                            "type": "container"
                          },
                          "onTap": {
                            "actionType": "sequence",
                            "actions": [
                              {
                                "actionType": "setValue",
                                "key": "recipientType",
                                "value": true
                              },
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
                            ]
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
                              "border": {
                                "color": "{{isLegalSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}",
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
                              "padding": {
                                "left": 16.0,
                                "top": 6.0,
                                "right": 16.0,
                                "bottom": 6.0
                              },
                              "child": {
                                "crossAxisAlignment": "center",
                                "textDirection": "rtl",
                                "children": [
                                  {
                                    "decoration": {
                                      "color": "transparent",
                                      "border": {
                                        "color": "{{isLegalSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}",
                                        "width": 2.0
                                      },
                                      "borderRadius": {
                                        "topLeft": 9999.0,
                                        "topRight": 9999.0,
                                        "bottomLeft": 9999.0,
                                        "bottomRight": 9999.0
                                      }
                                    },
                                    "width": 20.0,
                                    "height": 20.0,
                                    "child": {
                                      "child": {
                                        "decoration": {
                                          "color": "{{isLegalSelected ? appColors.current.secondary.color : \"transparent\"}}",
                                          "borderRadius": {
                                            "topLeft": 9999.0,
                                            "topRight": 9999.0,
                                            "bottomLeft": 9999.0,
                                            "bottomRight": 9999.0
                                          }
                                        },
                                        "width": 10.0,
                                        "height": 10.0,
                                        "type": "container"
                                      },
                                      "type": "center"
                                    },
                                    "type": "container"
                                  },
                                  {
                                    "width": 8.0,
                                    "type": "sizedBox"
                                  },
                                  {
                                    "child": {
                                      "data": "{{appStrings.promissory.receiverTypeLegal}}",
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
                                  }
                                ],
                                "type": "row"
                              },
                              "type": "padding"
                            },
                            "type": "container"
                          },
                          "onTap": {
                            "actionType": "sequence",
                            "actions": [
                              {
                                "actionType": "setValue",
                                "key": "recipientType",
                                "value": false
                              },
                              {
                                "actionType": "setValue",
                                "key": "isLegalSelected",
                                "value": true
                              },
                              {
                                "actionType": "setValue",
                                "key": "isIndividualSelected",
                                "value": false
                              },
                              {
                                "actionType": "setValue",
                                "key": "isReceiverFormValid",
                                "value": false
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
                    "height": 16.0,
                    "type": "sizedBox"
                  },
                  {
                    "type": "visibility",
                    "visible": "[[isIndividualSelected]]",
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "{{appStrings.promissory.nationalCode}}",
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
                          "decoration": {
                            "hintText": "{{appStrings.promissory.enterNationalCode}}",
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
                          "maxLength": 10,
                          "inputFormatters": [
                            {
                              "type": "allow",
                              "rule": "[0-9]"
                            }
                          ],
                          "validatorRules": [
                            {
                              "rule": "^\\d{10}$",
                              "message": "{{appStrings.promissory.nationalCodeError}}"
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
                          "data": "{{appStrings.promissory.mobileNumber}}",
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
                          "decoration": {
                            "hintText": "{{appStrings.promissory.enterMobileNumber}}",
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
                          "maxLength": 11,
                          "inputFormatters": [
                            {
                              "type": "allow",
                              "rule": "[0-9]"
                            }
                          ],
                          "validatorRules": [
                            {
                              "rule": "^09\\d{9}$",
                              "message": "{{appStrings.promissory.mobileNumberError}}"
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
                          "data": "{{appStrings.promissory.birthdate}}",
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
                              "hintText": "{{appStrings.promissory.selectBirthdate}}",
                              "hintStyle": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 15.0,
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
                                "message": "{{appStrings.promissory.selectBirthdateError}}"
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
                    }
                  },
                  {
                    "type": "visibility",
                    "visible": "[[isLegalSelected]]",
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "mainAxisAlignment": "spaceBetween",
                          "textDirection": "rtl",
                          "children": [
                            {
                              "child": {
                                "data": "{{appStrings.promissory.selectGardeshgariAsReceiver}}",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.title}}",
                                  "fontSize": 15.0,
                                  "fontWeight": "w600"
                                },
                                "textDirection": "rtl",
                                "type": "text"
                              },
                              "type": "expanded"
                            },
                            {
                              "mainAxisSize": "min",
                              "textDirection": "rtl",
                              "children": [
                                {
                                  "src": "assets/icons/ic_gardeshgari.svg",
                                  "imageType": "asset",
                                  "width": 24.0,
                                  "height": 24.0,
                                  "type": "image"
                                },
                                {
                                  "width": 8.0,
                                  "type": "sizedBox"
                                },
                                {
                                  "type": "reactiveSwitch",
                                  "id": "legal_receiver_bank_switch",
                                  "valueKey": "isLegalReceiverTourismBank",
                                  "onChanged": {
                                    "actionType": "sequence",
                                    "actions": [
                                      {
                                        "actionType": "setValue",
                                        "values": [
                                          {
                                            "key": "legal_national_id",
                                            "value": "10320435268",
                                            "condition": "isLegalReceiverTourismBank"
                                          },
                                          {
                                            "key": "legal_contact_number",
                                            "value": "02123952395",
                                            "condition": "isLegalReceiverTourismBank"
                                          },
                                          {
                                            "key": "legal_national_id",
                                            "value": "",
                                            "condition": "!isLegalReceiverTourismBank"
                                          },
                                          {
                                            "key": "legal_contact_number",
                                            "value": "",
                                            "condition": "!isLegalReceiverTourismBank"
                                          },
                                          {
                                            "key": "isReceiverFormValid",
                                            "value": true,
                                            "condition": "isLegalReceiverTourismBank"
                                          },
                                          {
                                            "key": "isReceiverFormValid",
                                            "value": false,
                                            "condition": "!isLegalReceiverTourismBank"
                                          }
                                        ]
                                      }
                                    ]
                                  },
                                  "activeColor": "{{appColors.current.secondary.color}}"
                                }
                              ],
                              "type": "row"
                            }
                          ],
                          "type": "row"
                        },
                        {
                          "type": "visibility",
                          "visible": "[[!isLegalReceiverTourismBank]]",
                          "child": {
                            "crossAxisAlignment": "stretch",
                            "children": [
                              {
                                "height": 16.0,
                                "type": "sizedBox"
                              },
                              {
                                "data": "{{appStrings.promissory.nationalId}}",
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
                                "id": "legal_national_id",
                                "textDirection": "rtl",
                                "textAlign": "right",
                                "decoration": {
                                  "hintText": "{{appStrings.promissory.enterNationalId}}",
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
                                "maxLength": 11,
                                "inputFormatters": [
                                  {
                                    "type": "allow",
                                    "rule": "[0-9]"
                                  }
                                ],
                                "validatorRules": [
                                  {
                                    "rule": "^\\d{10,}$",
                                    "message": "{{appStrings.promissory.nationalCodeError}}"
                                  }
                                ],
                                "onChanged": {
                                  "actionType": "validateFields",
                                  "resultKey": "isReceiverFormValid",
                                  "fields": [
                                    {
                                      "id": "legal_national_id",
                                      "rule": "^\\d{10,}$"
                                    },
                                    {
                                      "id": "legal_contact_number",
                                      "rule": "^\\d{10,}$"
                                    }
                                  ]
                                }
                              },
                              {
                                "height": 16.0,
                                "type": "sizedBox"
                              },
                              {
                                "data": "{{appStrings.promissory.contactNumber}}",
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
                                "id": "legal_contact_number",
                                "textDirection": "rtl",
                                "textAlign": "right",
                                "decoration": {
                                  "hintText": "{{appStrings.promissory.enterContactNumber}}",
                                  "contentPadding": {
                                    "left": 16.0,
                                    "top": 16.0,
                                    "right": 16.0,
                                    "bottom": 16.0
                                  },
                                  "filled": false
                                },
                                "keyboardType": "phone",
                                "textInputAction": "done",
                                "maxLength": 11,
                                "inputFormatters": [
                                  {
                                    "type": "allow",
                                    "rule": "[0-9]"
                                  }
                                ],
                                "validatorRules": [
                                  {
                                    "rule": "^\\d{10,}$",
                                    "message": "{{appStrings.promissory.mobileNumberError}}"
                                  }
                                ],
                                "onChanged": {
                                  "actionType": "validateFields",
                                  "resultKey": "isReceiverFormValid",
                                  "fields": [
                                    {
                                      "id": "legal_national_id",
                                      "rule": "^\\d{10,}$"
                                    },
                                    {
                                      "id": "legal_contact_number",
                                      "rule": "^\\d{10,}$"
                                    }
                                  ]
                                }
                              },
                              {
                                "height": 40.0,
                                "type": "sizedBox"
                              }
                            ],
                            "type": "column"
                          }
                        },
                        {
                          "type": "visibility",
                          "visible": "[[isLegalReceiverTourismBank]]",
                          "child": {
                            "crossAxisAlignment": "stretch",
                            "children": [
                              {
                                "height": 16.0,
                                "type": "sizedBox"
                              },
                              {
                                "data": "{{appStrings.promissory.nationalId}}",
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
                                "type": "container",
                                "decoration": {
                                  "color": "{{appColors.current.background.surfaceContainer}}",
                                  "border": {
                                    "color": "{{appColors.current.input.borderEnabled}}"
                                  },
                                  "borderRadius": {
                                    "topLeft": 12.0,
                                    "topRight": 12.0,
                                    "bottomLeft": 12.0,
                                    "bottomRight": 12.0
                                  }
                                },
                                "child": {
                                  "padding": {
                                    "left": 16.0,
                                    "top": 16.0,
                                    "right": 16.0,
                                    "bottom": 16.0
                                  },
                                  "child": {
                                    "data": "10320435268",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.title}}",
                                      "fontSize": 16.0,
                                      "fontWeight": "w600"
                                    },
                                    "textAlign": "right",
                                    "type": "text"
                                  },
                                  "type": "padding"
                                }
                              },
                              {
                                "height": 16.0,
                                "type": "sizedBox"
                              },
                              {
                                "data": "{{appStrings.promissory.contactNumber}}",
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
                                "type": "container",
                                "decoration": {
                                  "color": "{{appColors.current.background.surfaceContainer}}",
                                  "border": {
                                    "color": "{{appColors.current.input.borderEnabled}}"
                                  },
                                  "borderRadius": {
                                    "topLeft": 12.0,
                                    "topRight": 12.0,
                                    "bottomLeft": 12.0,
                                    "bottomRight": 12.0
                                  }
                                },
                                "child": {
                                  "padding": {
                                    "left": 16.0,
                                    "top": 16.0,
                                    "right": 16.0,
                                    "bottom": 16.0
                                  },
                                  "child": {
                                    "data": "02123952395",
                                    "style": {
                                      "type": "custom",
                                      "color": "{{appColors.current.text.title}}",
                                      "fontSize": 16.0,
                                      "fontWeight": "w600"
                                    },
                                    "textAlign": "right",
                                    "textDirection": "ltr",
                                    "type": "text"
                                  },
                                  "type": "padding"
                                }
                              },
                              {
                                "height": 40.0,
                                "type": "sizedBox"
                              }
                            ],
                            "type": "column"
                          }
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
            "type": "expanded"
          },
          {
            "type": "visibility",
            "visible": "[[isIndividualSelected]]",
            "child": {
              "padding": {
                "left": 16.0,
                "top": 16.0,
                "right": 16.0,
                "bottom": 16.0
              },
              "child": {
                "type": "reactiveElevatedButton",
                "enabledKey": "isReceiverFormValid",
                "loadingKey": "receiver.isLoading",
                "onPressed": {
                  "actionType": "sequence",
                  "actions": [
                    {
                      "actionType": "setValue",
                      "values": [
                        {
                          "key": "receiver.isLoading",
                          "value": true
                        },
                        {
                          "key": "receiver.error"
                        }
                      ]
                    },
                    {
                      "actionType": "setValue",
                      "values": [
                        {
                          "key": "receiver.nationalCode",
                          "value": {
                            "actionType": "getFormValue",
                            "id": "receiver_national_code"
                          }
                        },
                        {
                          "key": "form.receiver_national_code",
                          "value": {
                            "actionType": "getFormValue",
                            "id": "receiver_national_code"
                          }
                        },
                        {
                          "key": "receiver.mobile",
                          "value": {
                            "actionType": "getFormValue",
                            "id": "receiver_mobile"
                          }
                        },
                        {
                          "key": "form.receiver_mobile",
                          "value": {
                            "actionType": "getFormValue",
                            "id": "receiver_mobile"
                          }
                        },
                        {
                          "key": "receiver.birthDate",
                          "value": {
                            "actionType": "getFormValue",
                            "id": "receiver_birthdate"
                          }
                        },
                        {
                          "key": "form.receiver_birthdate",
                          "value": {
                            "actionType": "getFormValue",
                            "id": "receiver_birthdate"
                          }
                        },
                        {
                          "key": "receiver.birthDateCompact",
                          "value": "__STAC_OPEN__replace(receiver.birthDate,'/','')}}"
                        }
                      ]
                    },
                    {
                      "actionType": "networkRequest",
                      "url": "http://192.168.107.22:8280/api/digitalbanking/customers/v1.0/identity/__STAC_OPEN__receiver.nationalCode}}/__STAC_OPEN__receiver.birthDateCompact}}",
                      "method": "get",
                      "headers": {
                        "accept": "*/*",
                        "app-platform": "android",
                        "app-store": "application/json",
                        "app-version": "456",
                        "device-uuid": "5109ab4c-77ca-4f0c-9858-da4df58031d2",
                        "serviceauthorization": "Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==",
                        "authorization": "__STAC_OPEN__auth.accessToken}}"
                      },
                      "results": [
                        {
                          "statusCode": 200,
                          "action": {
                            "actionType": "sequence",
                            "actions": [
                              {
                                "actionType": "setValue",
                                "values": [
                                  {
                                    "key": "receiver.isLoading",
                                    "value": false
                                  },
                                  {
                                    "key": "receiverIdentity.raw",
                                    "value": "__STAC_OPEN__data.data}}"
                                  },
                                  {
                                    "key": "receiverIdentity.name",
                                    "value": "__STAC_OPEN__data.data.name}}"
                                  },
                                  {
                                    "key": "receiverIdentity.family",
                                    "value": "__STAC_OPEN__data.data.family}}"
                                  },
                                  {
                                    "key": "receiverIdentity.fullName",
                                    "value": "__STAC_OPEN__data.data.name}} __STAC_OPEN__data.data.family}}"
                                  },
                                  {
                                    "key": "receiverIdentity.fatherName",
                                    "value": "__STAC_OPEN__data.data.fatherName}}"
                                  },
                                  {
                                    "key": "receiverIdentity.gender",
                                    "value": "__STAC_OPEN__data.data.gender}}"
                                  },
                                  {
                                    "key": "receiverIdentity.nationalId",
                                    "value": "__STAC_OPEN__data.data.nationalId}}"
                                  }
                                ]
                              },
                              {
                                "actionType": "navigate",
                                "assetPath": "lib/stac/tobank/flows/promissory_real/json/promissory_real_data.json",
                                "navigationStyle": "push"
                              }
                            ]
                          }
                        },
                        {
                          "statusCode": 422,
                          "action": {
                            "actionType": "sequence",
                            "actions": [
                              {
                                "actionType": "setValue",
                                "values": [
                                  {
                                    "key": "receiver.isLoading",
                                    "value": false
                                  },
                                  {
                                    "key": "receiver.error",
                                    "value": "__STAC_OPEN__appStrings.promissory.invalidDataError}}"
                                  }
                                ]
                              },
                              {
                                "actionType": "customSnackBar",
                                "message": "__STAC_OPEN__appStrings.promissory.invalidDataErrorDetail}}",
                                "backgroundColor": "#D32F2F",
                                "duration": 4000
                              }
                            ]
                          }
                        },
                        {
                          "statusCode": 401,
                          "action": {
                            "actionType": "sequence",
                            "actions": [
                              {
                                "actionType": "setValue",
                                "values": [
                                  {
                                    "key": "receiver.isLoading",
                                    "value": false
                                  }
                                ]
                              },
                              {
                                "actionType": "customSnackBar",
                                "message": "__STAC_OPEN__appStrings.promissory.sessionExpiredError}}",
                                "backgroundColor": "#D32F2F",
                                "duration": 4000
                              }
                            ]
                          }
                        },
                        {
                          "statusCode": -1,
                          "action": {
                            "actionType": "sequence",
                            "actions": [
                              {
                                "actionType": "setValue",
                                "values": [
                                  {
                                    "key": "receiver.isLoading",
                                    "value": false
                                  },
                                  {
                                    "key": "receiver.error",
                                    "value": "__STAC_OPEN__appStrings.promissory.serverConnectionError}}"
                                  }
                                ]
                              },
                              {
                                "actionType": "customSnackBar",
                                "message": "__STAC_OPEN__appStrings.promissory.serverConnectionErrorDetail}}",
                                "backgroundColor": "#D32F2F",
                                "duration": 4000
                              }
                            ]
                          }
                        }
                      ]
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
          },
          {
            "type": "visibility",
            "visible": "[[isLegalSelected]]",
            "child": {
              "padding": {
                "left": 16.0,
                "top": 16.0,
                "right": 16.0,
                "bottom": 16.0
              },
              "child": {
                "type": "reactiveElevatedButton",
                "enabledKey": "isReceiverFormValid",
                "loadingKey": "receiver.isLoading",
                "onPressed": {
                  "actionType": "sequence",
                  "actions": [
                    {
                      "actionType": "setValue",
                      "values": [
                        {
                          "key": "receiver.isLoading",
                          "value": true
                        },
                        {
                          "key": "receiver.error"
                        }
                      ]
                    },
                    {
                      "actionType": "setValue",
                      "values": [
                        {
                          "key": "receiver.legalNationalId",
                          "value": {
                            "actionType": "getFormValue",
                            "id": "legal_national_id"
                          },
                          "condition": "!isLegalReceiverTourismBank"
                        },
                        {
                          "key": "receiver.legalNationalId",
                          "value": "__STAC_OPEN__legal_national_id}}",
                          "condition": "isLegalReceiverTourismBank"
                        },
                        {
                          "key": "form.legal_national_id",
                          "value": {
                            "actionType": "getFormValue",
                            "id": "legal_national_id"
                          },
                          "condition": "!isLegalReceiverTourismBank"
                        },
                        {
                          "key": "form.legal_national_id",
                          "value": "__STAC_OPEN__legal_national_id}}",
                          "condition": "isLegalReceiverTourismBank"
                        },
                        {
                          "key": "form.legal_contact_number",
                          "value": {
                            "actionType": "getFormValue",
                            "id": "legal_contact_number"
                          },
                          "condition": "!isLegalReceiverTourismBank"
                        },
                        {
                          "key": "form.legal_contact_number",
                          "value": "__STAC_OPEN__legal_contact_number}}",
                          "condition": "isLegalReceiverTourismBank"
                        }
                      ]
                    },
                    {
                      "actionType": "networkRequest",
                      "url": "http://192.168.107.22:8280/api/digitalbanking/customers/v1.0/identity/__STAC_OPEN__receiver.legalNationalId}}",
                      "method": "get",
                      "headers": {
                        "accept": "*/*",
                        "app-platform": "android",
                        "app-store": "application/json",
                        "app-version": "456",
                        "device-uuid": "5109ab4c-77ca-4f0c-9858-da4df58031d2",
                        "serviceauthorization": "Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==",
                        "authorization": "__STAC_OPEN__auth.accessToken}}"
                      },
                      "results": [
                        {
                          "statusCode": 200,
                          "action": {
                            "actionType": "sequence",
                            "actions": [
                              {
                                "actionType": "setValue",
                                "values": [
                                  {
                                    "key": "receiver.isLoading",
                                    "value": false
                                  },
                                  {
                                    "key": "receiverIdentity.raw",
                                    "value": "__STAC_OPEN__data.data}}"
                                  },
                                  {
                                    "key": "receiverIdentity.name",
                                    "value": "__STAC_OPEN__data.data.name}}"
                                  },
                                  {
                                    "key": "receiverIdentity.fullName",
                                    "value": "__STAC_OPEN__data.data.name}}"
                                  },
                                  {
                                    "key": "receiverIdentity.nationalId",
                                    "value": "__STAC_OPEN__data.data.nationalId}}"
                                  },
                                  {
                                    "key": "receiverIdentity.phone",
                                    "value": "__STAC_OPEN__data.data.phone}}"
                                  },
                                  {
                                    "key": "receiverIdentity.address",
                                    "value": "__STAC_OPEN__data.data.address}}"
                                  },
                                  {
                                    "key": "form.paymentPlace",
                                    "value": "__STAC_OPEN__data.data.address}}"
                                  }
                                ]
                              },
                              {
                                "actionType": "navigate",
                                "assetPath": "lib/stac/tobank/flows/promissory_real/json/promissory_real_data.json",
                                "navigationStyle": "push"
                              }
                            ]
                          }
                        },
                        {
                          "statusCode": 422,
                          "action": {
                            "actionType": "sequence",
                            "actions": [
                              {
                                "actionType": "setValue",
                                "values": [
                                  {
                                    "key": "receiver.isLoading",
                                    "value": false
                                  },
                                  {
                                    "key": "receiver.error",
                                    "value": "__STAC_OPEN__appStrings.promissory.invalidDataError}}"
                                  }
                                ]
                              },
                              {
                                "actionType": "customSnackBar",
                                "message": "__STAC_OPEN__appStrings.promissory.invalidDataErrorDetail}}",
                                "backgroundColor": "#D32F2F",
                                "duration": 4000
                              }
                            ]
                          }
                        },
                        {
                          "statusCode": 520,
                          "action": {
                            "actionType": "sequence",
                            "actions": [
                              {
                                "actionType": "setValue",
                                "values": [
                                  {
                                    "key": "receiver.isLoading",
                                    "value": false
                                  }
                                ]
                              },
                              {
                                "actionType": "customSnackBar",
                                "message": "__STAC_OPEN__appStrings.promissory.serverConnectionErrorDetail}}",
                                "backgroundColor": "#D32F2F",
                                "duration": 4000
                              }
                            ]
                          }
                        },
                        {
                          "statusCode": -1,
                          "action": {
                            "actionType": "sequence",
                            "actions": [
                              {
                                "actionType": "setValue",
                                "values": [
                                  {
                                    "key": "receiver.isLoading",
                                    "value": false
                                  },
                                  {
                                    "key": "receiver.error",
                                    "value": "__STAC_OPEN__appStrings.promissory.serverConnectionError}}"
                                  }
                                ]
                              },
                              {
                                "actionType": "customSnackBar",
                                "message": "__STAC_OPEN__appStrings.promissory.serverConnectionErrorDetail}}",
                                "backgroundColor": "#D32F2F",
                                "duration": 4000
                              }
                            ]
                          }
                        }
                      ]
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
