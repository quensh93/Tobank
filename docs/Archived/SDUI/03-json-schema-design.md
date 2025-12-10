# SDUI JSON Schema Design

## Overview

This document defines the complete JSON schema structure for the Tobank SDUI system. The schema is designed to be:
- **Extensible** - Easy to add new widget types
- **Type-safe** - Clear type definitions
- **Cacheable** - Version-controlled for offline support
- **Secure** - Validated and signed

---

## 1. Entry Point JSON (App Configuration)

The first JSON fetched when app starts. Provides the big picture of the app structure.

### 1.1 Schema

```json
{
  "$schema": "tobank-sdui/v1/app-config",
  "version": "1.0.0",
  "lastUpdated": "2025-01-15T10:30:00Z",
  "signature": "base64_signature_here",
  
  "app": {
    "minVersion": "3.9.0",
    "forceUpdate": false,
    "updateUrl": "https://tobank.ir/download",
    "maintenanceMode": false,
    "maintenanceMessage": "در حال بروزرسانی سیستم هستیم"
  },
  
  "endpoints": {
    "baseUrl": "https://api.tobank.ir",
    "apiVersion": "v1",
    "sduiBase": "https://sdui.tobank.ir/api/v1",
    "cdnBase": "https://cdn.tobank.ir",
    "wsUrl": "wss://ws.tobank.ir"
  },
  
  "features": {
    "cardToCard": true,
    "bpmsWorkflows": true,
    "customerClub": true,
    "promissory": true,
    "giftCard": true,
    "charity": true,
    "safeBox": true,
    "cbs": true
  },
  
  "navigation": {
    "bottomTabs": [
      {
        "id": "home",
        "icon": "home_main",
        "activeIcon": "home_main_selected",
        "pageRef": "pages/home"
      },
      {
        "id": "transactions",
        "icon": "transaction_main",
        "activeIcon": "transaction_main_selected",
        "pageRef": "pages/transactions"
      },
      {
        "id": "cards",
        "icon": "cardboard",
        "activeIcon": "cardboard_selected",
        "pageRef": "pages/cards"
      },
      {
        "id": "profile",
        "icon": "profile_main",
        "activeIcon": "profile_main_selected",
        "pageRef": "pages/profile"
      }
    ]
  },
  
  "pageRegistry": {
    "pages/home": {
      "url": "/sdui/pages/home.json",
      "cache": "1h",
      "preload": true
    },
    "pages/transactions": {
      "url": "/sdui/pages/transactions.json",
      "cache": "5m"
    },
    "pages/cards": {
      "url": "/sdui/pages/cards.json",
      "cache": "5m"
    },
    "pages/profile": {
      "url": "/sdui/pages/profile.json",
      "cache": "1h"
    },
    "flows/marriage-loan": {
      "url": "/sdui/flows/marriage-loan.json",
      "cache": "1d"
    }
  },
  
  "menu": {
    "url": "/sdui/menu/main.json",
    "cache": "1h"
  },
  
  "theme": {
    "url": "/sdui/theme/default.json",
    "cache": "1d"
  },
  
  "localization": {
    "defaultLocale": "fa",
    "supportedLocales": ["fa", "en"],
    "url": "/sdui/i18n/{locale}.json"
  },
  
  "analytics": {
    "enabled": true,
    "provider": "firebase",
    "sampleRate": 1.0
  }
}
```

---

## 2. Page/View JSON Template

Defines the structure and layout of a single page/screen.

### 2.1 Schema

```json
{
  "$schema": "tobank-sdui/v1/page",
  "id": "home-page",
  "version": "1.2.0",
  "type": "page",
  
  "meta": {
    "title": "{{i18n.home_title}}",
    "titleKey": "home_title",
    "showAppBar": true,
    "showBackButton": false,
    "backgroundColor": "{{theme.surface}}",
    "statusBarStyle": "dark"
  },
  
  "appBar": {
    "type": "custom",
    "leading": {
      "type": "widget",
      "ref": "components/user-avatar"
    },
    "title": {
      "type": "text",
      "value": "{{user.fullName}}",
      "style": "titleMedium"
    },
    "actions": [
      {
        "type": "icon_button",
        "icon": "notification",
        "badge": "{{notifications.unreadCount}}",
        "onTap": {
          "action": "navigate",
          "route": "pages/notifications"
        }
      }
    ]
  },
  
  "body": {
    "type": "scroll_view",
    "refreshable": true,
    "onRefresh": {
      "action": "api_call",
      "endpoint": "dashboard/refresh"
    },
    "children": [
      {
        "type": "ref",
        "ref": "sections/card-carousel",
        "data": "{{user.cards}}"
      },
      {
        "type": "ref",
        "ref": "sections/quick-actions"
      },
      {
        "type": "ref",
        "ref": "sections/banner-slider",
        "data": "{{banners}}"
      },
      {
        "type": "ref",
        "ref": "sections/service-grid",
        "data": "{{services}}"
      }
    ]
  },
  
  "floatingActionButton": {
    "type": "fab",
    "icon": "qr_scan",
    "onTap": {
      "action": "static",
      "handler": "scanQR"
    }
  },
  
  "bottomSheet": null,
  
  "dataBindings": {
    "user": {
      "source": "local",
      "key": "currentUser"
    },
    "banners": {
      "source": "api",
      "endpoint": "dashboard/banners",
      "cache": "5m"
    },
    "services": {
      "source": "api",
      "endpoint": "menu/services",
      "cache": "1h"
    },
    "notifications": {
      "source": "api",
      "endpoint": "notifications/summary",
      "cache": "1m"
    }
  },
  
  "lifecycle": {
    "onInit": [
      {
        "action": "api_call",
        "endpoint": "dashboard/init"
      }
    ],
    "onResume": [
      {
        "action": "refresh_bindings",
        "bindings": ["notifications"]
      }
    ]
  }
}
```

---

## 3. Widget Component JSON

Reusable widget definitions.

### 3.1 Container Widgets

```json
{
  "$schema": "tobank-sdui/v1/widget",
  "type": "container",
  
  "variants": {
    "column": {
      "type": "column",
      "mainAxisAlignment": "start|center|end|spaceBetween|spaceAround|spaceEvenly",
      "crossAxisAlignment": "start|center|end|stretch",
      "mainAxisSize": "min|max",
      "children": []
    },
    
    "row": {
      "type": "row",
      "mainAxisAlignment": "start|center|end|spaceBetween|spaceAround|spaceEvenly",
      "crossAxisAlignment": "start|center|end|stretch",
      "mainAxisSize": "min|max",
      "children": []
    },
    
    "stack": {
      "type": "stack",
      "alignment": "topLeft|topCenter|topRight|centerLeft|center|centerRight|bottomLeft|bottomCenter|bottomRight",
      "children": []
    },
    
    "scroll_view": {
      "type": "scroll_view",
      "direction": "vertical|horizontal",
      "physics": "always|never|bouncing|clamping",
      "padding": {},
      "children": []
    },
    
    "list_view": {
      "type": "list_view",
      "direction": "vertical|horizontal",
      "itemBuilder": {},
      "data": "{{binding}}",
      "separator": {},
      "emptyState": {}
    },
    
    "grid_view": {
      "type": "grid_view",
      "crossAxisCount": 2,
      "mainAxisSpacing": 8,
      "crossAxisSpacing": 8,
      "childAspectRatio": 1.0,
      "itemBuilder": {},
      "data": "{{binding}}"
    },
    
    "page_view": {
      "type": "page_view",
      "controller": "pageController",
      "physics": "page|never",
      "children": []
    },
    
    "card": {
      "type": "card",
      "elevation": 2,
      "borderRadius": 12,
      "margin": {},
      "padding": {},
      "backgroundColor": "{{theme.cardColor}}",
      "child": {}
    },
    
    "expanded": {
      "type": "expanded",
      "flex": 1,
      "child": {}
    },
    
    "padding": {
      "type": "padding",
      "padding": {
        "all": 16,
        "horizontal": 16,
        "vertical": 8,
        "top": 8,
        "bottom": 8,
        "left": 16,
        "right": 16
      },
      "child": {}
    },
    
    "sized_box": {
      "type": "sized_box",
      "width": 100,
      "height": 100,
      "child": {}
    },
    
    "aspect_ratio": {
      "type": "aspect_ratio",
      "ratio": 16/9,
      "child": {}
    }
  }
}
```

### 3.2 Display Widgets

```json
{
  "$schema": "tobank-sdui/v1/widget",
  "type": "display",
  
  "variants": {
    "text": {
      "type": "text",
      "value": "Static text or {{binding}}",
      "style": "displayLarge|displayMedium|displaySmall|headlineLarge|headlineMedium|headlineSmall|titleLarge|titleMedium|titleSmall|bodyLarge|bodyMedium|bodySmall|labelLarge|labelMedium|labelSmall",
      "color": "{{theme.primary}}",
      "maxLines": 2,
      "overflow": "ellipsis|clip|fade",
      "textAlign": "start|center|end|justify",
      "fontWeight": "normal|bold|w100-w900"
    },
    
    "rich_text": {
      "type": "rich_text",
      "children": [
        {
          "type": "span",
          "text": "Normal text",
          "style": "bodyMedium"
        },
        {
          "type": "span",
          "text": "Bold text",
          "style": "bodyMedium",
          "fontWeight": "bold"
        }
      ]
    },
    
    "image": {
      "type": "image",
      "source": "network|asset|base64",
      "url": "https://...",
      "assetPath": "assets/images/...",
      "base64": "...",
      "width": 100,
      "height": 100,
      "fit": "contain|cover|fill|fitWidth|fitHeight|none|scaleDown",
      "placeholder": {},
      "errorWidget": {}
    },
    
    "svg": {
      "type": "svg",
      "source": "network|asset",
      "url": "https://...",
      "assetPath": "assets/icons/...",
      "width": 24,
      "height": 24,
      "color": "{{theme.iconColor}}"
    },
    
    "icon": {
      "type": "icon",
      "name": "icon_name",
      "size": 24,
      "color": "{{theme.iconColor}}"
    },
    
    "divider": {
      "type": "divider",
      "height": 1,
      "thickness": 1,
      "color": "{{theme.dividerColor}}",
      "indent": 16,
      "endIndent": 16
    },
    
    "spacer": {
      "type": "spacer",
      "flex": 1
    },
    
    "badge": {
      "type": "badge",
      "value": "{{count}}",
      "backgroundColor": "{{theme.error}}",
      "textColor": "{{theme.onError}}",
      "child": {}
    },
    
    "avatar": {
      "type": "avatar",
      "source": "network|asset|initials",
      "url": "{{user.avatarUrl}}",
      "initials": "{{user.initials}}",
      "size": 40,
      "backgroundColor": "{{theme.primary}}"
    },
    
    "progress_indicator": {
      "type": "progress_indicator",
      "variant": "circular|linear",
      "value": 0.5,
      "indeterminate": false,
      "color": "{{theme.primary}}"
    },
    
    "chip": {
      "type": "chip",
      "label": "Label text",
      "avatar": {},
      "deleteIcon": {},
      "onDeleted": {},
      "selected": false,
      "backgroundColor": "{{theme.surfaceVariant}}"
    },
    
    "shimmer": {
      "type": "shimmer",
      "width": 100,
      "height": 20,
      "borderRadius": 4
    }
  }
}
```

### 3.3 Input Widgets

```json
{
  "$schema": "tobank-sdui/v1/widget",
  "type": "input",
  
  "variants": {
    "text_field": {
      "type": "text_field",
      "id": "fieldId",
      "label": "{{i18n.field_label}}",
      "hint": "{{i18n.field_hint}}",
      "helperText": "{{i18n.field_helper}}",
      "errorText": "{{validation.fieldId.error}}",
      "prefixIcon": "icon_name",
      "suffixIcon": "icon_name",
      "obscureText": false,
      "enabled": true,
      "readOnly": false,
      "maxLength": 100,
      "maxLines": 1,
      "keyboardType": "text|number|email|phone|url|multiline",
      "textInputAction": "done|next|search|send|go",
      "inputFormatters": [
        {
          "type": "mask",
          "mask": "####-####-####-####"
        },
        {
          "type": "digits_only"
        },
        {
          "type": "thousands_separator"
        }
      ],
      "validation": [
        {
          "type": "required",
          "message": "{{i18n.required_error}}"
        },
        {
          "type": "min_length",
          "value": 3,
          "message": "{{i18n.min_length_error}}"
        },
        {
          "type": "regex",
          "pattern": "^[0-9]+$",
          "message": "{{i18n.digits_only_error}}"
        },
        {
          "type": "custom",
          "validator": "validators/national_code"
        }
      ],
      "binding": "formData.fieldId",
      "onChanged": {},
      "onSubmitted": {}
    },
    
    "dropdown": {
      "type": "dropdown",
      "id": "fieldId",
      "label": "{{i18n.select_label}}",
      "hint": "{{i18n.select_hint}}",
      "items": [
        {
          "value": "option1",
          "label": "{{i18n.option1}}"
        }
      ],
      "itemsBinding": "{{options.list}}",
      "valueKey": "id",
      "labelKey": "title",
      "selectedValue": "{{formData.fieldId}}",
      "validation": [],
      "onChanged": {}
    },
    
    "date_picker": {
      "type": "date_picker",
      "id": "fieldId",
      "label": "{{i18n.date_label}}",
      "mode": "date|time|datetime",
      "calendar": "jalali|gregorian",
      "minDate": "1300/01/01",
      "maxDate": "1450/12/29",
      "initialDate": "{{today}}",
      "binding": "formData.fieldId",
      "validation": [],
      "onChanged": {}
    },
    
    "checkbox": {
      "type": "checkbox",
      "id": "fieldId",
      "label": "{{i18n.checkbox_label}}",
      "value": "{{formData.fieldId}}",
      "tristate": false,
      "onChanged": {}
    },
    
    "radio_group": {
      "type": "radio_group",
      "id": "fieldId",
      "label": "{{i18n.radio_label}}",
      "direction": "vertical|horizontal",
      "items": [
        {
          "value": "option1",
          "label": "{{i18n.option1}}"
        }
      ],
      "selectedValue": "{{formData.fieldId}}",
      "onChanged": {}
    },
    
    "switch": {
      "type": "switch",
      "id": "fieldId",
      "label": "{{i18n.switch_label}}",
      "value": "{{formData.fieldId}}",
      "activeColor": "{{theme.primary}}",
      "onChanged": {}
    },
    
    "slider": {
      "type": "slider",
      "id": "fieldId",
      "label": "{{i18n.slider_label}}",
      "min": 0,
      "max": 100,
      "divisions": 10,
      "value": "{{formData.fieldId}}",
      "showLabel": true,
      "onChanged": {}
    },
    
    "document_picker": {
      "type": "document_picker",
      "id": "fieldId",
      "label": "{{i18n.upload_label}}",
      "allowedExtensions": ["jpg", "png", "pdf"],
      "maxSize": 5242880,
      "multiple": false,
      "binding": "formData.fieldId",
      "uploadEndpoint": "documents/upload",
      "onUploaded": {}
    },
    
    "camera_capture": {
      "type": "camera_capture",
      "id": "fieldId",
      "label": "{{i18n.capture_label}}",
      "mode": "photo|video",
      "facing": "front|back",
      "overlay": "document_frame|face_frame|none",
      "binding": "formData.fieldId",
      "onCaptured": {}
    },
    
    "signature_pad": {
      "type": "signature_pad",
      "id": "fieldId",
      "label": "{{i18n.signature_label}}",
      "width": 300,
      "height": 150,
      "penColor": "#000000",
      "backgroundColor": "#FFFFFF",
      "binding": "formData.fieldId",
      "onSigned": {}
    },
    
    "pin_input": {
      "type": "pin_input",
      "id": "fieldId",
      "length": 6,
      "obscureText": true,
      "keyboardType": "number",
      "binding": "formData.fieldId",
      "onCompleted": {}
    },
    
    "amount_input": {
      "type": "amount_input",
      "id": "fieldId",
      "label": "{{i18n.amount_label}}",
      "currency": "IRR",
      "min": 10000,
      "max": 1000000000,
      "quickAmounts": [100000, 500000, 1000000, 5000000],
      "showInWords": true,
      "binding": "formData.fieldId",
      "onChanged": {}
    }
  }
}
```

### 3.4 Interactive Widgets

```json
{
  "$schema": "tobank-sdui/v1/widget",
  "type": "interactive",
  
  "variants": {
    "button": {
      "type": "button",
      "variant": "elevated|filled|outlined|text|icon",
      "label": "{{i18n.button_label}}",
      "icon": "icon_name",
      "iconPosition": "start|end",
      "loading": "{{isLoading}}",
      "enabled": "{{!isLoading}}",
      "fullWidth": true,
      "onTap": {
        "action": "action_type",
        "params": {}
      }
    },
    
    "icon_button": {
      "type": "icon_button",
      "icon": "icon_name",
      "size": 24,
      "color": "{{theme.iconColor}}",
      "backgroundColor": "transparent",
      "tooltip": "{{i18n.tooltip}}",
      "onTap": {}
    },
    
    "ink_well": {
      "type": "ink_well",
      "borderRadius": 8,
      "splashColor": "{{theme.primary.withOpacity(0.1)}}",
      "onTap": {},
      "onLongPress": {},
      "child": {}
    },
    
    "gesture_detector": {
      "type": "gesture_detector",
      "onTap": {},
      "onDoubleTap": {},
      "onLongPress": {},
      "onSwipe": {
        "direction": "left|right|up|down",
        "action": {}
      },
      "child": {}
    },
    
    "dismissible": {
      "type": "dismissible",
      "direction": "horizontal|startToEnd|endToStart|vertical|up|down",
      "background": {},
      "secondaryBackground": {},
      "onDismissed": {},
      "child": {}
    },
    
    "refresh_indicator": {
      "type": "refresh_indicator",
      "onRefresh": {},
      "child": {}
    },
    
    "expansion_tile": {
      "type": "expansion_tile",
      "title": {},
      "subtitle": {},
      "leading": {},
      "trailing": {},
      "initiallyExpanded": false,
      "children": []
    },
    
    "tab_bar": {
      "type": "tab_bar",
      "tabs": [
        {
          "label": "{{i18n.tab1}}",
          "icon": "icon1"
        }
      ],
      "selectedIndex": "{{currentTab}}",
      "onTabChanged": {}
    },
    
    "bottom_sheet_trigger": {
      "type": "bottom_sheet_trigger",
      "sheetContent": {},
      "isDismissible": true,
      "enableDrag": true,
      "child": {}
    },
    
    "dialog_trigger": {
      "type": "dialog_trigger",
      "dialogContent": {},
      "barrierDismissible": true,
      "child": {}
    }
  }
}
```

---

## 4. Form & Workflow JSON

For multi-step processes like BPMS workflows.

### 4.1 Workflow Definition

```json
{
  "$schema": "tobank-sdui/v1/workflow",
  "id": "marriage-loan-flow",
  "version": "2.0.0",
  "type": "workflow",
  
  "meta": {
    "title": "{{i18n.marriage_loan_title}}",
    "description": "{{i18n.marriage_loan_desc}}",
    "icon": "loan",
    "estimatedTime": "15 min"
  },
  
  "requirements": {
    "authentication": true,
    "biometric": true,
    "customerStatus": ["registered"],
    "requiredData": ["nationalCode", "customerNumber"]
  },
  
  "steps": [
    {
      "id": "rules",
      "type": "info",
      "title": "{{i18n.rules_title}}",
      "content": {
        "type": "ref",
        "ref": "components/rules-view",
        "data": {
          "rulesEndpoint": "bpms/marriage-loan/rules"
        }
      },
      "actions": {
        "primary": {
          "label": "{{i18n.accept_continue}}",
          "condition": "{{rulesAccepted}}",
          "onTap": {
            "action": "next_step"
          }
        }
      }
    },
    {
      "id": "customer-info",
      "type": "form",
      "title": "{{i18n.customer_info_title}}",
      "form": {
        "ref": "forms/customer-info-form"
      },
      "dataSource": {
        "endpoint": "bpms/start-form-data",
        "params": {
          "processDefinitionKey": "MarriageLoan"
        }
      },
      "actions": {
        "primary": {
          "label": "{{i18n.continue}}",
          "validation": "form",
          "onTap": {
            "action": "submit_form",
            "endpoint": "bpms/check-personal-info",
            "onSuccess": {
              "action": "next_step"
            }
          }
        }
      }
    },
    {
      "id": "loan-amount",
      "type": "form",
      "title": "{{i18n.loan_amount_title}}",
      "form": {
        "fields": [
          {
            "type": "dropdown",
            "id": "requestAmount",
            "label": "{{i18n.loan_amount}}",
            "itemsBinding": "{{formData.requestAmountOptions}}",
            "validation": [{"type": "required"}]
          },
          {
            "type": "text_field",
            "id": "cbiTrackingNumber",
            "label": "{{i18n.tracking_code}}",
            "maxLength": 20,
            "validation": [
              {"type": "required"},
              {"type": "exact_length", "value": 20}
            ]
          },
          {
            "type": "checkbox",
            "id": "isVeteran",
            "label": "{{i18n.is_veteran}}"
          }
        ]
      },
      "actions": {
        "primary": {
          "label": "{{i18n.start_process}}",
          "validation": "form",
          "onTap": {
            "action": "api_call",
            "endpoint": "bpms/start-process",
            "method": "POST",
            "body": {
              "processDefinitionKey": "MarriageLoan",
              "variables": "{{formData}}"
            },
            "onSuccess": {
              "action": "next_step"
            }
          }
        }
      }
    },
    {
      "id": "task-list",
      "type": "dynamic",
      "title": "{{i18n.required_documents}}",
      "content": {
        "type": "ref",
        "ref": "components/bpms-task-list",
        "data": {
          "processInstanceId": "{{processInstanceId}}"
        }
      },
      "taskResolver": {
        "endpoint": "bpms/applicant-task-list",
        "taskMapping": {
          "COMPLETE_CUSTOMER_INFO": "forms/customer-info-task",
          "COMPLETE_CUSTOMER_DOCUMENTS": "forms/document-upload-task",
          "COMPLETE_SPOUSE_INFO": "forms/spouse-info-task",
          "COMPLETE_MARRIAGE_LICENSE": "forms/marriage-license-task",
          "COMPLETE_GUARANTOR_INFO": "forms/guarantor-info-task",
          "SIGN_CONTRACT": "forms/sign-contract-task"
        }
      }
    },
    {
      "id": "completion",
      "type": "result",
      "title": "{{i18n.process_completed}}",
      "content": {
        "type": "ref",
        "ref": "components/success-view",
        "data": {
          "message": "{{i18n.marriage_loan_success}}",
          "trackingNumber": "{{result.trackingNumber}}"
        }
      },
      "actions": {
        "primary": {
          "label": "{{i18n.back_to_home}}",
          "onTap": {
            "action": "navigate",
            "route": "pages/home",
            "clearStack": true
          }
        }
      }
    }
  ],
  
  "navigation": {
    "type": "pageView",
    "canGoBack": true,
    "backConfirmation": {
      "show": true,
      "message": "{{i18n.exit_confirmation}}"
    }
  },
  
  "state": {
    "persist": true,
    "storageKey": "marriage-loan-draft"
  }
}
```

### 4.2 Form Definition

```json
{
  "$schema": "tobank-sdui/v1/form",
  "id": "customer-info-form",
  "version": "1.0.0",
  
  "sections": [
    {
      "id": "personal",
      "title": "{{i18n.personal_info}}",
      "collapsible": false,
      "fields": [
        {
          "type": "text_field",
          "id": "firstName",
          "label": "{{i18n.first_name}}",
          "readOnly": true,
          "binding": "{{user.firstName}}"
        },
        {
          "type": "text_field",
          "id": "lastName",
          "label": "{{i18n.last_name}}",
          "readOnly": true,
          "binding": "{{user.lastName}}"
        },
        {
          "type": "text_field",
          "id": "nationalCode",
          "label": "{{i18n.national_code}}",
          "readOnly": true,
          "binding": "{{user.nationalCode}}"
        },
        {
          "type": "date_picker",
          "id": "birthDate",
          "label": "{{i18n.birth_date}}",
          "readOnly": true,
          "calendar": "jalali",
          "binding": "{{user.birthDate}}"
        }
      ]
    },
    {
      "id": "contact",
      "title": "{{i18n.contact_info}}",
      "collapsible": true,
      "fields": [
        {
          "type": "text_field",
          "id": "mobile",
          "label": "{{i18n.mobile}}",
          "keyboardType": "phone",
          "inputFormatters": [
            {"type": "mask", "mask": "####-###-####"}
          ],
          "validation": [
            {"type": "required"},
            {"type": "regex", "pattern": "^09[0-9]{9}$"}
          ]
        },
        {
          "type": "text_field",
          "id": "email",
          "label": "{{i18n.email}}",
          "keyboardType": "email",
          "validation": [
            {"type": "email"}
          ]
        }
      ]
    },
    {
      "id": "address",
      "title": "{{i18n.address_info}}",
      "collapsible": true,
      "fields": [
        {
          "type": "dropdown",
          "id": "province",
          "label": "{{i18n.province}}",
          "itemsBinding": "{{provinces}}",
          "valueKey": "code",
          "labelKey": "name",
          "validation": [{"type": "required"}],
          "onChanged": {
            "action": "load_dependent",
            "target": "city",
            "endpoint": "cities/{{value}}"
          }
        },
        {
          "type": "dropdown",
          "id": "city",
          "label": "{{i18n.city}}",
          "itemsBinding": "{{cities}}",
          "valueKey": "code",
          "labelKey": "name",
          "validation": [{"type": "required"}],
          "dependsOn": "province"
        },
        {
          "type": "text_field",
          "id": "postalCode",
          "label": "{{i18n.postal_code}}",
          "keyboardType": "number",
          "maxLength": 10,
          "inputFormatters": [{"type": "digits_only"}],
          "validation": [
            {"type": "required"},
            {"type": "exact_length", "value": 10}
          ]
        },
        {
          "type": "text_field",
          "id": "address",
          "label": "{{i18n.full_address}}",
          "maxLines": 3,
          "validation": [
            {"type": "required"},
            {"type": "min_length", "value": 20}
          ]
        }
      ]
    }
  ],
  
  "submitButton": {
    "label": "{{i18n.save_continue}}",
    "position": "bottom",
    "fullWidth": true
  },
  
  "validation": {
    "mode": "onSubmit|onChange|onBlur",
    "showErrors": "all|first|perField"
  }
}
```

---

## 5. Data Binding JSON

Defines how data is fetched and bound to UI.

### 5.1 Binding Types

```json
{
  "$schema": "tobank-sdui/v1/data-binding",
  
  "bindings": {
    "local": {
      "type": "local",
      "description": "Data from local state/storage",
      "example": {
        "source": "local",
        "key": "user.profile",
        "default": null
      }
    },
    
    "api": {
      "type": "api",
      "description": "Data fetched from API",
      "example": {
        "source": "api",
        "endpoint": "cards/list",
        "method": "GET",
        "params": {},
        "headers": {},
        "cache": "5m",
        "refreshOn": ["app_resume", "manual"],
        "transform": "response.data.cards"
      }
    },
    
    "computed": {
      "type": "computed",
      "description": "Derived from other bindings",
      "example": {
        "source": "computed",
        "expression": "{{cards.length}} > 0",
        "dependencies": ["cards"]
      }
    },
    
    "form": {
      "type": "form",
      "description": "Form field values",
      "example": {
        "source": "form",
        "formId": "customerInfoForm",
        "field": "nationalCode"
      }
    },
    
    "route": {
      "type": "route",
      "description": "Route parameters",
      "example": {
        "source": "route",
        "param": "cardId"
      }
    },
    
    "context": {
      "type": "context",
      "description": "App context values",
      "example": {
        "source": "context",
        "key": "theme|locale|platform|isAuthenticated"
      }
    }
  },
  
  "expressions": {
    "syntax": "Mustache-style {{expression}}",
    "operators": [
      "{{value}}",
      "{{object.property}}",
      "{{array[0]}}",
      "{{condition ? trueValue : falseValue}}",
      "{{value | filter}}",
      "{{!booleanValue}}",
      "{{value1 && value2}}",
      "{{value1 || value2}}",
      "{{num1 + num2}}",
      "{{num1 - num2}}",
      "{{num1 * num2}}",
      "{{num1 / num2}}",
      "{{string1 + string2}}"
    ],
    "filters": [
      "currency",
      "date",
      "time",
      "datetime",
      "number",
      "percentage",
      "uppercase",
      "lowercase",
      "capitalize",
      "truncate",
      "mask"
    ]
  }
}
```

### 5.2 Expression Examples

```json
{
  "examples": {
    "simple_binding": "{{user.name}}",
    
    "nested_binding": "{{user.profile.avatar.url}}",
    
    "array_access": "{{cards[0].number}}",
    
    "conditional": "{{isLoading ? 'Loading...' : data.title}}",
    
    "null_coalesce": "{{user.nickname || user.name || 'Guest'}}",
    
    "boolean_not": "{{!isLoading}}",
    
    "comparison": "{{balance > 0}}",
    
    "string_concat": "{{'Welcome, ' + user.name}}",
    
    "filter_currency": "{{amount | currency('IRR')}}",
    
    "filter_date": "{{createdAt | date('yyyy/MM/dd')}}",
    
    "filter_mask": "{{cardNumber | mask('****-****-****-####')}}",
    
    "i18n_reference": "{{i18n.welcome_message}}",
    
    "theme_reference": "{{theme.primary}}",
    
    "complex": "{{cards.length > 0 ? cards[0].balance | currency : i18n.no_cards}}"
  }
}
```

---

## 6. Action/Navigation JSON

Defines actions that can be triggered from UI.

### 6.1 Action Types

```json
{
  "$schema": "tobank-sdui/v1/actions",
  
  "actions": {
    "navigate": {
      "type": "navigate",
      "description": "Navigate to another page/route",
      "params": {
        "route": "string - Route identifier",
        "params": "object - Route parameters",
        "transition": "push|replace|pushAndClear|pop|popUntil",
        "animation": "slide|fade|scale|none"
      },
      "example": {
        "action": "navigate",
        "route": "pages/card-detail",
        "params": {"cardId": "{{selectedCard.id}}"},
        "transition": "push"
      }
    },
    
    "api_call": {
      "type": "api_call",
      "description": "Make an API request",
      "params": {
        "endpoint": "string - API endpoint",
        "method": "GET|POST|PUT|DELETE",
        "body": "object - Request body",
        "headers": "object - Additional headers",
        "loading": "string - Loading state binding",
        "onSuccess": "action - Success callback",
        "onError": "action - Error callback"
      },
      "example": {
        "action": "api_call",
        "endpoint": "cards/{{cardId}}/block",
        "method": "POST",
        "body": {"reason": "{{formData.reason}}"},
        "loading": "isBlocking",
        "onSuccess": {
          "action": "show_toast",
          "message": "{{i18n.card_blocked}}"
        },
        "onError": {
          "action": "show_dialog",
          "type": "error"
        }
      }
    },
    
    "static_action": {
      "type": "static",
      "description": "Call native static handler",
      "params": {
        "handler": "string - Handler name",
        "params": "object - Handler parameters",
        "onResult": "action - Result callback"
      },
      "example": {
        "action": "static",
        "handler": "biometric_verify",
        "params": {"reason": "{{i18n.verify_identity}}"},
        "onResult": {
          "success": {"action": "next_step"},
          "failure": {"action": "show_dialog", "type": "error"}
        }
      }
    },
    
    "show_dialog": {
      "type": "show_dialog",
      "description": "Display a dialog",
      "params": {
        "type": "alert|confirm|custom",
        "title": "string",
        "message": "string",
        "content": "widget - For custom dialog",
        "actions": "array - Dialog buttons"
      },
      "example": {
        "action": "show_dialog",
        "type": "confirm",
        "title": "{{i18n.confirm_title}}",
        "message": "{{i18n.confirm_message}}",
        "actions": [
          {
            "label": "{{i18n.cancel}}",
            "style": "text",
            "onTap": {"action": "dismiss"}
          },
          {
            "label": "{{i18n.confirm}}",
            "style": "filled",
            "onTap": {"action": "api_call", "endpoint": "..."}
          }
        ]
      }
    },
    
    "show_bottom_sheet": {
      "type": "show_bottom_sheet",
      "description": "Display a bottom sheet",
      "params": {
        "content": "widget - Sheet content",
        "isDismissible": "boolean",
        "enableDrag": "boolean",
        "height": "number|string"
      }
    },
    
    "show_toast": {
      "type": "show_toast",
      "description": "Display a toast message",
      "params": {
        "message": "string",
        "type": "success|error|warning|info",
        "duration": "short|long|number"
      }
    },
    
    "set_state": {
      "type": "set_state",
      "description": "Update local state",
      "params": {
        "key": "string - State key",
        "value": "any - New value"
      }
    },
    
    "refresh_bindings": {
      "type": "refresh_bindings",
      "description": "Refresh data bindings",
      "params": {
        "bindings": "array - Binding keys to refresh"
      }
    },
    
    "submit_form": {
      "type": "submit_form",
      "description": "Submit form data",
      "params": {
        "formId": "string - Form identifier",
        "endpoint": "string - Submit endpoint",
        "onSuccess": "action",
        "onError": "action"
      }
    },
    
    "validate_form": {
      "type": "validate_form",
      "description": "Trigger form validation",
      "params": {
        "formId": "string",
        "fields": "array - Specific fields (optional)"
      }
    },
    
    "next_step": {
      "type": "next_step",
      "description": "Move to next workflow step"
    },
    
    "previous_step": {
      "type": "previous_step",
      "description": "Move to previous workflow step"
    },
    
    "go_to_step": {
      "type": "go_to_step",
      "description": "Jump to specific step",
      "params": {
        "stepId": "string"
      }
    },
    
    "copy_to_clipboard": {
      "type": "copy_to_clipboard",
      "description": "Copy text to clipboard",
      "params": {
        "text": "string"
      }
    },
    
    "share": {
      "type": "share",
      "description": "Share content",
      "params": {
        "text": "string",
        "url": "string",
        "image": "string - Base64 or URL"
      }
    },
    
    "open_url": {
      "type": "open_url",
      "description": "Open external URL",
      "params": {
        "url": "string",
        "mode": "external|internal_browser"
      }
    },
    
    "analytics": {
      "type": "analytics",
      "description": "Track analytics event",
      "params": {
        "event": "string",
        "params": "object"
      }
    },
    
    "dismiss": {
      "type": "dismiss",
      "description": "Dismiss current dialog/sheet"
    },
    
    "pop": {
      "type": "pop",
      "description": "Go back in navigation",
      "params": {
        "result": "any - Optional result"
      }
    },
    
    "chain": {
      "type": "chain",
      "description": "Execute multiple actions in sequence",
      "params": {
        "actions": "array - Actions to execute"
      }
    },
    
    "conditional": {
      "type": "conditional",
      "description": "Execute action based on condition",
      "params": {
        "condition": "string - Expression",
        "then": "action",
        "else": "action"
      }
    }
  }
}
```

---

## 7. Theme JSON

Dynamic theme configuration.

```json
{
  "$schema": "tobank-sdui/v1/theme",
  "id": "default-theme",
  "version": "1.0.0",
  
  "colors": {
    "primary": "#1976D2",
    "primaryVariant": "#1565C0",
    "secondary": "#26A69A",
    "secondaryVariant": "#00897B",
    "background": "#FFFFFF",
    "surface": "#FFFFFF",
    "error": "#B00020",
    "success": "#4CAF50",
    "warning": "#FF9800",
    "info": "#2196F3",
    "onPrimary": "#FFFFFF",
    "onSecondary": "#FFFFFF",
    "onBackground": "#000000",
    "onSurface": "#000000",
    "onError": "#FFFFFF",
    "divider": "#E0E0E0",
    "disabled": "#9E9E9E",
    "cardColor": "#FFFFFF",
    "scaffoldBackground": "#F5F5F5"
  },
  
  "typography": {
    "fontFamily": "IranYekan",
    "displayLarge": {"fontSize": 57, "fontWeight": "400", "letterSpacing": -0.25},
    "displayMedium": {"fontSize": 45, "fontWeight": "400"},
    "displaySmall": {"fontSize": 36, "fontWeight": "400"},
    "headlineLarge": {"fontSize": 32, "fontWeight": "400"},
    "headlineMedium": {"fontSize": 28, "fontWeight": "400"},
    "headlineSmall": {"fontSize": 24, "fontWeight": "400"},
    "titleLarge": {"fontSize": 22, "fontWeight": "500"},
    "titleMedium": {"fontSize": 16, "fontWeight": "500", "letterSpacing": 0.15},
    "titleSmall": {"fontSize": 14, "fontWeight": "500", "letterSpacing": 0.1},
    "bodyLarge": {"fontSize": 16, "fontWeight": "400", "letterSpacing": 0.5},
    "bodyMedium": {"fontSize": 14, "fontWeight": "400", "letterSpacing": 0.25},
    "bodySmall": {"fontSize": 12, "fontWeight": "400", "letterSpacing": 0.4},
    "labelLarge": {"fontSize": 14, "fontWeight": "500", "letterSpacing": 0.1},
    "labelMedium": {"fontSize": 12, "fontWeight": "500", "letterSpacing": 0.5},
    "labelSmall": {"fontSize": 11, "fontWeight": "500", "letterSpacing": 0.5}
  },
  
  "spacing": {
    "xs": 4,
    "sm": 8,
    "md": 16,
    "lg": 24,
    "xl": 32,
    "xxl": 48
  },
  
  "borderRadius": {
    "none": 0,
    "sm": 4,
    "md": 8,
    "lg": 12,
    "xl": 16,
    "full": 9999
  },
  
  "elevation": {
    "none": 0,
    "low": 2,
    "medium": 4,
    "high": 8
  },
  
  "components": {
    "button": {
      "borderRadius": 8,
      "minHeight": 48,
      "padding": {"horizontal": 16, "vertical": 12}
    },
    "card": {
      "borderRadius": 12,
      "elevation": 2,
      "padding": 16
    },
    "input": {
      "borderRadius": 8,
      "borderWidth": 1,
      "padding": {"horizontal": 16, "vertical": 12}
    },
    "dialog": {
      "borderRadius": 16,
      "padding": 24
    },
    "bottomSheet": {
      "borderRadius": {"topLeft": 16, "topRight": 16}
    }
  }
}
```

---

## Next Document

→ [04-implementation-roadmap.md](./04-implementation-roadmap.md) - Implementation Plan & Timeline

