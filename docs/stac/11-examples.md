# Examples

This section provides comprehensive examples of Stac applications, from simple widgets to complex, production-ready applications.

## Basic Examples

### Hello World

The simplest possible Stac application:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Hello Stac"
    }
  },
  "body": {
    "type": "center",
    "child": {
      "type": "text",
      "data": "Hello, World!",
      "style": {
        "fontSize": 24,
        "fontWeight": "bold"
      }
    }
  }
}
```

### Counter App

A simple counter application:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Counter"
    }
  },
  "body": {
    "type": "center",
    "child": {
      "type": "column",
      "mainAxisAlignment": "center",
      "children": [
        {
          "type": "text",
          "data": "{{counter}}",
          "style": {
            "fontSize": 48,
            "fontWeight": "bold"
          }
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
              "type": "elevatedButton",
              "child": {
                "type": "text",
                "data": "-"
              },
              "onPressed": {
                "actionType": "setValue",
                "key": "counter",
                "value": "{{counter - 1}}"
              }
            },
            {
              "type": "sizedBox",
              "width": 20
            },
            {
              "type": "elevatedButton",
              "child": {
                "type": "text",
                "data": "+"
              },
              "onPressed": {
                "actionType": "setValue",
                "key": "counter",
                "value": "{{counter + 1}}"
              }
            }
          ]
        }
      ]
    }
  }
}
```

## Form Examples

### User Registration Form

A comprehensive user registration form:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "User Registration"
    }
  },
  "body": {
    "type": "singleChildScrollView",
    "child": {
      "type": "container",
      "padding": {
        "top": 20,
        "bottom": 20,
        "left": 16,
        "right": 16
      },
      "child": {
        "type": "form",
        "key": "registrationForm",
        "child": {
          "type": "column",
          "children": [
            {
              "type": "text",
              "data": "Create Your Account",
              "style": {
                "fontSize": 28,
                "fontWeight": "bold",
                "color": "#2C3E50"
              }
            },
            {
              "type": "sizedBox",
              "height": 8
            },
            {
              "type": "text",
              "data": "Fill in your details to get started",
              "style": {
                "fontSize": 16,
                "color": "#7F8C8D"
              }
            },
            {
              "type": "sizedBox",
              "height": 32
            },
            {
              "type": "textFormField",
              "key": "firstName",
              "decoration": {
                "labelText": "First Name",
                "hintText": "Enter your first name",
                "prefixIcon": {
                  "type": "icon",
                  "iconType": "material",
                  "icon": "person"
                }
              },
              "validator": {
                "required": true,
                "minLength": 2
              }
            },
            {
              "type": "sizedBox",
              "height": 16
            },
            {
              "type": "textFormField",
              "key": "lastName",
              "decoration": {
                "labelText": "Last Name",
                "hintText": "Enter your last name",
                "prefixIcon": {
                  "type": "icon",
                  "iconType": "material",
                  "icon": "person"
                }
              },
              "validator": {
                "required": true,
                "minLength": 2
              }
            },
            {
              "type": "sizedBox",
              "height": 16
            },
            {
              "type": "textFormField",
              "key": "email",
              "keyboardType": "emailAddress",
              "decoration": {
                "labelText": "Email Address",
                "hintText": "Enter your email",
                "prefixIcon": {
                  "type": "icon",
                  "iconType": "material",
                  "icon": "email"
                }
              },
              "validator": {
                "required": true,
                "email": true
              }
            },
            {
              "type": "sizedBox",
              "height": 16
            },
            {
              "type": "textFormField",
              "key": "password",
              "obscureText": true,
              "decoration": {
                "labelText": "Password",
                "hintText": "Enter your password",
                "prefixIcon": {
                  "type": "icon",
                  "iconType": "material",
                  "icon": "lock"
                }
              },
              "validator": {
                "required": true,
                "minLength": 8
              }
            },
            {
              "type": "sizedBox",
              "height": 16
            },
            {
              "type": "textFormField",
              "key": "confirmPassword",
              "obscureText": true,
              "decoration": {
                "labelText": "Confirm Password",
                "hintText": "Confirm your password",
                "prefixIcon": {
                  "type": "icon",
                  "iconType": "material",
                  "icon": "lock"
                }
              },
              "validator": {
                "required": true,
                "minLength": 8
              }
            },
            {
              "type": "sizedBox",
              "height": 32
            },
            {
              "type": "elevatedButton",
              "child": {
                "type": "text",
                "data": "Create Account",
                "style": {
                  "color": "#FFFFFF",
                  "fontSize": 16,
                  "fontWeight": "bold"
                }
              },
              "style": {
                "backgroundColor": "#3498DB",
                "padding": {
                  "top": 16,
                  "bottom": 16
                }
              },
              "onPressed": {
                "actionType": "multi",
                "actions": [
                  {
                    "actionType": "formValidate",
                    "formKey": "registrationForm"
                  },
                  {
                    "actionType": "getFormValue",
                    "formKey": "registrationForm",
                    "onSuccess": {
                      "actionType": "networkRequest",
                      "url": "https://api.example.com/users",
                      "method": "POST",
                      "body": "{{formData}}",
                      "onSuccess": {
                        "actionType": "snackBar",
                        "message": "Account created successfully!"
                      },
                      "onError": {
                        "actionType": "snackBar",
                        "message": "Failed to create account"
                      }
                    },
                    "onError": {
                      "actionType": "snackBar",
                      "message": "Please fill in all required fields"
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
```

### Login Form

A simple login form:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Login"
    }
  },
  "body": {
    "type": "center",
    "child": {
      "type": "container",
      "padding": {
        "top": 20,
        "bottom": 20,
        "left": 16,
        "right": 16
      },
      "child": {
        "type": "form",
        "key": "loginForm",
        "child": {
          "type": "column",
          "children": [
            {
              "type": "text",
              "data": "Welcome Back",
              "style": {
                "fontSize": 28,
                "fontWeight": "bold",
                "color": "#2C3E50"
              }
            },
            {
              "type": "sizedBox",
              "height": 8
            },
            {
              "type": "text",
              "data": "Sign in to your account",
              "style": {
                "fontSize": 16,
                "color": "#7F8C8D"
              }
            },
            {
              "type": "sizedBox",
              "height": 32
            },
            {
              "type": "textFormField",
              "key": "email",
              "keyboardType": "emailAddress",
              "decoration": {
                "labelText": "Email",
                "hintText": "Enter your email",
                "prefixIcon": {
                  "type": "icon",
                  "iconType": "material",
                  "icon": "email"
                }
              },
              "validator": {
                "required": true,
                "email": true
              }
            },
            {
              "type": "sizedBox",
              "height": 16
            },
            {
              "type": "textFormField",
              "key": "password",
              "obscureText": true,
              "decoration": {
                "labelText": "Password",
                "hintText": "Enter your password",
                "prefixIcon": {
                  "type": "icon",
                  "iconType": "material",
                  "icon": "lock"
                }
              },
              "validator": {
                "required": true,
                "minLength": 6
              }
            },
            {
              "type": "sizedBox",
              "height": 24
            },
            {
              "type": "elevatedButton",
              "child": {
                "type": "text",
                "data": "Sign In",
                "style": {
                  "color": "#FFFFFF",
                  "fontSize": 16,
                  "fontWeight": "bold"
                }
              },
              "style": {
                "backgroundColor": "#3498DB",
                "padding": {
                  "top": 16,
                  "bottom": 16
                }
              },
              "onPressed": {
                "actionType": "multi",
                "actions": [
                  {
                    "actionType": "formValidate",
                    "formKey": "loginForm"
                  },
                  {
                    "actionType": "getFormValue",
                    "formKey": "loginForm",
                    "onSuccess": {
                      "actionType": "networkRequest",
                      "url": "https://api.example.com/auth/login",
                      "method": "POST",
                      "body": "{{formData}}",
                      "onSuccess": {
                        "actionType": "navigate",
                        "route": "/dashboard"
                      },
                      "onError": {
                        "actionType": "snackBar",
                        "message": "Invalid credentials"
                      }
                    }
                  }
                ]
              }
            },
            {
              "type": "sizedBox",
              "height": 16
            },
            {
              "type": "textButton",
              "child": {
                "type": "text",
                "data": "Forgot Password?",
                "style": {
                  "color": "#3498DB"
                }
              },
              "onPressed": {
                "actionType": "navigate",
                "route": "/forgot-password"
              }
            }
          ]
        }
      }
    }
  }
}
```

## Navigation Examples

### Bottom Navigation

A bottom navigation bar with multiple screens:

```json
{
  "type": "scaffold",
  "body": {
    "type": "bottomNavigationView",
    "currentIndex": "{{currentTab}}",
    "onTap": {
      "actionType": "setValue",
      "key": "currentTab",
      "value": "{{index}}"
    },
    "children": [
      {
        "type": "scaffold",
        "appBar": {
          "type": "appBar",
          "title": {
            "type": "text",
            "data": "Home"
          }
        },
        "body": {
          "type": "center",
          "child": {
            "type": "text",
            "data": "Home Screen",
            "style": {
              "fontSize": 24,
              "fontWeight": "bold"
            }
          }
        }
      },
      {
        "type": "scaffold",
        "appBar": {
          "type": "appBar",
          "title": {
            "type": "text",
            "data": "Search"
          }
        },
        "body": {
          "type": "center",
          "child": {
            "type": "text",
            "data": "Search Screen",
            "style": {
              "fontSize": 24,
              "fontWeight": "bold"
            }
          }
        }
      },
      {
        "type": "scaffold",
        "appBar": {
          "type": "appBar",
          "title": {
            "type": "text",
            "data": "Profile"
          }
        },
        "body": {
          "type": "center",
          "child": {
            "type": "text",
            "data": "Profile Screen",
            "style": {
              "fontSize": 24,
              "fontWeight": "bold"
            }
          }
        }
      }
    ],
    "bottomNavigationBar": {
      "type": "bottomNavigationBar",
      "currentIndex": "{{currentTab}}",
      "onTap": {
        "actionType": "setValue",
        "key": "currentTab",
        "value": "{{index}}"
      },
      "items": [
        {
          "icon": {
            "type": "icon",
            "iconType": "material",
            "icon": "home"
          },
          "label": "Home"
        },
        {
          "icon": {
            "type": "icon",
            "iconType": "material",
            "icon": "search"
          },
          "label": "Search"
        },
        {
          "icon": {
            "type": "icon",
            "iconType": "material",
            "icon": "person"
          },
          "label": "Profile"
        }
      ]
    }
  }
}
```

### Tab Navigation

A tab-based navigation system:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "My App"
    },
    "bottom": {
      "type": "tabBar",
      "tabs": [
        {
          "text": "Home"
        },
        {
          "text": "Search"
        },
        {
          "text": "Profile"
        }
      ]
    }
  },
  "body": {
    "type": "tabBarView",
    "children": [
      {
        "type": "center",
        "child": {
          "type": "text",
          "data": "Home Tab",
          "style": {
            "fontSize": 24,
            "fontWeight": "bold"
          }
        }
      },
      {
        "type": "center",
        "child": {
          "type": "text",
          "data": "Search Tab",
          "style": {
            "fontSize": 24,
            "fontWeight": "bold"
          }
        }
      },
      {
        "type": "center",
        "child": {
          "type": "text",
          "data": "Profile Tab",
          "style": {
            "fontSize": 24,
            "fontWeight": "bold"
          }
        }
      }
    ]
  }
}
```

## List Examples

### Simple List

A basic list with items:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Items"
    }
  },
  "body": {
    "type": "listView",
    "children": [
      {
        "type": "listTile",
        "title": {
          "type": "text",
          "data": "Item 1"
        },
        "subtitle": {
          "type": "text",
          "data": "Description 1"
        },
        "leading": {
          "type": "icon",
          "iconType": "material",
          "icon": "star"
        },
        "trailing": {
          "type": "icon",
          "iconType": "material",
          "icon": "arrow_forward"
        },
        "onTap": {
          "actionType": "snackBar",
          "message": "Item 1 tapped"
        }
      },
      {
        "type": "listTile",
        "title": {
          "type": "text",
          "data": "Item 2"
        },
        "subtitle": {
          "type": "text",
          "data": "Description 2"
        },
        "leading": {
          "type": "icon",
          "iconType": "material",
          "icon": "favorite"
        },
        "trailing": {
          "type": "icon",
          "iconType": "material",
          "icon": "arrow_forward"
        },
        "onTap": {
          "actionType": "snackBar",
          "message": "Item 2 tapped"
        }
      },
      {
        "type": "listTile",
        "title": {
          "type": "text",
          "data": "Item 3"
        },
        "subtitle": {
          "type": "text",
          "data": "Description 3"
        },
        "leading": {
          "type": "icon",
          "iconType": "material",
          "icon": "bookmark"
        },
        "trailing": {
          "type": "icon",
          "iconType": "material",
          "icon": "arrow_forward"
        },
        "onTap": {
          "actionType": "snackBar",
          "message": "Item 3 tapped"
        }
      }
    ]
  }
}
```

### Dynamic List

A list with dynamic data:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Dynamic List"
    }
  },
  "body": {
    "type": "dynamicView",
    "data": "{{items}}",
    "itemBuilder": {
      "type": "listTile",
      "title": {
        "type": "text",
        "data": "{{item.name}}"
      },
      "subtitle": {
        "type": "text",
        "data": "{{item.description}}"
      },
      "leading": {
        "type": "icon",
        "iconType": "material",
        "icon": "{{item.icon}}"
      },
      "onTap": {
        "actionType": "navigate",
        "route": "/item/{{item.id}}"
      }
    }
  }
}
```

## Card Examples

### Product Card

A product card with image and details:

```json
{
  "type": "card",
  "child": {
    "type": "column",
    "crossAxisAlignment": "start",
    "children": [
      {
        "type": "image",
        "src": "https://example.com/product.jpg",
        "height": 200,
        "width": "100%",
        "fit": "cover"
      },
      {
        "type": "padding",
        "padding": {
          "top": 16,
          "bottom": 16,
          "left": 16,
          "right": 16
        },
        "child": {
          "type": "column",
          "crossAxisAlignment": "start",
          "children": [
            {
              "type": "text",
              "data": "Product Name",
              "style": {
                "fontSize": 18,
                "fontWeight": "bold",
                "color": "#2C3E50"
              }
            },
            {
              "type": "sizedBox",
              "height": 4
            },
            {
              "type": "text",
              "data": "Product description goes here",
              "style": {
                "fontSize": 14,
                "color": "#7F8C8D"
              }
            },
            {
              "type": "sizedBox",
              "height": 8
            },
            {
              "type": "row",
              "mainAxisAlignment": "spaceBetween",
              "children": [
                {
                  "type": "text",
                  "data": "$99.99",
                  "style": {
                    "fontSize": 20,
                    "fontWeight": "bold",
                    "color": "#E74C3C"
                  }
                },
                {
                  "type": "elevatedButton",
                  "child": {
                    "type": "text",
                    "data": "Add to Cart",
                    "style": {
                      "color": "#FFFFFF",
                      "fontSize": 14
                    }
                  },
                  "style": {
                    "backgroundColor": "#3498DB"
                  },
                  "onPressed": {
                    "actionType": "snackBar",
                    "message": "Added to cart"
                  }
                }
              ]
            }
          ]
        }
      }
    ]
  }
}
```

### User Profile Card

A user profile card:

```json
{
  "type": "card",
  "child": {
    "type": "padding",
    "padding": {
      "top": 20,
      "bottom": 20,
      "left": 16,
      "right": 16
    },
    "child": {
      "type": "row",
      "children": [
        {
          "type": "circleAvatar",
          "radius": 30,
          "backgroundImage": "https://example.com/avatar.jpg",
          "child": {
            "type": "text",
            "data": "JD"
          }
        },
        {
          "type": "sizedBox",
          "width": 16
        },
        {
          "type": "expanded",
          "child": {
            "type": "column",
            "crossAxisAlignment": "start",
            "children": [
              {
                "type": "text",
                "data": "John Doe",
                "style": {
                  "fontSize": 18,
                  "fontWeight": "bold",
                  "color": "#2C3E50"
                }
              },
              {
                "type": "sizedBox",
                "height": 4
              },
              {
                "type": "text",
                "data": "Software Developer",
                "style": {
                  "fontSize": 14,
                  "color": "#7F8C8D"
                }
              },
              {
                "type": "sizedBox",
                "height": 4
              },
              {
                "type": "text",
                "data": "San Francisco, CA",
                "style": {
                  "fontSize": 12,
                  "color": "#95A5A6"
                }
              }
            ]
          }
        },
        {
          "type": "iconButton",
          "icon": {
            "type": "icon",
            "iconType": "material",
            "icon": "more_vert"
          },
          "onPressed": {
            "actionType": "modalBottomSheet",
            "title": "Options",
            "items": [
              {
                "text": "Edit Profile",
                "onTap": {
                  "actionType": "navigate",
                  "route": "/edit-profile"
                }
              },
              {
                "text": "Settings",
                "onTap": {
                  "actionType": "navigate",
                  "route": "/settings"
                }
              }
            ]
          }
        }
      ]
    }
  }
}
```

## Dashboard Examples

### Analytics Dashboard

A dashboard with charts and metrics:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Analytics Dashboard"
    }
  },
  "body": {
    "type": "singleChildScrollView",
    "child": {
      "type": "padding",
      "padding": {
        "top": 16,
        "bottom": 16,
        "left": 16,
        "right": 16
      },
      "child": {
        "type": "column",
        "children": [
          {
            "type": "row",
            "children": [
              {
                "type": "expanded",
                "child": {
                  "type": "card",
                  "child": {
                    "type": "padding",
                    "padding": {
                      "top": 16,
                      "bottom": 16,
                      "left": 16,
                      "right": 16
                    },
                    "child": {
                      "type": "column",
                      "children": [
                        {
                          "type": "text",
                          "data": "Total Users",
                          "style": {
                            "fontSize": 14,
                            "color": "#7F8C8D"
                          }
                        },
                        {
                          "type": "sizedBox",
                          "height": 4
                        },
                        {
                          "type": "text",
                          "data": "1,234",
                          "style": {
                            "fontSize": 24,
                            "fontWeight": "bold",
                            "color": "#2C3E50"
                          }
                        }
                      ]
                    }
                  }
                }
              },
              {
                "type": "sizedBox",
                "width": 16
              },
              {
                "type": "expanded",
                "child": {
                  "type": "card",
                  "child": {
                    "type": "padding",
                    "padding": {
                      "top": 16,
                      "bottom": 16,
                      "left": 16,
                      "right": 16
                    },
                    "child": {
                      "type": "column",
                      "children": [
                        {
                          "type": "text",
                          "data": "Revenue",
                          "style": {
                            "fontSize": 14,
                            "color": "#7F8C8D"
                          }
                        },
                        {
                          "type": "sizedBox",
                          "height": 4
                        },
                        {
                          "type": "text",
                          "data": "$12,345",
                          "style": {
                            "fontSize": 24,
                            "fontWeight": "bold",
                            "color": "#27AE60"
                          }
                        }
                      ]
                    }
                  }
                }
              }
            ]
          },
          {
            "type": "sizedBox",
            "height": 16
          },
          {
            "type": "card",
            "child": {
              "type": "padding",
              "padding": {
                "top": 16,
                "bottom": 16,
                "left": 16,
                "right": 16
              },
              "child": {
                "type": "column",
                "children": [
                  {
                    "type": "text",
                    "data": "Recent Activity",
                    "style": {
                      "fontSize": 18,
                      "fontWeight": "bold",
                      "color": "#2C3E50"
                    }
                  },
                  {
                    "type": "sizedBox",
                    "height": 16
                  },
                  {
                    "type": "listView",
                    "shrinkWrap": true,
                    "children": [
                      {
                        "type": "listTile",
                        "title": {
                          "type": "text",
                          "data": "New user registered"
                        },
                        "subtitle": {
                          "type": "text",
                          "data": "2 minutes ago"
                        },
                        "leading": {
                          "type": "icon",
                          "iconType": "material",
                          "icon": "person_add"
                        }
                      },
                      {
                        "type": "listTile",
                        "title": {
                          "type": "text",
                          "data": "Payment received"
                        },
                        "subtitle": {
                          "type": "text",
                          "data": "5 minutes ago"
                        },
                        "leading": {
                          "type": "icon",
                          "iconType": "material",
                          "icon": "payment"
                        }
                      },
                      {
                        "type": "listTile",
                        "title": {
                          "type": "text",
                          "data": "System update"
                        },
                        "subtitle": {
                          "type": "text",
                          "data": "1 hour ago"
                        },
                        "leading": {
                          "type": "icon",
                          "iconType": "material",
                          "icon": "update"
                        }
                      }
                    ]
                  }
                ]
              }
            }
          }
        ]
      }
    }
  }
}
```

## E-commerce Examples

### Product List

A product listing page:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Products"
    },
    "actions": [
      {
        "type": "iconButton",
        "icon": {
          "type": "icon",
          "iconType": "material",
          "icon": "search"
        },
        "onPressed": {
          "actionType": "snackBar",
          "message": "Search clicked"
        }
      },
      {
        "type": "iconButton",
        "icon": {
          "type": "icon",
          "iconType": "material",
          "icon": "shopping_cart"
        },
        "onPressed": {
          "actionType": "navigate",
          "route": "/cart"
        }
      }
    ]
  },
  "body": {
    "type": "gridView",
    "crossAxisCount": 2,
    "crossAxisSpacing": 8,
    "mainAxisSpacing": 8,
    "padding": {
      "top": 8,
      "bottom": 8,
      "left": 8,
      "right": 8
    },
    "children": [
      {
        "type": "card",
        "child": {
          "type": "column",
          "children": [
            {
              "type": "image",
              "src": "https://example.com/product1.jpg",
              "height": 150,
              "width": "100%",
              "fit": "cover"
            },
            {
              "type": "padding",
              "padding": {
                "top": 8,
                "bottom": 8,
                "left": 8,
                "right": 8
              },
              "child": {
                "type": "column",
                "crossAxisAlignment": "start",
                "children": [
                  {
                    "type": "text",
                    "data": "Product 1",
                    "style": {
                      "fontSize": 14,
                      "fontWeight": "bold"
                    }
                  },
                  {
                    "type": "sizedBox",
                    "height": 4
                  },
                  {
                    "type": "text",
                    "data": "$99.99",
                    "style": {
                      "fontSize": 16,
                      "fontWeight": "bold",
                      "color": "#E74C3C"
                    }
                  },
                  {
                    "type": "sizedBox",
                    "height": 8
                  },
                  {
                    "type": "elevatedButton",
                    "child": {
                      "type": "text",
                      "data": "Add to Cart",
                      "style": {
                        "color": "#FFFFFF",
                        "fontSize": 12
                      }
                    },
                    "style": {
                      "backgroundColor": "#3498DB"
                    },
                    "onPressed": {
                      "actionType": "snackBar",
                      "message": "Added to cart"
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
}
```

## Social Media Examples

### Feed Post

A social media feed post:

```json
{
  "type": "card",
  "child": {
    "type": "column",
    "children": [
      {
        "type": "padding",
        "padding": {
          "top": 12,
          "bottom": 12,
          "left": 16,
          "right": 16
        },
        "child": {
          "type": "row",
          "children": [
            {
              "type": "circleAvatar",
              "radius": 20,
              "backgroundImage": "https://example.com/avatar.jpg"
            },
            {
              "type": "sizedBox",
              "width": 12
            },
            {
              "type": "expanded",
              "child": {
                "type": "column",
                "crossAxisAlignment": "start",
                "children": [
                  {
                    "type": "text",
                    "data": "John Doe",
                    "style": {
                      "fontSize": 14,
                      "fontWeight": "bold"
                    }
                  },
                  {
                    "type": "text",
                    "data": "2 hours ago",
                    "style": {
                      "fontSize": 12,
                      "color": "#7F8C8D"
                    }
                  }
                ]
              }
            },
            {
              "type": "iconButton",
              "icon": {
                "type": "icon",
                "iconType": "material",
                "icon": "more_vert"
              },
              "onPressed": {
                "actionType": "modalBottomSheet",
                "title": "Post Options",
                "items": [
                  {
                    "text": "Report",
                    "onTap": {
                      "actionType": "snackBar",
                      "message": "Post reported"
                    }
                  },
                  {
                    "text": "Hide",
                    "onTap": {
                      "actionType": "snackBar",
                      "message": "Post hidden"
                    }
                  }
                ]
              }
            }
          ]
        }
      },
      {
        "type": "text",
        "data": "This is a sample post content. It can contain multiple lines of text and will wrap accordingly.",
        "style": {
          "fontSize": 14
        }
      },
      {
        "type": "image",
        "src": "https://example.com/post-image.jpg",
        "height": 200,
        "width": "100%",
        "fit": "cover"
      },
      {
        "type": "padding",
        "padding": {
          "top": 8,
          "bottom": 8,
          "left": 16,
          "right": 16
        },
        "child": {
          "type": "row",
          "mainAxisAlignment": "spaceBetween",
          "children": [
            {
              "type": "row",
              "children": [
                {
                  "type": "iconButton",
                  "icon": {
                    "type": "icon",
                    "iconType": "material",
                    "icon": "favorite"
                  },
                  "onPressed": {
                    "actionType": "snackBar",
                    "message": "Liked"
                  }
                },
                {
                  "type": "iconButton",
                  "icon": {
                    "type": "icon",
                    "iconType": "material",
                    "icon": "comment"
                  },
                  "onPressed": {
                    "actionType": "snackBar",
                    "message": "Comment clicked"
                  }
                },
                {
                  "type": "iconButton",
                  "icon": {
                    "type": "icon",
                    "iconType": "material",
                    "icon": "share"
                  },
                  "onPressed": {
                    "actionType": "snackBar",
                    "message": "Shared"
                  }
                }
              ]
            },
            {
              "type": "text",
              "data": "42 likes",
              "style": {
                "fontSize": 12,
                "color": "#7F8C8D"
              }
            }
          ]
        }
      }
    ]
  }
}
```

## Next Steps

- [API Reference](./12-api-reference.md) - Detailed API documentation
- [Contributing](./13-contributing.md) - Contribute to Stac
- [Community](./14-community.md) - Join the community
