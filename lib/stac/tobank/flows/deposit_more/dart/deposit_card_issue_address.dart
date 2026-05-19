import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'deposit_card_issue_address')
StacWidget depositCardIssueAddress() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'depositCardIssue.postalCode', 'value': ''},
        {'key': 'depositCardIssue.hasPostalCodeInput', 'value': false},
        {'key': 'depositCardIssue.isPostalCodeComplete', 'value': false},
        {'key': 'depositCardIssue.hasAddressData', 'value': false},
        {'key': 'depositCardIssue.province', 'value': ''},
        {'key': 'depositCardIssue.city', 'value': ''},
        {'key': 'depositCardIssue.county', 'value': ''},
        {'key': 'depositCardIssue.mainStreet', 'value': ''},
        {'key': 'depositCardIssue.subStreet', 'value': ''},
        {'key': 'depositCardIssue.plaque', 'value': ''},
        {'key': 'depositCardIssue.unit', 'value': ''},
        {'key': 'depositCardIssue.hasCountyInput', 'value': false},
        {'key': 'depositCardIssue.hasMainStreetInput', 'value': false},
        {'key': 'depositCardIssue.hasSubStreetInput', 'value': false},
        {'key': 'depositCardIssue.hasPlaqueInput', 'value': false},
        {'key': 'depositCardIssue.hasUnitInput', 'value': false},
        {'key': 'depositCardIssue.isAddressFormComplete', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title: 'آدرس دریافت کارت بانکی',
        showSupport: true,
      ),
      body: StacForm(
        child: StacSingleChildScrollView(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              _addressLabel('کد پستی محل سکونت'),
              StacSizedBox(height: 10),
              _postalCodeRow(),
              StacSizedBox(height: 20),
              StacCustomVisibility(
                visible: '[[depositCardIssue.hasAddressData]]',
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    _addressLabel('استان'),
                    StacSizedBox(height: 8),
                    _addressField(
                      valueKey: 'depositCardIssue.province',
                      showClear: false,
                    ),
                    StacSizedBox(height: 14),
                    _addressLabel('شهر'),
                    StacSizedBox(height: 8),
                    _addressField(
                      valueKey: 'depositCardIssue.city',
                      showClear: false,
                    ),
                    StacSizedBox(height: 14),
                    _addressLabel('شهرستان'),
                    StacSizedBox(height: 8),
                    _editableAddressField(
                      id: 'deposit_card_issue_county',
                      valueKey: 'depositCardIssue.county',
                      inputFlagKey: 'depositCardIssue.hasCountyInput',
                      hintText: 'مقدار شهرستان را وارد نمایید',
                    ),
                    StacSizedBox(height: 14),
                    _addressLabel('خیابان اصلی'),
                    StacSizedBox(height: 8),
                    _editableAddressField(
                      id: 'deposit_card_issue_main_street',
                      valueKey: 'depositCardIssue.mainStreet',
                      inputFlagKey: 'depositCardIssue.hasMainStreetInput',
                      hintText: 'خیابان اصلی خود را وارد نمایید',
                    ),
                    StacSizedBox(height: 14),
                    _addressLabel('خیابان فرعی'),
                    StacSizedBox(height: 8),
                    _editableAddressField(
                      id: 'deposit_card_issue_sub_street',
                      valueKey: 'depositCardIssue.subStreet',
                      inputFlagKey: 'depositCardIssue.hasSubStreetInput',
                      hintText: 'خیابان فرعی خود را وارد نمایید',
                    ),
                    StacSizedBox(height: 14),
                    _addressLabel('پلاک'),
                    StacSizedBox(height: 8),
                    _editableAddressField(
                      id: 'deposit_card_issue_plaque',
                      valueKey: 'depositCardIssue.plaque',
                      inputFlagKey: 'depositCardIssue.hasPlaqueInput',
                      hintText: 'پلاک خود را وارد نمایید',
                      keyboardType: 'number',
                    ),
                    StacSizedBox(height: 14),
                    _addressLabel('واحد'),
                    StacSizedBox(height: 8),
                    _editableAddressField(
                      id: 'deposit_card_issue_unit',
                      valueKey: 'depositCardIssue.unit',
                      inputFlagKey: 'depositCardIssue.hasUnitInput',
                      hintText: 'واحد خود را وارد نمایید',
                      keyboardType: 'number',
                    ),
                    StacSizedBox(height: 35),
                    StacRawJsonWidget({
                      'type': 'reactiveElevatedButton',
                      'enabledKey': 'depositCardIssue.isAddressFormComplete',
                      'enabled': true,
                      'style': StacButtonStyle(
                        backgroundColor: '{{appColors.current.primary.color}}',
                        foregroundColor: '{{appColors.current.primary.onPrimary}}',
                        elevation: 0,
                        padding: StacEdgeInsets.symmetric(vertical: 23),
                        shape: StacRoundedRectangleBorder(
                          borderRadius: StacBorderRadius.all(11),
                        ),
                      ).toJson(),
                      'disabledStyle': StacButtonStyle(
                        backgroundColor:
                            '{{appColors.current.background.surfaceContainerHigh}}',
                        foregroundColor: '{{appColors.current.text.subtitle}}',
                        elevation: 0,
                        padding: StacEdgeInsets.symmetric(vertical: 23),
                        shape: StacRoundedRectangleBorder(
                          borderRadius: StacBorderRadius.all(11),
                        ),
                      ).toJson(),
                      'child': StacText(
                        data: 'ادامه',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 18,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.primary.onPrimary}}',
                        ),
                      ).toJson(),
                      'onPressed': _continueAddressAction().toJson(),
                    }),
                  ],
                ).toJson(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

StacWidget _postalCodeRow() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacExpanded(
        child: StacCustomTextFormField(
          id: 'deposit_card_issue_postal_code',
          textDirection: 'rtl',
          textAlign: 'right',
          keyboardType: 'number',
          maxLength: 10,
          inputFormatters: const [
            {'type': 'allow', 'rule': '[0-9]'},
          ],
          onChanged: StacSequenceAction(
            actions: [
              StacCustomSetValueAction(
                key: 'depositCardIssue.postalCode',
                value: StacGetFormValueAction(id: 'deposit_card_issue_postal_code'),
              ),
              const StacValidateFieldsAction(
                resultKey: 'depositCardIssue.hasPostalCodeInput',
                fields: [
                  {'id': 'deposit_card_issue_postal_code'},
                ],
              ),
              const StacValidateFieldsAction(
                resultKey: 'depositCardIssue.isPostalCodeComplete',
                fields: [
                  {'id': 'deposit_card_issue_postal_code', 'rule': r'^\d{10}$'},
                ],
              ),
              const StacCustomSetValueAction(
                key: 'depositCardIssue.hasAddressData',
                value: false,
              ),
            ],
          ).toJson(),
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ).toJson(),
          decoration: {
            ...StacInputDecoration(
              hintText: 'کد پستی محل سکونت را وارد کنید',
              hintStyle: StacTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.hint}}',
              ),
              contentPadding: StacEdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
              prefixIcon: StacRawJsonWidget({
                'type': 'visibility',
                'visible': '[[depositCardIssue.hasPostalCodeInput]]',
                'child': StacGestureDetector(
                  onTap: const StacCustomSetValueAction(
                    values: [
                      {'key': 'deposit_card_issue_postal_code', 'value': ''},
                      {'key': 'depositCardIssue.postalCode', 'value': ''},
                      {'key': 'depositCardIssue.hasPostalCodeInput', 'value': false},
                      {'key': 'depositCardIssue.isPostalCodeComplete', 'value': false},
                      {'key': 'depositCardIssue.hasAddressData', 'value': false},
                      {'key': 'depositCardIssue.province', 'value': ''},
                      {'key': 'depositCardIssue.city', 'value': ''},
                      {'key': 'depositCardIssue.county', 'value': ''},
                      {'key': 'depositCardIssue.mainStreet', 'value': ''},
                      {'key': 'depositCardIssue.subStreet', 'value': ''},
                      {'key': 'depositCardIssue.plaque', 'value': ''},
                      {'key': 'depositCardIssue.unit', 'value': ''},
                      {'key': 'depositCardIssue.hasCountyInput', 'value': false},
                      {'key': 'depositCardIssue.hasMainStreetInput', 'value': false},
                      {'key': 'depositCardIssue.hasSubStreetInput', 'value': false},
                      {'key': 'depositCardIssue.hasPlaqueInput', 'value': false},
                      {'key': 'depositCardIssue.hasUnitInput', 'value': false},
                      {'key': 'deposit_card_issue_county', 'value': ''},
                      {'key': 'deposit_card_issue_main_street', 'value': ''},
                      {'key': 'deposit_card_issue_sub_street', 'value': ''},
                      {'key': 'deposit_card_issue_plaque', 'value': ''},
                      {'key': 'deposit_card_issue_unit', 'value': ''},
                      {'key': 'depositCardIssue.isAddressFormComplete', 'value': false},
                    ],
                  ),
                  child: StacPadding(
                    padding: StacEdgeInsets.all(12),
                    child: StacIcon(
                      icon: StacIcons.close,
                      size: 20,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ).toJson(),
              }),
            ).toJson(),
            'counterText': '',
          },
        ),
      ),
      StacSizedBox(width: 10),
      StacRawJsonWidget({
        'type': 'reactiveElevatedButton',
        'enabledKey': 'depositCardIssue.isPostalCodeComplete',
        'enabled': true,
        'style': StacButtonStyle(
          backgroundColor: '{{appColors.current.primary.color}}',
          foregroundColor: '{{appColors.current.primary.onPrimary}}',
          elevation: 0,
          padding: StacEdgeInsets.symmetric(horizontal: 24, vertical: 21),
          shape: StacRoundedRectangleBorder(
            borderRadius: StacBorderRadius.all(10),
          ),
        ).toJson(),
        'disabledStyle': StacButtonStyle(
          backgroundColor: '{{appColors.current.background.surfaceContainerHigh}}',
          foregroundColor: '{{appColors.current.text.subtitle}}',
          elevation: 0,
          padding: StacEdgeInsets.symmetric(horizontal: 24, vertical: 21),
          shape: StacRoundedRectangleBorder(
            borderRadius: StacBorderRadius.all(10),
          ),
        ).toJson(),
        'child': StacText(
          data: 'استعلام',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.primary.onPrimary}}',
          ),
        ).toJson(),
        'onPressed': const StacCustomSetValueAction(
          values: [
            {'key': 'depositCardIssue.hasAddressData', 'value': true},
            {'key': 'depositCardIssue.province', 'value': 'تهران'},
            {'key': 'depositCardIssue.city', 'value': 'تهران'},
            {'key': 'depositCardIssue.county', 'value': 'تهران'},
            {'key': 'depositCardIssue.mainStreet', 'value': 'شهرک صدرا خیابان چهل و نهم'},
            {'key': 'depositCardIssue.subStreet', 'value': 'خیابان نصر پنجم'},
            {'key': 'depositCardIssue.plaque', 'value': ''},
            {'key': 'depositCardIssue.unit', 'value': ''},
            {'key': 'depositCardIssue.hasCountyInput', 'value': true},
            {'key': 'depositCardIssue.hasMainStreetInput', 'value': true},
            {'key': 'depositCardIssue.hasSubStreetInput', 'value': true},
            {'key': 'depositCardIssue.hasPlaqueInput', 'value': false},
            {'key': 'depositCardIssue.hasUnitInput', 'value': false},
            {'key': 'deposit_card_issue_county', 'value': 'تهران'},
            {'key': 'deposit_card_issue_main_street', 'value': 'شهرک صدرا خیابان چهل و نهم'},
            {'key': 'deposit_card_issue_sub_street', 'value': 'خیابان نصر پنجم'},
            {'key': 'deposit_card_issue_plaque', 'value': ''},
            {'key': 'deposit_card_issue_unit', 'value': ''},
            {'key': 'depositCardIssue.isAddressFormComplete', 'value': false},
          ],
        ).toJson(),
      }),
    ],
  );
}

StacWidget _addressLabel(String label) {
  return StacText(
    data: label,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacCustomTextStyle(
      fontSize: 20,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _addressField({
  required String valueKey,
  required bool showClear,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surface}}',
    ),
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacText(
              data: '{{$valueKey}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.hint}}',
              ),
            ),
          ),
          StacCustomVisibility(
            visible: showClear,
            child: StacPadding(
              padding: StacEdgeInsets.only(right: 8),
              child: StacIcon(
                icon: StacIcons.close,
                size: 20,
                color: '{{appColors.current.text.title}}',
              ),
            ).toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _editableAddressField({
  required String id,
  required String valueKey,
  required String inputFlagKey,
  required String hintText,
  String? keyboardType,
}) {
  return StacCustomTextFormField(
    id: id,
    textDirection: 'rtl',
    textAlign: 'right',
    initialValue: '{{$valueKey}}',
    keyboardType: keyboardType,
    onChanged: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          key: valueKey,
          value: StacGetFormValueAction(id: id),
        ),
        StacValidateFieldsAction(
          resultKey: inputFlagKey,
          fields: [
            {'id': id},
          ],
        ),
        _validateAddressFormAction(),
      ],
    ).toJson(),
    style: StacCustomTextStyle(
      fontSize: 18,
      fontWeight: StacFontWeight.w500,
      color: '{{appColors.current.text.title}}',
    ).toJson(),
    decoration: {
      ...StacInputDecoration(
        hintText: hintText,
        hintStyle: StacTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.hint}}',
        ),
        contentPadding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
        prefixIcon: StacRawJsonWidget({
          'type': 'visibility',
          'visible': '[[$inputFlagKey]]',
          'child': StacGestureDetector(
            onTap: StacSequenceAction(
              actions: [
                StacCustomSetValueAction(
                  values: [
                    {'key': id, 'value': ''},
                    {'key': valueKey, 'value': ''},
                    {'key': inputFlagKey, 'value': false},
                  ],
                ),
                _validateAddressFormAction(),
              ],
            ),
            child: StacPadding(
              padding: StacEdgeInsets.all(12),
              child: StacIcon(
                icon: StacIcons.close,
                size: 20,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ).toJson(),
        }),
      ).toJson(),
      'counterText': '',
    },
  );
}

StacAction _validateAddressFormAction() {
  return const StacValidateFieldsAction(
    resultKey: 'depositCardIssue.isAddressFormComplete',
    fields: [
      {'id': 'deposit_card_issue_county'},
      {'id': 'deposit_card_issue_main_street'},
      {'id': 'deposit_card_issue_sub_street'},
      {'id': 'deposit_card_issue_plaque'},
      {'id': 'deposit_card_issue_unit'},
    ],
  );
}

StacAction _continueAddressAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {
            'key': 'depositCardIssue.confirmAddressText',
            'value':
                'استان {{depositCardIssue.province}}، شهر {{depositCardIssue.city}}، شهرستان {{depositCardIssue.county}}، خیابان اصلی {{depositCardIssue.mainStreet}}، خیابان فرعی {{depositCardIssue.subStreet}}، پلاک {{depositCardIssue.plaque}}، واحد {{depositCardIssue.unit}}',
          },
          {'key': 'depositCardIssue.continuePressed', 'value': true},
        ],
      ),
      StacShowBottomSheetAction(
        isScrollControlled: true,
        useSafeArea: false,
        isDismissible: true,
        enableDrag: true,
        sheet: {
          'type': 'safeArea',
          'top': false,
          'bottom': false,
          'child': {
            'type': 'container',
            'decoration': {
              'color': '{{appColors.current.background.surface}}',
              'borderRadius': {
                'topLeft': 24,
                'topRight': 24,
              },
            },
            'child': {
              'type': 'padding',
              'padding': {'left': 16, 'top': 10, 'right': 16, 'bottom': 22},
              'child': {
                'type': 'column',
                'mainAxisSize': 'min',
                'crossAxisAlignment': 'stretch',
                'children': [
                  {
                    'type': 'center',
                    'child': {
                      'type': 'container',
                      'width': 44,
                      'height': 5,
                      'decoration': {
                        'color': '{{appColors.current.text.disabled}}',
                        'borderRadius': {'all': 999},
                      },
                    },
                  },
                  {'type': 'sizedBox', 'height': 26},
                  {
                    'type': 'text',
                    'data': 'این آدرس را برای دریافت کارت تایید می‌کنید؟',
                    'textDirection': 'rtl',
                    'textAlign': 'center',
                    'style': {
                      'fontSize': 20,
                      'fontWeight': 'w700',
                      'color': '{{appColors.current.text.title}}',
                    },
                  },
                  {'type': 'sizedBox', 'height': 22},
                  {
                    'type': 'text',
                    'data': '{{depositCardIssue.confirmAddressText}}',
                    'textDirection': 'rtl',
                    'textAlign': 'center',
                    'style': {
                      'fontSize': 16,
                      'fontWeight': 'w500',
                      'color': '{{appColors.current.text.title}}',
                      'height': 1.8,
                    },
                  },
                  {'type': 'sizedBox', 'height': 28},
                  {
                    'type': 'row',
                    'textDirection': 'rtl',
                    'children': [
                      {
                        'type': 'expanded',
                        'child': {
                          'type': 'filledButton',
                          'onPressed': {
                            'actionType': 'sequence',
                            'actions': [
                              {
                                'actionType': 'navigate',
                                'navigationStyle': 'pop',
                              },
                              {
                                'actionType': 'navigate',
                                'routeName': 'deposit_card_issue_template',
                                'navigationStyle': 'push',
                              },
                            ],
                          },
                          'style': {
                            'backgroundColor':
                                '{{appColors.current.primary.color}}',
                            'foregroundColor':
                                '{{appColors.current.primary.onPrimary}}',
                            'fixedSize': {'width': 999999, 'height': 50},
                            'elevation': 0,
                            'shape': {
                              'type': 'roundedRectangleBorder',
                              'borderRadius': {
                                'topLeft': 11,
                                'topRight': 11,
                                'bottomLeft': 11,
                                'bottomRight': 11,
                              },
                            },
                          },
                          'child': {
                            'type': 'text',
                            'data': 'تایید آدرس',
                            'textDirection': 'rtl',
                            'style': {
                              'fontSize': 18,
                              'fontWeight': 'w700',
                              'color': '{{appColors.current.primary.onPrimary}}',
                            },
                          },
                        },
                      },
                      {'type': 'sizedBox', 'width': 12},
                      {
                        'type': 'expanded',
                        'child': {
                          'type': 'outlinedButton',
                          'onPressed': {
                            'actionType': 'navigate',
                            'navigationStyle': 'pop',
                          },
                          'style': {
                            'fixedSize': {'width': 999999, 'height': 50},
                            'side': {
                              'color': '{{appColors.current.input.borderEnabled}}',
                              'width': 1,
                            },
                            'shape': {
                              'type': 'roundedRectangleBorder',
                              'borderRadius': {
                                'topLeft': 11,
                                'topRight': 11,
                                'bottomLeft': 11,
                                'bottomRight': 11,
                              },
                            },
                          },
                          'child': {
                            'type': 'text',
                            'data': 'اصلاح آدرس',
                            'textDirection': 'rtl',
                            'style': {
                              'fontSize': 18,
                              'fontWeight': 'w600',
                              'color': '{{appColors.current.text.title}}',
                            },
                          },
                        },
                      },
                    ],
                  },
                ],
              },
            },
          },
        },
      ),
    ],
  );
}
