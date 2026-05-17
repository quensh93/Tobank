# flows/promissory/api/GET_promissory_data.json

Source: lib/stac/tobank/flows/promissory/api/GET_promissory_data.json

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
                "child": {
                    "type": "scaffold",
                    "appBar": {
                        "type": "appBar",
                        "title": {
                            "type": "text",
                            "data": "Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ø³ÙØªÙ‡",
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
                                        "id": "amount",
                                        "keyboardType": "number",
                                        "style": {
                                            "type": "custom",
                                            "fontFamily": "IranYekan"
                                        },
                                        "decoration": {
                                            "labelText": "Ù…Ø¨Ù„Øº ØªØ¹Ù‡Ø¯ (Ø±ÛŒØ§Ù„)",
                                            "border": {
                                                "type": "outline"
                                            }
                                        }
                                    },
                                    {
                                        "type": "sizedBox",
                                        "height": 16
                                    },
                                    {
                                        "type": "textFormField",
                                        "id": "dueDate",
                                        "style": {
                                            "type": "custom",
                                            "fontFamily": "IranYekan"
                                        },
                                        "decoration": {
                                            "labelText": "ØªØ§Ø±ÛŒØ® Ø³Ø±Ø±Ø³ÛŒØ¯",
                                            "hintText": "Ù…Ø«Ø§Ù„: 14050320",
                                            "border": {
                                                "type": "outline"
                                            }
                                        }
                                    },
                                    {
                                        "type": "sizedBox",
                                        "height": 16
                                    },
                                    {
                                        "type": "textFormField",
                                        "id": "description",
                                        "maxLines": 3,
                                        "style": {
                                            "type": "custom",
                                            "fontFamily": "IranYekan"
                                        },
                                        "decoration": {
                                            "labelText": "Ø¨Ø§Ø¨Øª / ØªÙˆØ¶ÛŒØ­Ø§Øª",
                                            "border": {
                                                "type": "outline"
                                            }
                                        }
                                    },
                                    {
                                        "type": "spacer"
                                    },
                                    {
                                        "type": "filledButton",
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
                                            "data": "Ù…Ø­Ø§Ø³Ø¨Ù‡ Ù‡Ø²ÛŒÙ†Ù‡ Ùˆ Ø§Ø¯Ø§Ù…Ù‡",
                                            "style": {
                                                "type": "custom",
                                                "fontSize": 18,
                                                "fontWeight": "bold"
                                            }
                                        },
                                        "onPressed": {
                                            "actionType": "networkRequest",
                                            "url": "https://api.tobank.com/promissory_price",
                                            "method": "post",
                                            "body": {
                                                "amount": "{{form.amount}}",
                                                "gssToYekta": false
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
                                                                        "key": "appData.feeAmount",
                                                                        "value": "{{data.data.feeAmount}}"
                                                                    },
                                                                    {
                                                                        "key": "appData.taxAmount",
                                                                        "value": "{{data.data.taxAmount}}"
                                                                    },
                                                                    {
                                                                        "key": "appData.totalAmount",
                                                                        "value": "{{data.data.totalAmount}}"
                                                                    }
                                                                ]
                                                            },
                                                            {
                                                                "actionType": "navigate",
                                                                "widgetType": "promissory_confirm",
                                                                "assetPath": "lib/stac/tobank/flows/promissory/api/GET_promissory_confirm.json"
                                                            }
                                                        ]
                                                    }
                                                }
                                            ]
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
