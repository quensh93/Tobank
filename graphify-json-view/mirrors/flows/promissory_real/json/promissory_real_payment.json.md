# flows/promissory_real/json/promissory_real_payment.json

Source: lib/stac/tobank/flows/promissory_real/json/promissory_real_payment.json

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
        "actionType": "formatNumber",
        "sourceKey": "promissory.fees.total",
        "destinationKey": "promissory.fees.total_formatted"
      },
      {
        "actionType": "formatNumber",
        "sourceKey": "promissory.fees.stampFee",
        "destinationKey": "promissory.fees.stampFee_formatted"
      },
      {
        "actionType": "formatNumber",
        "sourceKey": "promissory.fees.wage",
        "destinationKey": "promissory.fees.wage_formatted"
      },
      {
        "actionType": "formatNumber",
        "sourceKey": "wallet.balance",
        "destinationKey": "wallet.balance_formatted"
      },
      {
        "actionType": "setValue",
        "key": "isWalletSelected",
        "value": false
      },
      {
        "actionType": "setValue",
        "key": "isDepositSelected",
        "value": false
      },
      {
        "actionType": "setValue",
        "key": "selectedPaymentMethod",
        "value": ""
      },
      {
        "actionType": "setValue",
        "key": "isPayEnabled",
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
        "data": "{{appStrings.promissory.paymentTitle}}",
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
                  "children": [
                    {
                      "padding": {
                        "left": 12.0,
                        "top": 12.0,
                        "right": 12.0,
                        "bottom": 12.0
                      },
                      "decoration": {
                        "color": "{{appColors.current.background.surfaceContainer}}",
                        "border": {
                          "color": "{{appColors.current.input.borderEnabled}}",
                          "width": 0.5
                        },
                        "borderRadius": {
                          "topLeft": 40.0,
                          "topRight": 40.0,
                          "bottomLeft": 40.0,
                          "bottomRight": 40.0
                        }
                      },
                      "child": {
                        "src": "assets/icons/ic_promissory_request.svg",
                        "imageType": "asset",
                        "width": 40.0,
                        "height": 40.0,
                        "type": "image"
                      },
                      "type": "container"
                    },
                    {
                      "height": 12.0,
                      "type": "sizedBox"
                    },
                    {
                      "data": "{{appStrings.promissory.issuanceTitle}}",
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
                      "height": 20.0,
                      "type": "sizedBox"
                    },
                    {
                      "mainAxisAlignment": "spaceAround",
                      "textDirection": "rtl",
                      "children": [
                        {
                          "data": "{{appStrings.promissory.payableAmount}}",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 14.0,
                            "fontWeight": "w500"
                          },
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "textDirection": "rtl",
                          "children": [
                            {
                              "data": "{{promissory.fees.total_formatted}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 16.0,
                                "fontWeight": "w900"
                              },
                              "type": "text"
                            },
                            {
                              "width": 4.0,
                              "type": "sizedBox"
                            },
                            {
                              "data": "{{appStrings.common.rial}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 16.0
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            }
                          ],
                          "type": "row"
                        }
                      ],
                      "type": "row"
                    }
                  ],
                  "type": "column"
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
                    "children": [
                      {
                        "mainAxisAlignment": "spaceBetween",
                        "textDirection": "rtl",
                        "children": [
                          {
                            "child": {
                              "data": "{{appStrings.promissory.stampDuty}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 14.0
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "type": "expanded"
                          },
                          {
                            "width": 8.0,
                            "type": "sizedBox"
                          },
                          {
                            "data": "{{promissory.fees.stampFee_formatted}} {{appStrings.common.rial}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 14.0,
                              "fontWeight": "w600"
                            },
                            "textDirection": "rtl",
                            "type": "text"
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
                        "textDirection": "rtl",
                        "children": [
                          {
                            "child": {
                              "data": "{{appStrings.promissory.issuanceFee}}",
                              "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.subtitle}}",
                                "fontSize": 14.0
                              },
                              "textDirection": "rtl",
                              "type": "text"
                            },
                            "type": "expanded"
                          },
                          {
                            "width": 8.0,
                            "type": "sizedBox"
                          },
                          {
                            "data": "{{promissory.fees.wage_formatted}} {{appStrings.common.rial}}",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.title}}",
                              "fontSize": 14.0,
                              "fontWeight": "w600"
                            },
                            "textDirection": "rtl",
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
                  "data": "{{appStrings.promissory.paymentMethod}}",
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
                  "child": {
                    "padding": {
                      "left": 16.0,
                      "top": 16.0,
                      "right": 16.0,
                      "bottom": 16.0
                    },
                    "decoration": {
                      "color": "{{appColors.current.background.surfaceContainer}}",
                      "border": {
                        "color": "{{isWalletSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}",
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
                      "textDirection": "rtl",
                      "children": [
                        {
                          "decoration": {
                            "color": "{{appColors.current.background.surfaceContainer}}",
                            "borderRadius": {
                              "topLeft": 25.0,
                              "topRight": 25.0,
                              "bottomLeft": 25.0,
                              "bottomRight": 25.0
                            }
                          },
                          "child": {
                            "src": "assets/icons/ic_wallet.svg",
                            "imageType": "asset",
                            "width": 32.0,
                            "height": 32.0,
                            "type": "image"
                          },
                          "type": "container"
                        },
                        {
                          "width": 6.0,
                          "type": "sizedBox"
                        },
                        {
                          "data": "{{appStrings.promissory.walletPayment}}",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w600"
                          },
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "crossAxisAlignment": "start",
                            "children": [
                              {
                                "height": 4.0,
                                "type": "sizedBox"
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
                        "key": "selectedPaymentMethod",
                        "value": "wallet"
                      },
                      {
                        "actionType": "setValue",
                        "key": "paymentMethod",
                        "value": "Ú©ÛŒÙ Ù¾ÙˆÙ„"
                      },
                      {
                        "actionType": "setValue",
                        "key": "isPayEnabled",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "isDepositSelected",
                        "value": false
                      },
                      {
                        "actionType": "setValue",
                        "key": "isWalletSelected",
                        "value": true
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
                      "left": 16.0,
                      "top": 16.0,
                      "right": 16.0,
                      "bottom": 16.0
                    },
                    "decoration": {
                      "color": "{{appColors.current.background.surfaceContainer}}",
                      "border": {
                        "color": "{{isDepositSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}",
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
                      "textDirection": "rtl",
                      "children": [
                        {
                          "decoration": {
                            "color": "{{appColors.current.background.surfaceContainer}}",
                            "borderRadius": {
                              "topLeft": 25.0,
                              "topRight": 25.0,
                              "bottomLeft": 25.0,
                              "bottomRight": 25.0
                            }
                          },
                          "child": {
                            "src": "assets/icons/ic_gateway.svg",
                            "imageType": "asset",
                            "width": 32.0,
                            "height": 32.0,
                            "type": "image"
                          },
                          "type": "container"
                        },
                        {
                          "width": 6.0,
                          "type": "sizedBox"
                        },
                        {
                          "data": "{{appStrings.promissory.depositPayment}}",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w600"
                          },
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "width": 12.0,
                          "type": "sizedBox"
                        },
                        {
                          "child": {
                            "crossAxisAlignment": "start",
                            "children": [
                              {
                                "height": 4.0,
                                "type": "sizedBox"
                              },
                              {
                                "data": "",
                                "style": {
                                  "type": "custom",
                                  "color": "{{appColors.current.text.subtitle}}",
                                  "fontSize": 12.0
                                },
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
                        "key": "selectedPaymentMethod",
                        "value": "deposit"
                      },
                      {
                        "actionType": "setValue",
                        "key": "paymentMethod",
                        "value": "Ø­Ø³Ø§Ø¨"
                      },
                      {
                        "actionType": "setValue",
                        "key": "isPayEnabled",
                        "value": true
                      },
                      {
                        "actionType": "setValue",
                        "key": "isWalletSelected",
                        "value": false
                      },
                      {
                        "actionType": "setValue",
                        "key": "isDepositSelected",
                        "value": true
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
            },
            "type": "singleChildScrollView"
          },
          "type": "expanded"
        },
        {
          "children": [
            {
              "type": "container",
              "height": "{{isDepositSelected ? 0 : 88}}",
              "clipBehavior": "hardEdge",
              "decoration": {
                "color": "transparent"
              },
              "child": {
                "padding": {
                  "left": 16.0,
                  "top": 16.0,
                  "right": 16.0,
                  "bottom": 16.0
                },
                "child": {
                  "type": "reactiveElevatedButton",
                  "enabledKey": "isPayEnabled",
                  "enabled": false,
                  "onPressed": {
                    "widget": {
                      "type": "alertDialog",
                      "title": {
                        "type": "column",
                        "mainAxisAlignment": "center",
                        "children": [
                          {
                            "type": "container",
                            "width": 48,
                            "height": 48,
                            "child": {
                              "type": "image",
                              "src": "assets/icons/ic_info.svg",
                              "imageType": "asset",
                              "width": 12,
                              "height": 12,
                              "color": "__STAC_OPEN__appColors.current.primary.color}}"
                            }
                          },
                          {
                            "type": "sizedBox",
                            "height": 12
                          },
                          {
                            "type": "text",
                            "data": "__STAC_OPEN__appStrings.promissory.payConfirmMessage}}",
                            "textDirection": "rtl",
                            "textAlign": "center",
                            "style": {
                              "type": "custom",
                              "fontSize": 16,
                              "fontWeight": "bold",
                              "color": "__STAC_OPEN__appColors.current.text.title}}"
                            }
                          }
                        ]
                      },
                      "content": {
                        "type": "text",
                        "data": "__STAC_OPEN__appStrings.promissory.signConfirmationMessage}}",
                        "textDirection": "rtl",
                        "textAlign": "center",
                        "style": {
                          "type": "custom",
                          "fontSize": 14,
                          "color": "__STAC_OPEN__appColors.current.text.subtitle}}"
                        }
                      },
                      "actions": [
                        {
                          "type": "container",
                          "decoration": {
                            "border": {
                              "color": "#000000",
                              "width": 0.8
                            },
                            "borderRadius": {
                              "topLeft": 12.0,
                              "topRight": 12.0,
                              "bottomLeft": 12.0,
                              "bottomRight": 12.0
                            }
                          },
                          "child": {
                            "type": "elevatedButton",
                            "onPressed": {
                              "actionType": "closeDialog"
                            },
                            "style": {
                              "foregroundColor": "__STAC_OPEN__appColors.current.text.title}}",
                              "elevation": 0.0,
                              "fixedSize": {
                                "width": 120.0,
                                "height": 44.0
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
                              "type": "text",
                              "data": "__STAC_OPEN__appStrings.common.cancel}}",
                              "textDirection": "rtl",
                              "style": {
                                "type": "custom",
                                "fontSize": 16,
                                "fontWeight": "bold",
                                "color": "__STAC_OPEN__appColors.current.text.title}}"
                              }
                            }
                          }
                        },
                        {
                          "type": "elevatedButton",
                          "onPressed": {
                            "actionType": "sequence",
                            "actions": [
                              {
                                "actionType": "closeDialog"
                              },
                              {
                                "actionType": "networkRequest",
                                "url": "http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/draft",
                                "method": "post",
                                "data": {
                                  "issuerType": "I",
                                  "issuerBirthDate": "__STAC_OPEN__replace(userData.birthDate, '/', '')}}",
                                  "issuerNN": "__STAC_OPEN__userData.nationalCode}}",
                                  "issuerSanaCheck": true,
                                  "issuerCellphone": "__STAC_OPEN__removeLeadingZero(userData.mobile)}}",
                                  "issuerFullName": "__STAC_OPEN__userData.fullName}}",
                                  "issuerAddress": "__STAC_OPEN__userData.address}}",
                                  "issuerPostalCode": "__STAC_OPEN__userData.postalCode}}",
                                  "recipientType": "__STAC_OPEN__payload.recipientType}}",
                                  "recipientBirthDate": "__STAC_OPEN__payload.recipientBirthDate}}",
                                  "recipientNationalId": "__STAC_OPEN__payload.recipientNationalId}}",
                                  "recipientCellphone": "__STAC_OPEN__payload.recipientCellphone}}",
                                  "recipientFullName": "__STAC_OPEN__receiverIdentity.fullName}}",
                                  "paymentPlace": "__STAC_OPEN__form.paymentPlace}}",
                                  "amount": "__STAC_OPEN__toInt(form.promissory_amount)}}",
                                  "dueDate": "__STAC_OPEN__replace(form.promissory_due_date, '/', '')}}",
                                  "description": "__STAC_OPEN__form.description}}",
                                  "transferable": "__STAC_OPEN__form.transferable}}"
                                },
                                "headers": {
                                  "accept": "application/json",
                                  "authorization": "__STAC_OPEN__auth.accessToken}}",
                                  "content-type": "application/json"
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
                                              "key": "form.unsigned_pdf_id",
                                              "value": "__STAC_OPEN__data_payload.unSignedPdfId}}"
                                            },
                                            {
                                              "key": "form.promissory_id",
                                              "value": "__STAC_OPEN__data_payload.id}}"
                                            },
                                            {
                                              "key": "rawTransactionTime",
                                              "value": "__STAC_OPEN__data.meta.time}}"
                                            }
                                          ]
                                        },
                                        {
                                          "actionType": "formatDate",
                                          "sourceKey": "rawTransactionTime",
                                          "destinationKey": "transactionTime"
                                        },
                                        {
                                          "assetPath": "lib/stac/tobank/flows/promissory_real/json/promissory_real_sign.json",
                                          "navigationStyle": "pushReplacement",
                                          "actionType": "navigate"
                                        }
                                      ]
                                    }
                                  }
                                ]
                              }
                            ]
                          },
                          "style": {
                            "foregroundColor": "__STAC_OPEN__appColors.current.primary.onPrimary}}",
                            "backgroundColor": "__STAC_OPEN__appColors.current.primary.color}}",
                            "elevation": 0.0,
                            "fixedSize": {
                              "width": 120.0,
                              "height": 44.0
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
                            "type": "text",
                            "data": "__STAC_OPEN__appStrings.common.confirm}}",
                            "textDirection": "rtl",
                            "style": {
                              "type": "custom",
                              "fontSize": 16,
                              "fontWeight": "bold",
                              "color": "__STAC_OPEN__appColors.current.primary.onPrimary}}"
                            }
                          }
                        }
                      ]
                    },
                    "actionType": "showDialog"
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
                    "data": "{{appStrings.promissory.payAndSign}}",
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
              "type": "container",
              "height": "{{isDepositSelected ? 88 : 0}}",
              "clipBehavior": "hardEdge",
              "decoration": {
                "color": "transparent"
              },
              "child": {
                "padding": {
                  "left": 16.0,
                  "top": 16.0,
                  "right": 16.0,
                  "bottom": 16.0
                },
                "child": {
                  "type": "reactiveElevatedButton",
                  "enabledKey": "isPayEnabled",
                  "enabled": false,
                  "onPressed": {
                    "assetPath": "lib/stac/tobank/flows/promissory_real/json/promissory_real_payment_deposits.json",
                    "navigationStyle": "push",
                    "actionType": "navigate"
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
                    "data": "{{appStrings.promissory.payAndSign}}",
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
        }
      ],
      "type": "column"
    },
    "type": "scaffold"
  }
}
```
