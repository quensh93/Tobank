# flows/promissory/api/GET_promissory_issuer.json

Source: lib/stac/tobank/flows/promissory/api/GET_promissory_issuer.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
    "GET": {
        "statusCode": 200,
        "data": {
            "type": "stateful",
            "onInit": {
                "actionType": "networkRequest",
                "url": "https://api.tobank.com/customer_info",
                "method": "post",
                "body": {
                    "trackingNumber": "d714481d-e19f-445e-a339-374e517db007",
                    "nationalCode": "1272125191",
                    "forceCacheUpdate": false,
                    "forceInquireAddressInfo": true,
                    "getCustomerStartableProcesses": false,
                    "getCustomerDeposits": false,
                    "getCustomerActiveCertificate": false
                },
                "results": [
                    {
                        "statusCode": 200,
                        "action": {
                            "actionType": "setValue",
                            "values": [
                                {
                                    "key": "form.name",
                                    "value": "{{data.data.firstName}} {{data.data.lastName}}"
                                },
                                {
                                    "key": "form.nationalCode",
                                    "value": "{{data.data.nationalCode}}"
                                },
                                {
                                    "key": "form.address",
                                    "value": "{{data.data.address}}"
                                },
                                {
                                    "key": "form.postalCode",
                                    "value": "{{data.data.postalCode}}"
                                }
                            ]
                        }
                    }
                ]
            },
            "child": {
                "type": "scaffold",
                "appBar": {
                    "type": "appBar",
                    "title": {
                        "type": "text",
                        "data": "Ù…Ø´Ø®ØµØ§Øª Ù…ØªØ¹Ù‡Ø¯ (ØµØ§Ø¯Ø±Ú©Ù†Ù†Ø¯Ù‡)",
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
                                    "id": "name",
                                    "readOnly": true,
                                    "title": "Ù†Ø§Ù… Ùˆ Ù†Ø§Ù… Ø®Ø§Ù†ÙˆØ§Ø¯Ú¯ÛŒ",
                                    "style": {
                                        "type": "custom",
                                        "fontFamily": "IranYekan"
                                    },
                                    "decoration": {
                                        "labelText": "Ù†Ø§Ù… Ùˆ Ù†Ø§Ù… Ø®Ø§Ù†ÙˆØ§Ø¯Ú¯ÛŒ",
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
                                    "id": "nationalCode",
                                    "readOnly": true,
                                    "style": {
                                        "type": "custom",
                                        "fontFamily": "IranYekan"
                                    },
                                    "decoration": {
                                        "labelText": "Ú©Ø¯ Ù…Ù„ÛŒ",
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
                                    "id": "address",
                                    "maxLines": 3,
                                    "style": {
                                        "type": "custom",
                                        "fontFamily": "IranYekan"
                                    },
                                    "decoration": {
                                        "labelText": "Ù†Ø´Ø§Ù†ÛŒ",
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
                                    "id": "postalCode",
                                    "style": {
                                        "type": "custom",
                                        "fontFamily": "IranYekan"
                                    },
                                    "decoration": {
                                        "labelText": "Ú©Ø¯ Ù¾Ø³ØªÛŒ",
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
                                        "data": "ØªØ§ÛŒÛŒØ¯ Ùˆ Ø§Ø¯Ø§Ù…Ù‡",
                                        "style": {
                                            "type": "custom",
                                            "fontSize": 18,
                                            "fontWeight": "bold"
                                        }
                                    },
                                    "onPressed": {
                                        "actionType": "navigate",
                                        "widgetType": "promissory_receiver",
                                        "assetPath": "lib/stac/tobank/flows/promissory/api/GET_promissory_receiver.json"
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
