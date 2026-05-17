# flows/promissory/json/promissory_payment.json

Source: lib/stac/tobank/flows/promissory/json/promissory_payment.json

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
                "data": "{{appStrings.promissory.paymentTitle}} JSON",
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
                                                "color": "{{appColors.current.primary.color}}",
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
                                                    "textDirection": "ltr",
                                                    "children": [
                                                        {
                                                            "data": "{{appData.totalAmount}}",
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
                                                        "data": "{{appData.taxAmount}} {{appStrings.common.rial}}",
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
                                                        "data": "{{appData.feeAmount}} {{appStrings.common.rial}}",
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
                                                "color": "{{isWalletSelected ? appColors.current.error.color : appColors.current.input.borderEnabled}}",
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
                                                    "src": "assets/icons/ic_wallet.svg",
                                                    "imageType": "asset",
                                                    "color": "{{appColors.current.primary.color}}",
                                                    "width": 32.0,
                                                    "height": 32.0,
                                                    "type": "image"
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
                                                            },
                                                            {
                                                                "data": "{{wallet.balance}} {{appStrings.common.rial}}",
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
                                                "value": "wallet"
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
                                                "color": "{{isDepositSelected ? appColors.current.primary.color : appColors.current.input.borderEnabled}}",
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
                                                    "src": "assets/icons/ic_branch.svg",
                                                    "imageType": "asset",
                                                    "color": "{{appColors.current.primary.color}}",
                                                    "width": 32.0,
                                                    "height": 32.0,
                                                    "type": "image"
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
                                    "title": {
                                        "data": "{{appStrings.promissory.payConfirmTitle}}",
                                        "textDirection": "rtl",
                                        "type": "text"
                                    },
                                    "content": {
                                        "data": "{{appStrings.promissory.payConfirmMessage}}",
                                        "textDirection": "rtl",
                                        "type": "text"
                                    },
                                    "actions": [
                                        {
                                            "onPressed": {
                                                "actionType": "closeDialog"
                                            },
                                            "child": {
                                                "data": "{{appStrings.common.cancel}}",
                                                "textDirection": "rtl",
                                                "type": "text"
                                            },
                                            "type": "textButton"
                                        },
                                        {
                                            "onPressed": {
                                                "actionType": "sequence",
                                                "actions": [
                                                    {
                                                        "actionType": "closeDialog"
                                                    },
                                                    {
                                                        "actionType": "navigate",
                                                        "assetPath": "lib/stac/tobank/flows/promissory/json/promissory_sign.json",
                                                        "navigationStyle": "pushReplacement"
                                                    }
                                                ]
                                            },
                                            "child": {
                                                "data": "{{appStrings.common.confirm}}",
                                                "textDirection": "rtl",
                                                "type": "text"
                                            },
                                            "type": "textButton"
                                        }
                                    ],
                                    "insetPadding": {
                                        "left": 40.0,
                                        "top": 24.0,
                                        "right": 40.0,
                                        "bottom": 24.0
                                    },
                                    "type": "alertDialog"
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
                                "actionType": "navigate",
                                "assetPath": "lib/stac/tobank/flows/promissory/json/promissory_deposit_select.json",
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
        },
        "type": "scaffold"
    }
}
```
