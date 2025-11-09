import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

class RegisterFormPage extends StatelessWidget {
  const RegisterFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stac.fromJson(registerFormJson, context) ?? const SizedBox();
  }
}

// Material 3 Minimal Registration Form with Auto-Interactive Validation
const Map<String, dynamic> registerFormJson = {
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Sign up",
      "style": {
        "fontSize": 22,
        "fontWeight": "w400"
      }
    },
    "backgroundColor": "transparent",
    "elevation": 0,
    "centerTitle": true,
    "surfaceTintColor": "transparent"
  },
  "backgroundColor": "#FEFBFF",
  "body": {
    "type": "padding",
    "padding": {
      "left": 16,
      "right": 16,
      "top": 0,
      "bottom": 16
    },
    "child": {
      "type": "singleChildScrollView",
      "child": {
        "type": "form",
        "autovalidateMode": "onUserInteraction",
        "child": {
          "type": "column",
          "crossAxisAlignment": "stretch",
          "children": [
            {
              "type": "sizedBox",
              "height": 32
            },
            // Minimal Header
            {
              "type": "text",
              "data": "Create your account",
              "style": {
                "fontSize": 28,
                "fontWeight": "w400",
                "color": "#1C1B1F"
              }
            },
            {
              "type": "sizedBox",
              "height": 8
            },
            {
              "type": "text",
              "data": "Join ToBank and start your financial journey",
              "style": {
                "fontSize": 16,
                "fontWeight": "w400",
                "color": "#49454F"
              }
            },
            {
              "type": "sizedBox",
              "height": 40
            },
            // Full Name Field
            {
              "type": "textFormField",
              "id": "fullName",
              "keyboardType": "text",
              "textInputAction": "next",
              "maxLines": 1,
              "autovalidateMode": "onUserInteraction",
              "decoration": {
                "labelText": "Full name",
                "hintText": "Enter your full name",
                "filled": true,
                "fillColor": "#F7F2FA",
                "border": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "transparent"
                  }
                },
                "enabledBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "transparent"
                  }
                },
                "focusedBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "#6750A4",
                    "width": 2
                  }
                },
                "errorBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "#BA1A1A",
                    "width": 2
                  }
                },
                "labelStyle": {
                  "color": "#49454F"
                },
                "hintStyle": {
                  "color": "#79747E"
                }
              },
              "validatorRules": [
                {
                  "rule": "isName",
                  "message": "Enter a valid name"
                }
              ]
            },
            {
              "type": "sizedBox",
              "height": 16
            },
            // Email Field
            {
              "type": "textFormField",
              "id": "email",
              "keyboardType": "emailAddress",
              "textInputAction": "next",
              "maxLines": 1,
              "autovalidateMode": "onUserInteraction",
              "decoration": {
                "labelText": "Email",
                "hintText": "Enter your email address",
                "filled": true,
                "fillColor": "#F7F2FA",
                "border": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "transparent"
                  }
                },
                "enabledBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "transparent"
                  }
                },
                "focusedBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "#6750A4",
                    "width": 2
                  }
                },
                "errorBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "#BA1A1A",
                    "width": 2
                  }
                },
                "labelStyle": {
                  "color": "#49454F"
                },
                "hintStyle": {
                  "color": "#79747E"
                }
              },
              "validatorRules": [
                {
                  "rule": "isEmail",
                  "message": "Enter a valid email"
                }
              ]
            },
            {
              "type": "sizedBox",
              "height": 16
            },
            // Phone Field
            {
              "type": "textFormField",
              "id": "phone",
              "keyboardType": "phone",
              "textInputAction": "next",
              "maxLines": 1,
              "autovalidateMode": "onUserInteraction",
              "decoration": {
                "labelText": "Phone",
                "hintText": "Enter your phone number",
                "filled": true,
                "fillColor": "#F7F2FA",
                "border": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "transparent"
                  }
                },
                "enabledBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "transparent"
                  }
                },
                "focusedBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "#6750A4",
                    "width": 2
                  }
                },
                "errorBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "#BA1A1A",
                    "width": 2
                  }
                },
                "labelStyle": {
                  "color": "#49454F"
                },
                "hintStyle": {
                  "color": "#79747E"
                }
              },
              "validatorRules": [
                {
                  "rule": "^[+]?[0-9]{10,15}\$",
                  "message": "Enter a valid phone number"
                }
              ]
            },
            {
              "type": "sizedBox",
              "height": 16
            },
            // Password Field
            {
              "type": "textFormField",
              "id": "password",
              "keyboardType": "visiblePassword",
              "textInputAction": "next",
              "maxLines": 1,
              "obscureText": true,
              "autovalidateMode": "onUserInteraction",
              "decoration": {
                "labelText": "Password",
                "hintText": "Create a strong password",
                "filled": true,
                "fillColor": "#F7F2FA",
                "border": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "transparent"
                  }
                },
                "enabledBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "transparent"
                  }
                },
                "focusedBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "#6750A4",
                    "width": 2
                  }
                },
                "errorBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "#BA1A1A",
                    "width": 2
                  }
                },
                "labelStyle": {
                  "color": "#49454F"
                },
                "hintStyle": {
                  "color": "#79747E"
                }
              },
              "validatorRules": [
                {
                  "rule": "isPassword",
                  "message": "Password must be 8+ chars with uppercase, lowercase, number, and special character"
                }
              ]
            },
            {
              "type": "sizedBox",
              "height": 16
            },
            // Confirm Password Field
            {
              "type": "textFormField",
              "id": "confirmPassword",
              "keyboardType": "visiblePassword",
              "textInputAction": "done",
              "maxLines": 1,
              "obscureText": true,
              "autovalidateMode": "onUserInteraction",
              "decoration": {
                "labelText": "Confirm password",
                "hintText": "Re-enter your password",
                "filled": true,
                "fillColor": "#F7F2FA",
                "border": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "transparent"
                  }
                },
                "enabledBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "transparent"
                  }
                },
                "focusedBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "#6750A4",
                    "width": 2
                  }
                },
                "errorBorder": {
                  "type": "outlineInputBorder",
                  "borderRadius": 4,
                  "borderSide": {
                    "color": "#BA1A1A",
                    "width": 2
                  }
                },
                "labelStyle": {
                  "color": "#49454F"
                },
                "hintStyle": {
                  "color": "#79747E"
                }
              },
              "validatorRules": [
                {
                  "rule": "isPassword",
                  "message": "Password must be 8+ chars with uppercase, lowercase, number, and special character"
                }
              ]
            },
            {
              "type": "sizedBox",
              "height": 40
            },
            // Submit Button
            {
              "type": "filledButton",
              "child": {
                "type": "text",
                "data": "Create account",
                "style": {
                  "fontSize": 14,
                  "fontWeight": "w500",
                  "color": "#FFFFFF"
                }
              },
              "style": {
                "backgroundColor": "#6750A4",
                "foregroundColor": "#FFFFFF",
                "padding": {
                  "top": 10,
                  "bottom": 10,
                  "left": 24,
                  "right": 24
                },
                "shape": {
                  "type": "roundedRectangleBorder",
                  "borderRadius": 20
                },
                "elevation": 0
              },
              "onPressed": {
                "actionType": "validateForm",
                "isValid": {
                  "actionType": "showDialog",
                  "widget": {
                    "type": "alertDialog",
                    "title": {
                      "type": "text",
                      "data": "✅ Form Submitted Successfully!"
                    },
                    "content": {
                      "type": "text",
                      "data": "Your registration form has been submitted with all valid data. Password validation passed!"
                    },
                    "actions": [
                      {
                        "type": "textButton",
                        "child": {
                          "type": "text",
                          "data": "OK"
                        }
                      }
                    ]
                  }
                },
                "isNotValid": {
                  "actionType": "showSnackBar",
                  "content": {
                    "type": "text",
                    "data": "Please fix the form errors above"
                  },
                  "behavior": "floating"
                }
              }
            },
            {
              "type": "sizedBox",
              "height": 32
            },
            // Debug Result Display
            {
              "type": "container",
              "decoration": {
                "color": "#F7F2FA",
                "borderRadius": 12
              },
              "padding": {
                "left": 16,
                "right": 16,
                "top": 16,
                "bottom": 16
              },
              "child": {
                "type": "column",
                "crossAxisAlignment": "start",
                "children": [
                  {
                    "type": "text",
                    "data": "🔍 Password Validation Test",
                    "style": {
                      "fontSize": 14,
                      "fontWeight": "w500",
                      "color": "#1C1B1F"
                    }
                  },
                  {
                    "type": "sizedBox",
                    "height": 8
                  },
                  {
                    "type": "text",
                    "data": "Test Password: Aa#123456",
                    "style": {
                      "fontSize": 12,
                      "fontWeight": "w400",
                      "color": "#49454F"
                    }
                  },
                  {
                    "type": "sizedBox",
                    "height": 4
                  },
                  {
                    "type": "text",
                    "data": "✅ Contains: Uppercase (A), Lowercase (a), Number (123456), Special (#)",
                    "style": {
                      "fontSize": 12,
                      "fontWeight": "w400",
                      "color": "#2E7D32"
                    }
                  },
                  {
                    "type": "sizedBox",
                    "height": 4
                  },
                  {
                    "type": "text",
                    "data": "✅ Length: 8+ characters",
                    "style": {
                      "fontSize": 12,
                      "fontWeight": "w400",
                      "color": "#2E7D32"
                    }
                  },
                  {
                    "type": "sizedBox",
                    "height": 8
                  },
                  {
                    "type": "text",
                    "data": "Enter the same password in both fields and submit to test validation.",
                    "style": {
                      "fontSize": 12,
                      "fontWeight": "w400",
                      "color": "#49454F"
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
};
