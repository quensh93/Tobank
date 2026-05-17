# flows/verify_identity_real/json/verify_identity_real_certificate_generator.json

Source: lib/stac/tobank/flows/verify_identity_real/json/verify_identity_real_certificate_generator.json

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
        "key": "isVerifyIdentityCertificateInfoValid",
        "value": false
      },
      {
        "key": "hasVerifyIdentityEnglishFirstNameInput",
        "value": false
      },
      {
        "key": "hasVerifyIdentityEnglishLastNameInput",
        "value": false
      },
      {
        "key": "hasVerifyIdentityEmailInput",
        "value": false
      },
      {
        "key": "hasVerifyIdentityHomePhoneInput",
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
        "autovalidateMode": "onUserInteraction",
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
                      "height": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "Ù„Ø·ÙØ§ Ø§Ø·Ù„Ø§Ø¹Ø§Øª ØªÚ©Ù…ÛŒÙ„ÛŒ Ù…ÙˆØ±Ø¯ Ù†ÛŒØ§Ø² Ø±Ø§ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.subtitle}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600",
                        "height": 1.8
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    {
                      "height": 28.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "Ù†Ø§Ù… Ø¨Ù‡ Ø§Ù†Ú¯Ù„ÛŒØ³ÛŒ",
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
                      "height": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "type": "textFormField",
                      "id": "verify_identity_english_first_name",
                      "textDirection": "ltr",
                      "textAlign": "right",
                      "supportTextDirection": "rtl",
                      "keyboardType": "text",
                      "textInputAction": "next",
                      "decoration": {
                        "hintText": "Ù†Ø§Ù… Ø®ÙˆØ¯ Ø±Ø§ Ø¨Ù‡ Ø§Ù†Ú¯Ù„ÛŒØ³ÛŒ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                        "hintStyle": {
                          "type": "custom",
                          "color": "{{appColors.current.text.hint}}",
                          "fontSize": 14.0,
                          "fontWeight": "w500"
                        },
                        "helperText": " ",
                        "helperStyle": {
                          "type": "custom",
                          "height": 0.5
                        },
                        "suffixIcon": {
                          "type": "visibility",
                          "visible": "[[hasVerifyIdentityEnglishFirstNameInput]]",
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
                                      "key": "verify_identity_english_first_name",
                                      "value": ""
                                    },
                                    {
                                      "key": "hasVerifyIdentityEnglishFirstNameInput",
                                      "value": false
                                    },
                                    {
                                      "key": "isVerifyIdentityCertificateInfoValid",
                                      "value": false
                                    }
                                  ]
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          }
                        },
                        "contentPadding": {
                          "left": 16.0,
                          "top": 18.0,
                          "right": 16.0,
                          "bottom": 18.0
                        },
                        "filled": false
                      },
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "validatorRules": [
                        {
                          "rule": "^[A-Za-z ]{2,}$",
                          "message": "Ù„Ø·ÙØ§ Ù†Ø§Ù… Ø±Ø§ Ø¨Ù‡ Ø§Ù†Ú¯Ù„ÛŒØ³ÛŒ Ùˆ Ø¨Ù‡â€ŒØµÙˆØ±Øª ØµØ­ÛŒØ­ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯"
                        }
                      ],
                      "onChanged": {
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "validateFields",
                            "resultKey": "hasVerifyIdentityEnglishFirstNameInput",
                            "fields": [
                              {
                                "id": "verify_identity_english_first_name"
                              }
                            ]
                          },
                          {
                            "actionType": "validateFields",
                            "resultKey": "isVerifyIdentityCertificateInfoValid",
                            "fields": [
                              {
                                "id": "verify_identity_english_first_name",
                                "rule": "^[A-Za-z ]{2,}$"
                              },
                              {
                                "id": "verify_identity_english_last_name",
                                "rule": "^[A-Za-z ]{2,}$"
                              },
                              {
                                "id": "verify_identity_email",
                                "rule": "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
                              },
                              {
                                "id": "verify_identity_home_phone",
                                "rule": "^0\\d{10}$"
                              }
                            ]
                          }
                        ]
                      },
                      "maxLength": 40,
                      "inputFormatters": [
                        {
                          "type": "allow",
                          "rule": "[A-Za-z ]"
                        }
                      ]
                    },
                    {
                      "height": 18.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "Ù†Ø§Ù… Ø®Ø§Ù†ÙˆØ§Ø¯Ú¯ÛŒ Ø¨Ù‡ Ø§Ù†Ú¯Ù„ÛŒØ³ÛŒ",
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
                      "height": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "type": "textFormField",
                      "id": "verify_identity_english_last_name",
                      "textDirection": "ltr",
                      "textAlign": "right",
                      "supportTextDirection": "rtl",
                      "keyboardType": "text",
                      "textInputAction": "next",
                      "decoration": {
                        "hintText": "Ù†Ø§Ù… Ø®Ø§Ù†ÙˆØ§Ø¯Ú¯ÛŒ Ø®ÙˆØ¯ Ø±Ø§ Ø¨Ù‡ Ø§Ù†Ú¯Ù„ÛŒØ³ÛŒ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                        "hintStyle": {
                          "type": "custom",
                          "color": "{{appColors.current.text.hint}}",
                          "fontSize": 14.0,
                          "fontWeight": "w500"
                        },
                        "helperText": " ",
                        "helperStyle": {
                          "type": "custom",
                          "height": 0.5
                        },
                        "suffixIcon": {
                          "type": "visibility",
                          "visible": "[[hasVerifyIdentityEnglishLastNameInput]]",
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
                                      "key": "verify_identity_english_last_name",
                                      "value": ""
                                    },
                                    {
                                      "key": "hasVerifyIdentityEnglishLastNameInput",
                                      "value": false
                                    },
                                    {
                                      "key": "isVerifyIdentityCertificateInfoValid",
                                      "value": false
                                    }
                                  ]
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          }
                        },
                        "contentPadding": {
                          "left": 16.0,
                          "top": 18.0,
                          "right": 16.0,
                          "bottom": 18.0
                        },
                        "filled": false
                      },
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "validatorRules": [
                        {
                          "rule": "^[A-Za-z ]{2,}$",
                          "message": "Ù„Ø·ÙØ§ Ù†Ø§Ù… Ø®Ø§Ù†ÙˆØ§Ø¯Ú¯ÛŒ Ø±Ø§ Ø¨Ù‡ Ø§Ù†Ú¯Ù„ÛŒØ³ÛŒ Ùˆ Ø¨Ù‡â€ŒØµÙˆØ±Øª ØµØ­ÛŒØ­ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯"
                        }
                      ],
                      "onChanged": {
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "validateFields",
                            "resultKey": "hasVerifyIdentityEnglishLastNameInput",
                            "fields": [
                              {
                                "id": "verify_identity_english_last_name"
                              }
                            ]
                          },
                          {
                            "actionType": "validateFields",
                            "resultKey": "isVerifyIdentityCertificateInfoValid",
                            "fields": [
                              {
                                "id": "verify_identity_english_first_name",
                                "rule": "^[A-Za-z ]{2,}$"
                              },
                              {
                                "id": "verify_identity_english_last_name",
                                "rule": "^[A-Za-z ]{2,}$"
                              },
                              {
                                "id": "verify_identity_email",
                                "rule": "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
                              },
                              {
                                "id": "verify_identity_home_phone",
                                "rule": "^0\\d{10}$"
                              }
                            ]
                          }
                        ]
                      },
                      "maxLength": 60,
                      "inputFormatters": [
                        {
                          "type": "allow",
                          "rule": "[A-Za-z ]"
                        }
                      ]
                    },
                    {
                      "height": 18.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "Ø§ÛŒÙ…ÛŒÙ„",
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
                      "height": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "type": "textFormField",
                      "id": "verify_identity_email",
                      "textDirection": "ltr",
                      "textAlign": "right",
                      "supportTextDirection": "rtl",
                      "keyboardType": "emailAddress",
                      "textInputAction": "next",
                      "decoration": {
                        "hintText": "Ø§ÛŒÙ…ÛŒÙ„ Ø®ÙˆØ¯ Ø±Ø§ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                        "hintStyle": {
                          "type": "custom",
                          "color": "{{appColors.current.text.hint}}",
                          "fontSize": 14.0,
                          "fontWeight": "w500"
                        },
                        "helperText": " ",
                        "helperStyle": {
                          "type": "custom",
                          "height": 0.5
                        },
                        "suffixIcon": {
                          "type": "visibility",
                          "visible": "[[hasVerifyIdentityEmailInput]]",
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
                                      "key": "verify_identity_email",
                                      "value": ""
                                    },
                                    {
                                      "key": "hasVerifyIdentityEmailInput",
                                      "value": false
                                    },
                                    {
                                      "key": "isVerifyIdentityCertificateInfoValid",
                                      "value": false
                                    }
                                  ]
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          }
                        },
                        "contentPadding": {
                          "left": 16.0,
                          "top": 18.0,
                          "right": 16.0,
                          "bottom": 18.0
                        },
                        "filled": false
                      },
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "validatorRules": [
                        {
                          "rule": "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$",
                          "message": "Ù„Ø·ÙØ§ Ø§ÛŒÙ…ÛŒÙ„ Ù…Ø¹ØªØ¨Ø± ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯"
                        }
                      ],
                      "onChanged": {
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "validateFields",
                            "resultKey": "hasVerifyIdentityEmailInput",
                            "fields": [
                              {
                                "id": "verify_identity_email"
                              }
                            ]
                          },
                          {
                            "actionType": "validateFields",
                            "resultKey": "isVerifyIdentityCertificateInfoValid",
                            "fields": [
                              {
                                "id": "verify_identity_english_first_name",
                                "rule": "^[A-Za-z ]{2,}$"
                              },
                              {
                                "id": "verify_identity_english_last_name",
                                "rule": "^[A-Za-z ]{2,}$"
                              },
                              {
                                "id": "verify_identity_email",
                                "rule": "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
                              },
                              {
                                "id": "verify_identity_home_phone",
                                "rule": "^0\\d{10}$"
                              }
                            ]
                          }
                        ]
                      },
                      "maxLength": 80
                    },
                    {
                      "height": 18.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "Ø´Ù…Ø§Ø±Ù‡ ØªÙ„ÙÙ† Ù…Ù†Ø²Ù„",
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
                      "height": 8.0,
                      "type": "sizedBox"
                    },
                    {
                      "type": "textFormField",
                      "id": "verify_identity_home_phone",
                      "textDirection": "ltr",
                      "textAlign": "right",
                      "supportTextDirection": "rtl",
                      "keyboardType": "phone",
                      "textInputAction": "done",
                      "decoration": {
                        "hintText": "Ø´Ù…Ø§Ø±Ù‡ ØªÙ„ÙÙ† Ù…Ù†Ø²Ù„ Ø±Ø§ Ø¨Ø§ Ù¾ÛŒØ´ Ø´Ù…Ø§Ø±Ù‡ Ø§Ø³ØªØ§Ù† ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯",
                        "hintStyle": {
                          "type": "custom",
                          "color": "{{appColors.current.text.hint}}",
                          "fontSize": 14.0,
                          "fontWeight": "w500"
                        },
                        "helperText": " ",
                        "helperStyle": {
                          "type": "custom",
                          "height": 0.5
                        },
                        "suffixIcon": {
                          "type": "visibility",
                          "visible": "[[hasVerifyIdentityHomePhoneInput]]",
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
                                      "key": "verify_identity_home_phone",
                                      "value": ""
                                    },
                                    {
                                      "key": "hasVerifyIdentityHomePhoneInput",
                                      "value": false
                                    },
                                    {
                                      "key": "isVerifyIdentityCertificateInfoValid",
                                      "value": false
                                    }
                                  ]
                                }
                              ]
                            },
                            "type": "gestureDetector"
                          }
                        },
                        "contentPadding": {
                          "left": 16.0,
                          "top": 18.0,
                          "right": 16.0,
                          "bottom": 18.0
                        },
                        "filled": false
                      },
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 16.0,
                        "fontWeight": "w600"
                      },
                      "validatorRules": [
                        {
                          "rule": "^0\\d{10}$",
                          "message": "Ù„Ø·ÙØ§ Ø´Ù…Ø§Ø±Ù‡ ØªÙ„ÙÙ† Ù…Ù†Ø²Ù„ Ø±Ø§ Ø¨Ø§ Ù¾ÛŒØ´â€ŒØ´Ù…Ø§Ø±Ù‡ ØµØ­ÛŒØ­ ÙˆØ§Ø±Ø¯ Ú©Ù†ÛŒØ¯"
                        }
                      ],
                      "onChanged": {
                        "actionType": "sequence",
                        "actions": [
                          {
                            "actionType": "validateFields",
                            "resultKey": "hasVerifyIdentityHomePhoneInput",
                            "fields": [
                              {
                                "id": "verify_identity_home_phone"
                              }
                            ]
                          },
                          {
                            "actionType": "validateFields",
                            "resultKey": "isVerifyIdentityCertificateInfoValid",
                            "fields": [
                              {
                                "id": "verify_identity_english_first_name",
                                "rule": "^[A-Za-z ]{2,}$"
                              },
                              {
                                "id": "verify_identity_english_last_name",
                                "rule": "^[A-Za-z ]{2,}$"
                              },
                              {
                                "id": "verify_identity_email",
                                "rule": "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
                              },
                              {
                                "id": "verify_identity_home_phone",
                                "rule": "^0\\d{10}$"
                              }
                            ]
                          }
                        ]
                      },
                      "maxLength": 11,
                      "inputFormatters": [
                        {
                          "type": "allow",
                          "rule": "[0-9]"
                        }
                      ]
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
                "enabledKey": "isVerifyIdentityCertificateInfoValid",
                "enabled": false,
                "onPressed": {
                  "navigationStyle": "push",
                  "actionType": "navigate",
                  "request": {
                    "url": "http://192.168.179.21:8101/api/configurations/v1.0/configs/resolve/ipaam.builder.form.form.verify_identity_real_final/1",
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
                  "data": "ØªÚ©Ù…ÛŒÙ„ ÙØ±Ø¢ÛŒÙ†Ø¯",
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
      }
    },
    "type": "scaffold"
  }
}
```
