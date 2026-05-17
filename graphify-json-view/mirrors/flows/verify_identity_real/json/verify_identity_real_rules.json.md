# flows/verify_identity_real/json/verify_identity_real_rules.json

Source: lib/stac/tobank/flows/verify_identity_real/json/verify_identity_real_rules.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "appBar": {
    "title": {
      "data": "{{appStrings.authentication.rulesTitle}}",
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
  "backgroundColor": "{{appColors.current.background.surface}}",
  "body": {
    "type": "safeArea",
    "top": false,
    "bottom": true,
    "child": {
      "padding": {
        "left": 16.0,
        "top": 12.0,
        "right": 16.0,
        "bottom": 12.0
      },
      "child": {
        "crossAxisAlignment": "stretch",
        "children": [
          {
            "color": "{{appColors.current.input.borderEnabled}}",
            "height": 1.0,
            "type": "container"
          },
          {
            "height": 24.0,
            "type": "sizedBox"
          },
          {
            "child": {
              "child": {
                "crossAxisAlignment": "stretch",
                "children": [
                  {
                    "data": "Ø´Ø±Ø§ÛŒØ· Ùˆ Ù…Ù‚Ø±Ø±Ø§Øª Ø§Ø±Ø§Ø¦Ù‡ Ø®Ø¯Ù…Ø§Øª ØªÙˆØ¨Ø§Ù†Ú©",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.text.title}}",
                      "fontSize": 17.0,
                      "fontWeight": "w600"
                    },
                    "textDirection": "rtl",
                    "type": "text"
                  },
                  {
                    "height": 12.0,
                    "type": "sizedBox"
                  },
                  {
                    "padding": {
                      "bottom": 4.0
                    },
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "Ø­Ø¯ÙˆØ¯ Ù…Ø³Ø¦ÙˆÙ„ÛŒØª Ùˆ Ø´Ø±Ø§ÛŒØ· Ø¨Ø§Ù†Ú©",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w700",
                            "height": 1.8
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ø§Ù…Ù†ÛŒØª Ø³Ù¾Ø±Ø¯Ù‡â€ŒÙ‡Ø§ Ùˆ ØªØ¶Ø§Ù…ÛŒÙ†",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ù…Ø¨Ø§Ù„Øº Ø³Ù¾Ø±Ø¯Ù‡â€ŒÙ‡Ø§ÛŒ Ù…Ø´ØªØ±ÛŒØ§Ù† Ø¯Ø± Ú†Ø§Ø±Ú†ÙˆØ¨ Ø¶ÙˆØ§Ø¨Ø· Ù‚Ø§Ù†ÙˆÙ†ÛŒ Ùˆ ØªØ§ Ø³Ù‚Ù Ù‚Ø§Ù†ÙˆÙ†ÛŒ ØªØ¹ÛŒÛŒÙ† Ø´Ø¯Ù‡ØŒ Ù…ÙˆØ±Ø¯ ØªØ¶Ù…ÛŒÙ† ØµÙ†Ø¯ÙˆÙ‚ Ø¶Ù…Ø§Ù†Øª Ø³Ù¾Ø±Ø¯Ù‡ Ù‡Ø§ÛŒ Ø¨Ø§Ù†Ú© Ù…Ø±Ú©Ø²ÛŒ Ùˆ Ø¨Ø§Ù†Ú© Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ Ø§Ø³Øª.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ù‡Ù…Ù‡â€ŒÛŒ Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ø­Ø³Ø§Ø¨â€ŒÙ‡Ø§ Ùˆ Ù…Ø¯Ø§Ø±Ú© Ù‡ÙˆÛŒØªÛŒ Ù…Ø´ØªØ±ÛŒØ§Ù† Ù…Ø­Ø±Ù…Ø§Ù†Ù‡ Ø¨ÙˆØ¯Ù‡ Ùˆ Ø¨Ø§Ù†Ú© Ù…ØªØ¹Ù‡Ø¯ Ù…ÛŒâ€ŒØ´ÙˆØ¯ ØªØ­Øª Ù‡Ø± Ø´Ø±Ø§ÛŒØ·ÛŒ Ø¬Ø² Ø¯Ø± Ù…ÙˆØ§Ø±Ø¯ Ù…ØµØ±Ø­Ù‡ Ù‚Ø§Ù†ÙˆÙ†ÛŒ Ùˆ Ø¨Ø§ Ø¯Ø³ØªÙˆØ± Ù…Ø±Ø§Ø¬Ø¹ Ù‚Ø§Ù†ÙˆÙ†ÛŒ Ø§Ø² Ø§ÙØ´Ø§ Ø¢Ù† Ø®ÙˆØ¯Ø¯Ø§Ø±ÛŒ Ù†Ù…Ø§ÛŒØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  {
                    "padding": {
                      "bottom": 4.0
                    },
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "Ø³Ø§Ø¹Ø§Øª Ù¾Ø§Ø³Ø®Ú¯ÙˆÛŒÛŒ",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w700",
                            "height": 1.8
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØªÙˆØ¨Ø§Ù†Ú© ØŒ ÛŒÚ© Ø¨Ø§Ù†Ú© Û²Û´ Ø³Ø§Ø¹ØªÙ‡ Ø§Ø³Øª Ùˆ Ø¯Ø± Ù‡ÛŒÚ† Ø±ÙˆØ² Ùˆ Ø³Ø§Ø¹ØªÛŒ Ø§Ø² Ø³Ø§Ù„ØŒ ØªØ¹Ø·ÛŒÙ„ÛŒ Ù†Ø¯Ø§Ø±Ø¯. ØªÙ…Ø§Ù… Ø±ÙˆØ²Ù‡Ø§ Ùˆ ØªÙ…Ø§Ù… Ø³Ø§Ø¹Ø§Øª Ø´Ø¨Ø§Ù†Ù‡â€ŒØ±ÙˆØ²ØŒ ØªÙˆØ¨Ø§Ù†Ú© Ø¨Ø§Ø² Ø§Ø³Øª.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØªÙˆØ¨Ø§Ù†Ú© Ø§Ø² Ø·Ø±ÛŒÙ‚ Ù…Ø±Ú©Ø² Ø§Ù…ÙˆØ± Ù…Ø´ØªØ±ÛŒØ§Ù† Ø¨Ø§ Ø´Ù…Ø§Ø±Ù‡ ØªÙ…Ø§Ø³23950 ØŒ Ù…ÙˆØ¸Ù Ø¨Ù‡ Ù¾Ø§Ø³Ø®Ú¯ÙˆÛŒÛŒ Ø¨Ù‡ Ù…Ø´ØªØ±ÛŒØ§Ù† Ù…Ø­ØªØ±Ù… Ù…ÛŒâ€ŒØ¨Ø§Ø´Ø¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  {
                    "padding": {
                      "bottom": 4.0
                    },
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "Ú©Ø§Ø±Ù…Ø²Ø¯Ù‡Ø§",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w700",
                            "height": 1.8
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØªÙˆØ¨Ø§Ù†Ú©ØŒ Ú©Ø§Ø±Øªâ€ŒÙ‡Ø§ÛŒ Ø¨Ø§Ù†Ú©ÛŒ Ø¯Ø±Ø®ÙˆØ§Ø³Øª Ø´Ø¯Ù‡ Ù…Ø´ØªØ±ÛŒØ§Ù† Ø±Ø§ Ø¨Ø±Ø§ÛŒ Ø¨Ø§Ø± Ø§ÙˆÙ„ØŒ Ø¨ØµÙˆØ±Øª Ø±Ø§ÛŒÚ¯Ø§Ù† Ùˆ Ø¯Ø± Ú©Ù…ØªØ±ÛŒÙ† Ø²Ù…Ø§Ù† Ù…Ù…Ú©Ù† Ø¨Ù‡ Ø¯Ø³Øª Ù…Ø´ØªØ±ÛŒØ§Ù† Ù…ÛŒâ€ŒØ±Ø³Ø§Ù†Ø¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ú©Ù„ÛŒÙ‡ Ù‡Ø²ÛŒÙ†Ù‡â€ŒÙ‡Ø§ Ùˆ Ú©Ø§Ø±Ù…Ø²Ø¯Ù‡Ø§ÛŒ Ù…Ø±ØªØ¨Ø· Ø¨Ø§ ÙØ±Ø§ÛŒÙ†Ø¯ Ø´Ù†Ø§Ø³Ø§ÛŒÛŒ Ù…Ø´ØªØ±ÛŒØŒ Ø§ÙØªØªØ§Ø­ Ø­Ø³Ø§Ø¨ØŒ ØµØ¯ÙˆØ± Ùˆ Ø§Ø±Ø³Ø§Ù„ Ú©Ø§Ø±Øª ØªÙˆØ³Ø· ØªÙˆØ¨Ø§Ù†Ú© Ù¾Ø±Ø¯Ø§Ø®Øª Ù…ÛŒâ€ŒØ´ÙˆØ¯ Ùˆ Ø®Ø¯Ù…Ø§Øª Ù…Ø°Ú©ÙˆØ± Ø¨Ø±Ø§ÛŒ Ù…Ø´ØªØ±ÛŒØ§Ù† Ù…Ø­ØªØ±Ù… Ø±Ø§ÛŒÚ¯Ø§Ù† Ø§Ø³Øª.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ø§ÙØªØªØ§Ø­ Ø­Ø³Ø§Ø¨ Ø¯Ø± ØªÙˆØ¨Ø§Ù†Ú©ØŒ Ù†ÛŒØ§Ø²Ù…Ù†Ø¯ Ù‡ÛŒÚ† Ù…Ø¨Ù„Øº Ø§ÙˆÙ„ÛŒÙ‡â€ŒØ§ÛŒ Ø¨Ø±Ø§ÛŒ Ø°Ø®ÛŒØ±Ù‡â€ŒØ³Ø§Ø²ÛŒ Ø¯Ø± Ø­Ø³Ø§Ø¨ Ø¨Ù‡ Ø§Ø³ØªØ«Ù†Ø§ Ù…ÙˆØ§Ø±Ø¯ Ù…ØµØ±Ø­Ù‡ Ù‚Ø§Ù†ÙˆÙ†ÛŒ Ù†ÛŒØ³Øª.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ù‡Ø²ÛŒÙ†Ù‡ Ù‡Ø±Ú¯ÙˆÙ†Ù‡ Ù‡Ø¯ÛŒÙ‡ Ùˆ ØªØ´ÙˆÛŒÙ‚ Ù…Ø´ØªØ±ÛŒØ§Ù† Ø¨Ø§Ø¨Øª Ø¯Ø¹ÙˆØª Ù…Ø´ØªØ±ÛŒØ§Ù† Ø¬Ø¯ÛŒØ¯ØŒ Ø¨Ø± Ø¹Ù‡Ø¯Ù‡ ØªÙˆØ¨Ø§Ù†Ú© Ø§Ø³Øª Ùˆ Ù…Ø´ØªØ±ÛŒØ§Ù† Ù‡ÛŒÚ† Ù‡Ø²ÛŒÙ†Ù‡â€ŒØ§ÛŒ Ø±Ø§ Ø¨Ù‡ Ù…Ø¹Ø±Ù Ø¨Ø§Ø¨Øª Ø¯Ø±ÛŒØ§ÙØª Ú©Ø¯ ÙØ¹Ø§Ù„â€ŒØ³Ø§Ø²ÛŒ Ù†Ø¨Ø§ÛŒØ¯ Ù¾Ø±Ø¯Ø§Ø®Øª Ú©Ù†Ù†Ø¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  {
                    "padding": {
                      "bottom": 4.0
                    },
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "Ø§Ù…Ù†ÛŒØª Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ùˆ Ø­Ø±ÛŒÙ… Ø´Ø®ØµÛŒ",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w700",
                            "height": 1.8
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØªÙ…Ø§Ù…ÛŒ Ù…ÙˆØ§Ø±Ø¯ Ø§Ù…Ù†ÛŒØªÛŒ Ú©Ù‡ Ø¨Ø± Ø¹Ù‡Ø¯Ù‡ Ø¨Ø§Ù†Ú© Ø§Ø³Øª ØªÙˆØ³Ø· ØªÙˆØ¨Ø§Ù†Ú© Ø¨Ø§ Ú©Ù…Ø§Ù„ Ø¯Ù‚Øª Ø±Ø¹Ø§ÛŒØª Ø®ÙˆØ§Ù‡Ø¯ Ø´Ø¯ Ùˆ Ù…Ø³Ø¦ÙˆÙ„ÛŒØª Ù‡Ø±Ú¯ÙˆÙ†Ù‡ ØªÙ‚ØµÛŒØ± Ø¯Ø± Ø§ÛŒÙ† Ø®ØµÙˆØµ Ø¨Ø± Ø¹Ù‡Ø¯Ù‡ ØªÙˆØ¨Ø§Ù†Ú© Ø§Ø³Øª.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ø­Ø±ÛŒÙ… Ø´Ø®ØµÛŒ Ú©Ø§Ø±Ø¨Ø±Ø§Ù† Ø¯Ø± Ù‡Ù†Ú¯Ø§Ù… Ø§Ø³ØªÙØ§Ø¯Ù‡ Ø§Ø² Ø§Ù¾Ù„ÛŒÚ©ÛŒØ´Ù† ØªÙˆØ¨Ø§Ù†Ú© Ù†Ø¸ÛŒØ± Ø¯Ø³ØªØ±Ø³ÛŒ Ø¨Ù‡ Ø¯ÙˆØ±Ø¨ÛŒÙ† Ø¨Ù‡ Ø¬Ù‡Øª Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØªØŒ Ø­Ø³Ú¯Ø±Ù‡Ø§ÛŒ Ø¨ÛŒÙˆÙ…ØªØ±ÛŒÚ© Ø¨Ù‡ Ø¬Ù‡Øª ÙˆØ±ÙˆØ¯ Ø¨Ù‡ Ø§Ù¾Ù„ÛŒÚ©ÛŒØ´Ù†ØŒ Ù…ÙˆÙ‚Ø¹ÛŒØª Ù…Ú©Ø§Ù†ÛŒ Ø¨Ù‡ Ø¬Ù‡Øª Ø¯Ø±ÛŒØ§ÙØª Ú©Ø§Ø±Øª Ø¨Ø§Ù†Ú©ÛŒØŒ Ù…Ø®Ø§Ø·Ø¨ÛŒÙ† Ø¨Ù‡ Ø¬Ù‡Øª Ø®Ø±ÛŒØ¯ Ø´Ø§Ø±Ú˜ ØªÙ„ÙÙ† Ù‡Ù…Ø±Ø§Ù‡ØŒ Ù…Ø¯ÛŒØ±ÛŒØª ÙØ§ÛŒÙ„â€ŒÙ‡Ø§ Ø¨Ù‡ Ø¬Ù‡Øª Ø°Ø®ÛŒØ±Ù‡ Ø±Ø³ÛŒØ¯ ØªØ±Ø§Ú©Ù†Ø´â€ŒÙ‡Ø§ Ùˆ ØªØ´Ø®ÛŒØµ Ø§Ù¾Ù„ÛŒÚ©ÛŒØ´Ù†â€ŒÙ‡Ø§ÛŒ Ù…Ø®Ø±Ø¨ ØªÙˆØ³Ø· ØªÙˆØ¨Ø§Ù†Ú© Ø±Ø¹Ø§ÛŒØª Ù…ÛŒâ€ŒØ´ÙˆØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØªÙˆØ¨Ø§Ù†Ú© Ù…ÙˆØ¸Ù Ø§Ø³Øª Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ù‡ÙˆÛŒØªÛŒ Ùˆ Ù…Ø¯Ø§Ø±Ú© Ú©Ø§Ø±Ø¨Ø±Ø§Ù† Ø±Ø§ Ø¯Ø± Ú©Ù…Ø§Ù„ Ø¯Ù‚Øª Ùˆ Ø¬Ø¯ÛŒØª Ù†Ú¯Ù‡Ø¯Ø§Ø±ÛŒ Ù†Ù…Ø§ÛŒØ¯Ø› ØªÙˆØ¨Ø§Ù†Ú© Ù†ÛŒØ² Ø¨Ø§ Ø§Ù†Ø¬Ø§Ù… Ù†Ø¸Ø§Ø±ØªØŒ Ù…Ø³Ø¦ÙˆÙ„ÛŒØª Ù‡Ø±Ú¯ÙˆÙ†Ù‡ Ø³Ùˆ Ø§Ø³ØªÙØ§Ø¯Ù‡ Ø§Ø² Ø¢Ù† Ù‡Ø§ Ø±Ø§ ØªØ¹Ù‡Ø¯ Ù…ÛŒ Ù†Ù…Ø§ÛŒØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  {
                    "padding": {
                      "bottom": 4.0
                    },
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "Ø§Ù…Ú©Ø§Ù†Ø§Øª",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w700",
                            "height": 1.8
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ú©Ø§Ø±Øªâ€ŒÙ‡Ø§ÛŒ Ø¨Ø§Ù†Ú©ÛŒ ØŒ Ø¨Ù‡ Ø´Ø¨Ú©Ù‡â€ŒÙ‡Ø§ÛŒ Ø³Ø±Ø§Ø³Ø±ÛŒ Ø´ØªØ§Ø¨ Ùˆ Ø´Ø§Ù¾Ø±Ú© Ù…ØªØµÙ„ Ø§Ø³Øª Ùˆ Ú©Ø§Ø±Ø¨Ø±Ø§Ù†ØŒ Ø§Ù…Ú©Ø§Ù† Ú©Ø§Ø± Ø¨Ø§ Ù‡Ù…Ù‡ Ø¯Ø³ØªÚ¯Ø§Ù‡â€ŒÙ‡Ø§ÛŒ Ø®ÙˆØ¯Ù¾Ø±Ø¯Ø§Ø² Ø´ØªØ§Ø¨ÛŒ Ø³Ø±Ø§Ø³Ø± Ú©Ø´ÙˆØ±ØŒ Ø¯Ø³ØªÚ¯Ø§Ù‡â€ŒÙ‡Ø§ÛŒ Ú©Ø§Ø±ØªØ®ÙˆØ§Ù† ÙØ±ÙˆØ´Ú¯Ø§Ù‡â€ŒÙ‡Ø§ØŒ Ùˆ Ø¯Ø±Ú¯Ø§Ù‡â€ŒÙ‡Ø§ÛŒ Ù¾Ø±Ø¯Ø§Ø®Øª Ø§ÛŒÙ†ØªØ±Ù†ØªÛŒ Ø±Ø§ Ø¯Ø§Ø±Ù†Ø¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØªÙˆØ¨Ø§Ù†Ú©ØŒ Ù†ÙˆØ¢ÙˆØ±ÛŒ Ø¯Ø± Ù…Ø­ØµÙˆÙ„Ø§Øª Ùˆ Ø®Ø¯Ù…Ø§Øª Ø¨Ø§Ù†Ú©ÛŒ Ø±Ø§ ÙˆØ¸ÛŒÙÙ‡ Ù‚Ø·Ø¹ÛŒ Ùˆ Ø­ØªÙ…ÛŒ Ø®ÙˆØ¯ Ù…ÛŒâ€ŒØ¯Ø§Ù†Ø¯ Ùˆ Ù…Ø£Ù…ÙˆØ±ÛŒØª Ø®ÙˆØ¯ Ø±Ø§ Ø®Ù„Ù‚ Ùˆ Ø·Ø±Ø§Ø­ÛŒ Ú†ÛŒØ²ÛŒ Ø¨ÛŒØ´ØªØ± Ø§Ø² Ú¯Ø°Ø´ØªÙ‡ Ù…ÛŒâ€ŒØ¯Ø§Ù†Ø¯. Ø§ÛŒÙ† Ù…ÙˆØ¶ÙˆØ¹ Ù†Ù‡ ÛŒÚ© Ú†Ø´Ù…â€ŒØ§Ù†Ø¯Ø§Ø² Ø¨Ù„Ú©Ù‡ ÛŒÚ©ÛŒ Ø§Ø² ØªØ¹Ù‡Ø¯Ø§Øª Ù…Ø§Ø³Øª Ø¨Ù‡ Ù…Ø´ØªØ±ÛŒØ§Ù†.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØªÙˆØ¨Ø§Ù†Ú© Ø¶Ø±ÙˆØ±ÛŒ Ù…ÛŒâ€ŒØ¯Ø§Ù†Ø¯ Ø´ÙØ§ÙÛŒØª Ú©Ø§Ù…Ù„ÛŒ Ø¯Ø± Ù…Ø¨Ø§Ù„Øº Ú©Ø§Ø±Ù…Ø²Ø¯Ù‡Ø§ØŒ Ø³ÙˆØ¯Ù‡Ø§ÛŒ Ø¯Ø±ÛŒØ§ÙØªÛŒ Ùˆ Ù¾Ø±Ø¯Ø§Ø®ØªÛŒ Ùˆ Ù†ÛŒØ² Ø¹Ù…Ù„ÛŒØ§Øª Ù…Ø§Ù„ÛŒ Ø¯Ø§Ø´ØªÙ‡ Ø¨Ø§Ø´Ø¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  {
                    "padding": {
                      "bottom": 4.0
                    },
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "Ø­Ø¯ÙˆØ¯ Ù…Ø³Ø¦ÙˆÙ„ÛŒØª Ù…Ø´ØªØ±ÛŒ Ùˆ Ø´Ø±Ø§ÛŒØ· Ù„Ø§Ø²Ù… Ø¨Ø±Ø§ÛŒ Ø§ÙØªØªØ§Ø­ Ø­Ø³Ø§Ø¨:",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w700",
                            "height": 1.8
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ø§ÙØªØªØ§Ø­ Ø­Ø³Ø§Ø¨ Ø¯Ø± ØªÙˆØ¨Ø§Ù†Ú© Ø¨Ø± Ø§Ø³Ø§Ø³ Ø¶ÙˆØ§Ø¨Ø·ØŒ Ù…Ù‚Ø±Ø±Ø§Øª Ùˆ Ø¯Ø³ØªÙˆØ±Ø§Ù„Ø¹Ù…Ù„ Ù‡Ø§ÛŒ Ø¨Ø§Ù†Ú©ÛŒ Ø§Ø¨Ù„Ø§ØºÛŒ Ø§Ø² Ø³ÙˆÛŒ Ø¨Ø§Ù†Ú© Ù…Ø±Ú©Ø²ÛŒ Ùˆ Ø³Ø§ÛŒØ± Ù…Ø±Ø§Ø¬Ø¹ Ù‚Ø§Ù†ÙˆÙ†ÛŒ Ø§Ø³Øª.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ú©Ø§Ø±Ø¨Ø±Ø§Ù† Ø¨Ø§ Ø³Ù† Û±Û¸ Ø³Ø§Ù„ ØªÙ…Ø§Ù… Ùˆ Ø¨Ù‡ Ø¨Ø§Ù„Ø§ØŒ Ù…ÛŒâ€ŒØªÙˆØ§Ù†Ù†Ø¯ Ù†Ø³Ø¨Øª Ø¨Ù‡ Ø§ÙØªØªØ§Ø­ Ø³Ù¾Ø±Ø¯Ù‡ Ø³Ø±Ù…Ø§ÛŒÙ‡ Ú¯Ø°Ø§Ø±ÛŒ Ú©ÙˆØªØ§Ù‡ Ù…Ø¯Øª Ø§Ù‚Ø¯Ø§Ù… Ú©Ù†Ù†Ø¯. Ø¨Ø§Ù†Ú© Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ Ø§Ø³ØªØ±Ø¯Ø§Ø¯ Ù…Ø¨Ù„Øº Ø§ØµÙ„ Ø­Ø³Ø§Ø¨ Ø±Ø§ ØªØ¹Ù‡Ø¯ Ù…ÛŒ Ù†Ù…Ø§ÛŒØ¯ Ùˆ ÙˆØ¬ÙˆÙ‡ Ø­Ø³Ø§Ø¨ Ø³Ø±Ù…Ø§ÛŒÙ‡ Ú¯Ø°Ø§Ø±ÛŒ Ø±Ø§ Ø¨Ø§ Ø­Ù‚ ØªÙˆÚ©ÛŒÙ„ Ø¨Ù‡ ØºÛŒØ± ÙˆÙ„Ùˆ Ú©Ø±Ø§Ø±Ø§ Ùˆ Ø¯Ø± ØµÙˆØ±Øª ÙÙˆØª ØµØ§Ø­Ø¨ / ØµØ§Ø­Ø¨Ø§Ù† Ø­Ø³Ø§Ø¨ Ø¨Ù‡ ÙˆØµØ§ÛŒØª(Ø§Ø² Ø·Ø±Ù ØµØ§Ø­Ø¨/ØµØ§Ø­Ø¨Ø§Ù† Ø­Ø³Ø§Ø¨) Ø·Ø¨Ù‚ Ù‚Ø§Ù†ÙˆÙ† Ø¹Ù…Ù„ÛŒØ§Øª Ø¨Ø§Ù†Ú©ÛŒ Ø¨ÙˆØ¯Ù† Ø±Ø¨Ø§ Ø¨Ù‡ Ø·ÙˆØ± Ù…Ø´Ø§Ø¹ Ø¨Ù‡ Ú©Ø§Ø± Ú¯Ø±ÙØªÙ‡ Ùˆ Ù…Ù†Ø§ÙØ¹ Ø­Ø§ØµÙ„Ù‡ Ø±Ø§ Ù¾Ø³ Ø§Ø² Ú©Ø³Ø± Ø­Ù‚ Ø§Ù„ÙˆÚ©Ø§Ù„Ù‡ Ùˆ Ø­Ù‚ Ø§Ù„ÙˆØµØ§ÛŒÙ‡ Ø¨Ø§ Ø¯Ø§Ø´ØªÙ† Ø­Ù‚ Ù…ØµØ§Ù„Ø­Ù‡ Ø·Ø¨Ù‚ Ø¢ÛŒÛŒÙ† Ù†Ø§Ù…Ù‡ Ùˆ Ù…Ù‚Ø±Ø±Ø§Øª Ù…Ø±Ø¨ÙˆØ·Ù‡ Ø¨Ù‡ ØªÙ†Ø§Ø³Ø¨ Ù…Ø¨Ù„Øº Ùˆ Ù…Ø¯Øª Ø¨Ù‡ Ø°ÛŒÙ†ÙØ¹ Ø­Ø³Ø§Ø¨ Ù‡Ø§ ÛŒØ§ Ù‚Ø§Ø¦Ù… Ù…Ù‚Ø§Ù… Ù‚Ø§Ù†ÙˆÙ†ÛŒ Ø§ÛŒØ´Ø§Ù† Ù¾Ø±Ø¯Ø§Ø®Øª Ù…ÛŒ Ù†Ù…Ø§ÛŒØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØµØ±ÙØ§ ØµØ§Ø­Ø¨ Ø­Ø³Ø§Ø¨ Ø­Ù‚ Ø§Ø³ØªÙØ§Ø¯Ù‡ Ø§Ø² Ù…ÙˆØ¬ÙˆØ¯ÛŒ Ø­Ø³Ø§Ø¨ Ø¢Ù† Ù‡Ù… Ø§Ø² Ø¯Ø±Ú¯Ø§Ù‡â€ŒÙ‡Ø§ÛŒ Ù…ÙˆØ±Ø¯ ØªØ§ÛŒÛŒØ¯ ØªÙˆØ¨Ø§Ù†Ú© Ø±Ø§ Ø¯Ø§Ø±Ø¯ Ùˆ Ø¯Ø± Ù…ÙˆØ§Ù‚Ø¹ Ø¶Ø±ÙˆØ±ÛŒ Ù¾ÛŒØ´ Ø¨ÛŒÙ†ÛŒ Ø´Ø¯Ù‡ Ø¯Ø± Ù‚Ø§Ù†ÙˆÙ† Ù…Ø«Ù„ ÙÙˆØªØŒ Ø­Ø¬Ø± Ùˆ ... ØŒ Ø§Ø³ØªÙØ§Ø¯Ù‡ Ø§Ø² Ø­Ø³Ø§Ø¨ ØµØ±ÙØ§ Ø§Ø² Ø·Ø±ÛŒÙ‚ Ù…Ø±Ú©Ø² Ø¹Ù…Ù„ÛŒØ§Øª ØªÙˆØ¨Ø§Ù†Ú© Ø¨Ø±Ø§ÛŒ ØµØ§Ø­Ø¨ Ø­Ø³Ø§Ø¨ Ùˆ ÛŒØ§ Ù†Ù…Ø§ÛŒÙ†Ø¯Ù‡ Ù‚Ø§Ù†ÙˆÙ†ÛŒ Ø§Ùˆ (ÙˆÙ„ÛŒØŒ ÙˆØµÛŒØŒ Ù‚ÛŒÙ… Ùˆ ÙˆÚ©ÛŒÙ„) Ù¾Ø³ Ø§Ø² Ø§Ø±Ø§ÛŒÙ‡ Ù…Ø¯Ø§Ø±Ú© Ùˆ Ú¯ÙˆØ§Ù‡ÛŒâ€ŒÙ‡Ø§ÛŒ Ù…Ø«Ø¨ØªÙ‡ Ù‚Ø§Ù†ÙˆÙ†ÛŒ Ùˆ Ø±Ø¹Ø§ÛŒØª ØªØ´Ø±ÛŒÙØ§Øª Ù…Ø§Ù„ÛŒØ§ØªÛŒ Ù…Ù…Ú©Ù† Ø®ÙˆØ§Ù‡Ø¯ Ø¨ÙˆØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ù…Ø´ØªØ±ÛŒ Ù…ÛŒâ€ŒØªÙˆØ§Ù†Ø¯ Ø§Ø² Ø·Ø±ÛŒÙ‚ ØªÙˆØ¨Ø§Ù†Ú© Ø¨Ø± Ø§Ø³Ø§Ø³ Ø¶ÙˆØ§Ø¨Ø· Ùˆ Ù…Ù‚Ø±Ø±Ø§Øª Ø§Ø¹Ù„Ø§Ù…ÛŒ Ø§Ø² Ø³ÙˆÛŒ Ø¨Ø§Ù†Ú© Ù…Ø±Ú©Ø²ÛŒ ÛŒØ§ Ø¢ÛŒÛŒÙ†â€ŒÙ†Ø§Ù…Ù‡â€ŒÙ‡Ø§ÛŒ Ø¯Ø§Ø®Ù„ÛŒ Ø¨Ø§Ù†Ú©ØŒ Ù…Ø¨Ø§Ù„Øº Ø±Ø§ Ø§Ø² Ø­Ø³Ø§Ø¨ Ø®ÙˆØ¯ Ø¨Ù‡ Ù‡Ø± Ø­Ø³Ø§Ø¨ÛŒ Ø¯Ø± Ø¨Ø§Ù†Ú© Ú¯Ø±Ø¯Ø´Ú¯Ø±ÛŒ Ùˆ Ø³Ø§ÛŒØ± Ø¨Ø§Ù†Ú©â€ŒÙ‡Ø§ Ù…Ù†ØªÙ‚Ù„ Ù†Ù…Ø§ÛŒØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ø¯Ø± ØµÙˆØ±ØªÛŒ Ú©Ù‡ Ø¨Ø§Ù†Ú© Ø¨Ù‡ Ù‡Ø± Ø·Ø±ÛŒÙ‚ÛŒ Ø§Ø² ÙÙˆØªØŒ Ø­Ø¬Ø± Ùˆ ÙˆØ±Ø´Ú©Ø³ØªÚ¯ÛŒ Ø¯Ø§Ø±Ù†Ø¯Ù‡ Ø­Ø³Ø§Ø¨ ÛŒØ§ Ø§Ø³ØªÙØ§Ø¯Ù‡â€ŒÚ©Ù†Ù†Ø¯Ù‡ Ø§Ø² Ø®Ø¯Ù…Ø§Øª Ø§Ù„Ú©ØªØ±ÙˆÙ†ÛŒÚ©ÛŒ Ù…Ø·Ù„Ø¹ Ú¯Ø±Ø¯Ø¯ Ùˆ Ù‡Ù…Ú†Ù†ÛŒÙ† Ø¯Ø± Ù…ÙˆØ§Ø±Ø¯ÛŒ Ú©Ù‡ Ù†Ø§Ù…Ù‡â€ŒØ§ÛŒ Ø§Ø² Ù…Ø±Ø§Ø¬Ø¹ Ø°ÛŒØµÙ„Ø§Ø­ Ù‚Ø§Ù†ÙˆÙ†ÛŒ Ú©Ù‡ Ø­Ù‚ Ø¨Ø§Ø²Ø¯Ø§Ø´Øª Ø§Ù…ÙˆØ§Ù„ Ø§Ø´Ø®Ø§Øµ Ø±Ø§ Ø¯Ø§Ø±Ù†Ø¯ Ø¯Ø±ÛŒØ§ÙØª Ù†Ù…Ø§ÛŒØ¯ØŒ Ø®Ø¯Ù…Ø§Øª Ù…Ø°Ú©ÙˆØ± Ø±Ø§ ØºÛŒØ±ÙØ¹Ø§Ù„ Ù†Ù…ÙˆØ¯Ù‡ Ùˆ Ø¨Ø§ Ù…Ø§Ù†Ø¯Ù‡ Ø­Ø³Ø§Ø¨â€ŒÙ‡Ø§ÛŒ Ù…Ø±ØªØ¨Ø· Ø¨Ù‡ Ø¢Ù† Ø·Ø¨Ù‚ Ø´Ø±Ø§ÛŒØ· Ùˆ Ù…Ù‚Ø±Ø±Ø§Øª Ø­Ø³Ø§Ø¨â€ŒÙ‡Ø§ÛŒ Ù…Ø°Ú©ÙˆØ± Ø¹Ù…Ù„ Ø®ÙˆØ§Ù‡Ø¯ Ù†Ù…ÙˆØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ú©Ø§Ø±Øª Ø¨Ø§Ù†Ú©ÛŒ ØŒ Ø¨Ù‡ Ø¢Ø¯Ø±Ø³ Ø§Ø¹Ù„Ø§Ù…ÛŒ Ù…Ø´ØªØ±ÛŒØ§Ù† Ø§Ø±Ø³Ø§Ù„ Ù…ÛŒâ€ŒØ´ÙˆØ¯ Ùˆ Ø¯Ø±ÛŒØ§ÙØª Ø±Ù…Ø²Ù‡Ø§ØŒ Ø¯Ø± Ø§Ù¾Ù„ÛŒÚ©ÛŒØ´Ù† Ø§Ù†Ø¬Ø§Ù… Ù…ÛŒâ€ŒØ´ÙˆØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  {
                    "padding": {
                      "bottom": 4.0
                    },
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª Ù…Ø´ØªØ±ÛŒ",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w700",
                            "height": 1.8
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ù…Ø´ØªØ±ÛŒ Ø¨Ø§ Ø±Ø¶Ø§ÛŒØª Ú©Ø§Ù…Ù„ Ø§Ù‚Ø±Ø§Ø± Ù†Ù…ÙˆØ¯ Ú©Ù„ÛŒÙ‡ Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª Ø±Ø§ Ù…Ø·Ø§Ø¨Ù‚ Ø¨Ø§ ÙˆØ§Ù‚Ø¹ÛŒØª Ùˆ Ù…Ù†Ø·Ø¨Ù‚ Ø¨Ø± Ø¢Ø®Ø±ÛŒÙ† Ù…Ø¯Ø§Ø±Ú© Ø´Ù†Ø§Ø³Ø§ÛŒÛŒ Ø®ÙˆØ¯ Ø¯Ø± Ø§Ø®ØªÛŒØ§Ø± ØªÙˆØ¨Ø§Ù†Ú© Ù‚Ø±Ø§Ø± Ø¯Ø§Ø¯Ù‡ Ø§Ø³Øª.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØªÙˆØ¨Ø§Ù†Ú© Ø¯Ø± ØµÙˆØ±Øª Ø¹Ø¯Ù… Ø§Ø­Ø±Ø§Ø² Ø´Ø±Ø§ÛŒØ· Ù…Ù‚Ø±Ø± Ø¨Ø±Ø§ÛŒ Ø§Ø­Ø±Ø§Ø² Ù‡ÙˆÛŒØª ÛŒØ§ ØµÙ„Ø§Ø­ÛŒØª Ù…ØªÙ‚Ø§Ø¶ÛŒØ§Ù†ØŒ Ù…ÛŒâ€ŒØªÙˆØ§Ù†Ø¯ Ø§Ø² Ø§ÙØªØªØ§Ø­ Ø­Ø³Ø§Ø¨ Ø®ÙˆØ¯Ø¯Ø§Ø±ÛŒ Ù†Ù…Ø§ÛŒØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ø¨Ù‡ Ù…Ù†Ø¸ÙˆØ± Ø±Ø¹Ø§ÛŒØª Ø§ØµÙˆÙ„ Ø§Ù…Ù†ÛŒØªÛŒ Ùˆ Ù…Ø±Ø§Ù‚Ø¨Øª Ø§Ø² Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ùˆ Ø­Ù‚ÙˆÙ‚ Ù…Ø´ØªØ±ÛŒØ§Ù†ØŒ Ø§ÛŒÙ† Ø­Ù‚ Ø¨Ø±Ø§ÛŒ ØªÙˆØ¨Ø§Ù†Ú© Ù…Ø­ÙÙˆØ¸ Ø§Ø³Øª Ú©Ù‡ ÙØ±Ø§ÛŒÙ†Ø¯ Ø´Ù†Ø§Ø³Ø§ÛŒÛŒ Ù…Ø´ØªØ±ÛŒ Ø±Ø§ Ø¯Ø± Ù‡Ø± Ø²Ù…Ø§Ù†ÛŒ Ú©Ù‡ Ù„Ø§Ø²Ù… Ø§Ø³Øª ØªÚ©Ø±Ø§Ø± Ùˆ Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ù…Ø´ØªØ±ÛŒ Ø±Ø§ ØµØ­Ù‡â€ŒÚ¯Ø°Ø§Ø±ÛŒ Ù†Ù…Ø§ÛŒØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ù…ØªÙ‚Ø§Ø¶ÛŒ Ø§ÙØªØªØ§Ø­ Ø­Ø³Ø§Ø¨ØŒ Ø¨Ù‡ ØªÙˆØ¨Ø§Ù†Ú© Ø§Ø¬Ø§Ø²Ù‡ Ù…ÛŒâ€ŒØ¯Ù‡Ø¯ ØªØ§ Ø¨Ø±Ø§ÛŒ Ø´Ù†Ø§Ø³Ø§ÛŒÛŒ Ù‡ÙˆÛŒØª Ùˆ Ø§Ø¹ØªØ¨Ø§Ø±Ø³Ù†Ø¬ÛŒ ÙˆÛŒØŒ Ø§Ø² Ù…Ø±Ø§Ø¬Ø¹ Ù‚Ø§Ù†ÙˆÙ†ÛŒ Ùˆ Ø¨Ø§ ØµÙ„Ø§Ø­ÛŒØª Ù†Ø¸ÛŒØ± Ø¨Ø§Ù†Ú© Ù…Ø±Ú©Ø²ÛŒ Ùˆ Ø³Ø§Ø²Ù…Ø§Ù† Ø«Ø¨Øª Ø§Ø­ÙˆØ§Ù„ØŒ Ø¯Ø± Ù…ÙˆØ±Ø¯ Ø§Ø·Ù„Ø§Ø¹Ø§Øª ÙˆÛŒ Ø§Ø³ØªØ¹Ù„Ø§Ù… Ù†Ù…Ø§ÛŒØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØªØ¹Ø±ÛŒÙ Ù…Ø´ØªØ±ÛŒ Ùˆ Ø§ÙØªØªØ§Ø­ Ø­Ø³Ø§Ø¨ Ø¨Ø±Ø§ÛŒ ÙˆÛŒØŒ Ù…Ø³ØªÙ„Ø²Ù… Ø§Ø³ØªØ¹Ù„Ø§Ù…â€ŒÙ‡Ø§ÛŒÛŒ Ø§Ø² Ø¨Ø§Ù†Ú© Ù…Ø±Ú©Ø²ÛŒ Ùˆ Ø«Ø¨Øª Ø§Ø­ÙˆØ§Ù„ Ùˆ Ù†ÛŒØ² ØªØ·Ø§Ø¨Ù‚ Ø¢Ù†Ù‡Ø§ Ø¨Ø§ Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ø§Ø¸Ù‡Ø§Ø± Ø´Ø¯Ù‡â€ŒÛŒ Ú©Ø§Ø±Ø¨Ø± Ø§Ø³ØªØ› Ø¯Ø± ØµÙˆØ±Øª Ø¹Ø¯Ù… ØªØ·Ø§Ø¨Ù‚ Ø§Ø·Ù„Ø§Ø¹Ø§Øª Ù…Ø´ØªØ±ÛŒ Ùˆ ÛŒØ§ ÙˆØ¬ÙˆØ¯ Ø§Ø´Ú©Ø§Ù„ Ø³ÛŒØ³ØªÙ…ÛŒ Ø¯Ø± Ø§Ø³ØªØ¹Ù„Ø§Ù…ØŒ Ù…Ø³Ø¦ÙˆÙ„ÛŒØªÛŒ Ù…ØªÙˆØ¬Ù‡ ØªÙˆØ¨Ø§Ù†Ú© Ù†Ø®ÙˆØ§Ù‡Ø¯ Ø¨ÙˆØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØªÙˆØ¨Ø§Ù†Ú© Ø¨Ø±Ø§ÛŒ Ø§Ø±Ø§Ø¦Ù‡ Ø®Ø¯Ù…Ø§Øª Ø¨Ù‡ Ù…Ø´ØªØ±ÛŒØ§Ù† Ø´Ù†Ø§Ø³Ø§ÛŒÛŒ Ø´Ø¯Ù‡ØŒ Ø¨Ø§ Ø±Ø¹Ø§ÛŒØª Ú©Ø§Ù…Ù„ Ø§ØµÙˆÙ„ Ùˆ Ø§Ø³ØªØ§Ù†Ø¯Ø§Ø±Ø¯Ù‡Ø§ÛŒ Ø§Ù…Ù†ÛŒØªÛŒØŒ Ø§Ø² Ø±ÙˆØ´â€ŒÙ‡Ø§ÛŒÛŒ Ù†Ø¸ÛŒØ± Ø´Ù†Ø§Ø³Ø§ÛŒÛŒ Ø¨Ø§ Ø±Ù…Ø² Ø§Ø®ØªØµØ§ØµÛŒ ÛŒØ§ ÙˆÛŒÚ˜Ú¯ÛŒâ€ŒÙ‡Ø§ÛŒ Ø¨Ø§ÛŒÙˆÙ…ØªØ±ÛŒÚ© Ø§Ø³ØªÙØ§Ø¯Ù‡ Ù…ÛŒâ€ŒÚ©Ù†Ø¯ Ú©Ù‡ Ø¨Ù‡ Ù…Ù†Ø²Ù„Ù‡ ØªØ´Ø®ÛŒØµ Ø¨Ø§ Ø§Ù…Ø¶Ø§ÛŒ Ù…Ø´ØªØ±ÛŒ Ø¨ÙˆØ¯Ù‡ Ùˆ Ø§ÛŒÙ† Ù…ÙˆØ¶ÙˆØ¹ Ù…ÙˆØ±Ø¯ ØªØ§ÛŒÛŒØ¯ Ùˆ Ù…ÙˆØ§ÙÙ‚Øª Ù…Ø´ØªØ±ÛŒ Ù…ÛŒâ€ŒØ¨Ø§Ø´Ø¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  {
                    "padding": {
                      "bottom": 4.0
                    },
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "Ø´Ø±Ø§ÛŒØ· Ø¹Ù…Ù„ÛŒØ§ØªÛŒ ØªÙˆØ¨Ø§Ù†Ú©",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w700",
                            "height": 1.8
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØªÙˆØ¨Ø§Ù†Ú© ÙØ§Ù‚Ø¯ Ø´Ø¹Ø¨Ù‡ ÙÛŒØ²ÛŒÚ©ÛŒ Ø¨Ø±Ø§ÛŒ Ù…Ø±Ø§Ø¬Ø¹Ù‡ Ùˆ Ø§Ù†Ø¬Ø§Ù… Ø¹Ù…Ù„ÛŒØ§Øª Ø¨Ø§Ù†Ú©ÛŒ Ø§Ø³Øª Ùˆ Ù‡Ù…Ù‡ Ø§Ù…ÙˆØ± Ù…Ø´ØªØ±ÛŒØ§Ù† Ø§Ø² Ø¯Ø±Ú¯Ø§Ù‡ Ø§Ù¾Ù„ÛŒÚ©ÛŒØ´Ù† Ø§Ù†Ø¬Ø§Ù… Ù…ÛŒâ€ŒØ´ÙˆØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "Ø¯Ø± Ù…ÙˆØ§Ø±Ø¯ÛŒ Ú©Ù‡ Ø¨Ù†Ø§ Ø¨Ù‡ Ø¹Ù„Ù„ÛŒ Ø§Ø² Ù‚Ø¨ÛŒÙ„ Ø®Ø±Ø§Ø¨ÛŒ Ø²ÛŒØ±Ø³Ø§Ø®ØªÙ‡Ø§ÛŒ Ø§ÛŒÙ†ØªØ±Ù†ØªÛŒØŒ Ø§Ø®ØªÙ„Ø§Ù„ ÛŒØ§ Ù‚Ø·Ø¹ Ø®Ø·ÙˆØ· Ø§Ø±ØªØ¨Ø§Ø·ÛŒ Ùˆ Ø³Ø§ÛŒØ± Ø±ÙˆÛŒØ¯Ø§Ø¯Ù‡Ø§ÛŒ Ø§Ø¬ØªÙ†Ø§Ø¨â€ŒÙ†Ø§Ù¾Ø°ÛŒØ± Ú©Ù‡ Ø®Ø§Ø±Ø¬ Ø§Ø² Ú©Ù†ØªØ±Ù„ ØªÙˆØ¨Ø§Ù†Ú© Ø¨Ø§Ø´Ø¯ØŒ Ø§ÛŒÙ† Ø¨Ø§Ù†Ú© Ù‚Ø§Ø¯Ø± Ø¨Ù‡ Ø§Ø±Ø§Ø¦Ù‡ Ø®Ø¯Ù…Ø§Øª Ø¨Ø§Ù†Ú©ÛŒ Ù†Ø®ÙˆØ§Ù‡Ø¯ Ø¨ÙˆØ¯ Ú©Ù‡ Ø¬Ø²Ø¦ÛŒ Ø§Ø² Ù…Ø§Ù‡ÛŒØª ÛŒÚ© Ø³Ø±ÙˆÛŒØ³â€ŒÙ‡Ø§ÛŒ ØªÙ…Ø§Ù… Ø¯ÛŒØ¬ÛŒØªØ§Ù„ Ø§Ø³Øª.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  {
                    "padding": {
                      "bottom": 4.0
                    },
                    "child": {
                      "crossAxisAlignment": "stretch",
                      "children": [
                        {
                          "data": "Ø§Ø®ØªÛŒØ§Ø±Ø§Øª ØªÙˆØ¨Ø§Ù†Ú©",
                          "style": {
                            "type": "custom",
                            "color": "{{appColors.current.text.title}}",
                            "fontSize": 16.0,
                            "fontWeight": "w700",
                            "height": 1.8
                          },
                          "textAlign": "right",
                          "textDirection": "rtl",
                          "type": "text"
                        },
                        {
                          "padding": {
                            "bottom": 12.0
                          },
                          "child": {
                            "data": "ØµØ§Ø­Ø¨ Ø­Ø³Ø§Ø¨ Ø¶Ù…Ù† Ø¹Ù‚Ø¯ Ø®Ø§Ø±Ø¬ Ù„Ø§Ø²Ù… Ùˆ Ø¨Ù‡ Ø·ÙˆØ± ØºÛŒØ±Ù‚Ø§Ø¨Ù„ Ø¨Ø±Ú¯Ø´Øª Ø¨Ù‡ Ø¨Ø§Ù†Ú© Ø§Ø®ØªÛŒØ§Ø± Ø¯Ø§Ø¯ Ú©Ù‡ Ø§Ú¯Ø± ØªÙˆØ¨Ø§Ù†Ú© ØªØ­Øª Ù‡Ø± Ø¹Ù†ÙˆØ§Ù† Ø§Ø´ØªØ¨Ø§Ù‡Ø§ Ùˆ ÛŒØ§ Ù…Ù† ØºÛŒØ± Ø­Ù‚ ÙˆØ¬ÙˆÙ‡ ÛŒØ§ Ø§Ø±Ù‚Ø§Ù…ÛŒ Ø§Ø¶Ø§ÙÙ‡ Ø¨Ø± Ø­Ø³Ø§Ø¨ Ù…Ø´ØªØ±ÛŒ Ù…Ù†Ø¸ÙˆØ± Ùˆ ÛŒØ§ Ø¯Ø± Ù…Ø­Ø§Ø³Ø¨Ù‡ Ù‡Ø± Ù†ÙˆØ¹ Ø§Ø´ØªØ¨Ø§Ù‡ÛŒ Ù†Ù…Ø§ÛŒØ¯ØŒ Ù…Ø¬Ø§Ø² Ø§Ø³Øª Ø±Ø§Ø³Ø§ Ùˆ Ø¨Ø¯ÙˆÙ† Ù†ÛŒØ§Ø² Ø¨Ù‡ Ù‡Ø±Ú¯ÙˆÙ†Ù‡ ØªØ´Ø±ÛŒÙØ§Øª Ø§Ø¯Ø§Ø±ÛŒ Ùˆ Ù‚Ø¶Ø§ÛŒÛŒ Ù†Ø³Ø¨Øª Ø¨Ù‡ Ø±ÙØ¹ Ø§Ø´ØªØ¨Ø§Ù‡ Ùˆ Ø¨Ø±Ú¯Ø´Øª Ø§Ø² Ø­Ø³Ø§Ø¨ ÙˆÛŒ Ø§Ù‚Ø¯Ø§Ù… Ù†Ù…Ø§ÛŒØ¯ØŒ Ú†Ù†Ø§Ù†Ú†Ù‡ Ù…Ø´ØªØ±ÛŒ ÙˆØ¬ÙˆÙ‡ Ø±Ø§ Ù‚Ø¨Ù„Ø§ Ø¨Ø±Ø¯Ø§Ø´Øª Ù†Ù…Ø§ÛŒØ¯ØŒ Ø¨Ø¯ÛŒÙ†ÙˆØ³ÛŒÙ„Ù‡ ØªØ¹Ù‡Ø¯ Ù†Ù…ÙˆØ¯ Ú©Ù‡ Ø¸Ø±Ù Ù…Ø¯Øª 3 Ø±ÙˆØ² Ú©Ø§Ø±ÛŒ Ù¾Ø³ Ø§Ø² Ø§Ø®Ø·Ø§Ø± Ú©ØªØ¨ÛŒ Ø¨Ø§Ù†Ú© Ù†Ø³Ø¨Øª Ø¨Ù‡ Ø§Ø³ØªØ±Ø¯Ø§Ø¯ ÙˆØ¬Ù‡ Ø§Ù‚Ø¯Ø§Ù… Ù†Ù…Ø§ÛŒØ¯ Ø¯Ø± ØºÛŒØ± Ø§ÛŒÙ† ØµÙˆØ±Øª Ø¹Ù„Ø§ÙˆÙ‡ Ø¨Ø± Ø§Ø³ØªØ±Ø¯Ø§Ø¯ Ø§ØµÙ„ ÙˆØ¬ÙˆÙ‡ Ø§Ø³ØªÙØ§Ø¯Ù‡ Ø´Ø¯Ù‡ØŒ ÙˆØ¬Ù‡ Ø§Ù„ØªØ²Ø§Ù…ÛŒ( Ù…Ø¹Ø§Ø¯Ù„ Ø¨Ø§Ù„Ø§ØªØ±ÛŒÙ† Ù†Ø±Ø® Ø³ÙˆØ¯ ØªØ³Ù‡ÛŒÙ„Ø§Øª Ø§Ø¹Ø·Ø§ÛŒÛŒ Ø¯Ø± Ø¨Ø®Ø´ Ø®Ø¯Ù…Ø§Øª Ø¨Ù‡ Ø¹Ù„Ø§ÙˆÙ‡ 6 Ø¯Ø±ØµØ¯) Ø§Ø² ØªØ§Ø±ÛŒØ® Ø¨Ø±Ø¯Ø§Ø´Øª Ø¨Ù‡ Ø¨Ø§Ù†Ú© Ù¾Ø±Ø¯Ø§Ø®Øª Ù†Ù…Ø§ÛŒØ¯. ØªØ´Ø®ÛŒØµ Ø¨Ø§Ù†Ú© Ø¯Ø± Ù…ÙˆØ±Ø¯ ÙˆÙ‚ÙˆØ¹ Ø§Ø´ØªØ¨Ø§Ù‡ ÛŒØ§ Ù¾Ø±Ø¯Ø§Ø®Øª Ø¨Ø¯ÙˆÙ† Ø­Ù‚ Ùˆ Ù„Ø²ÙˆÙ… Ø¨Ø±Ú¯Ø´Øª Ø§Ø² Ø­Ø³Ø§Ø¨ Ù…Ø¹ØªØ¨Ø± Ø¨ÙˆØ¯Ù‡ Ùˆ ØµØ§Ø­Ø¨ Ø­Ø³Ø§Ø¨ Ø­Ù‚ Ù‡Ø±Ú¯ÙˆÙ†Ù‡ Ø§Ø¹ØªØ±Ø§Ø¶ÛŒ Ø±Ø§ Ø¯Ø± Ø§ÛŒÙ† Ø®ØµÙˆØµ Ø§Ø² Ø®ÙˆØ¯ Ø³Ù„Ø¨ Ù†Ù…ÙˆØ¯.",
                            "style": {
                              "type": "custom",
                              "color": "{{appColors.current.text.subtitle}}",
                              "fontSize": 15.0,
                              "fontWeight": "w500",
                              "height": 1.9
                            },
                            "textAlign": "right",
                            "textDirection": "rtl",
                            "type": "text"
                          },
                          "type": "padding"
                        }
                      ],
                      "type": "column"
                    },
                    "type": "padding"
                  },
                  {
                    "height": 20.0,
                    "type": "sizedBox"
                  },
                  {
                    "padding": {
                      "bottom": 12.0
                    },
                    "child": {
                      "onPressed": {
                        "navigationStyle": "pop",
                        "actionType": "navigate"
                      },
                      "style": {
                        "foregroundColor": "#D61F2C",
                        "backgroundColor": "#FFFFFF",
                        "elevation": 0.0,
                        "fixedSize": {
                          "width": 999999.0,
                          "height": 67.0
                        },
                        "shape": {
                          "side": {
                            "color": "#D61F2C",
                            "width": 1.5
                          },
                          "type": "roundedRectangleBorder",
                          "borderRadius": {
                            "topLeft": 13.0,
                            "topRight": 13.0,
                            "bottomLeft": 13.0,
                            "bottomRight": 13.0
                          }
                        }
                      },
                      "child": {
                        "data": "Ù…ØªÙˆØ¬Ù‡ Ø´Ø¯Ù…",
                        "style": {
                          "type": "custom",
                          "color": "#D61F2C",
                          "fontSize": 17.0,
                          "fontWeight": "w700"
                        },
                        "textDirection": "rtl",
                        "type": "text"
                      },
                      "type": "elevatedButton"
                    },
                    "type": "padding"
                  }
                ],
                "type": "column"
              },
              "type": "singleChildScrollView"
            },
            "type": "expanded"
          }
        ],
        "type": "column"
      },
      "type": "padding"
    }
  },
  "type": "scaffold"
}
```
