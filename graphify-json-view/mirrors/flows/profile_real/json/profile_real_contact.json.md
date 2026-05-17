# flows/profile_real/json/profile_real_contact.json

Source: lib/stac/tobank/flows/profile_real/json/profile_real_contact.json

## JSON Paths (sample)
- Could not parse JSON structure for path extraction.

## Raw JSON
```json
{
  "appBar": {
    "leading": {
      "padding": {
        "left": 12.0
      },
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
      "type": "padding"
    },
    "title": {
      "data": "{{appStrings.profile.real.contact.title}}",
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
          "right": 12.0
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
            "width": 31.0,
            "height": 31.0,
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
          "padding": {
            "left": 14.0,
            "top": 14.0,
            "right": 14.0,
            "bottom": 14.0
          },
          "decoration": {
            "color": "{{appColors.current.background.surface}}",
            "border": {
              "color": "{{appColors.current.input.borderEnabled}}",
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
                "data": "{{appStrings.profile.real.contact.addressLabel}}",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.text.subtitle}}",
                  "fontSize": 14.0,
                  "fontWeight": "w500"
                },
                "textAlign": "right",
                "textDirection": "rtl",
                "type": "text"
              },
              {
                "height": 8.0,
                "type": "sizedBox"
              },
              {
                "data": "{{appStrings.profile.real.contact.addressValue}}",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.text.title}}",
                  "fontSize": 16.0,
                  "fontWeight": "w600",
                  "height": 1.8
                },
                "textAlign": "right",
                "textDirection": "rtl",
                "type": "text"
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
          "padding": {
            "left": 14.0,
            "top": 16.0,
            "right": 14.0,
            "bottom": 16.0
          },
          "decoration": {
            "color": "{{appColors.current.background.surface}}",
            "border": {
              "color": "{{appColors.current.input.borderEnabled}}",
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
            "mainAxisAlignment": "spaceBetween",
            "textDirection": "rtl",
            "children": [
              {
                "data": "{{appStrings.profile.real.contact.postalCodeLabel}}",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.text.subtitle}}",
                  "fontSize": 15.0,
                  "fontWeight": "w400"
                },
                "textDirection": "rtl",
                "type": "text"
              },
              {
                "data": "{{appStrings.profile.real.contact.postalCodeValue}}",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.text.title}}",
                  "fontSize": 16.0,
                  "fontWeight": "w600"
                },
                "textDirection": "rtl",
                "type": "text"
              }
            ],
            "type": "row"
          },
          "type": "container"
        },
        {
          "height": 16.0,
          "type": "sizedBox"
        },
        {
          "padding": {
            "left": 14.0,
            "top": 16.0,
            "right": 14.0,
            "bottom": 16.0
          },
          "decoration": {
            "color": "{{appColors.current.background.surface}}",
            "border": {
              "color": "{{appColors.current.input.borderEnabled}}",
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
            "mainAxisAlignment": "spaceBetween",
            "textDirection": "rtl",
            "children": [
              {
                "data": "{{appStrings.profile.real.contact.supportLabel}}",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.text.subtitle}}",
                  "fontSize": 15.0,
                  "fontWeight": "w400"
                },
                "textDirection": "rtl",
                "type": "text"
              },
              {
                "data": "{{appStrings.profile.real.contact.supportValue}}",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.text.title}}",
                  "fontSize": 16.0,
                  "fontWeight": "w600"
                },
                "textDirection": "rtl",
                "type": "text"
              }
            ],
            "type": "row"
          },
          "type": "container"
        },
        {
          "height": 16.0,
          "type": "sizedBox"
        },
        {
          "padding": {
            "left": 14.0,
            "top": 16.0,
            "right": 14.0,
            "bottom": 16.0
          },
          "decoration": {
            "color": "{{appColors.current.background.surface}}",
            "border": {
              "color": "{{appColors.current.input.borderEnabled}}",
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
            "mainAxisAlignment": "spaceBetween",
            "textDirection": "rtl",
            "children": [
              {
                "data": "{{appStrings.profile.real.contact.instagramLabel}}",
                "style": {
                  "type": "custom",
                  "color": "{{appColors.current.text.subtitle}}",
                  "fontSize": 15.0,
                  "fontWeight": "w400"
                },
                "textDirection": "rtl",
                "type": "text"
              },
              {
                "crossAxisAlignment": "end",
                "children": [
                  {
                    "data": "{{appStrings.profile.real.contact.instagramValue}}",
                    "style": {
                      "type": "custom",
                      "color": "{{appColors.current.text.title}}",
                      "fontSize": 16.0,
                      "fontWeight": "w600"
                    },
                    "textDirection": "ltr",
                    "type": "text"
                  },
                  {
                    "height": 2.0,
                    "type": "sizedBox"
                  },
                  {
                    "color": "{{appColors.current.text.title}}",
                    "width": 98.0,
                    "height": 1.0,
                    "type": "container"
                  }
                ],
                "type": "column"
              }
            ],
            "type": "row"
          },
          "type": "container"
        },
        {
          "height": 32.0,
          "type": "sizedBox"
        },
        {
          "child": {
            "data": "{{appStrings.profile.real.contact.connectTitle}}",
            "style": {
              "type": "custom",
              "color": "{{appColors.current.text.title}}",
              "fontSize": 16.0,
              "fontWeight": "w500"
            },
            "textDirection": "rtl",
            "type": "text"
          },
          "type": "center"
        },
        {
          "height": 16.0,
          "type": "sizedBox"
        },
        {
          "mainAxisAlignment": "center",
          "children": [
            {
              "padding": {
                "left": 8.0,
                "right": 8.0
              },
              "child": {
                "child": {
                  "decoration": {
                    "color": "#FDF3F4",
                    "shape": "circle"
                  },
                  "width": 48.0,
                  "height": 48.0,
                  "child": {
                    "child": {
                      "src": "assets/icons/ic_website.svg",
                      "imageType": "asset",
                      "color": "{{appColors.current.primary.color}}",
                      "width": 24.0,
                      "height": 24.0,
                      "type": "image"
                    },
                    "type": "center"
                  },
                  "type": "container"
                },
                "onTap": {
                  "actionType": "showResult",
                  "title": "{{appStrings.profile.real.contact.comingSoonTitle}}",
                  "content": "{{appStrings.profile.real.contact.comingSoonContent}}"
                },
                "type": "gestureDetector"
              },
              "type": "padding"
            },
            {
              "padding": {
                "left": 8.0,
                "right": 8.0
              },
              "child": {
                "child": {
                  "decoration": {
                    "color": "#FDF3F4",
                    "shape": "circle"
                  },
                  "width": 48.0,
                  "height": 48.0,
                  "child": {
                    "child": {
                      "src": "assets/icons/ic_email.svg",
                      "imageType": "asset",
                      "color": "{{appColors.current.primary.color}}",
                      "width": 24.0,
                      "height": 24.0,
                      "type": "image"
                    },
                    "type": "center"
                  },
                  "type": "container"
                },
                "onTap": {
                  "actionType": "showResult",
                  "title": "{{appStrings.profile.real.contact.comingSoonTitle}}",
                  "content": "{{appStrings.profile.real.contact.comingSoonContent}}"
                },
                "type": "gestureDetector"
              },
              "type": "padding"
            },
            {
              "padding": {
                "left": 8.0,
                "right": 8.0
              },
              "child": {
                "child": {
                  "decoration": {
                    "color": "#FDF3F4",
                    "shape": "circle"
                  },
                  "width": 48.0,
                  "height": 48.0,
                  "child": {
                    "child": {
                      "src": "assets/icons/ic_call.svg",
                      "imageType": "asset",
                      "color": "{{appColors.current.primary.color}}",
                      "width": 24.0,
                      "height": 24.0,
                      "type": "image"
                    },
                    "type": "center"
                  },
                  "type": "container"
                },
                "onTap": {
                  "actionType": "showResult",
                  "title": "{{appStrings.profile.real.contact.comingSoonTitle}}",
                  "content": "{{appStrings.profile.real.contact.comingSoonContent}}"
                },
                "type": "gestureDetector"
              },
              "type": "padding"
            }
          ],
          "type": "row"
        },
        {
          "height": 16.0,
          "type": "sizedBox"
        },
        {
          "mainAxisAlignment": "center",
          "children": [
            {
              "padding": {
                "left": 8.0,
                "right": 8.0
              },
              "child": {
                "child": {
                  "decoration": {
                    "color": "#FDF3F4",
                    "shape": "circle"
                  },
                  "width": 48.0,
                  "height": 48.0,
                  "child": {
                    "child": {
                      "src": "assets/icons/ic_aparat.svg",
                      "imageType": "asset",
                      "color": "{{appColors.current.primary.color}}",
                      "width": 24.0,
                      "height": 24.0,
                      "type": "image"
                    },
                    "type": "center"
                  },
                  "type": "container"
                },
                "onTap": {
                  "actionType": "showResult",
                  "title": "{{appStrings.profile.real.contact.comingSoonTitle}}",
                  "content": "{{appStrings.profile.real.contact.comingSoonContent}}"
                },
                "type": "gestureDetector"
              },
              "type": "padding"
            },
            {
              "padding": {
                "left": 8.0,
                "right": 8.0
              },
              "child": {
                "child": {
                  "decoration": {
                    "color": "#FDF3F4",
                    "shape": "circle"
                  },
                  "width": 48.0,
                  "height": 48.0,
                  "child": {
                    "child": {
                      "src": "assets/icons/ic_linkedin.svg",
                      "imageType": "asset",
                      "color": "{{appColors.current.primary.color}}",
                      "width": 24.0,
                      "height": 24.0,
                      "type": "image"
                    },
                    "type": "center"
                  },
                  "type": "container"
                },
                "onTap": {
                  "actionType": "showResult",
                  "title": "{{appStrings.profile.real.contact.comingSoonTitle}}",
                  "content": "{{appStrings.profile.real.contact.comingSoonContent}}"
                },
                "type": "gestureDetector"
              },
              "type": "padding"
            },
            {
              "padding": {
                "left": 8.0,
                "right": 8.0
              },
              "child": {
                "child": {
                  "decoration": {
                    "color": "#FDF3F4",
                    "shape": "circle"
                  },
                  "width": 48.0,
                  "height": 48.0,
                  "child": {
                    "child": {
                      "src": "assets/icons/ic_instagram.svg",
                      "imageType": "asset",
                      "color": "{{appColors.current.primary.color}}",
                      "width": 24.0,
                      "height": 24.0,
                      "type": "image"
                    },
                    "type": "center"
                  },
                  "type": "container"
                },
                "onTap": {
                  "actionType": "showResult",
                  "title": "{{appStrings.profile.real.contact.comingSoonTitle}}",
                  "content": "{{appStrings.profile.real.contact.comingSoonContent}}"
                },
                "type": "gestureDetector"
              },
              "type": "padding"
            }
          ],
          "type": "row"
        }
      ],
      "type": "column"
    },
    "type": "singleChildScrollView"
  },
  "type": "scaffold"
}
```
