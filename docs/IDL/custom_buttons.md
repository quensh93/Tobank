# Custom Buttons

Documentation for Tobank custom button contracts in JSON format.

> ## Documentation Index
>
> Style reference: https://docs.stac.dev/widgets/elevated_button
>
> This page is JSON-only (no Dart examples).

## Custom Widgets

### reactiveElevatedButton

Description: Renders a registry-reactive button whose enabled/loading state and pressed action can depend on live STAC values.

| Property | Type | Description |
| --- | --- | --- |
| parser | String | ReactiveElevatedButtonParser |
| source | String | lib/core/stac/parsers/widgets/reactive_elevated_button_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/widgets/reactive_elevated_button_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerWidget(const ReactiveElevatedButtonParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| type | String | Yes | Contract key used in JSON. |
| enabledKey | String | No | Registry key that controls enabled/disabled state. |
| loadingKey | String | No | Registry key that controls loading state. |
| enabled | Boolean | No | Fallback enabled state when `enabledKey` is missing. |
| onPressed | Map | No | STAC action payload executed on tap. |
| child | Map | No | Normal child widget JSON for button content. |
| loadingChild | Map | No | Optional child widget shown while loading. |
| style | Map | No | Optional style applied in enabled state. |
| disabledStyle | Map | No | Optional style applied in disabled/loading state. |

#### JSON

```json
{
    "type": "reactiveElevatedButton",
    "enabledKey": "isFormValid",
    "loadingKey": "isSubmitting",
    "enabled": true,
    "child": {
        "type": "text",
        "data": "Continue"
    },
    "loadingChild": {
        "type": "circularProgressIndicator",
        "strokeWidth": 2.5,
        "color": "#FFFFFF"
    },
    "style": {
        "backgroundColor": "#246BFD"
    },
    "disabledStyle": {
        "backgroundColor": "#9CA3AF"
    },
    "onPressed": {
        "actionType": "sequence",
        "actions": [
            {
                "actionType": "setValue",
                "values": [
                    {
                        "key": "isSubmitting",
                        "value": true
                    }
                ]
            }
        ]
    }
}
```
