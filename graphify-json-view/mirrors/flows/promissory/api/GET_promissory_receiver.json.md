# flows/promissory/api/GET_promissory_receiver.json

Source: lib/stac/tobank/flows/promissory/api/GET_promissory_receiver.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
    "GET": {
        "statusCode": 200,
        "data": {
            "data": {
                "type": "stateful",
                "onInit": {
                    "actionType": "setValue",
                    "values": [
                        {
                            "key": "isReceiverValid",
                            "value": false
                        }
                    ]
                },
                "child": {
                    "type": "scaffold",
                    "appBar": {
                        "type": "appBar",
                        "title": {
                            "type": "text",
                            "data": "Ù…Ø´Ø®ØµØ§Øª Ú¯ÛŒØ±Ù†Ø¯Ù‡ (Ø°ÛŒÙ†ÙØ¹)",
                            "textDirection": "rtl",
                            "style": {
                                "type": "custom",
                                "fontSize": 18,
                                "fontWeight": "bold",
                                "color": "{{appColors.current.text.title}}"
                            }
                        },
                        "centerTitle": true
                    },
                    "body": {
                        "type": "form",
                        "autovalidateMode": "onUserInteraction",
                        "child": {
                            "type": "padding",
                            "padding": {
                                "all": 16
                            },
                            "child": {
                                "type": "column",
                                "crossAxisAlignment": "stretch",
                                "children": [
                                    {
                                        "type": "textFormField",
                                        "id": "receiverNationalCode",
                                        "keyboardType": "number",
                                        "style": {
                                            "type": "custom",
                                            "fontFamily": "IranYekan"
                                        },
                                        "decoration": {
                                            "labelText": "Ú©Ø¯ Ù…Ù„ÛŒ Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                                            "border": {
                                                "type": "outline"
                                            }
                                        },
                                        "validatorRules": [
                                            {
                                                "rule": "^\\d{10}$",
                                                "message": "Ú©Ø¯ Ù…Ù„ÛŒ Ø¨Ø§ÛŒØ¯ Û±Û° Ø±Ù‚Ù… Ø¨Ø§Ø´Ø¯"
                                            }
                                        ]
                                    },
                                    {
                                        "type": "sizedBox",
                                        "height": 16
                                    },
                                    {
                                        "type": "textFormField",
                                        "id": "receiverMobile",
                                        "keyboardType": "phone",
                                        "style": {
                                            "type": "custom",
                                            "fontFamily": "IranYekan"
                                        },
                                        "decoration": {
                                            "labelText": "Ø´Ù…Ø§Ø±Ù‡ Ù…ÙˆØ¨Ø§ÛŒÙ„ Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                                            "hintText": "0912...",
                                            "border": {
                                                "type": "outline"
                                            }
                                        },
                                        "validatorRules": [
                                            {
                                                "rule": "^09\\d{9}$",
                                                "message": "Ø´Ù…Ø§Ø±Ù‡ Ù…ÙˆØ¨Ø§ÛŒÙ„ ØµØ­ÛŒØ­ Ù†ÛŒØ³Øª"
                                            }
                                        ]
                                    },
                                    {
                                        "type": "sizedBox",
                                        "height": 16
                                    },
                                    {
                                        "type": "textFormField",
                                        "id": "receiverBirthDate",
                                        "style": {
                                            "type": "custom",
                                            "fontFamily": "IranYekan"
                                        },
                                        "decoration": {
                                            "labelText": "ØªØ§Ø±ÛŒØ® ØªÙˆÙ„Ø¯ Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                                            "hintText": "1370-01-01",
                                            "border": {
                                                "type": "outline"
                                            }
                                        }
                                    },
                                    {
                                        "type": "sizedBox",
                                        "height": 24
                                    },
                                    {
                                        "type": "outlinedButton",
                                        "style": {
                                            "minimumSize": {
                                                "width": 999999,
                                                "height": 48
                                            }
                                        },
                                        "child": {
                                            "type": "text",
                                            "data": "Ø§Ø³ØªØ¹Ù„Ø§Ù… Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                                            "style": {
                                                "type": "custom",
                                                "fontWeight": "bold"
                                            }
                                        },
                                        "onPressed": {
                                            "actionType": "networkRequest",
                                            "url": "https://api.tobank.com/dest_user_info",
                                            "method": "post",
                                            "body": {
                                                "birth_date": "{{form.receiverBirthDate}}",
                                                "national_code": "{{form.receiverNationalCode}}",
                                                "mobile": "{{form.receiverMobile}}"
                                            },
                                            "results": [
                                                {
                                                    "statusCode": 200,
                                                    "action": {
                                                        "actionType": "multiAction",
                                                        "actions": [
                                                            {
                                                                "actionType": "setValue",
                                                                "values": [
                                                                    {
                                                                        "key": "isReceiverValid",
                                                                        "value": true
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                "actionType": "showDialog",
                                                                "widget": {
                                                                    "type": "alertDialog",
                                                                    "title": {
                                                                        "type": "text",
                                                                        "data": "ØªØ§ÛŒÛŒØ¯ Ù†Ø§Ù… Ú¯ÛŒØ±Ù†Ø¯Ù‡",
                                                                        "textDirection": "rtl"
                                                                    },
                                                                    "content": {
                                                                        "type": "text",
                                                                        "data": "Ù†Ø§Ù… Ø¯Ø±ÛŒØ§ÙØª Ø´Ø¯Ù‡: {{data.data.first_name}} {{data.data.last_name}}",
                                                                        "textDirection": "rtl"
                                                                    },
                                                                    "actions": [
                                                                        {
                                                                            "type": "textButton",
                                                                            "child": {
                                                                                "type": "text",
                                                                                "data": "Ø¨Ø³ØªÙ†"
                                                                            },
                                                                            "onPressed": {
                                                                                "actionType": "closeDialog"
                                                                            }
                                                                        }
                                                                    ]
                                                                }
                                                            }
                                                        ]
                                                    }
                                                }
                                            ]
                                        }
                                    },
                                    {
                                        "type": "spacer"
                                    },
                                    {
                                        "type": "reactiveElevatedButton",
                                        "enabledKey": "isReceiverValid",
                                        "enabled": false,
                                        "style": {
                                            "backgroundColor": "{{appColors.current.primary.color}}",
                                            "foregroundColor": "{{appColors.current.primary.onPrimary}}",
                                            "minimumSize": {
                                                "width": 999999,
                                                "height": 56
                                            },
                                            "shape": {
                                                "type": "roundedRectangle",
                                                "borderRadius": {
                                                    "all": 12
                                                }
                                            }
                                        },
                                        "child": {
                                            "type": "text",
                                            "data": "Ø§Ø¯Ø§Ù…Ù‡",
                                            "style": {
                                                "type": "custom",
                                                "fontSize": 18,
                                                "fontWeight": "bold"
                                            }
                                        },
                                        "onPressed": {
                                            "actionType": "navigate",
                                            "widgetType": "promissory_data",
                                            "assetPath": "lib/stac/tobank/flows/promissory/api/GET_promissory_data.json"
                                        }
                                    }
                                ]
                            }
                        }
                    }
                }
            }
        }
    }
}
```
