import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

class StacTestPage extends StatelessWidget {
  const StacTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stac.fromJson(testJson, context) ?? const SizedBox();
  }
}

// Complex STAC JSON configuration for testing
const Map<String, dynamic> testJson = {
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "STAC Complex Test"
    },
    "actions": [
      {
        "type": "iconButton",
        "icon": {
          "type": "icon",
          "icon": "settings"
        }
      }
    ]
  },
  "body": {
    "type": "padding",
    "padding": {
      "left": 16,
      "right": 16,
      "top": 16,
      "bottom": 16
    },
    "child": {
      "type": "singleChildScrollView",
      "child": {
        "type": "column",
      "children": [
        {
          "type": "card",
          "child": {
            "type": "padding",
            "padding": {
              "left": 16,
              "right": 16,
              "top": 16,
              "bottom": 16
            },
            "child": {
              "type": "column",
              "children": [
                {
                  "type": "text",
                  "data": "🎉 STAC Complex Test",
                  "style": {
                    "fontSize": 24,
                    "fontWeight": "bold"
                  }
                },
                {
                  "type": "sizedBox",
                  "height": 8
                },
                {
                  "type": "text",
                  "data": "This demonstrates various STAC widgets working together",
                  "style": {
                    "fontSize": 16
                  }
                }
              ]
            }
          }
        },
        {
          "type": "sizedBox",
          "height": 20
        },
        {
          "type": "row",
          "mainAxisAlignment": "spaceEvenly",
          "children": [
            {
              "type": "elevatedButton",
              "child": {
                "type": "text",
                "data": "Button 1"
              }
            },
            {
              "type": "outlinedButton",
              "child": {
                "type": "text",
                "data": "Button 2"
              }
            },
            {
              "type": "textButton",
              "child": {
                "type": "text",
                "data": "Button 3"
              }
            }
          ]
        },
        {
          "type": "sizedBox",
          "height": 20
        },
        {
          "type": "container",
          "height": 100,
          "decoration": {
            "borderRadius": 8,
            "color": "Colors.blue.shade100"
          },
          "child": {
            "type": "center",
            "child": {
              "type": "text",
              "data": "Container with decoration",
              "style": {
                "fontSize": 18,
                "fontWeight": "bold"
              }
            }
          }
        },
        {
          "type": "sizedBox",
          "height": 20
        },
        {
          "type": "listView",
          "shrinkWrap": true,
          "physics": "never",
          "children": [
            {
              "type": "listTile",
              "leading": {
                "type": "icon",
                "icon": "star"
              },
              "title": {
                "type": "text",
                "data": "List Item 1"
              },
              "subtitle": {
                "type": "text",
                "data": "This is a subtitle"
              }
            },
            {
              "type": "listTile",
              "leading": {
                "type": "icon",
                "icon": "favorite"
              },
              "title": {
                "type": "text",
                "data": "List Item 2"
              },
              "subtitle": {
                "type": "text",
                "data": "Another subtitle"
              }
            },
            {
              "type": "listTile",
              "leading": {
                "type": "icon",
                "icon": "thumb_up"
              },
              "title": {
                "type": "text",
                "data": "List Item 3"
              },
              "subtitle": {
                "type": "text",
                "data": "Third subtitle"
              }
            }
          ]
        },
        {
          "type": "sizedBox",
          "height": 20
        },
        {
          "type": "wrap",
          "spacing": 8,
          "runSpacing": 8,
          "children": [
            {
              "type": "chip",
              "label": {
                "type": "text",
                "data": "Chip 1"
              }
            },
            {
              "type": "chip",
              "label": {
                "type": "text",
                "data": "Chip 2"
              }
            },
            {
              "type": "chip",
              "label": {
                "type": "text",
                "data": "Chip 3"
              }
            },
            {
              "type": "chip",
              "label": {
                "type": "text",
                "data": "Chip 4"
              }
            }
          ]
        },
        {
          "type": "sizedBox",
          "height": 20
        },
        {
          "type": "divider"
        },
        {
          "type": "sizedBox",
          "height": 20
        },
        {
          "type": "row",
          "mainAxisAlignment": "center",
          "children": [
            {
              "type": "circularProgressIndicator"
            },
            {
              "type": "sizedBox",
              "width": 20
            },
            {
              "type": "expanded",
              "child": {
                "type": "linearProgressIndicator",
                "value": 0.7
              }
            }
          ]
        }
      ]
    }
  }
  },
  "floatingActionButton": {
    "type": "floatingActionButton",
    "child": {
      "type": "icon",
      "icon": "add"
    }
  }
};
