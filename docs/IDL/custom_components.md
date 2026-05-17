# Custom Components

Documentation for Tobank custom STAC contracts in JSON format.

> ## Documentation Index
>
> Style reference: https://docs.stac.dev/widgets/check_box
>
> This page is JSON-only (no Dart examples).

The sections below document every custom widget and custom action parser currently registered in this repository.

## Properties

| Property | Type | Description |
| --- | --- | --- |
| widgetKey | String | JSON key used by custom widgets (type). |
| actionKey | String | JSON key used by custom actions (actionType). |
| registry | CustomComponentRegistry | Canonical registry for custom parsers. |
| registerEntrypoint | registerCustomParsers() | Entrypoint that registers all custom parsers. |

## Example (JSON)

```json
{
    "type":  "reactiveElevatedButton",
    "enabledKey":  "form.canContinue",
    "child":  {
                  "type":  "text",
                  "data":  "Continue"
              },
    "onPressed":  {
                      "actionType":  "setValue",
                      "values":  [
                                     {
                                         "key":  "form.amount",
                                         "value":  1000
                                     }
                                 ]
                  }
}
```

## Custom Widgets

### assetWidget

Description: Loads and renders another STAC JSON asset from assetPath, so screens can be composed from external JSON files.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | AssetWidgetParser |
| source | String | lib/core/stac/parsers/widgets/asset_widget_parser.dart |

#### JSON

```json
{
    "type":  "assetWidget",
    "assetPath":  "lib/stac/tobank/flows/login_flow_linear/json/login_flow_linear_login.json"
}
```

### bottomNavigationBar

Description: Renders a custom bottom navigation bar and supports custom type/layout behavior used in Tobank flows.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | CustomBottomNavigationBarParser |
| source | String | lib/core/stac/parsers/widgets/custom_bottom_navigation_bar_parser.dart |

#### Enum Values

- `type`: `fixed`, `shifting`
- `landscapeLayout`: `spread`, `centered`, `linear`

#### JSON

```json
{
    "type": "bottomNavigationBar",
    "items": [...],
    "showSelectedLabels": false
}
```

### bottomNavigationView

Description: Hosts tab/page content for bottom navigation and keeps tab content behavior aligned with the custom navigation bar parser.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | CustomBottomNavigationViewParser |
| source | String | lib/core/stac/parsers/widgets/custom_bottom_navigation_view_parser.dart |

#### JSON

```json
{
    "type": "bottomNavigationView",
    "children": [...]
}
```

### image

Description: Renders images with Tobank custom behavior (registry-aware source resolution, SVG handling, and fit/image-type controls).


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | CustomImageParser |
| source | String | lib/core/stac/parsers/widgets/custom_image_parser.dart |

#### Enum Values

- `imageType`: `asset`, `network`, `file`
- `fit`: `fill`, `contain`, `cover`, `fitWidth`, `fitHeight`, `none`, `scaleDown`

#### JSON

```json
{
    "type":  "image",
    "src":  "{{appAssets.icons.support}}",
    "imageType":  "asset",
    "width":  24,
    "height":  24
}
```

### textFormField

Description: Renders an enhanced text input with custom validation, controller integration, and extended decoration/text-direction options.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | CustomTextFormFieldParser |
| source | String | lib/core/stac/parsers/widgets/custom_text_form_field_parser.dart |

#### Enum Values

- `supportTextDirection`: `rtl`, `ltr`
- `decoration.hintTextAlign`: `left`, `right`, `center`, `start`, `end`, `justify`
- `decoration.hintTextDirection`: `ltr`, `rtl`
- `decoration.border.type` (and `enabledBorder` / `focusedBorder` / `errorBorder` / `focusedErrorBorder` / `disabledBorder`): `none`
- `validatorRules[].rule`: `isEmail`, `isName`, `isPassword`, `isNotEmpty`, `compare`, `general`

#### JSON

```json
{
    "type":  "textFormField",
    "id":  "phone",
    "keyboardType":  "number",
    "maxLength":  11
}
```

### visibility

Description: Shows or hides its child dynamically based on resolved/registry values (including string and boolean coercion).


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | CustomVisibilityParser |
| source | String | lib/core/stac/parsers/widgets/custom_visibility_parser.dart |

#### JSON

```json
{
    "type":  "visibility",
    "visible":  "[[form.canContinue]]",
    "child":  {
                  "type":  "text",
                  "data":  "Continue"
              }
}
```

### exampleCard

Description: Sample/demo widget parser used as a reference for building and registering custom widgets.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | ExampleCardParser |
| source | String | lib/core/stac/parsers/widgets/example_card_parser.dart |

#### JSON

```json
{
    "type":  "exampleCard",
    "title":  "Example",
    "description":  "Demo"
}
```

### onMountAction

Description: Executes a STAC action when the widget mounts, then renders its child widget.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | OnMountActionParser |
| source | String | lib/core/stac/parsers/widgets/on_mount_action_parser.dart |

#### JSON

```json
{
    "type":  "onMountAction",
    "action":  {
                   "actionType":  "log",
                   "message":  "mounted"
               },
    "child":  {
                  "type":  "text",
                  "data":  "Loading"
              }
}
```

### otpCountdownButton

Description: Shows an OTP resend/countdown button with timer state and retry/request behavior for verification flows.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | OtpCountdownButtonParser |
| source | String | lib/core/stac/parsers/widgets/otp_countdown_button_parser.dart |

#### JSON

```json
{
    "type":  "otpCountdownButton",
    "initialSeconds":  119,
    "requestLabel":  "OTP",
    "retryLabel":  "Retry"
}
```

### pdfPreview

Description: Renders a PDF preview (typically from registry/base64 content) inside STAC-driven screens.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | PdfPreviewParser |
| source | String | lib/core/stac/parsers/widgets/pdf_preview_parser.dart |

#### JSON

```json
{
    "type":  "pdfPreview",
    "registryKey":  "serverSignedPdf",
    "height":  500
}
```

### promissory_real_loader

Description: Feature loader widget that boots the Promissory Real experience from server-driven flow data.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | PromissoryRealLoaderParser |
| source | String | lib/core/stac/parsers/widgets/promissory_real_loader_parser.dart |

#### JSON

```json
{
    "type":  "promissory_real_loader"
}
```

### reactiveElevatedButton

Description: Renders a registry-reactive button whose enabled/loading state and pressed action can depend on live STAC values.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | ReactiveElevatedButtonParser |
| source | String | lib/core/stac/parsers/widgets/reactive_elevated_button_parser.dart |

#### JSON

```json
{
    "type":  "reactiveElevatedButton",
    "enabledKey":  "form.canContinue",
    "child":  {
                  "type":  "text",
                  "data":  "Continue"
              }
}
```

### reactiveListView

Description: Builds list items from registry-backed data and updates automatically when the underlying data changes.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | ReactiveListViewParser |
| source | String | lib/core/stac/parsers/widgets/reactive_list_view_parser.dart |

#### JSON

```json
{
    "type":  "reactiveListView",
    "dataKey":  "deposits.rawData",
    "dataPath":  "data",
    "itemIdField":  "depositNumber"
}
```

### reactiveSwitch

Description: Renders a switch bound to registry state so toggles can both read and write server-driven values.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | ReactiveSwitchParser |
| source | String | lib/core/stac/parsers/widgets/reactive_switch_parser.dart |

#### JSON

```json
{
    "type":  "reactiveSwitch",
    "valueKey":  "settings.enabled",
    "initialValue":  false
}
```

### receiptRepaintBoundary

Description: Wraps receipt UI with a registered repaint boundary key so receipts can be captured/shared later.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | ReceiptRepaintBoundaryParser |
| source | String | lib/core/stac/parsers/widgets/receipt_repaint_boundary_parser.dart |

#### JSON

```json
{
    "type":  "receiptRepaintBoundary",
    "boundaryKey":  "chargeRealReceiptContent"
}
```

### registryReactive

Description: Rebuilds its child whenever watched registry values change.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | RegistryReactiveWidgetParser |
| source | String | lib/core/stac/parsers/widgets/registry_reactive_widget_parser.dart |

#### JSON

```json
{
    "type":  "registryReactive",
    "child":  {
                  "type":  "text",
                  "data":  "{{form.amount}}"
              }
}
```

### signaturePad

Description: Captures handwritten signatures and stores signature data/state keys for downstream actions.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | SignaturePadParser |
| source | String | lib/core/stac/parsers/widgets/signature_pad_parser.dart |

#### JSON

```json
{
    "type":  "signaturePad",
    "valueKey":  "verifyIdentitySignatureImage",
    "hasSignatureKey":  "verifyIdentityHasSignature"
}
```

### stateful

Description: Provides lifecycle-aware STAC rendering with hooks such as mount/resume/pause and related actions.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | StatefulWidgetParser |
| source | String | lib/core/stac/parsers/widgets/stateful_widget_parser.dart |

#### JSON

```json
{
    "type":  "stateful",
    "child":  {
                  "type":  "scaffold"
              }
}
```

### stateFull

Description: Alias for the stateful lifecycle widget contract (kept for compatibility with existing JSON).


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | StateFullWidgetParser |
| source | String | lib/core/stac/parsers/widgets/stateful_widget_parser.dart |

#### JSON

```json
{
    "type":  "stateFull",
    "child":  {
                  "type":  "scaffold"
              }
}
```

### timedSplash

Description: Shows splash content for a duration and then triggers follow-up navigation/action automatically.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | TimedSplashParser |
| source | String | lib/core/stac/parsers/widgets/timed_splash_parser.dart |

#### JSON

```json
{
    "type":  "timedSplash",
    "duration":  1500,
    "action":  {
                   "actionType":  "navigate",
                   "routeName":  "login"
               }
}
```

### tobankBannerCarousel

Description: Displays Tobank marketing/feature banners as a carousel with paging behavior.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | TobankBannerCarouselParser |
| source | String | lib/core/stac/parsers/widgets/tobank_banner_carousel_parser.dart |

#### JSON

```json
{
    "type":  "tobankBannerCarousel",
    "imageUrls":  [
                      "https://example.com/banner.jpg"
                  ],
    "height":  106
}
```

### tobankCardManagementSlider

Description: Displays a card-management focused slider used in dashboard/card operations.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | TobankCardManagementSliderParser |
| source | String | lib/core/stac/parsers/widgets/tobank_card_management_slider_parser.dart |

#### JSON

```json
{
    "type":  "tobankCardManagementSlider",
    "height":  240
}
```

### tobankCardsCarousel

Description: Displays multiple card views in a swipeable carousel for account/card browsing.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | TobankCardsCarouselParser |
| source | String | lib/core/stac/parsers/widgets/tobank_cards_carousel_parser.dart |

#### JSON

```json
{
    "type": "tobankCardsCarousel",
    "pages": [...],
    "height": 268
}
```

### tobankCardsStackScroller

Description: Displays stacked cards with scrolling/overlap presentation used by dashboard card stacks.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | TobankCardsStackScrollerParser |
| source | String | lib/core/stac/parsers/widgets/tobank_cards_stack_scroller_parser.dart |

#### JSON

```json
{
    "type": "tobankCardsStackScroller",
    "cards": [...],
    "itemHeight": 125
}
```

### tobankMegaGashtWebView

Description: Renders the MegaGasht embedded web view experience inside STAC flow screens.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | TobankMegaGashtWebViewParser |
| source | String | lib/core/stac/parsers/widgets/tobank_mega_gasht_webview_parser.dart |

#### JSON

```json
{
    "type":  "tobankMegaGashtWebView",
    "url":  "https://example.com"
}
```

### tobankAcceptorWebView

Description: Renders the Acceptor embedded web view experience inside STAC flow screens.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | TobankAcceptorWebViewParser |
| source | String | lib/core/stac/parsers/widgets/tobank_acceptor_webview_parser.dart |

#### JSON

```json
{
    "type":  "tobankAcceptorWebView",
    "url":  "https://example.com"
}
```

### tobank_onboarding_slider

Description: Shows Tobank onboarding slides/pages with controlled paging and visual progression.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | TobankOnboardingSliderParser |
| source | String | lib/core/stac/parsers/widgets/tobank_onboarding_slider_parser.dart |

#### JSON

```json
{
    "type":  "tobank_onboarding_slider",
    "pages":  [
                  {
                      "title":  "Intro",
                      "description":  "...",
                      "image":  "..."
                  }
              ]
}
```

### verify_identity_real_loader

Description: Feature loader widget that boots the Verify Identity Real experience from flow data.


| Property | Type | Description |
| --- | --- | --- |
| type | String | Contract key used in JSON. |
| parser | String | VerifyIdentityRealLoaderParser |
| source | String | lib/core/stac/parsers/widgets/verify_identity_real_loader_parser.dart |

#### JSON

```json
{
    "type":  "verify_identity_real_loader"
}
```

## Custom Actions

### addGiftCardAmountCard

Description: Adds an additional gift-card amount card block and updates related visibility/count keys.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | AddGiftCardAmountCardActionParser |
| source | String | lib/core/stac/parsers/actions/add_gift_card_amount_card_action_parser.dart |

#### JSON

```json
{
    "actionType":  "addGiftCardAmountCard",
    "secondCardVisibleKey":  "gift.show2",
    "thirdCardVisibleKey":  "gift.show3"
}
```

### amountToWords

Description: Converts a numeric amount into words and stores the verbalized value in registry.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | AmountToWordsActionParser |
| source | String | lib/core/stac/parsers/actions/amount_to_words_action_parser.dart |

#### JSON

```json
{
    "actionType":  "amountToWords",
    "sourceKey":  "form.amountRaw",
    "destinationKey":  "form.amountWords",
    "suffix":  "Toman"
}
```

### auth_persist

Description: Persists authentication/token data to local auth storage and syncs related runtime state.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | AuthPersistActionParser |
| source | String | lib/core/stac/parsers/actions/auth_persist_action_parser.dart |

#### JSON

```json
{
    "actionType":  "auth_persist"
}
```

### biometricDebug

Description: Runs biometric diagnostic operations (availability, registration, auth, passkey checks) for QA/debug flows.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | BiometricDebugActionParser |
| source | String | lib/core/stac/parsers/actions/biometric_debug_action_parser.dart |

#### Enum Values

- `operation`: `checkAvailability`, `checkRegistration`, `checkPasskeyRegistration`, `authenticate`, `createCredential`, `registerPasskey`, `clearCredential`, `logProbe`

#### JSON

```json
{
    "actionType":  "biometricDebug",
    "operation":  "status"
}
```

### biometricRegister

Description: Triggers biometric/passkey registration flow and stores related success/failure state.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | BiometricRegisterActionParser |
| source | String | lib/core/stac/parsers/actions/biometric_register_action_parser.dart |

#### JSON

```json
{
    "actionType":  "biometricRegister"
}
```

### calculateSum

Description: Calculates numeric sums from configured fields and writes the result to a target key.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | CalculateSumActionParser |
| source | String | lib/core/stac/parsers/actions/calculate_sum_action_parser.dart |

#### JSON

```json
{
    "actionType":  "calculateSum",
    "fields":  [
                   "a",
                   "b"
               ],
    "resultKey":  "sum"
}
```

### closeDialog

Description: Closes the current dialog/sheet context.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | CloseDialogActionParser |
| source | String | lib/core/stac/parsers/actions/close_dialog_action_parser.dart |

#### JSON

```json
{
    "actionType":  "closeDialog"
}
```

### navigate

Description: Performs navigation using STAC navigation styles and supports route, widgetType, assetPath, or request-driven destinations.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | CustomNavigateActionParser |
| source | String | lib/core/stac/parsers/actions/custom_navigate_action_parser.dart |

#### Enum Values

- `navigationStyle`: `push`, `pop`, `pushReplacement`, `pushAndRemoveAll`, `popAll`, `pushNamed`, `pushNamedAndRemoveAll`, `pushReplacementNamed`

#### JSON

```json
{
    "actionType":  "navigate",
    "navigationStyle":  "push",
    "assetPath":  "lib/stac/tobank/flows/login_flow_linear/json/login_flow_linear_login.json"
}
```

### networkRequest

Description: Executes a network request and stores/propagates response data for later JSON/template resolution.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | CustomNetworkRequestActionParser |
| source | String | lib/core/stac/parsers/actions/custom_network_request_action_parser.dart |

#### JSON

```json
{
    "actionType":  "networkRequest",
    "url":  "https://api.example.com",
    "method":  "get"
}
```

### setValue

Description: Writes values into the STAC registry with custom resolution logic (including nested/getFormValue handling).


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | CustomSetValueActionParser |
| source | String | lib/core/stac/parsers/actions/custom_set_value_action_parser.dart |

#### JSON

```json
{
    "actionType":  "setValue",
    "values":  [
                   {
                       "key":  "form.phone",
                       "value":  "09123456789"
                   }
               ]
}
```

### exampleAction

Description: Sample/demo action parser used as a reference for building and registering custom actions.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ExampleActionParser |
| source | String | lib/core/stac/parsers/actions/example_action_parser.dart |

#### JSON

```json
{
    "actionType":  "exampleAction",
    "message":  "Hello"
}
```

### pickFile

Description: Picks files/images/videos, optionally previews/crops them, then stores result metadata/content in registry keys.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | FilePickerActionParser |
| source | String | lib/core/stac/parsers/actions/file_picker_action_parser.dart |

#### Enum Values

- `fileType`: `image`, `video`, `audio`, `media`, `custom`, `any`
- `source`: `camera`, `gallery`
- `cameraDevice`: `front`, `rear`

#### JSON

```json
{
    "actionType":  "pickFile",
    "fileType":  "image",
    "targetKey":  "photo.path",
    "source":  "camera"
}
```

### filterTransferIbanList

Description: Filters transfer IBAN options and updates visibility/output keys for transfer selection UI.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | FilterTransferIbanListActionParser |
| source | String | lib/core/stac/parsers/actions/filter_transfer_iban_list_action_parser.dart |

#### JSON

```json
{
    "actionType":  "filterTransferIbanList",
    "fieldId":  "transferApiIbanInput",
    "ibanValues":  [
                       "IR..."
                   ],
    "visibleKeys":  [
                        "transferApiIbanVisible1"
                    ]
}
```

### fingerPrint

Description: Runs fingerprint authentication flow and reports result through configured state/actions.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | FingerPrintActionParser |
| source | String | lib/core/stac/parsers/actions/finger_print_action_parser.dart |

#### JSON

```json
{
    "actionType":  "fingerPrint",
    "title":  "Biometric check"
}
```

### flowNext

Description: Advances the current flow step and supports fallback behavior when no next step is available.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | FlowNextActionParser |
| source | String | lib/core/stac/parsers/actions/flow_next_action_parser.dart |

#### JSON

```json
{
    "actionType":  "flowNext",
    "fallback":  {
                     "actionType":  "navigate",
                     "navigationStyle":  "popAll"
                 }
}
```

### formatDate

Description: Formats date/time values from one key and stores the formatted output in another key.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | FormatDateActionParser |
| source | String | lib/core/stac/parsers/actions/format_date_action_parser.dart |

#### JSON

```json
{
    "actionType":  "formatDate",
    "sourceKey":  "rawTransactionTime",
    "destinationKey":  "transactionTime"
}
```

### formatNumber

Description: Formats numeric values (e.g., separators/presentation format) and writes the formatted result.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | FormatNumberActionParser |
| source | String | lib/core/stac/parsers/actions/format_number_action_parser.dart |

#### JSON

```json
{
    "actionType":  "formatNumber",
    "sourceKey":  "form.amount",
    "destinationKey":  "form.amountFormatted"
}
```

### hideSnackBar

Description: Hides the currently displayed snackbar/notification.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | HideSnackBarActionParser |
| source | String | lib/core/stac/parsers/actions/hide_snackbar_action_parser.dart |

#### JSON

```json
{
    "actionType":  "hideSnackBar"
}
```

### launchUrl

Description: Launches URLs using selected launch modes (in-app webview or external app/browser).


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | LaunchUrlActionParser |
| source | String | lib/core/stac/parsers/actions/launch_url_action_parser.dart |

#### Enum Values

- `mode`: `platformDefault`, `inAppWebView`, `externalApplication`, `externalNonBrowserApplication`

#### JSON

```json
{
    "actionType":  "launchUrl",
    "url":  "https://example.com",
    "mode":  "inAppWebView"
}
```

### log

Description: Logs resolved messages to app logging with configurable severity level.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | LogActionParser |
| source | String | lib/core/stac/parsers/actions/log_action_parser.dart |

#### Enum Values

- `level`: `debug`, `warning`, `warn`, `error`, `info`

#### JSON

```json
{
    "actionType":  "log",
    "message":  "screen mounted"
}
```

### persianDatePicker

Description: Opens a Persian/Jalali date picker and writes selected date values to configured targets.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | PersianDatePickerActionParser |
| source | String | lib/core/stac/parsers/actions/persian_date_picker_action_parser.dart |

#### JSON

```json
{
    "actionType":  "persianDatePicker",
    "formFieldId":  "birthdate",
    "firstDate":  "1350/01/01",
    "lastDate":  "1450/12/29"
}
```

### pickContactPhone

Description: Opens contact picker and maps selected phone data into target form/registry keys.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | PickContactPhoneActionParser |
| source | String | lib/core/stac/parsers/actions/pick_contact_phone_action_parser.dart |

#### JSON

```json
{
    "actionType":  "pickContactPhone",
    "formFieldId":  "phone",
    "targetKey":  "form.phone"
}
```

### playAudioUrl

Description: Starts audio playback from a URL (with optional stop-previous behavior).


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | PlayAudioUrlActionParser |
| source | String | lib/core/stac/parsers/actions/play_audio_url_action_parser.dart |

#### JSON

```json
{
    "actionType":  "playAudioUrl",
    "url":  "https://example.com/a.mp3",
    "stopPrevious":  true
}
```

### stopAudioUrl

Description: Stops active audio playback started by playAudioUrl.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | StopAudioUrlActionParser |
| source | String | lib/core/stac/parsers/actions/play_audio_url_action_parser.dart |

#### JSON

```json
{
    "actionType":  "stopAudioUrl"
}
```

### promissorySign

Description: Signs promissory PDF/document data at configured location and stores signed output.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | PromissorySignActionParser |
| source | String | lib/core/stac/parsers/actions/promissory_sign_action_parser.dart |

#### JSON

```json
{
    "actionType":  "promissorySign",
    "unsignedContract":  "{{form.pdf}}",
    "signLocation":  {
                         "x":  450,
                         "y":  450,
                         "width":  150,
                         "height":  50
                     }
}
```

### removeGiftCardAmountCard

Description: Removes a gift-card amount card block and updates visibility/count keys accordingly.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | RemoveGiftCardAmountCardActionParser |
| source | String | lib/core/stac/parsers/actions/remove_gift_card_amount_card_action_parser.dart |

#### JSON

```json
{
    "actionType":  "removeGiftCardAmountCard",
    "cardIndex":  2,
    "secondCardVisibleKey":  "gift.show2",
    "thirdCardVisibleKey":  "gift.show3"
}
```

### saveFile

Description: Saves file content (path/base64/registry value) to local device storage.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | SaveFileActionParser |
| source | String | lib/core/stac/parsers/actions/save_file_action_parser.dart |

#### JSON

```json
{
    "actionType":  "saveFile",
    "fileName":  "promissory_preview.pdf",
    "registryKey":  "serverSignedPdf",
    "isBase64":  true
}
```

### sequence

Description: Executes a list of actions sequentially in order.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | SequenceActionParser |
| source | String | lib/core/stac/parsers/actions/sequence_action_parser.dart |

#### JSON

```json
{
    "actionType":  "sequence",
    "actions":  [
                    {
                        "actionType":  "log",
                        "message":  "a"
                    },
                    {
                        "actionType":  "log",
                        "message":  "b"
                    }
                ]
}
```

### setTransferDestinationFromIban

Description: Derives and sets transfer destination information based on selected IBAN value.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | SetTransferDestinationFromIbanActionParser |
| source | String | lib/core/stac/parsers/actions/set_transfer_destination_from_iban_action_parser.dart |

#### JSON

```json
{
    "actionType":  "setTransferDestinationFromIban",
    "fieldId":  "transferApiIbanInput",
    "destinationNameKey":  "transferApiDestinationName"
}
```

### setTransferDetailsContinueEnabled

Description: Computes transfer-details continue state and updates its enable/disable key.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | SetTransferDetailsContinueEnabledActionParser |
| source | String | lib/core/stac/parsers/actions/set_transfer_details_continue_enabled_action_parser.dart |

#### JSON

```json
{
    "actionType":  "setTransferDetailsContinueEnabled",
    "amountRawKey":  "transferApiAmountRaw",
    "continueEnabledKey":  "transferApiDetailsContinueEnabled"
}
```

### setTransferInBankContinueEnabled

Description: Computes in-bank transfer continue state and updates its enable/disable key.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | SetTransferInBankContinueEnabledActionParser |
| source | String | lib/core/stac/parsers/actions/set_transfer_in_bank_continue_enabled_action_parser.dart |

#### JSON

```json
{
    "actionType":  "setTransferInBankContinueEnabled",
    "fieldId":  "transferApiInBankAccountInput",
    "continueEnabledKey":  "transferApiContinueEnabled"
}
```

### shareFile

Description: Shares a file/document through platform share sheet using provided content metadata.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShareFileActionParser |
| source | String | lib/core/stac/parsers/actions/share_file_action_parser.dart |

#### JSON

```json
{
    "actionType":  "shareFile",
    "fileName":  "promissory.pdf",
    "registryKey":  "serverSignedPdf",
    "mimeType":  "application/pdf"
}
```

### showAddDestinationCardBottomSheet

Description: Opens the destination-card picker/adder bottom sheet for transfer flows.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowAddDestinationCardBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_add_destination_card_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showAddDestinationCardBottomSheet"
}
```

### showBankAddressBottomSheet

Description: Opens bank-address bottom sheet UI and handles address selection/edit result.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowBankAddressBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_bank_address_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showBankAddressBottomSheet",
    "title":  "Bank address"
}
```

### showBottomSheet

Description: Opens a generic STAC bottom sheet from provided sheet/widget JSON.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showBottomSheet",
    "sheet":  {
                  "type":  "container",
                  "child":  {
                                "type":  "text",
                                "data":  "Sheet"
                            }
              }
}
```

### showMobileBankServicesBottomSheet

Description: Opens mobile-bank services bottom sheet for service selection and navigation.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowMobileBankServicesBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showMobileBankServicesBottomSheet"
}
```

### showCardExpireSelectBottomSheet

Description: Opens month/year selector bottom sheet for card expiry input fields.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowCardExpireSelectBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_card_expire_select_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showCardExpireSelectBottomSheet",
    "formFieldId":  "transferApiCardExpireInput",
    "confirmText":  "OK"
}
```

### showDeleteAccountConfirmBottomSheet

Description: Opens delete-account confirmation bottom sheet and handles decision actions.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowDeleteAccountConfirmBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_delete_account_confirm_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showDeleteAccountConfirmBottomSheet",
    "title":  "Delete account"
}
```

### showGiftCardAmountGuideBottomSheet

Description: Opens gift-card amount guide bottom sheet with min/max and helper content.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowGiftCardAmountGuideBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_gift_card_amount_guide_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showGiftCardAmountGuideBottomSheet",
    "minAmount":  1000000,
    "maxAmount":  50000000
}
```

### showGiftCardDesignTypeBottomSheet

Description: Opens design-type selector bottom sheet for gift-card customization.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowGiftCardDesignTypeBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_gift_card_design_type_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showGiftCardDesignTypeBottomSheet",
    "title":  "Design type"
}
```

### showGiftCardLocationSelectorBottomSheet

Description: Opens location selector (province/city) bottom sheet for gift-card receiver data.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowGiftCardLocationSelectorBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_gift_card_location_selector_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showGiftCardLocationSelectorBottomSheet",
    "title":  "Province",
    "selectedKey":  "giftCardRealReceiverProvince"
}
```

### showGiftCardMessageGuideBottomSheet

Description: Opens message guide/help bottom sheet for gift-card text entry.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowGiftCardMessageGuideBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_gift_card_message_guide_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showGiftCardMessageGuideBottomSheet",
    "title":  "Guide"
}
```

### showGiftCardPaymentAccountsBottomSheet

Description: Opens payment-account selector bottom sheet for gift-card purchase payment source.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowGiftCardPaymentAccountsBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_gift_card_payment_accounts_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showGiftCardPaymentAccountsBottomSheet",
    "title":  "Gift card",
    "paymentAmountKey":  "giftCardRealSummaryPaymentAmount"
}
```

### showGiftCardPlanSelectorBottomSheet

Description: Opens gift-card plan selector bottom sheet and writes selected plan keys.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowGiftCardPlanSelectorBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_gift_card_plan_selector_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showGiftCardPlanSelectorBottomSheet",
    "title":  "Plan selector",
    "selectedPlanIdKey":  "giftCardRealSelectedPlanId"
}
```

### showGiftCardPurchaseBottomSheet

Description: Opens gift-card purchase summary/confirmation bottom sheet.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowGiftCardPurchaseBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_gift_card_purchase_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showGiftCardPurchaseBottomSheet",
    "title":  "Purchase gift card"
}
```

### showGiftCardSelectAmountBottomSheet

Description: Opens amount selector bottom sheet for gift-card amount choice.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowGiftCardSelectAmountBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_gift_card_select_amount_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showGiftCardSelectAmountBottomSheet",
    "title":  "Select amount",
    "amountValueKey":  "giftCardRealAmountValue1"
}
```

### showGiftCardSelectDateBottomSheet

Description: Opens date selector bottom sheet for scheduling/sending gift-card operations.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowGiftCardSelectDateBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_gift_card_select_date_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showGiftCardSelectDateBottomSheet",
    "title":  "Select date",
    "dateOptions":  [
                        "1405/02/03"
                    ]
}
```

### showGuideOptionsBottomSheet

Description: Opens a guide/options bottom sheet and handles selected option actions.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowGuideOptionsBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_guide_options_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showGuideOptionsBottomSheet",
    "title":  "Guide",
    "options":  [
                    {
                        "title":  "A"
                    }
                ]
}
```

### showJobSelectorBottomSheet

Description: Opens job selector bottom sheet with searchable option list and selection output.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowJobSelectorBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_job_selector_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showJobSelectorBottomSheet",
    "heightFactor":  0.75
}
```

### showLogoutConfirmDialog

Description: Opens logout confirmation dialog and executes selected branch actions.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowLogoutConfirmDialogActionParser |
| source | String | lib/core/stac/parsers/actions/show_logout_confirm_dialog_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showLogoutConfirmDialog",
    "title":  "Logout"
}
```

### showPhotoTipsBottomSheet

Description: Opens photo tips/guide bottom sheet before capture/upload actions.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowPhotoTipsBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_photo_tips_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showPhotoTipsBottomSheet",
    "title":  "Photo tips",
    "tips":  [
                 "Clear image"
             ]
}
```

### showRulesBottomSheet

Description: Opens rules bottom sheet; routeName maps to predefined rules sections.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowRulesBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_rules_bottom_sheet_action_parser.dart |

#### Enum Values

- `routeName`: `verify_identity_real_rules`

#### JSON

```json
{
    "actionType":  "showRulesBottomSheet",
    "routeName":  "verify_identity_real_rules",
    "title":  "Rules"
}
```

### showSnackBar

Description: Shows a snackbar/notification message in the current context.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowSnackBarActionParser |
| source | String | lib/core/stac/parsers/actions/show_snackbar_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showSnackBar",
    "message":  "Saved"
}
```

### customSnackBar

Description: Shows snackbar via built-in custom snackbar variant used for compatibility paths.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | BuiltInShowSnackBarActionParser |
| source | String | lib/core/stac/parsers/actions/show_snackbar_action_parser.dart |

#### JSON

```json
{
    "actionType":  "customSnackBar",
    "message":  "Saved"
}
```

### showThemeSelectorBottomSheet

Description: Opens theme selector bottom sheet (light/dark/system) and updates theme choice.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowThemeSelectorBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_theme_selector_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showThemeSelectorBottomSheet",
    "title":  "Theme",
    "lightLabel":  "Light",
    "darkLabel":  "Dark",
    "systemLabel":  "System"
}
```

### showTransferCardConfirmDialog

Description: Opens transfer-card confirmation dialog before executing transfer submission.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowTransferCardConfirmDialogActionParser |
| source | String | lib/core/stac/parsers/actions/show_transfer_card_confirm_dialog_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showTransferCardConfirmDialog",
    "destinationCardKey":  "transferApiCardDestinationNumber",
    "amountKey":  "transferApiCardAmountRaw"
}
```

### showTransferCardScanner

Description: Opens card scanner flow and writes scanned card info to target fields.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowTransferCardScannerActionParser |
| source | String | lib/core/stac/parsers/actions/show_transfer_card_scanner_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showTransferCardScanner",
    "fieldId":  "transferApiCardInput"
}
```

### showTransferInBankTypeBottomSheet

Description: Opens in-bank transfer-type selector bottom sheet.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowTransferInBankTypeBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_transfer_in_bank_type_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showTransferInBankTypeBottomSheet",
    "selectedTypeKey":  "transferApiTransferTypeTitle"
}
```

### showTransferPurposeBottomSheet

Description: Opens transfer-purpose selector bottom sheet and stores selected reason.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowTransferPurposeBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_transfer_purpose_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showTransferPurposeBottomSheet",
    "selectedValueKey":  "transferApiReasonTitle",
    "hasValueKey":  "transferApiHasReason"
}
```

### showTransferTypeBottomSheet

Description: Opens transfer-type selector bottom sheet for destination/method selection.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ShowTransferTypeBottomSheetActionParser |
| source | String | lib/core/stac/parsers/actions/show_transfer_type_bottom_sheet_action_parser.dart |

#### JSON

```json
{
    "actionType":  "showTransferTypeBottomSheet",
    "selectedTypeKey":  "transferApiTransferTypeTitle"
}
```

### toggleTheme

Description: Toggles app theme mode and propagates the updated theme state.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ThemeToggleActionParser |
| source | String | lib/core/stac/parsers/actions/theme_toggle_action_parser.dart |

#### JSON

```json
{
    "actionType":  "toggleTheme"
}
```

### transferReceipt

Description: Handles transfer receipt output actions (share text/image/file and capture boundary operations).


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | TransferReceiptActionParser |
| source | String | lib/core/stac/parsers/actions/transfer_receipt_action_parser.dart |

#### JSON

```json
{
    "actionType":  "transferReceipt",
    "mode":  "shareText",
    "boundaryKey":  "chargeRealReceiptContent"
}
```

### tobankMegaGashtBack

Description: Performs back navigation behavior for the MegaGasht embedded webview flow.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | TobankMegaGashtBackActionParser |
| source | String | lib/core/stac/parsers/widgets/tobank_mega_gasht_webview_parser.dart |

#### JSON

```json
{
    "actionType":  "tobankMegaGashtBack"
}
```

### tobankAcceptorBack

Description: Performs back navigation behavior for the Acceptor embedded webview flow.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | TobankAcceptorBackActionParser |
| source | String | lib/core/stac/parsers/widgets/tobank_acceptor_webview_parser.dart |

#### JSON

```json
{
    "actionType":  "tobankAcceptorBack"
}
```

### updateGiftCardAmountCount

Description: Updates gift-card amount-card count state using configured increment/decrement rules.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | UpdateGiftCardAmountCountActionParser |
| source | String | lib/core/stac/parsers/actions/update_gift_card_amount_count_action_parser.dart |

#### JSON

```json
{
    "actionType":  "updateGiftCardAmountCount",
    "countKey":  "giftCardRealCardCount1",
    "delta":  1
}
```

### validateFields

Description: Runs form validation rules and writes validation/continue state keys for downstream actions.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ValidateFieldsActionParser |
| source | String | lib/core/stac/parsers/actions/validate_fields_action_parser.dart |

#### JSON

```json
{
    "actionType":  "validateFields",
    "resultKey":  "crAddCanContinue",
    "fields":  [
                   {
                       "id":  "crAddPhone",
                       "rule":  "mobile"
                   }
               ]
}
```

### validateTransferCardContinue

Description: Validates transfer card input constraints and updates continue-enabled state.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | ValidateTransferCardContinueActionParser |
| source | String | lib/core/stac/parsers/actions/validate_transfer_card_continue_action_parser.dart |

#### JSON

```json
{
    "actionType":  "validateTransferCardContinue",
    "fieldId":  "transferApiCardInput",
    "requiredLength":  16
}
```

## Feature-Local Custom Actions

### loginAction

Description: Feature-local test action used by the STAC test app login flow.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | StacLoginActionParser |
| source | String | lib/features/stac_test_app/presentation/actions/stac_login_action_parser.dart |

#### JSON

```json
{
    "actionType":  "loginAction"
}
```

### promissory_real_login

Description: Feature-local login action used by Promissory Real service flow.


| Property | Type | Description |
| --- | --- | --- |
| actionType | String | Contract key used in JSON. |
| parser | String | PromissoryLoginActionParser |
| source | String | lib/stac/tobank/flows/promissory_real/service/promissory_login_action_parser.dart |

#### JSON

```json
{
    "actionType":  "promissory_real_login"
}
```

## Additional Custom JSON Models

### FlowStep

Description: Defines one step inside a flow configuration, including navigation/widget metadata and enablement.


#### JSON

```json
{
    "id":  "login",
    "title":  "Login",
    "widgetType":  "login",
    "jsonPath":  "lib/stac/tobank/login/api/GET_tobank_login.json",
    "apiPath":  "login/tobank_login",
    "enabled":  true
}
```

### FlowConfig

Description: Defines the full flow configuration, including ordered steps and flow-level metadata.


#### JSON

```json
{
    "flowId":  "login_flow",
    "title":  "Login flow",
    "steps":  [
                  {
                      "id":  "login",
                      "widgetType":  "login",
                      "jsonPath":  "lib/stac/tobank/login/api/GET_tobank_login.json"
                  }
              ]
}
```


