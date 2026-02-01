import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart'
    hide StacPersianDatePickerAction;
import 'package:tobank_sdui/core/stac/parsers/actions/persian_date_picker_action_model.dart';

/// Promissory Flow - Receiver Information Page
///
/// This screen collects the receiver (ذینفع) information.
/// Supports both Individual (حقیقی) and Legal (حقوقی) receiver types.
///
/// Reference: docs/promissory_docs/request_promissory_receiver_page.dart
@StacScreen(screenName: 'promissory_receiver')
StacWidget promissoryReceiver() {
  return StacStatefulWidget(
    onInit: StacMultiAction(
      actions: [
        // Receiver type: true = Individual, false = Legal
        StacCustomSetValueAction(key: 'isIndividualSelected', value: true),
        StacCustomSetValueAction(key: 'isLegalSelected', value: false),
        StacCustomSetValueAction(key: 'isReceiverFormValid', value: false),
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: 'اطلاعات ذینفع',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
          icon: StacImage(
            src: 'assets/icons/ic_right_arrow.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      body: StacForm(
        autovalidateMode: StacAutovalidateMode.onUserInteraction,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.symmetric(horizontal: 16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacSizedBox(height: 16),
                    // Title
                    StacText(
                      data: 'اطلاعات ذینفع (دریافت‌کننده)',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 16),

                    // Receiver Type Selection Row
                    StacRow(
                      textDirection: StacTextDirection.rtl,
                      children: [
                        // Individual Button
                        StacExpanded(
                          child: _buildReceiverTypeButton(
                            title: 'حقیقی',
                            selectedKey: 'isIndividualSelected',
                            otherKey: 'isLegalSelected',
                          ),
                        ),
                        StacSizedBox(width: 8),
                        // Legal Button
                        StacExpanded(
                          child: _buildReceiverTypeButton(
                            title: 'حقوقی',
                            selectedKey: 'isLegalSelected',
                            otherKey: 'isIndividualSelected',
                          ),
                        ),
                      ],
                    ),
                    StacSizedBox(height: 16),

                    // Individual Form Fields
                    // National Code Field
                    StacText(
                      data: 'کد ملی',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'receiver_national_code',
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'maxLength': 10,
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      'decoration': StacInputDecoration(
                        hintText: 'کد ملی ذینفع را وارد نمایید',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ).toJson(),
                      'keyboardType': 'number',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'^\d{10}$',
                          'message': 'کد ملی معتبر وارد نمایید',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isReceiverFormValid',
                        fields: [
                          {'id': 'receiver_national_code', 'rule': r'^\d{10}$'},
                          {'id': 'receiver_mobile', 'rule': r'^09\d{9}$'},
                          {
                            'id': 'receiver_birthdate',
                            'rule': r'^\d{4}/\d{2}/\d{2}$',
                          },
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // Mobile Number Field
                    StacText(
                      data: 'شماره همراه',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'receiver_mobile',
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'maxLength': 11,
                      'inputFormatters': [
                        {'type': 'allow', 'rule': '[0-9]'},
                      ],
                      'decoration': StacInputDecoration(
                        hintText: 'شماره همراه ذینفع را وارد نمایید',
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ).toJson(),
                      'keyboardType': 'phone',
                      'textInputAction': 'next',
                      'validatorRules': [
                        {
                          'rule': r'^09\d{9}$',
                          'message': 'شماره همراه معتبر وارد نمایید',
                        },
                      ],
                      'onChanged': StacValidateFieldsAction(
                        resultKey: 'isReceiverFormValid',
                        fields: [
                          {'id': 'receiver_national_code', 'rule': r'^\d{10}$'},
                          {'id': 'receiver_mobile', 'rule': r'^09\d{9}$'},
                          {
                            'id': 'receiver_birthdate',
                            'rule': r'^\d{4}/\d{2}/\d{2}$',
                          },
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 16),

                    // Birthdate Field
                    StacText(
                      data: 'تاریخ تولد',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 8),
                    StacRawJsonWidget({
                      'type': 'textFormField',
                      'id': 'receiver_birthdate',
                      'readOnly': true,
                      'showCursor': false,
                      'textDirection': 'rtl',
                      'textAlign': 'right',
                      'decoration': StacInputDecoration(
                        hintText:
                            'تاریخ تولد ذینفع را انتخاب نمایید',
                        hintStyle: StacCustomTextStyle(
                          color: '{{appColors.current.text.subtitle}}',
                          fontSize: 14,
                          fontWeight: StacFontWeight.w500,
                        ),
                        filled: false,
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        prefixIcon: StacPadding(
                          padding: StacEdgeInsets.all(8),
                          child: StacImage(
                            src: 'assets/icons/ic_calendar.svg',
                            imageType: StacImageType.asset,
                            width: 24,
                            height: 24,
                            fit: StacBoxFit.scaleDown,
                            color: '{{appColors.current.text.subtitle}}',
                          ),
                        ),
                      ).toJson(),
                      'keyboardType': 'text',
                      'textInputAction': 'done',
                      'validatorRules': [
                        {
                          'rule': r'^\d{4}/\d{2}/\d{2}$',
                          'message':
                              'تاریخ تولد را انتخاب نمایید',
                        },
                      ],
                      'onTap': StacPersianDatePickerAction(
                        formFieldId: 'receiver_birthdate',
                        firstDate: '1350/01/01',
                        lastDate: '1450/12/29',
                        onDateSelected: StacValidateFieldsAction(
                          resultKey: 'isReceiverFormValid',
                          fields: [
                            {
                              'id': 'receiver_national_code',
                              'rule': r'^\d{10}$',
                            },
                            {'id': 'receiver_mobile', 'rule': r'^09\d{9}$'},
                            {
                              'id': 'receiver_birthdate',
                              'rule': r'^\d{4}/\d{2}/\d{2}$',
                            },
                          ],
                        ).toJson(),
                      ).toJson(),
                    }),
                    StacSizedBox(height: 40),
                  ],
                ),
              ),
            ),
            // Continue Button
            StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isReceiverFormValid',
                'onPressed': {
                  'actionType': 'sequence',
                  'actions': [
                    // Copy form values into registry for use in URL templating
                    {
                      'actionType': 'setValue',
                      'values': [
                        {
                          'key': 'receiver.nationalCode',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_national_code',
                          },
                        },
                        {
                          'key': 'receiver.mobile',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_mobile',
                          },
                        },
                        {
                          'key': 'receiver.birthDate',
                          'value': {
                            'actionType': 'getFormValue',
                            'id': 'receiver_birthdate',
                          },
                        },
                        {
                          'key': 'receiver.birthDateCompact',
                          'value': "{{replace(receiver.birthDate,'/','')}}",
                        },
                      ],
                    },
                    // Call identity API (real) then navigate on success
                    {
                      'actionType': 'networkRequest',
                      'url':
                          'http://192.168.107.22:8280/api/digitalbanking/customers/v1.0/identity/{{receiver.nationalCode}}/{{receiver.birthDateCompact}}',
                      'method': 'get',
                      'headers': {
                        'accept': '*/*',
                        'app-platform': 'android',
                        'app-store': 'application/json',
                        'app-version': '456',
                        'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
                        'serviceauthorization':
                            'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
                        'authorization': '{{auth.accessToken}}',
                      },
                      'results': [
                        {
                          'statusCode': 200,
                          'action': {
                            'actionType': 'sequence',
                            'actions': [
                              {
                                'actionType': 'setValue',
                                'values': [
                                  {'key': 'receiverIdentity.raw', 'value': '{{data.data}}'},
                                  {'key': 'receiverIdentity.name', 'value': '{{data.data.name}}'},
                                  {'key': 'receiverIdentity.family', 'value': '{{data.data.family}}'},
                                  {
                                    'key': 'receiverIdentity.fullName',
                                    'value': '{{data.data.name}} {{data.data.family}}',
                                  },
                                  {'key': 'receiverIdentity.fatherName', 'value': '{{data.data.fatherName}}'},
                                  {'key': 'receiverIdentity.gender', 'value': '{{data.data.gender}}'},
                                  {'key': 'receiverIdentity.nationalId', 'value': '{{data.data.nationalId}}'},
                                ],
                              },
                              {
                                'actionType': 'navigate',
                                'widgetType': 'promissory_data',
                                'navigationStyle': 'push',
                              },
                            ],
                          },
                        },
                        {
                          'statusCode': 401,
                          'action': {
                            'actionType': 'log',
                            'message': 'Authentication failed. Please login again.',
                          },
                        },
                      ],
                    },
                  ],
                },
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.common.continue}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Builds a receiver type selection button (Individual or Legal)
StacWidget _buildReceiverTypeButton({
  required String title,
  required String selectedKey,
  required String otherKey,
}) {
  return StacGestureDetector(
    onTap: StacMultiAction(
      actions: [
        StacCustomSetValueAction(key: selectedKey, value: true),
        StacCustomSetValueAction(key: otherKey, value: false),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(vertical: 12),
      decoration: StacBoxDecoration(
        color:
            '{{$selectedKey ? appColors.current.primary.color : appColors.current.background.surfaceContainer}}',
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(
          color:
              '{{$selectedKey ? appColors.current.primary.color : appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacCenter(
        child: StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w600,
            color:
                '{{$selectedKey ? appColors.current.primary.onPrimary : appColors.current.text.title}}',
          ),
        ),
      ),
    ),
  );
}

/// Custom class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Raw JSON widget helper
class StacRawJsonWidget implements StacWidget {
  final Map<String, dynamic> json;
  StacRawJsonWidget(this.json);

  @override
  Map<String, dynamic> get jsonData => json;

  @override
  Map<String, dynamic> toJson() => json;

  @override
  String get type => json['type'] as String;

  String? get id => json['id'] as String?;
}

/// Raw JSON action helper
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}
