# flows/promissory/json/promissory_deposit_select.json

Source: lib/stac/tobank/flows/promissory/json/promissory_deposit_select.json

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
                "key": "isDeposit0Selected",
                "value": "{{form.selected_deposit_id == \"dep_001\"}}"
            },
            {
                "actionType": "setValue",
                "key": "isDeposit1Selected",
                "value": "{{form.selected_deposit_id == \"dep_002\"}}"
            },
            {
                "actionType": "setValue",
                "key": "isDeposit2Selected",
                "value": "{{form.selected_deposit_id == \"dep_003\"}}"
            },
            {
                "actionType": "setValue",
                "key": "hasSelection",
                "value": "{{form.selected_deposit_id ? true : false}}"
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
                "data": "Ø§Ù†ØªØ®Ø§Ø¨ Ø³Ù¾Ø±Ø¯Ù‡ JSON",
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
            "autovalidateMode": "disabled",
            "child": {
                "crossAxisAlignment": "stretch",
                "children": [
                    {
                        "height": 24.0,
                        "type": "sizedBox"
                    },
                    {
                        "padding": {
                            "left": 16.0,
                            "right": 16.0
                        },
                        "child": {
                            "data": "Ø³Ù¾Ø±Ø¯Ù‡ Ø®ÙˆØ¯ Ø±Ø§ Ø¬Ù‡Øª ØµØ¯ÙˆØ± Ø³ÙØªÙ‡ Ø§Ù†ØªØ®Ø§Ø¨ Ú©Ù†ÛŒØ¯",
                            "style": {
                                "type": "custom",
                                "color": "{{appColors.current.text.title}}",
                                "fontSize": 16.0,
                                "fontWeight": "w600"
                            },
                            "textDirection": "rtl",
                            "type": "text"
                        },
                        "type": "padding"
                    },
                    {
                        "height": 16.0,
                        "type": "sizedBox"
                    },
                    {
                        "child": {
                            "padding": {
                                "left": 16.0,
                                "top": 8.0,
                                "right": 16.0,
                                "bottom": 8.0
                            },
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
                                            "decoration": {
                                                "color": "{{appColors.current.background.surfaceContainer}}",
                                                "border": {
                                                    "color": "{{isDeposit0Selected ? appColors.current.primary.color : appColors.current.input.borderEnabled}}",
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
                                                "crossAxisAlignment": "stretch",
                                                "children": [
                                                    {
                                                        "mainAxisAlignment": "spaceBetween",
                                                        "crossAxisAlignment": "center",
                                                        "textDirection": "rtl",
                                                        "children": [
                                                            {
                                                                "data": "Ø­Ø³Ø§Ø¨ Ø¬Ø§Ø±ÛŒ Ø§ØµÙ„ÛŒ",
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
                                                                "decoration": {
                                                                    "border": {
                                                                        "color": "{{isDeposit0Selected ? appColors.current.primary.color : appColors.current.text.subtitle}}",
                                                                        "width": 2.0
                                                                    },
                                                                    "shape": "circle"
                                                                },
                                                                "width": 24.0,
                                                                "height": 24.0,
                                                                "child": {
                                                                    "child": {
                                                                        "type": "opacity",
                                                                        "opacity": "{{isDeposit0Selected ? 1.0 : 0.0}}",
                                                                        "child": {
                                                                            "decoration": {
                                                                                "color": "{{appColors.current.primary.color}}",
                                                                                "shape": "circle"
                                                                            },
                                                                            "width": 12.0,
                                                                            "height": 12.0,
                                                                            "type": "container"
                                                                        }
                                                                    },
                                                                    "type": "center"
                                                                },
                                                                "type": "container"
                                                            }
                                                        ],
                                                        "type": "row"
                                                    },
                                                    {
                                                        "height": 12.0,
                                                        "type": "sizedBox"
                                                    },
                                                    {
                                                        "color": "{{appColors.current.input.borderEnabled}}",
                                                        "height": 1.0,
                                                        "type": "container"
                                                    },
                                                    {
                                                        "height": 12.0,
                                                        "type": "sizedBox"
                                                    },
                                                    {
                                                        "textDirection": "rtl",
                                                        "children": [
                                                            {
                                                                "data": "Ø´Ù…Ø§Ø±Ù‡ Ø³Ù¾Ø±Ø¯Ù‡: ",
                                                                "style": {
                                                                    "type": "custom",
                                                                    "color": "{{appColors.current.text.subtitle}}",
                                                                    "fontSize": 14.0,
                                                                    "fontWeight": "w400"
                                                                },
                                                                "textDirection": "rtl",
                                                                "type": "text"
                                                            },
                                                            {
                                                                "data": "Û±Û²Û³Û´ÛµÛ¶Û·Û¸Û¹Û°",
                                                                "style": {
                                                                    "type": "custom",
                                                                    "color": "{{appColors.current.text.subtitle}}",
                                                                    "fontSize": 14.0,
                                                                    "fontWeight": "w500"
                                                                },
                                                                "textDirection": "rtl",
                                                                "type": "text"
                                                            }
                                                        ],
                                                        "type": "row"
                                                    },
                                                    {
                                                        "height": 8.0,
                                                        "type": "sizedBox"
                                                    },
                                                    {
                                                        "textDirection": "rtl",
                                                        "children": [
                                                            {
                                                                "data": "Ø´Ù…Ø§Ø±Ù‡ Ø´Ø¨Ø§: ",
                                                                "style": {
                                                                    "type": "custom",
                                                                    "color": "{{appColors.current.text.subtitle}}",
                                                                    "fontSize": 14.0,
                                                                    "fontWeight": "w400"
                                                                },
                                                                "textDirection": "rtl",
                                                                "type": "text"
                                                            },
                                                            {
                                                                "child": {
                                                                    "data": "IRÛ±Û²Û±Û°Û±Û²Û³Û´ÛµÛ¶Û·Û¸Û¹Û°Û±Û²Û³Û´ÛµÛ¶Û·Û¸Û¹Û°Û±",
                                                                    "style": {
                                                                        "type": "custom",
                                                                        "color": "{{appColors.current.text.subtitle}}",
                                                                        "fontSize": 14.0,
                                                                        "fontWeight": "w500"
                                                                    },
                                                                    "textDirection": "rtl",
                                                                    "type": "text"
                                                                },
                                                                "type": "expanded"
                                                            }
                                                        ],
                                                        "type": "row"
                                                    }
                                                ],
                                                "type": "column"
                                            },
                                            "type": "container"
                                        },
                                        "onTap": {
                                            "actions": [
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit0Selected",
                                                    "value": false
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit1Selected",
                                                    "value": false
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit2Selected",
                                                    "value": false
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit0Selected",
                                                    "value": true
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "hasSelection",
                                                    "value": true
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_deposit_id",
                                                    "value": "dep_001"
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_deposit_title",
                                                    "value": "Ø­Ø³Ø§Ø¨ Ø¬Ø§Ø±ÛŒ Ø§ØµÙ„ÛŒ"
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_deposit_number",
                                                    "value": "Û±Û²Û³Û´ÛµÛ¶Û·Û¸Û¹Û°"
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_shaba_number",
                                                    "value": "IRÛ±Û²Û±Û°Û±Û²Û³Û´ÛµÛ¶Û·Û¸Û¹Û°Û±Û²Û³Û´ÛµÛ¶Û·Û¸Û¹Û°Û±"
                                                }
                                            ],
                                            "sync": false,
                                            "actionType": "multiAction"
                                        },
                                        "type": "gestureDetector"
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
                                                    "color": "{{isDeposit1Selected ? appColors.current.primary.color : appColors.current.input.borderEnabled}}",
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
                                                "crossAxisAlignment": "stretch",
                                                "children": [
                                                    {
                                                        "mainAxisAlignment": "spaceBetween",
                                                        "crossAxisAlignment": "center",
                                                        "textDirection": "rtl",
                                                        "children": [
                                                            {
                                                                "data": "Ø­Ø³Ø§Ø¨ Ù¾Ø³â€ŒØ§Ù†Ø¯Ø§Ø²",
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
                                                                "decoration": {
                                                                    "border": {
                                                                        "color": "{{isDeposit1Selected ? appColors.current.primary.color : appColors.current.text.subtitle}}",
                                                                        "width": 2.0
                                                                    },
                                                                    "shape": "circle"
                                                                },
                                                                "width": 24.0,
                                                                "height": 24.0,
                                                                "child": {
                                                                    "child": {
                                                                        "type": "opacity",
                                                                        "opacity": "{{isDeposit1Selected ? 1.0 : 0.0}}",
                                                                        "child": {
                                                                            "decoration": {
                                                                                "color": "{{appColors.current.primary.color}}",
                                                                                "shape": "circle"
                                                                            },
                                                                            "width": 12.0,
                                                                            "height": 12.0,
                                                                            "type": "container"
                                                                        }
                                                                    },
                                                                    "type": "center"
                                                                },
                                                                "type": "container"
                                                            }
                                                        ],
                                                        "type": "row"
                                                    },
                                                    {
                                                        "height": 12.0,
                                                        "type": "sizedBox"
                                                    },
                                                    {
                                                        "color": "{{appColors.current.input.borderEnabled}}",
                                                        "height": 1.0,
                                                        "type": "container"
                                                    },
                                                    {
                                                        "height": 12.0,
                                                        "type": "sizedBox"
                                                    },
                                                    {
                                                        "textDirection": "rtl",
                                                        "children": [
                                                            {
                                                                "data": "Ø´Ù…Ø§Ø±Ù‡ Ø³Ù¾Ø±Ø¯Ù‡: ",
                                                                "style": {
                                                                    "type": "custom",
                                                                    "color": "{{appColors.current.text.subtitle}}",
                                                                    "fontSize": 14.0,
                                                                    "fontWeight": "w400"
                                                                },
                                                                "textDirection": "rtl",
                                                                "type": "text"
                                                            },
                                                            {
                                                                "data": "Û°Û¹Û¸Û·Û¶ÛµÛ°Û´Û³Û²Û±",
                                                                "style": {
                                                                    "type": "custom",
                                                                    "color": "{{appColors.current.text.subtitle}}",
                                                                    "fontSize": 14.0,
                                                                    "fontWeight": "w500"
                                                                },
                                                                "textDirection": "rtl",
                                                                "type": "text"
                                                            }
                                                        ],
                                                        "type": "row"
                                                    },
                                                    {
                                                        "height": 8.0,
                                                        "type": "sizedBox"
                                                    },
                                                    {
                                                        "textDirection": "rtl",
                                                        "children": [
                                                            {
                                                                "data": "Ø´Ù…Ø§Ø±Ù‡ Ø´Ø¨Ø§: ",
                                                                "style": {
                                                                    "type": "custom",
                                                                    "color": "{{appColors.current.text.subtitle}}",
                                                                    "fontSize": 14.0,
                                                                    "fontWeight": "w400"
                                                                },
                                                                "textDirection": "rtl",
                                                                "type": "text"
                                                            },
                                                            {
                                                                "child": {
                                                                    "data": "IRÛ±Û²Û±Û°Û°Û°Û¹Û¸Û·Û¶ÛµÛ°Û´Û³Û²Û±Û°Û¹Û¸Û·Û¶ÛµÛ°Û´Û³Û²Û±Û°",
                                                                    "style": {
                                                                        "type": "custom",
                                                                        "color": "{{appColors.current.text.subtitle}}",
                                                                        "fontSize": 14.0,
                                                                        "fontWeight": "w500"
                                                                    },
                                                                    "textDirection": "rtl",
                                                                    "type": "text"
                                                                },
                                                                "type": "expanded"
                                                            }
                                                        ],
                                                        "type": "row"
                                                    }
                                                ],
                                                "type": "column"
                                            },
                                            "type": "container"
                                        },
                                        "onTap": {
                                            "actions": [
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit0Selected",
                                                    "value": false
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit1Selected",
                                                    "value": false
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit2Selected",
                                                    "value": false
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit1Selected",
                                                    "value": true
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "hasSelection",
                                                    "value": true
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_deposit_id",
                                                    "value": "dep_002"
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_deposit_title",
                                                    "value": "Ø­Ø³Ø§Ø¨ Ù¾Ø³â€ŒØ§Ù†Ø¯Ø§Ø²"
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_deposit_number",
                                                    "value": "Û°Û¹Û¸Û·Û¶ÛµÛ°Û´Û³Û²Û±"
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_shaba_number",
                                                    "value": "IRÛ±Û²Û±Û°Û°Û°Û¹Û¸Û·Û¶ÛµÛ°Û´Û³Û²Û±Û°Û¹Û¸Û·Û¶ÛµÛ°Û´Û³Û²Û±Û°"
                                                }
                                            ],
                                            "sync": false,
                                            "actionType": "multiAction"
                                        },
                                        "type": "gestureDetector"
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
                                                    "color": "{{isDeposit2Selected ? appColors.current.primary.color : appColors.current.input.borderEnabled}}",
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
                                                "crossAxisAlignment": "stretch",
                                                "children": [
                                                    {
                                                        "mainAxisAlignment": "spaceBetween",
                                                        "crossAxisAlignment": "center",
                                                        "textDirection": "rtl",
                                                        "children": [
                                                            {
                                                                "data": "Ø­Ø³Ø§Ø¨ Ù‚Ø±Ø¶â€ŒØ§Ù„Ø­Ø³Ù†Ù‡",
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
                                                                "decoration": {
                                                                    "border": {
                                                                        "color": "{{isDeposit2Selected ? appColors.current.primary.color : appColors.current.text.subtitle}}",
                                                                        "width": 2.0
                                                                    },
                                                                    "shape": "circle"
                                                                },
                                                                "width": 24.0,
                                                                "height": 24.0,
                                                                "child": {
                                                                    "child": {
                                                                        "type": "opacity",
                                                                        "opacity": "{{isDeposit2Selected ? 1.0 : 0.0}}",
                                                                        "child": {
                                                                            "decoration": {
                                                                                "color": "{{appColors.current.primary.color}}",
                                                                                "shape": "circle"
                                                                            },
                                                                            "width": 12.0,
                                                                            "height": 12.0,
                                                                            "type": "container"
                                                                        }
                                                                    },
                                                                    "type": "center"
                                                                },
                                                                "type": "container"
                                                            }
                                                        ],
                                                        "type": "row"
                                                    },
                                                    {
                                                        "height": 12.0,
                                                        "type": "sizedBox"
                                                    },
                                                    {
                                                        "color": "{{appColors.current.input.borderEnabled}}",
                                                        "height": 1.0,
                                                        "type": "container"
                                                    },
                                                    {
                                                        "height": 12.0,
                                                        "type": "sizedBox"
                                                    },
                                                    {
                                                        "textDirection": "rtl",
                                                        "children": [
                                                            {
                                                                "data": "Ø´Ù…Ø§Ø±Ù‡ Ø³Ù¾Ø±Ø¯Ù‡: ",
                                                                "style": {
                                                                    "type": "custom",
                                                                    "color": "{{appColors.current.text.subtitle}}",
                                                                    "fontSize": 14.0,
                                                                    "fontWeight": "w400"
                                                                },
                                                                "textDirection": "rtl",
                                                                "type": "text"
                                                            },
                                                            {
                                                                "data": "Û±Û±Û²Û²Û³Û³Û´Û´ÛµÛµ",
                                                                "style": {
                                                                    "type": "custom",
                                                                    "color": "{{appColors.current.text.subtitle}}",
                                                                    "fontSize": 14.0,
                                                                    "fontWeight": "w500"
                                                                },
                                                                "textDirection": "rtl",
                                                                "type": "text"
                                                            }
                                                        ],
                                                        "type": "row"
                                                    },
                                                    {
                                                        "height": 8.0,
                                                        "type": "sizedBox"
                                                    },
                                                    {
                                                        "textDirection": "rtl",
                                                        "children": [
                                                            {
                                                                "data": "Ø´Ù…Ø§Ø±Ù‡ Ø´Ø¨Ø§: ",
                                                                "style": {
                                                                    "type": "custom",
                                                                    "color": "{{appColors.current.text.subtitle}}",
                                                                    "fontSize": 14.0,
                                                                    "fontWeight": "w400"
                                                                },
                                                                "textDirection": "rtl",
                                                                "type": "text"
                                                            },
                                                            {
                                                                "child": {
                                                                    "data": "IRÛ±Û²Û±Û°Û±Û±Û²Û²Û³Û³Û´Û´ÛµÛµÛ°Û±Û±Û²Û²Û³Û³Û´Û´ÛµÛµÛ¶",
                                                                    "style": {
                                                                        "type": "custom",
                                                                        "color": "{{appColors.current.text.subtitle}}",
                                                                        "fontSize": 14.0,
                                                                        "fontWeight": "w500"
                                                                    },
                                                                    "textDirection": "rtl",
                                                                    "type": "text"
                                                                },
                                                                "type": "expanded"
                                                            }
                                                        ],
                                                        "type": "row"
                                                    }
                                                ],
                                                "type": "column"
                                            },
                                            "type": "container"
                                        },
                                        "onTap": {
                                            "actions": [
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit0Selected",
                                                    "value": false
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit1Selected",
                                                    "value": false
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit2Selected",
                                                    "value": false
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "isDeposit2Selected",
                                                    "value": true
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "hasSelection",
                                                    "value": true
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_deposit_id",
                                                    "value": "dep_003"
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_deposit_title",
                                                    "value": "Ø­Ø³Ø§Ø¨ Ù‚Ø±Ø¶â€ŒØ§Ù„Ø­Ø³Ù†Ù‡"
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_deposit_number",
                                                    "value": "Û±Û±Û²Û²Û³Û³Û´Û´ÛµÛµ"
                                                },
                                                {
                                                    "actionType": "setValue",
                                                    "key": "form.selected_shaba_number",
                                                    "value": "IRÛ±Û²Û±Û°Û±Û±Û²Û²Û³Û³Û´Û´ÛµÛµÛ°Û±Û±Û²Û²Û³Û³Û´Û´ÛµÛµÛ¶"
                                                }
                                            ],
                                            "sync": false,
                                            "actionType": "multiAction"
                                        },
                                        "type": "gestureDetector"
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
                            "top": 16.0,
                            "right": 16.0,
                            "bottom": 16.0
                        },
                        "child": {
                            "type": "reactiveElevatedButton",
                            "enabledKey": "hasSelection",
                            "onPressed": {
                                "assetPath": "lib/stac/tobank/flows/promissory/json/promissory_sign.json",
                                "actionType": "navigate",
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
                ],
                "type": "column"
            },
            "type": "form"
        },
        "type": "scaffold"
    }
}
```
