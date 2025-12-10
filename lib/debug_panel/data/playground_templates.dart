/// Playground templates for common STAC patterns
class PlaygroundTemplates {
  static const Map<String, PlaygroundTemplate> templates = {
    'simple_text': PlaygroundTemplate(
      name: 'Simple Text',
      description: 'A basic text widget',
      category: 'Display',
      json: '''
{
  "type": "text",
  "data": "Hello World",
  "style": {
    "fontSize": 24,
    "color": "#333333",
    "fontWeight": "bold"
  }
}''',
    ),
    'button': PlaygroundTemplate(
      name: 'Button with Action',
      description: 'An elevated button with a dialog action',
      category: 'Interactive',
      json: '''
{
  "type": "elevatedButton",
  "child": {
    "type": "text",
    "data": "Click Me"
  },
  "onPressed": {
    "actionType": "showDialog",
    "title": "Success",
    "message": "Button clicked!"
  }
}''',
    ),
    'column_layout': PlaygroundTemplate(
      name: 'Column Layout',
      description: 'A vertical column with multiple children',
      category: 'Layout',
      json: '''
{
  "type": "column",
  "mainAxisAlignment": "center",
  "crossAxisAlignment": "center",
  "children": [
    {
      "type": "text",
      "data": "Title",
      "style": {
        "fontSize": 24,
        "fontWeight": "bold"
      }
    },
    {
      "type": "sizedBox",
      "height": 16
    },
    {
      "type": "text",
      "data": "Subtitle",
      "style": {
        "fontSize": 16,
        "color": "#666666"
      }
    }
  ]
}''',
    ),
    'row_layout': PlaygroundTemplate(
      name: 'Row Layout',
      description: 'A horizontal row with multiple children',
      category: 'Layout',
      json: '''
{
  "type": "row",
  "mainAxisAlignment": "spaceAround",
  "children": [
    {
      "type": "icon",
      "icon": "home",
      "size": 32,
      "color": "#2196F3"
    },
    {
      "type": "icon",
      "icon": "favorite",
      "size": 32,
      "color": "#E91E63"
    },
    {
      "type": "icon",
      "icon": "settings",
      "size": 32,
      "color": "#4CAF50"
    }
  ]
}''',
    ),
    'container': PlaygroundTemplate(
      name: 'Styled Container',
      description: 'A container with padding, margin, and decoration',
      category: 'Layout',
      json: '''
{
  "type": "container",
  "padding": {
    "left": 16,
    "top": 16,
    "right": 16,
    "bottom": 16
  },
  "margin": {
    "all": 8
  },
  "decoration": {
    "color": "#E3F2FD",
    "borderRadius": {
      "all": 12
    },
    "boxShadow": [
      {
        "color": "#00000033",
        "blurRadius": 4,
        "offset": {
          "dx": 0,
          "dy": 2
        }
      }
    ]
  },
  "child": {
    "type": "text",
    "data": "Styled Container",
    "style": {
      "fontSize": 18
    }
  }
}''',
    ),
    'text_field': PlaygroundTemplate(
      name: 'Text Input Field',
      description: 'A text field with label and hint',
      category: 'Interactive',
      json: '''
{
  "type": "textField",
  "decoration": {
    "labelText": "Email",
    "hintText": "Enter your email",
    "border": "outline"
  },
  "keyboardType": "emailAddress"
}''',
    ),
    'image': PlaygroundTemplate(
      name: 'Image Widget',
      description: 'An image from network with fit',
      category: 'Display',
      json: '''
{
  "type": "image",
  "src": "https://picsum.photos/300/200",
  "fit": "cover",
  "width": 300,
  "height": 200
}''',
    ),
    'list_view': PlaygroundTemplate(
      name: 'List View',
      description: 'A scrollable list of items',
      category: 'Layout',
      json: '''
{
  "type": "listView",
  "children": [
    {
      "type": "listTile",
      "leading": {
        "type": "icon",
        "icon": "person"
      },
      "title": {
        "type": "text",
        "data": "John Doe"
      },
      "subtitle": {
        "type": "text",
        "data": "Software Engineer"
      }
    },
    {
      "type": "listTile",
      "leading": {
        "type": "icon",
        "icon": "person"
      },
      "title": {
        "type": "text",
        "data": "Jane Smith"
      },
      "subtitle": {
        "type": "text",
        "data": "Product Manager"
      }
    },
    {
      "type": "listTile",
      "leading": {
        "type": "icon",
        "icon": "person"
      },
      "title": {
        "type": "text",
        "data": "Bob Johnson"
      },
      "subtitle": {
        "type": "text",
        "data": "Designer"
      }
    }
  ]
}''',
    ),
    'card': PlaygroundTemplate(
      name: 'Card Widget',
      description: 'A material design card',
      category: 'Display',
      json: '''
{
  "type": "card",
  "elevation": 4,
  "margin": {
    "all": 16
  },
  "child": {
    "type": "padding",
    "padding": {
      "all": 16
    },
    "child": {
      "type": "column",
      "crossAxisAlignment": "start",
      "children": [
        {
          "type": "text",
          "data": "Card Title",
          "style": {
            "fontSize": 20,
            "fontWeight": "bold"
          }
        },
        {
          "type": "sizedBox",
          "height": 8
        },
        {
          "type": "text",
          "data": "This is a card with some content inside it.",
          "style": {
            "fontSize": 14,
            "color": "#666666"
          }
        }
      ]
    }
  }
}''',
    ),
    'form': PlaygroundTemplate(
      name: 'Simple Form',
      description: 'A form with multiple input fields',
      category: 'Interactive',
      json: '''
{
  "type": "column",
  "crossAxisAlignment": "stretch",
  "children": [
    {
      "type": "text",
      "data": "Sign Up Form",
      "style": {
        "fontSize": 24,
        "fontWeight": "bold"
      }
    },
    {
      "type": "sizedBox",
      "height": 24
    },
    {
      "type": "textField",
      "decoration": {
        "labelText": "Name",
        "hintText": "Enter your name",
        "border": "outline"
      }
    },
    {
      "type": "sizedBox",
      "height": 16
    },
    {
      "type": "textField",
      "decoration": {
        "labelText": "Email",
        "hintText": "Enter your email",
        "border": "outline"
      },
      "keyboardType": "emailAddress"
    },
    {
      "type": "sizedBox",
      "height": 16
    },
    {
      "type": "textField",
      "decoration": {
        "labelText": "Password",
        "hintText": "Enter your password",
        "border": "outline"
      },
      "obscureText": true
    },
    {
      "type": "sizedBox",
      "height": 24
    },
    {
      "type": "elevatedButton",
      "child": {
        "type": "text",
        "data": "Submit"
      },
      "onPressed": {
        "actionType": "showDialog",
        "title": "Success",
        "message": "Form submitted!"
      }
    }
  ]
}''',
    ),
    'scaffold': PlaygroundTemplate(
      name: 'Full Screen',
      description: 'A complete screen with app bar and body',
      category: 'Layout',
      json: '''
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "My Screen"
    }
  },
  "body": {
    "type": "center",
    "child": {
      "type": "column",
      "mainAxisAlignment": "center",
      "children": [
        {
          "type": "icon",
          "icon": "check_circle",
          "size": 64,
          "color": "#4CAF50"
        },
        {
          "type": "sizedBox",
          "height": 16
        },
        {
          "type": "text",
          "data": "Welcome!",
          "style": {
            "fontSize": 24,
            "fontWeight": "bold"
          }
        }
      ]
    }
  }
}''',
    ),
  };

  /// Get all template categories
  static List<String> get categories {
    final cats = templates.values.map((t) => t.category).toSet().toList();
    cats.sort();
    return cats;
  }

  /// Get templates by category
  static List<PlaygroundTemplate> getByCategory(String category) {
    return templates.values
        .where((t) => t.category == category)
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  /// Get all templates as a list
  static List<PlaygroundTemplate> get all {
    return templates.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  /// Get template by key
  static PlaygroundTemplate? getByKey(String key) {
    return templates[key];
  }
}

/// Model for a playground template
class PlaygroundTemplate {
  final String name;
  final String description;
  final String category;
  final String json;

  const PlaygroundTemplate({
    required this.name,
    required this.description,
    required this.category,
    required this.json,
  });
}
