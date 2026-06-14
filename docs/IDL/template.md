# Overview

Documentation for Tobank custom STAC contracts in JSON format. Each entry describes one custom parser registered in `lib/core/stac/registry/register_custom_parsers.dart` (with the registry living at `lib/core/stac/registry/custom_component_registry.dart`). Built-in STAC widgets/actions are not redocumented here — see upstream STAC docs at https://docs.stac.dev/ for those.

> ## Documentation Index
>
> Style reference: see `custom_buttons.md` for the canonical entry format.
>
> Sibling pages:
> - `custom_buttons.md` — documents `reactiveElevatedButton`.
>
> This page is JSON-only (no Dart examples).

# Widgets

## Layout Widgets

Structural / wrapper / lifecycle widgets that arrange or gate other widgets.

### visibility

Description: Registry-reactive override of the built-in Flutter Visibility widget — accepts a literal `bool`, a `{{key}}` template, or a `[[key]]` escape, and rebuilds when the registry changes.

| Property | Type | Description |
| --- | --- | --- |
| parser | String | CustomVisibilityParser |
| source | String | lib/core/stac/parsers/widgets/custom_visibility_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/widgets/custom_visibility_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerWidget(const CustomVisibilityParser(), true);`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| type | String | Yes | Contract key used in JSON. |
| visible | Boolean \| String | No | Literal bool, or `{{key}}` / `[[key]]` template. Prefix the key with `!` inside the braces to negate. Defaults to `true` when missing. |
| child | Map | No | Widget shown when visible. |
| replacement | Map | No | Widget shown when hidden. Defaults to an empty `SizedBox.shrink()`. |
| maintainState | Boolean | No | Forwarded to Flutter Visibility. Defaults to `false`. |
| maintainAnimation | Boolean | No | Forwarded to Flutter Visibility. Defaults to `false`. |
| maintainSize | Boolean | No | Forwarded to Flutter Visibility. Defaults to `false`. |
| maintainSemantics | Boolean | No | Forwarded to Flutter Visibility. Defaults to `false`. |
| maintainInteractivity | Boolean | No | Forwarded to Flutter Visibility. Defaults to `false`. |

#### JSON

```json
{
    "type": "visibility",
    "visible": "{{isFormValid}}",
    "child": {
        "type": "text",
        "data": "Visible only when form is valid"
    },
    "replacement": {
        "type": "text",
        "data": "Form is not yet valid"
    }
}
```

### assetWidget

Description: Loads and renders a STAC widget tree from a local asset/API JSON file resolved by `StacWidgetResolver`. Shows a centred `CircularProgressIndicator` while loading and an empty box on error.

| Property | Type | Description |
| --- | --- | --- |
| parser | String | AssetWidgetParser |
| source | String | lib/core/stac/parsers/widgets/asset_widget_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/widgets/asset_widget_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerWidget(const AssetWidgetParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| type | String | Yes | Contract key used in JSON. |
| assetPath | String | Yes | Path of the JSON document to load and render. An empty / missing value renders nothing. |

#### JSON

```json
{
    "type": "assetWidget",
    "assetPath": "lib/stac/tobank/home/api/GET_tobank_home.json"
}
```

### To be documented

- `bottomNavigationBar` (override) — `lib/core/stac/parsers/widgets/custom_bottom_navigation_bar_parser.dart`
- `bottomNavigationView` (override) — `lib/core/stac/parsers/widgets/custom_bottom_navigation_view_parser.dart`
- `onMountAction` — `lib/core/stac/parsers/widgets/on_mount_action_parser.dart`
- `stateful` / `stateFull` (override) — `lib/core/stac/parsers/widgets/stateful_widget_parser.dart`
- `timedSplash` — `lib/core/stac/parsers/widgets/timed_splash_parser.dart`
- `registryReactiveWidget` — `lib/core/stac/parsers/widgets/registry_reactive_widget_parser.dart`

## Display Widgets

Visual / static content rendering.

### pdfPreview

Description: Decodes a base64-encoded PDF (either inline or pulled from the STAC registry) and renders it with Syncfusion's `SfPdfViewer.memory`. Shows a placeholder when no data is available and an error panel when decoding fails.

| Property | Type | Description |
| --- | --- | --- |
| parser | String | PdfPreviewParser |
| source | String | lib/core/stac/parsers/widgets/pdf_preview_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/widgets/pdf_preview_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerWidget(const PdfPreviewParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| type | String | Yes | Contract key used in JSON. |
| src | String | No | Inline base64 PDF or `data:application/pdf;base64,...` URI. Used as fallback when `registryKey` is empty. |
| registryKey | String | No | Preferred source: STAC registry key holding the base64 string. Read first on every rebuild. |
| width | Number | No | Viewer width in logical pixels. Defaults to intrinsic. |
| height | Number | No | Viewer height in logical pixels. Defaults to `500` (or `400` for empty/error states). |

#### JSON

```json
{
    "type": "pdfPreview",
    "registryKey": "serverSignedPdf",
    "src": "{{serverSignedPdf}}",
    "height": 500
}
```

### tobankBannerCarousel

Description: Auto-scrolling image PageView with animated dot indicators, used on the home page. Single image or zero `autoScrollSeconds` disables auto-scroll.

| Property | Type | Description |
| --- | --- | --- |
| parser | String | TobankBannerCarouselParser |
| source | String | lib/core/stac/parsers/widgets/tobank_banner_carousel_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/widgets/tobank_banner_carousel_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`registerTobankBannerCarouselParser();`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| type | String | Yes | Contract key used in JSON. |
| imageUrls | List<String> | Yes | Network image URLs to cycle through. Empty list renders nothing. |
| height | Number | No | Carousel height. Defaults to `146`. |
| borderRadius | Number | No | Outer ClipRRect radius. Defaults to `20`. |
| autoScrollSeconds | Number | No | Interval between auto-advances. Set to `0` to disable. Defaults to `15`. |
| showIndicators | Boolean | No | Show animated dot indicators when more than one image is present. Defaults to `true`. |
| indicatorActiveColor | String | No | Hex color (e.g. `#E31A2F`) for the active dot. Defaults to `#E31A2F`. |
| indicatorInactiveColor | String | No | Hex color for the inactive dots. Defaults to `#4C5E7A`. |
| indicatorSpacing | Number | No | Horizontal spacing between dots. Defaults to `8`. |

#### JSON

```json
{
    "type": "tobankBannerCarousel",
    "imageUrls": [
        "https://cdn.example.com/banners/1.png",
        "https://cdn.example.com/banners/2.png"
    ],
    "height": 146,
    "borderRadius": 20,
    "autoScrollSeconds": 6,
    "showIndicators": true,
    "indicatorActiveColor": "#E31A2F",
    "indicatorInactiveColor": "#4C5E7A",
    "indicatorSpacing": 8
}
```

### To be documented

- `image` (override) — `lib/core/stac/parsers/widgets/custom_image_parser.dart`
- `receiptRepaintBoundary` — `lib/core/stac/parsers/widgets/receipt_repaint_boundary_parser.dart`
- `exampleCard` — `lib/core/stac/parsers/widgets/example_card_parser.dart`
- `promissoryRealLoader` — `lib/core/stac/parsers/widgets/promissory_real_loader_parser.dart`
- `verifyIdentityRealLoader` — `lib/core/stac/parsers/widgets/authentication_real_loader_parser.dart`
- `tobankCardsCarousel` — `lib/core/stac/parsers/widgets/tobank_cards_carousel_parser.dart`
- `tobankCardManagementSlider` — `lib/core/stac/parsers/widgets/tobank_card_management_slider_parser.dart`
- `tobankCardsStackScroller` — `lib/core/stac/parsers/widgets/tobank_cards_stack_scroller_parser.dart`
- `tobankOnboardingSlider` — `lib/core/stac/parsers/widgets/tobank_onboarding_slider_parser.dart`
- `tobankMegaGashtWebView` — `lib/core/stac/parsers/widgets/tobank_mega_gasht_webview_parser.dart`
- `tobankAcceptorWebView` — `lib/core/stac/parsers/widgets/tobank_acceptor_webview_parser.dart`

## Interactive Widgets

User-input / control widgets.

### reactiveSwitch

Description: Registry-driven Material `Switch.adaptive`. The current value is read from the registry key on every rebuild; toggling writes back through `StacRegistry.setValue` and notifies the global `RegistryNotifier` before running the optional `onChanged` STAC action.

| Property | Type | Description |
| --- | --- | --- |
| parser | String | ReactiveSwitchParser |
| source | String | lib/core/stac/parsers/widgets/reactive_switch_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/widgets/reactive_switch_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerWidget(const ReactiveSwitchParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| type | String | Yes | Contract key used in JSON. |
| valueKey | String | Yes | Registry key that holds (and receives) the current bool. |
| initialValue | Boolean | No | Fallback when the registry value is missing or unrecognised. |
| onChanged | Map | No | STAC action payload executed after the new value is written to the registry. |
| activeColor | String | No | Hex color or `{{registryKey}}` template for the active track/thumb. |
| inactiveTrackColor | String | No | Hex color or template for the inactive track. |
| inactiveThumbColor | String | No | Hex color or template for the inactive thumb. |
| scale | Number | No | Optional `Transform.scale` factor applied around the switch. Values `<=0` or `1` are ignored. |

#### JSON

```json
{
    "type": "reactiveSwitch",
    "valueKey": "settings.notificationsEnabled",
    "initialValue": false,
    "activeColor": "{{appColors.current.primary.color}}",
    "onChanged": {
        "actionType": "log",
        "message": "Notifications toggled: {{settings.notificationsEnabled}}"
    }
}
```

### otpCountdownButton

Description: Outlined button that ticks down from `initialSeconds`, switches to a retry label when expired, and can optionally wait for a first tap before starting. On retry it fires `onRetry`; on the initial start it fires `onStart` (falling back to `onRetry` if `onStart` is not provided).

| Property | Type | Description |
| --- | --- | --- |
| parser | String | OtpCountdownButtonParser |
| source | String | lib/core/stac/parsers/widgets/otp_countdown_button_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/widgets/otp_countdown_button_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerWidget(const OtpCountdownButtonParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| type | String | Yes | Contract key used in JSON. |
| initialSeconds | Number | No | Countdown duration in seconds. Defaults to `120`. |
| retryLabel | String | No | Label shown when the countdown has expired. Defaults to `تلاش مجدد`. |
| requestLabel | String | No | Label shown before the first start (when `startOnTap` is `true`). Defaults to `دریافت رمز پویا`. |
| startOnTap | Boolean | No | If `true`, waits for the user's first tap before starting the timer. Defaults to `false`. |
| showIcon | Boolean | No | Show the clock icon next to the countdown text. Defaults to `true`. |
| iconAsset | String | No | Asset path for the icon (SVG or PNG). Defaults to `assets/icons/ic_clock.svg`. |
| onStart | Map | No | STAC action executed when the timer first starts. |
| onRetry | Map | No | STAC action executed when the user taps after expiry. |
| borderColor | String | No | Hex color or `{{registryKey}}` for the active border. |
| expiredBorderColor | String | No | Hex color or template for the border once expired. |
| countdownTextColor | String | No | Hex color or template for the countdown digits. |
| retryTextColor | String | No | Hex color or template for the retry / request label. |
| backgroundColor | String | No | Hex color or template for the button fill. Defaults to transparent. |
| height | Number | No | Button height. Defaults to `60`. |
| minWidth | Number | No | Minimum width constraint. Defaults to `132`. |

#### JSON

```json
{
    "type": "otpCountdownButton",
    "initialSeconds": 90,
    "startOnTap": true,
    "requestLabel": "دریافت رمز پویا",
    "retryLabel": "تلاش مجدد",
    "onStart": {
        "actionType": "networkRequest",
        "url": "/api/otp/request",
        "method": "POST"
    },
    "onRetry": {
        "actionType": "networkRequest",
        "url": "/api/otp/resend",
        "method": "POST"
    }
}
```

### To be documented

- `reactiveElevatedButton` — already documented in `custom_buttons.md`.
- `signaturePad` — `lib/core/stac/parsers/widgets/signature_pad_parser.dart`
- `textFormField` (override) — `lib/core/stac/parsers/widgets/custom_text_form_field_parser.dart`

## Data Widgets

Registry-driven data list / binding widgets.

### reactiveListView

Description: Reads a list from a registry key, iterates with an item template containing `{{item.*}}` / `{{isSelected}}` / `{{index}}` / `{{totalCount}}` placeholders, and rebuilds on registry changes. Item taps are dispatched programmatically (the template is re-resolved per item) so STAC's normal action pipeline does not consume the item-scoped placeholders. Supports loading / error / empty branches and an optional `separator`.

| Property | Type | Description |
| --- | --- | --- |
| parser | String | ReactiveListViewParser |
| source | String | lib/core/stac/parsers/widgets/reactive_list_view_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/widgets/reactive_list_view_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerWidget(const ReactiveListViewParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| type | String | Yes | Contract key used in JSON. |
| dataKey | String | Yes | Registry key holding either the list directly or an object that contains the list. |
| dataPath | String | No | Dotted path navigated into the value at `dataKey` to reach the list (e.g. `"data"`). |
| itemTemplate | Map | Yes | Widget JSON used for each item. May reference `{{item.<field>}}`, `{{isSelected}}`, `{{index}}`, `{{totalCount}}` and `{{formatNumber(...)}}`. |
| onItemTap | Map | No | STAC action template fired per-item (same placeholder set as `itemTemplate`). |
| itemIdField | String | No | Field on each item used as its identity. Defaults to `id`. |
| selectedIdKey | String | No | Registry key holding the currently selected id; controls the `isSelected` placeholder. |
| isLoadedKey | String | No | Registry key whose `true` value indicates data is ready. |
| loadingWidget | Map | No | Widget shown while `isLoadedKey` is not `true`. Defaults to a centred `CircularProgressIndicator`. |
| errorKey | String | No | Registry key that, when non-empty, switches to the error branch. |
| errorWidget | Map | No | Widget shown in the error branch. `{{error}}` is replaced with the error string. |
| emptyWidget | Map | No | Widget shown when the resolved list is empty. |
| separator | Map | No | Widget inserted between items (not after the last). |
| padding | Map | No | `{ left, top, right, bottom }` — outer padding around the `SingleChildScrollView`. |

#### JSON

```json
{
    "type": "reactiveListView",
    "dataKey": "deposits.rawData",
    "dataPath": "data",
    "isLoadedKey": "deposits.isLoaded",
    "errorKey": "deposits.error",
    "itemIdField": "depositNumber",
    "selectedIdKey": "selectedDepositId",
    "itemTemplate": {
        "type": "container",
        "child": {
            "type": "text",
            "data": "{{item.title}} — {{formatNumber(item.balance)}}"
        }
    },
    "onItemTap": {
        "actionType": "setValue",
        "values": [
            { "key": "selectedDepositId", "value": "{{item.depositNumber}}" }
        ]
    },
    "separator": { "type": "sizedBox", "height": 16 },
    "emptyWidget": { "type": "text", "data": "هیچ سپرده‌ای یافت نشد" },
    "padding": { "left": 16, "right": 16, "top": 8, "bottom": 8 }
}
```

### To be documented

- (none — `registryReactiveWidget` is documented under Layout Widgets.)

# Actions

## Navigation Actions

### navigate

Description: Override of STAC's built-in `navigate` action. Wraps every destination with the app theme and supports three sources, with priority **`widgetJson` (Dart-built) → `assetPath` (local JSON / API) → `request` (network) → `routeName`**. When `assetPath` is present it takes precedence over `widgetType`; when only `widgetType` is set the parser preloads the widget JSON via `StacWidgetLoader.loadWidgetJson`. Local `/json/*.json` paths are kept as-is (no auto-conversion to `/api/GET_*.json`).

| Property | Type | Description |
| --- | --- | --- |
| actionType | String | navigate |
| parser | String | CustomNavigateActionParser |
| source | String | lib/core/stac/parsers/actions/custom_navigate_action_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/actions/custom_navigate_action_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (inline override: `StacRegistry.instance.registerAction(const CustomNavigateActionParser(), true);`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| assetPath | String | No | Path of a local JSON / API document to render as the destination. Wins over `widgetType` when both are present. |
| widgetType | String | No | Key of a Dart-registered STAC widget loadable via `StacWidgetLoader.loadWidgetJson`. |
| routeName | String | No | Named route. Also used as a `widgetType` fallback for push-style navigation when it does not start with `/`. |
| navigationStyle | String | No | One of `push`, `pushReplacement`, `pushAndRemoveAll`, `pop`, etc. (see `NavigationStyle`). Defaults to `push`. |
| request | Map | No | `StacNetworkRequest` JSON for a network-fetched destination. |
| arguments | Map | No | Forwarded to `StacNavigationService.navigate`. |
| result | dynamic | No | Result value passed back when popping. |

#### JSON

```json
{
    "actionType": "navigate",
    "navigationStyle": "push",
    "assetPath": "lib/stac/tobank/cards/api/GET_tobank_cards_management.json"
}
```

### flowNext

Description: Advances a multi-step flow. When a `FlowProvider` is found in the context, calls `manager.nextStep()` (handling last-step completion). When no flow is active, runs the `fallback` action if it is one of the supported types (`pop`); generic fallbacks are logged but not executed.

| Property | Type | Description |
| --- | --- | --- |
| actionType | String | flowNext |
| parser | String | FlowNextActionParser |
| source | String | lib/core/stac/parsers/actions/flow_next_action_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/actions/flow_next_action_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerAction(const FlowNextActionParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| fallback | Map | No | Action JSON to run when no `FlowProvider` is in scope. Supported `actionType` values today: `pop`. |

#### JSON

```json
{
    "actionType": "flowNext",
    "fallback": {
        "actionType": "pop"
    }
}
```

### To be documented

- `closeDialog` — `lib/core/stac/parsers/actions/close_dialog_action_parser.dart`
- `launchUrl` — `lib/core/stac/parsers/actions/launch_url_action_parser.dart`

## UI Actions

Show snackbars, dialogs, bottom sheets, pickers, theme toggles, audio.

### customSnackBar

Description: Shows a floating `SnackBar`. Resolves `{{...}}` and `__STAC_OPEN__...}}` placeholders in `message` from the STAC registry (with `??` null-coalescing). Supports an optional `infoCard` style for an outlined bordered banner with an info icon, and an optional custom `child` widget that replaces the default text content entirely.

| Property | Type | Description |
| --- | --- | --- |
| actionType | String | customSnackBar |
| parser | String | ShowSnackBarActionParser |
| source | String | lib/core/stac/parsers/actions/show_snackbar_action_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/actions/show_snackbar_action_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerAction(const ShowSnackBarActionParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| message | String | No¹ | Snackbar text. Supports `{{key}}` and `__STAC_OPEN__key}}` placeholders. Falls back to `content` / `content.data` when empty. |
| content | String \| Map | No¹ | Built-in STAC compatibility: when `message` is empty, `content` (as a string) or `content.data` (as a map) is used. |
| backgroundColor | String | No | Hex color (`#RRGGBB` or `#AARRGGBB`). Defaults to `Colors.black87` (or transparent when `child` is provided). |
| textColor | String | No | Hex color for the default text. Defaults to white. |
| duration | Number | No | Duration in milliseconds. Defaults to `3000` (with the `infoCard` style adding 1000 ms). |
| snackStyle | String | No | `"infoCard"` switches to the bordered info-card layout. |
| child | Map | No | Custom STAC widget rendered in place of the default text content. |

¹ Either `message` (after fallback to `content`/`content.data`) or `child` must yield something to render.

#### JSON

```json
{
    "actionType": "customSnackBar",
    "message": "{{appStrings.cards.added ?? Card added}}",
    "snackStyle": "infoCard",
    "duration": 3000
}
```

### showBottomSheet

Description: Opens a modal bottom sheet whose body is the STAC widget JSON in `sheet`. If the sheet `pop`s with a `Map` value, that value is dispatched as a STAC action via `Stac.onCallFromJson`. When `sheet` is omitted a legacy fallback sheet is rendered using `title` and `items`.

| Property | Type | Description |
| --- | --- | --- |
| actionType | String | showBottomSheet |
| parser | String | ShowBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_bottom_sheet_action_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/actions/show_bottom_sheet_action_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`registerShowBottomSheetActionParser();`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| sheet | Map | No | STAC widget JSON rendered as the sheet body. When omitted, the legacy fallback (title + items list) is used. |
| title | String | No | Title for the legacy fallback. Defaults to `Bottom Sheet`. |
| items | List<Map> | No | Items for the legacy fallback. Each item supports `title` and `onTap` (returned via `Navigator.pop`). |
| isScrollControlled | Boolean | No | Forwarded to `showModalBottomSheet`. Defaults to `true`. |
| useSafeArea | Boolean | No | Forwarded to `showModalBottomSheet`. Defaults to `false`. |
| isDismissible | Boolean | No | Forwarded to `showModalBottomSheet`. Defaults to `true`. |
| enableDrag | Boolean | No | Forwarded to `showModalBottomSheet`. Defaults to `true`. |
| backgroundColor | String | No | Hex color. Defaults to transparent. |
| barrierColor | String | No | Hex color. Defaults to `Colors.black54`. |

#### JSON

```json
{
    "actionType": "showBottomSheet",
    "isScrollControlled": true,
    "sheet": {
        "type": "container",
        "padding": { "all": 16 },
        "child": {
            "type": "column",
            "children": [
                { "type": "text", "data": "اطلاعات بیشتر" },
                {
                    "type": "elevatedButton",
                    "child": { "type": "text", "data": "تأیید" },
                    "onPressed": {
                        "actionType": "pop",
                        "result": { "actionType": "log", "message": "Confirmed" }
                    }
                }
            ]
        }
    }
}
```

### To be documented

- `hideSnackBar` — `lib/core/stac/parsers/actions/hide_snackbar_action_parser.dart`
- `persianDatePicker` — `lib/core/stac/parsers/actions/persian_date_picker_action_parser.dart`
- `playAudioUrl` / `stopAudioUrl` — `lib/core/stac/parsers/actions/play_audio_url_action_parser.dart`
- `showRulesBottomSheet` — `lib/core/stac/parsers/actions/show_rules_bottom_sheet_action_parser.dart`
- `showGuideOptionsBottomSheet` — `lib/core/stac/parsers/actions/show_guide_options_bottom_sheet_action_parser.dart`
- `showPhotoTipsBottomSheet` — `lib/core/stac/parsers/actions/show_photo_tips_bottom_sheet_action_parser.dart`
- `showJobSelectorBottomSheet` — `lib/core/stac/parsers/actions/show_job_selector_bottom_sheet_action_parser.dart`
- `showBankAddressBottomSheet` — `lib/core/stac/parsers/actions/show_bank_address_bottom_sheet_action_parser.dart`
- `showThemeSelectorBottomSheet` — `lib/core/stac/parsers/actions/show_theme_selector_bottom_sheet_action_parser.dart`
- `showDeleteAccountConfirmBottomSheet` — `lib/core/stac/parsers/actions/show_delete_account_confirm_bottom_sheet_action_parser.dart`
- `showLogoutConfirmDialog` — `lib/core/stac/parsers/actions/show_logout_confirm_dialog_action_parser.dart`
- `showAddDestinationCardBottomSheet` — `lib/core/stac/parsers/actions/show_add_destination_card_bottom_sheet_action_parser.dart`
- `showGiftCardPurchaseBottomSheet` — `lib/core/stac/parsers/actions/show_gift_card_purchase_bottom_sheet_action_parser.dart`
- `showGiftCardPaymentAccountsBottomSheet` — `lib/core/stac/parsers/actions/show_gift_card_payment_accounts_bottom_sheet_action_parser.dart`
- `showGiftCardAmountGuideBottomSheet` — `lib/core/stac/parsers/actions/show_gift_card_amount_guide_bottom_sheet_action_parser.dart`
- `showGiftCardMessageGuideBottomSheet` — `lib/core/stac/parsers/actions/show_gift_card_message_guide_bottom_sheet_action_parser.dart`
- `showGiftCardLocationSelectorBottomSheet` — `lib/core/stac/parsers/actions/show_gift_card_location_selector_bottom_sheet_action_parser.dart`
- `showGiftCardSelectDateBottomSheet` — `lib/core/stac/parsers/actions/show_gift_card_select_date_bottom_sheet_action_parser.dart`
- `showGiftCardSelectAmountBottomSheet` — `lib/core/stac/parsers/actions/show_gift_card_select_amount_bottom_sheet_action_parser.dart`
- `showGiftCardDesignTypeBottomSheet` — `lib/core/stac/parsers/actions/show_gift_card_design_type_bottom_sheet_action_parser.dart`
- `showGiftCardPlanSelectorBottomSheet` — `lib/core/stac/parsers/actions/show_gift_card_plan_selector_bottom_sheet_action_parser.dart`
- `showTransferPurposeBottomSheet` — `lib/core/stac/parsers/actions/show_transfer_purpose_bottom_sheet_action_parser.dart`
- `showTransferTypeBottomSheet` — `lib/core/stac/parsers/actions/show_transfer_type_bottom_sheet_action_parser.dart`
- `showTransferInBankTypeBottomSheet` — `lib/core/stac/parsers/actions/show_transfer_in_bank_type_bottom_sheet_action_parser.dart`
- `showCardExpireSelectBottomSheet` — `lib/core/stac/parsers/actions/show_card_expire_select_bottom_sheet_action_parser.dart`
- `showTransferCardConfirmDialog` — `lib/core/stac/parsers/actions/show_transfer_card_confirm_dialog_action_parser.dart`
- `showTransferCardScanner` — `lib/core/stac/parsers/actions/show_transfer_card_scanner_action_parser.dart`

## Form Actions

Validation, value transforms, list management.

### validateFields

Description: Validates a list of form fields against optional regex rules and writes the boolean result to a registry key. Field values are resolved with the priority **form scope → `TextFormFieldControllerRegistry` → `registry["form.<id>"]` → `registry[<id>]`**, and the matched string is digit-normalised (Persian/Arabic digits → ASCII) before testing the rule.

| Property | Type | Description |
| --- | --- | --- |
| actionType | String | validateFields |
| parser | String | ValidateFieldsActionParser |
| source | String | lib/core/stac/parsers/actions/validate_fields_action_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/actions/validate_fields_action_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (inline override: `StacRegistry.instance.registerAction(const ValidateFieldsActionParser(), true);`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| resultKey | String | No | Registry key the boolean validity result is written to. Defaults to `formValid`. |
| fields | List<Map> | Yes | Field rules. Each entry: `id` (String, required), `rule` (String regex, optional), `optional` (String registry key whose `true` value skips this field). |

#### JSON

```json
{
    "actionType": "validateFields",
    "resultKey": "isFormValid",
    "fields": [
        { "id": "mobile", "rule": "^09\\d{9}$" },
        { "id": "nationalCode", "rule": "^\\d{10}$" },
        { "id": "referral", "optional": "noReferral" }
    ]
}
```

### formatNumber

Description: Reads a value from `sourceKey`, strips every non-digit character, applies thousands separators (commas every three digits from the right), and writes the formatted string to `destinationKey`. Empty input becomes `"0"`.

| Property | Type | Description |
| --- | --- | --- |
| actionType | String | formatNumber |
| parser | String | FormatNumberActionParser |
| source | String | lib/core/stac/parsers/actions/format_number_action_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/actions/format_number_action_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerAction(const FormatNumberActionParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| sourceKey | String | Yes | Registry key whose value is read and reformatted. |
| destinationKey | String | Yes | Registry key the formatted string is written to. |

#### JSON

```json
{
    "actionType": "formatNumber",
    "sourceKey": "amount",
    "destinationKey": "amountFormatted"
}
```

### To be documented

- `setValue` (override) — `lib/core/stac/parsers/actions/custom_set_value_action_parser.dart`
- `validateTransferCardContinue` — `lib/core/stac/parsers/actions/validate_transfer_card_continue_action_parser.dart`
- `setTransferDetailsContinueEnabled` — `lib/core/stac/parsers/actions/set_transfer_details_continue_enabled_action_parser.dart`
- `setTransferInBankContinueEnabled` — `lib/core/stac/parsers/actions/set_transfer_in_bank_continue_enabled_action_parser.dart`
- `filterTransferIbanList` — `lib/core/stac/parsers/actions/filter_transfer_iban_list_action_parser.dart`
- `setTransferDestinationFromIban` — `lib/core/stac/parsers/actions/set_transfer_destination_from_iban_action_parser.dart`
- `calculateSum` — `lib/core/stac/parsers/actions/calculate_sum_action_parser.dart`
- `formatDate` — `lib/core/stac/parsers/actions/format_date_action_parser.dart`
- `amountToWords` — `lib/core/stac/parsers/actions/amount_to_words_action_parser.dart`
- `addGiftCardAmountCard` — `lib/core/stac/parsers/actions/add_gift_card_amount_card_action_parser.dart`
- `removeGiftCardAmountCard` — `lib/core/stac/parsers/actions/remove_gift_card_amount_card_action_parser.dart`
- `updateGiftCardAmountCount` — `lib/core/stac/parsers/actions/update_gift_card_amount_count_action_parser.dart`

## Network Actions

### networkRequest

Description: Override of STAC's built-in `networkRequest`. Resolves `{{...}}` templates in URL, headers, and body (with support for `{{toInt(key)}}`, `{{removeLeadingZero(key)}}`, and `{{replace(key, 'old', 'new')}}` helpers), accepts `data` as an alias for `body`, then stores the response under registry keys `data` and `data_payload` (and, when `dataBind` is set, under `responses.<bind>.{raw,payload,data,statusCode,headers,ok,timestamp}`). Result handlers are dispatched by status code with `-1` acting as fallback.

| Property | Type | Description |
| --- | --- | --- |
| actionType | String | networkRequest |
| parser | String | CustomNetworkRequestActionParser |
| source | String | lib/core/stac/parsers/actions/custom_network_request_action_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/actions/custom_network_request_action_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (inline override: `StacRegistry.instance.registerAction(const CustomNetworkRequestActionParser(), true);`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| url | String | Yes | Request URL. Supports `{{...}}` templates and the `removeLeadingZero` / `replace` helpers. |
| method | String | No | HTTP method (`GET`, `POST`, `PUT`, `DELETE`, ...). |
| headers | Map<String,String> | No | Request headers. Each value is template-resolved. |
| body | dynamic | No | Request body. May be a Map / List / String; templates are resolved recursively. |
| data | dynamic | No | Alias for `body` (used when STAC JSON authors prefer the `data` key). |
| dataBind | String | No | Namespace under `responses.<dataBind>.*` where the response is stored in addition to the legacy `data` / `data_payload` keys. |
| results | List<Map> | Yes | Per-status-code handlers. Each entry has `statusCode` (use `-1` as the fallback / timeout / Dio exception bucket) and `action` (STAC action JSON). |

#### JSON

```json
{
    "actionType": "networkRequest",
    "method": "POST",
    "url": "{{apiBaseUrl}}/api/v1/cards/draft",
    "headers": {
        "Authorization": "Bearer {{auth.accessToken}}",
        "Content-Type": "application/json"
    },
    "data": {
        "sourceAccount": "{{selectedDeposit.depositNumber}}",
        "issuerAccountNumber": "{{selectedDeposit.depositIban}}"
    },
    "dataBind": "createCardDraft",
    "results": [
        {
            "statusCode": 200,
            "action": {
                "actionType": "navigate",
                "assetPath": "lib/stac/tobank/cards/api/GET_tobank_cards_confirm.json"
            }
        },
        {
            "statusCode": -1,
            "action": {
                "actionType": "customSnackBar",
                "message": "خطا در ارتباط با سرور"
            }
        }
    ]
}
```

### To be documented

- `transferReceipt` — `lib/core/stac/parsers/actions/transfer_receipt_action_parser.dart`
- `promissoryLogin` — `lib/stac/tobank/flows/promissory_real/service/promissory_login_action_parser.dart`
- `promissorySign` — `lib/core/stac/parsers/actions/promissory_sign_action_parser.dart`
- `authPersist` — `lib/core/stac/parsers/actions/auth_persist_action_parser.dart`

## State Actions

Logging, sequencing, biometric / identity state.

### log

Description: Writes a message to `AppLogger` at the requested `level`. The message resolves `{{key}}` placeholders from the registry, supports `{{now()}}` for the current epoch milliseconds, and supports simple `a - b` subtraction between two registry/`now()` terms. Long messages are chunked (2000 chars) to avoid log truncation.

| Property | Type | Description |
| --- | --- | --- |
| actionType | String | log |
| parser | String | LogActionParser |
| source | String | lib/core/stac/parsers/actions/log_action_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/actions/log_action_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerAction(const LogActionParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| message | String | Yes | Log line. Supports `{{key}}`, `{{now()}}`, and `{{a - b}}` expressions. |
| level | String | No | `debug`, `info`, `warning` / `warn`, or `error`. Defaults to `info`. |

#### JSON

```json
{
    "actionType": "log",
    "level": "debug",
    "message": "Tap latency = {{now() - tapStartedAt}}ms"
}
```

### sequence

Description: Runs a list of STAC actions one after another. `Future`-returning actions are awaited before the next runs, and the loop stops if the surrounding `BuildContext` becomes unmounted.

| Property | Type | Description |
| --- | --- | --- |
| actionType | String | sequence |
| parser | String | SequenceActionParser |
| source | String | lib/core/stac/parsers/actions/sequence_action_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/actions/sequence_action_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerAction(const SequenceActionParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| actions | List<Map> | Yes | STAC action JSONs executed in order. |

#### JSON

```json
{
    "actionType": "sequence",
    "actions": [
        {
            "actionType": "setValue",
            "values": [{ "key": "isSubmitting", "value": true }]
        },
        {
            "actionType": "networkRequest",
            "url": "/api/submit",
            "method": "POST",
            "results": [
                {
                    "statusCode": 200,
                    "action": { "actionType": "flowNext" }
                }
            ]
        },
        {
            "actionType": "setValue",
            "values": [{ "key": "isSubmitting", "value": false }]
        }
    ]
}
```

### To be documented

- `fingerPrint` — `lib/core/stac/parsers/actions/finger_print_action_parser.dart`
- `biometricRegister` — `lib/core/stac/parsers/actions/biometric_register_action_parser.dart`
- `biometricDebug` — `lib/core/stac/parsers/actions/biometric_debug_action_parser.dart`
- `themeToggle` — `lib/core/stac/parsers/actions/theme_toggle_action_parser.dart` *(registration is currently commented out in `register_custom_parsers.dart`; documented for parity but inactive at runtime.)*

## Utility Actions

File IO, OS / contact integration, examples.

### saveFile

Description: Resolves the file content (preferring `registryKey`, falling back to template-resolved `content`), then writes it to the platform Downloads directory under `fileName`. Treats the content as base64 by default — strips a `data:` prefix, decodes, and writes bytes — otherwise writes the raw string. Shows a `SnackBar` on success or failure.

| Property | Type | Description |
| --- | --- | --- |
| actionType | String | saveFile |
| parser | String | SaveFileActionParser |
| source | String | lib/core/stac/parsers/actions/save_file_action_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/actions/save_file_action_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`CustomComponentRegistry.instance.registerAction(const SaveFileActionParser());`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| fileName | String | No | Output file name (under Downloads / app documents). Defaults to `output.txt`. |
| content | String | No | Inline content; `{{key}}` placeholders are resolved from the registry. Used when `registryKey` yields nothing. |
| registryKey | String | No | Registry key holding the content. Preferred over `content` when non-empty. |
| isBase64 | Boolean | No | When `true` (default), the content is decoded from base64 and written as bytes. When `false`, written as plain text. |

#### JSON

```json
{
    "actionType": "saveFile",
    "fileName": "receipt_{{transferId}}.pdf",
    "registryKey": "serverSignedPdf",
    "isBase64": true
}
```

### pickFile

Description: Picks a file via `file_picker` (desktop / web) or `image_picker` (mobile camera / gallery), optionally crops images via `image_cropper`, optionally shows a confirm/retry preview bottom sheet, then writes the result into the STAC registry through `setValue`. On web the file is stored as a `data:` base64 URL; on native it is stored as a file path.

| Property | Type | Description |
| --- | --- | --- |
| actionType | String | pickFile |
| parser | String | FilePickerActionParser |
| source | String | lib/core/stac/parsers/actions/file_picker_action_parser.dart |
| parserImport | String | lib/core/stac/registry/register_custom_parsers.dart (`import '../parsers/actions/file_picker_action_parser.dart';`) |
| parserRegistration | String | lib/core/stac/registry/register_custom_parsers.dart (`registerFilePickerActionParser();`) |
| registry | String | lib/core/stac/registry/custom_component_registry.dart |

#### JSON Properties

| Property | Type | Is Required | Description |
| --- | --- | --- | --- |
| fileType | String | No | One of `image`, `video`, `audio`, `media`, `custom`, `any`. Defaults to `image`. |
| allowedExtensions | List<String> | No | Extension whitelist (used with `fileType: "custom"`). |
| allowMultiple | Boolean | No | Allow multiple selection. Forces the `file_picker` path. Defaults to `false`. |
| targetKey | String | No | Registry key where the picked value is stored. Defaults to `selectedFile`. |
| hasValueKey | String | No | Registry key set to `true` after a successful pick. Defaults to `hasImage`. |
| fileNameKey | String | No | Optional registry key where the picked file's name is stored. |
| source | String | No | `camera` or `gallery` — when set with `fileType` of `image`/`video` on mobile, uses `image_picker` instead of `file_picker`. |
| cameraDevice | String | No | `front` or `rear` (default). Only used when `source` is `camera`. |
| cropImage | Boolean | No | After picking an image on mobile, open `image_cropper`. Defaults to `false`. |
| cropAspectRatioX | Number | No | Locks the crop ratio's X component (used together with `cropAspectRatioY`). |
| cropAspectRatioY | Number | No | Locks the crop ratio's Y component. |
| previewBeforeConfirm | Boolean | No | Show a confirm / retry / cancel bottom sheet before committing. Defaults to `false`. |
| previewSheetTitle | String | No | Title shown on the preview sheet. |
| confirmButtonText | String | No | Label for the confirm button. |
| retryButtonText | String | No | Label for the retry button. |

#### JSON

```json
{
    "actionType": "pickFile",
    "fileType": "image",
    "source": "camera",
    "cameraDevice": "front",
    "cropImage": true,
    "cropAspectRatioX": 1,
    "cropAspectRatioY": 1,
    "targetKey": "profile.selfie",
    "hasValueKey": "profile.hasSelfie",
    "fileNameKey": "profile.selfieName",
    "previewBeforeConfirm": true,
    "previewSheetTitle": "عکس گرفته شده مورد تایید شما است؟",
    "confirmButtonText": "تایید عکس",
    "retryButtonText": "بازگشت"
}
```

### To be documented

- `shareFile` — `lib/core/stac/parsers/actions/share_file_action_parser.dart`
- `pickContactPhone` — `lib/core/stac/parsers/actions/pick_contact_phone_action_parser.dart`
- `exampleAction` — `lib/core/stac/parsers/actions/example_action_parser.dart`

# Theme Tokens

Global registry namespaces preloaded at app start by the loaders under `lib/core/stac/loaders/tobank/`. Each loader fetches a JSON document from the Tobank backend, flattens it into dot-notation keys, and writes the leaves to `StacRegistry` so any STAC JSON can reference them with `{{...}}` placeholders.

All four loaders share the same lifecycle:

- Called once during bootstrap (after `Stac.initialize()`).
- Re-runs on hot restart clear the old keys first and reload.
- Each loader exposes `isLoaded`, `clearCache()`, and a debug `getX()` helper.

## appColors

Description: Color tokens loaded by `TobankColorsLoader` from `https://api.tobank.com/colors`. Stores the raw schema under `appColors.light.*` and `appColors.dark.*`, then mirrors the active theme's leaves under `appColors.current.*` aliases. The active theme name is also written to `appTheme.current` and can be switched at runtime via `TobankColorsLoader.setCurrentTheme(...)`, which rebuilds the `current.*` aliases without re-fetching.

| Property | Type | Description |
| --- | --- | --- |
| prefix | String | appColors |
| loader | String | TobankColorsLoader |
| source | String | lib/core/stac/loaders/tobank/tobank_colors_loader.dart |
| endpoint | String | https://api.tobank.com/colors (`GET`, body shape `{ "data": { ... } }`) |
| bootstrapCall | String | `await TobankColorsLoader.loadColors(dio);` |
| themeSwitchCall | String | `TobankColorsLoader.setCurrentTheme('dark');` |
| storage | String | `StacRegistry.instance.setValue(...)` — one leaf per dotted key. |
| sideValues | String | Also writes `appTheme.current` (one of `light` / `dark`). |

#### Key Namespaces

| Pattern | Source | Description |
| --- | --- | --- |
| `appColors.light.<path>` | Always present | Light-theme color leaf (e.g. `appColors.light.text.title`). |
| `appColors.dark.<path>` | Always present | Dark-theme color leaf (e.g. `appColors.dark.text.title`). |
| `appColors.current.<path>` | Alias to active theme | Resolves to whichever of `light` / `dark` matches `appTheme.current`. **Use this in screen JSON unless a specific theme is intended.** |
| `appTheme.current` | Side value | Current theme name (`light` or `dark`). |

#### JSON

```json
{
    "type": "text",
    "data": "Welcome",
    "style": {
        "type": "custom",
        "color": "{{appColors.current.text.title}}",
        "fontSize": 18
    }
}
```

```json
{
    "type": "elevatedButton",
    "style": {
        "backgroundColor": "{{appColors.current.button.primary.backgroundColor}}"
    },
    "child": {
        "type": "text",
        "data": "Continue",
        "style": {
            "type": "custom",
            "color": "{{appColors.current.button.primary.foregroundColor}}"
        }
    }
}
```

## appStrings

Description: Localization strings loaded by `TobankStringsLoader` from `https://api.tobank.com/strings`. The nested JSON tree is flattened into dot-notation registry keys (e.g. `appStrings.login.validationTitle`) so any STAC `data` field can interpolate them with `{{...}}`.

| Property | Type | Description |
| --- | --- | --- |
| prefix | String | appStrings |
| loader | String | TobankStringsLoader |
| source | String | lib/core/stac/loaders/tobank/tobank_strings_loader.dart |
| endpoint | String | https://api.tobank.com/strings (`GET`, body shape `{ "data": { ... } }`) |
| bootstrapCall | String | `await TobankStringsLoader.loadStrings(dio);` |
| storage | String | `StacRegistry.instance.setValue(...)` — one leaf per dotted key. |

#### Key Namespaces

| Pattern | Description |
| --- | --- |
| `appStrings.<group>.<key>` | Localized string leaf (e.g. `appStrings.menu.appBarTitle`, `appStrings.common.loading`, `appStrings.promissory.confirmTitle`). |

Nesting depth is whatever the backend payload provides — every non-Map leaf becomes one registry key prefixed with `appStrings.`.

#### JSON

```json
{
    "type": "text",
    "data": "{{appStrings.promissory.confirmTitle}}"
}
```

```json
{
    "type": "appBar",
    "title": {
        "type": "text",
        "data": "{{appStrings.menu.appBarTitle}}"
    }
}
```

Null-coalescing fallback inside templates is supported by some actions (e.g. `customSnackBar`):

```json
{
    "actionType": "customSnackBar",
    "message": "{{appStrings.cards.added ?? Card added}}"
}
```

## appStyles

Description: Component style tokens loaded by `TobankStylesLoader` from `https://api.tobank.com/styles`. Before storage, every `{{appColors.*}}` reference inside the payload is pre-resolved against the already-loaded colors registry so the cached styles contain literal hex values (this is why **colors must load before styles**). The flattened leaves are then stored under `appStyles.*`. A helper `TobankStylesLoader.buildStyleObject(key)` reconstructs ready-to-use STAC style maps (`text`, `button`, `input`, ...) from those leaves.

| Property | Type | Description |
| --- | --- | --- |
| prefix | String | appStyles |
| loader | String | TobankStylesLoader |
| source | String | lib/core/stac/loaders/tobank/tobank_styles_loader.dart |
| endpoint | String | https://api.tobank.com/styles (`GET`, body shape `{ "data": { ... } }`) |
| bootstrapCall | String | `await TobankStylesLoader.loadStyles(dio);` (must run *after* `TobankColorsLoader.loadColors`) |
| storage | String | `StacRegistry.instance.setValue(...)` — leaves only; colors are pre-resolved. |
| builder | String | `TobankStylesLoader.buildStyleObject(String key)` returns a STAC style Map for known categories (`text`, `button`, `input`). |

#### Key Namespaces

| Pattern | Description |
| --- | --- |
| `appStyles.text.<name>.{color,fontSize,fontWeight,fontFamily,height}` | Text style leaves (e.g. `appStyles.text.pageTitle.color`). |
| `appStyles.button.<name>.{backgroundColor,elevation,height,borderRadius,paddingTop,paddingBottom,textStyleColor,textStyleFontWeight,textStyleFontSize}` | Button style leaves (e.g. `appStyles.button.primary.backgroundColor`). |
| `appStyles.input.<name>.{hintStyleColor,hintStyleFontWeight,hintStyleFontSize,suffixIconColor,contentPaddingHorizontal,contentPaddingVertical,fillColor}` | Input/textfield style leaves (e.g. `appStyles.input.login.hintStyleColor`). |
| `appStyles.<other>.<prop>` | Any additional categories the backend ships (e.g. `appStyles.appbarStyle`, `appStyles.cardStyle.*`). |

#### JSON

Direct leaf interpolation (use individual properties):

```json
{
    "type": "text",
    "data": "Page title",
    "style": {
        "type": "custom",
        "color": "{{appStyles.text.pageTitle.color}}",
        "fontSize": "{{appStyles.text.pageTitle.fontSize}}",
        "fontWeight": "{{appStyles.text.pageTitle.fontWeight}}"
    }
}
```

Whole-style interpolation (when the backend ships a flat node — value is whatever was stored at that key):

```json
{
    "type": "appBar",
    "value": "{{appStyles.appbarStyle}}"
}
```

Button composed from `appStyles.button.primary.*`:

```json
{
    "type": "elevatedButton",
    "style": {
        "backgroundColor": "{{appStyles.button.primary.backgroundColor}}",
        "elevation": "{{appStyles.button.primary.elevation}}",
        "textStyle": {
            "type": "custom",
            "color": "{{appStyles.button.primary.textStyleColor}}",
            "fontSize": "{{appStyles.button.primary.textStyleFontSize}}",
            "fontWeight": "{{appStyles.button.primary.textStyleFontWeight}}"
        }
    },
    "child": {
        "type": "text",
        "data": "{{appStrings.common.continueLabel}}"
    }
}
```

## appAssets

Description: Asset path tokens loaded by `TobankAssetsLoader` from `https://api.tobank.com/assets`. Flattens the payload into `appAssets.*` keys and (where the backend provides `*Dark` variants) creates `appAssets.current.*` aliases that follow `appTheme.current`. Use these placeholders anywhere a string asset path is expected (e.g. `iconAsset`, `assetPath`, image `src`).

| Property | Type | Description |
| --- | --- | --- |
| prefix | String | appAssets |
| loader | String | TobankAssetsLoader |
| source | String | lib/core/stac/loaders/tobank/tobank_assets_loader.dart |
| endpoint | String | https://api.tobank.com/assets (`GET`, body shape `{ "data": { ... } }`) |
| bootstrapCall | String | `await TobankAssetsLoader.loadAssets(dio);` (after colors, so `appTheme.current` is set) |
| storage | String | `StacRegistry.instance.setValue(...)` — one leaf per dotted key, plus theme-aware `current.*` aliases. |

#### Key Namespaces

| Pattern | Description |
| --- | --- |
| `appAssets.<group>.<name>` | Plain asset path (e.g. `appAssets.icons.login`). |
| `appAssets.<group>.<name>Dark` | Dark-variant raw leaf (when shipped by the backend). |
| `appAssets.current.<group>.<name>` | Theme-aware alias resolving to the correct light/dark variant. |

#### JSON

```json
{
    "type": "image",
    "src": "{{appAssets.icons.login}}"
}
```

```json
{
    "type": "otpCountdownButton",
    "iconAsset": "{{appAssets.current.icons.clock}}",
    "initialSeconds": 120
}
```

# Styles

No Tobank-specific custom style parsers are registered — styling is handled by built-in STAC types. See the upstream STAC docs at https://docs.stac.dev/ for the canonical reference.

## Layout Styles

_Empty. Use built-in STAC layout styles._

## Decoration Styles

_Empty. Use built-in STAC decoration styles._

## Border Styles

_Empty. Use built-in STAC border styles._

## Text Styles

_Empty. Use built-in STAC text styles._

## Table Styles

_Empty. Use built-in STAC table styles._

# Tools

No Tobank-specific tools are registered through the parser system. CLI helpers under `tools/` and `graphify-*/` directories are build-time utilities and are documented separately in their own folders.
