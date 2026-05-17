# flows/promissory/api/GET_promissory_payment.json

Source: lib/stac/tobank/flows/promissory/api/GET_promissory_payment.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
    "GET": {
        "statusCode": 200,
        "data": {
            "data": {
                "type": "scaffold",
                "appBar": {
                    "type": "appBar",
                    "title": {
                        "type": "text",
                        "data": "Ø§Ù†ØªØ®Ø§Ø¨ Ø±ÙˆØ´ Ù¾Ø±Ø¯Ø§Ø®Øª",
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
                    "type": "padding",
                    "padding": {
                        "all": 16
                    },
                    "child": {
                        "type": "column",
                        "crossAxisAlignment": "stretch",
                        "children": [
                            {
                                "type": "container",
                                "margin": {
                                    "bottom": 16
                                },
                                "decoration": {
                                    "color": "{{appColors.current.background.surfaceContainer}}",
                                    "borderRadius": {
                                        "all": 12
                                    },
                                    "border": {
                                        "color": "{{appColors.current.input.borderEnabled}}",
                                        "width": 1
                                    }
                                },
                                "child": {
                                    "type": "listTile",
                                    "title": {
                                        "type": "text",
                                        "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ø§Ø² Ø·Ø±ÛŒÙ‚ Ú©ÛŒÙ Ù¾ÙˆÙ„",
                                        "textDirection": "rtl"
                                    },
                                    "subtitle": {
                                        "type": "text",
                                        "data": "Ù…ÙˆØ¬ÙˆØ¯ÛŒ: Ú©Ø§ÙÛŒ",
                                        "textDirection": "rtl"
                                    },
                                    "leading": {
                                        "type": "icon",
                                        "data": "account_balance_wallet",
                                        "color": "{{appColors.current.primary.color}}"
                                    },
                                    "onTap": {
                                        "actionType": "networkRequest",
                                        "url": "https://api.tobank.com/promissory_fee",
                                        "method": "post",
                                        "results": [
                                            {
                                                "statusCode": 200,
                                                "action": {
                                                    "actionType": "navigate",
                                                    "widgetType": "promissory_sign",
                                                    "assetPath": "lib/stac/tobank/flows/promissory/dart/promissory_sign.dart"
                                                }
                                            }
                                        ]
                                    }
                                }
                            },
                            {
                                "type": "container",
                                "decoration": {
                                    "color": "{{appColors.current.background.surfaceContainer}}",
                                    "borderRadius": {
                                        "all": 12
                                    },
                                    "border": {
                                        "color": "{{appColors.current.input.borderEnabled}}",
                                        "width": 1
                                    }
                                },
                                "child": {
                                    "type": "listTile",
                                    "title": {
                                        "type": "text",
                                        "data": "Ù¾Ø±Ø¯Ø§Ø®Øª Ø§ÛŒÙ†ØªØ±Ù†ØªÛŒ (Ø´Ø§Ù¾Ø±Ú©)",
                                        "textDirection": "rtl"
                                    },
                                    "leading": {
                                        "type": "icon",
                                        "data": "language",
                                        "color": "{{appColors.current.secondary.color}}"
                                    },
                                    "onTap": {
                                        "actionType": "showResult",
                                        "title": "Ø¯Ø± Ø­Ø§Ù„ ØªÙˆØ³Ø¹Ù‡",
                                        "content": "Ø§ÛŒÙ† Ø±ÙˆØ´ Ù¾Ø±Ø¯Ø§Ø®Øª ÙØ¹Ù„Ø§ ØºÛŒØ±ÙØ¹Ø§Ù„ Ø§Ø³Øª."
                                    }
                                }
                            }
                        ]
                    }
                }
            }
        }
    }
}
```
