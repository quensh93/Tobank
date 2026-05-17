# flows/promissory/api/GET_promissory_success.json

Source: lib/stac/tobank/flows/promissory/api/GET_promissory_success.json

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
                    "actionType": "networkRequest",
                    "url": "https://api.tobank.com/promissory_finalize",
                    "method": "post",
                    "results": [
                        {
                            "statusCode": 200,
                            "action": {
                                "actionType": "setValue",
                                "values": [
                                    {
                                        "key": "promissoryId",
                                        "value": "{{data.data.promissoryId}}"
                                    }
                                ]
                            }
                        }
                    ]
                },
                "child": {
                    "type": "scaffold",
                    "body": {
                        "type": "padding",
                        "padding": {
                            "all": 24
                        },
                        "child": {
                            "type": "column",
                            "mainAxisAlignment": "center",
                            "crossAxisAlignment": "center",
                            "children": [
                                {
                                    "type": "icon",
                                    "data": "check_circle",
                                    "size": 80,
                                    "color": "{{appColors.current.success.color}}"
                                },
                                {
                                    "type": "sizedBox",
                                    "height": 24
                                },
                                {
                                    "type": "text",
                                    "data": "ØµØ¯ÙˆØ± Ø³ÙØªÙ‡ Ø¨Ø§ Ù…ÙˆÙÙ‚ÛŒØª Ø§Ù†Ø¬Ø§Ù… Ø´Ø¯",
                                    "style": {
                                        "type": "custom",
                                        "fontSize": 20,
                                        "fontWeight": "bold",
                                        "color": "{{appColors.current.success.color}}"
                                    }
                                },
                                {
                                    "type": "sizedBox",
                                    "height": 8
                                },
                                {
                                    "type": "text",
                                    "data": "Ø´Ù†Ø§Ø³Ù‡ Ø³ÙØªÙ‡: {{promissoryId}}",
                                    "style": {
                                        "type": "custom",
                                        "fontSize": 16
                                    }
                                },
                                {
                                    "type": "sizedBox",
                                    "height": 48
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
                                        "data": "Ø³ÙØªÙ‡â€ŒÙ‡Ø§ÛŒ Ù…Ù†",
                                        "style": {
                                            "type": "custom",
                                            "fontSize": 18,
                                            "fontWeight": "bold"
                                        }
                                    },
                                    "onPressed": {
                                        "actionType": "navigate",
                                        "navigationStyle": "popToRoot"
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
```
