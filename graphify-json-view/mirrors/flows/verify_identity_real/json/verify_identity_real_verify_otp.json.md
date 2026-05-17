# flows/verify_identity_real/json/verify_identity_real_verify_otp.json

Source: lib/stac/tobank/flows/verify_identity_real/json/verify_identity_real_verify_otp.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "type": "stateFull",
  "onInit": {
    "actionType": "setValue",
    "key": "isVerifyIdentityOtpValid",
    "value": false
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
                      "height": 12.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "{{appStrings.authentication.otpTitle}}",
                      "style": {
                        "type": "custom",
                        "color": "{{appColors.current.text.title}}",
                        "fontSize": 20.0,
                        "fontWeight": "w700"
                      },
                      "textAlign": "right",
                      "textDirection": "rtl",
                      "type": "text"
                    },
                    {
                      "height": 24.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "{{appStrings.authentication.otpDescription}}",
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
                    {
                      "height": 24.0,
                      "type": "sizedBox"
                    },
                    {
                      "crossAxisAlignment": "start",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "child": {
                            "type": "textFormField",
                            "id": "verify_identity_otp_code",
                            "textDirection": "ltr",
                            "textAlign": "right",
                            "supportTextDirection": "rtl",
                            "maxLength": 5,
                            "inputFormatters": [
                              {
                                "type": "allow",
                                "rule": "[0-9]"
                              }
                            ],
                            "keyboardType": "number",
                            "textInputAction": "done",
                            "decoration": {
                              "hintText": "{{appStrings.authentication.otpCodeHint}}",
                              "hintStyle": {
                                "type": "custom",
                                "color": "{{appColors.current.text.hint}}",
                                "fontSize": 15.0,
                                "fontWeight": "w600"
                              },
                              "helperText": " ",
                              "helperStyle": {
                                "type": "custom",
                                "height": 0.5
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
                              "fontSize": 18.0,
                              "fontWeight": "w600",
                              "letterSpacing": 4.0
                            },
                            "validatorRules": [
                              {
                                "rule": "^\\d{5}$",
                                "message": "{{appStrings.verifyOtp.otpCodeError}}"
                              }
                            ],
                            "onChanged": {
                              "actionType": "validateFields",
                              "resultKey": "isVerifyIdentityOtpValid",
                              "fields": [
                                {
                                  "id": "verify_identity_otp_code",
                                  "rule": "^\\d{5}$"
                                }
                              ]
                            }
                          },
                          "type": "expanded"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "type": "otpCountdownButton",
                          "initialSeconds": 120,
                          "retryLabel": "{{appStrings.authentication.otpRetryLabel}}",
                          "iconAsset": "{{appAssets.icons.timer}}",
                          "borderColor": "{{appColors.current.input.borderEnabled}}",
                          "expiredBorderColor": "{{appColors.current.primary.color}}",
                          "countdownTextColor": "{{appColors.current.text.subtitle}}",
                          "retryTextColor": "{{appColors.current.text.title}}",
                          "backgroundColor": "{{appColors.current.background.surface}}",
                          "height": 56,
                          "minWidth": 132,
                          "onRetry": {
                            "actionType": "showSnackBar",
                            "backgroundColor": "#2E7D32",
                            "content": {
                              "type": "text",
                              "data": "{{appStrings.authentication.otpResentMessage}}",
                              "style": {
                                "type": "custom",
                                "color": "#FFFFFF",
                                "fontSize": 16
                              }
                            }
                          }
                        }
                      ],
                      "type": "row"
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
                "enabledKey": "isVerifyIdentityOtpValid",
                "enabled": false,
                "style": {
                  "backgroundColor": "{{appColors.current.primary.color}}",
                  "elevation": 0.0,
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 64.0
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
                  "backgroundColor": "{{appColors.current.background.surfaceContainerHigh}}",
                  "elevation": 0.0,
                  "fixedSize": {
                    "width": 999999.0,
                    "height": 64.0
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
                  "data": "{{appStrings.authentication.confirmOtpButton}}",
                  "style": {
                    "type": "custom",
                    "color": "{{appColors.current.primary.onPrimary}}",
                    "fontSize": 18.0,
                    "fontWeight": "w700"
                  },
                  "textDirection": "rtl",
                  "type": "text"
                },
                "onPressed": {
                  "navigationStyle": "push",
                  "actionType": "navigate",
                  "request": {
                    "url": "http://192.168.179.21:8101/api/configurations/v1.0/configs/resolve/ipaam.builder.form.form.verify_identity_real_national_card_front/1",
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
