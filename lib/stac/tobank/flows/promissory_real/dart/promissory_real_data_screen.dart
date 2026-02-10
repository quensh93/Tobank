import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart'
    hide StacPersianDatePickerAction;
import '../../../../../core/stac/parsers/actions/persian_date_picker_action_model.dart';

/// Promissory Real Flow - Data Entry Page
///
/// This screen collects the promissory details:
/// 1. Amount
/// 2. Due Date
/// 3. Description (Optional)
/// 4. Payment Place (Optional)
///
/// It also displays a summary of the Receiver Information.
@StacScreen(screenName: 'promissory_real_data')
StacWidget promissoryRealData() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(
      values: [
        {'key': 'isDataFormValid', 'value': false},
        {'key': 'isIdentityLoading', 'value': false},
        {'key': 'isOnDemand', 'value': false},
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.dataTitle}}',
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
        child: StacStack(
          children: [
            StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacExpanded(
                  child: StacSingleChildScrollView(
                    padding: StacEdgeInsets.all(16),
                    child: StacColumn(
                      crossAxisAlignment: StacCrossAxisAlignment.stretch,
                      textDirection: StacTextDirection.rtl,
                      children: [
                        // Receiver Info Summary Card
                        StacContainer(
                          decoration: StacBoxDecoration(
                            color:
                                '{{appColors.current.background.surfaceContainer}}',
                            borderRadius: StacBorderRadius.all(12),
                            border: StacBorder.all(
                              color:
                                  '{{appColors.current.input.borderEnabled}}',
                              width: 1,
                            ),
                          ),
                          padding: StacEdgeInsets.all(16),
                          child: StacColumn(
                            crossAxisAlignment: StacCrossAxisAlignment.stretch,
                            children: [
                              StacText(
                                data: 'اطلاعات دریافت‌کننده',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  fontWeight: StacFontWeight.w700,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacSizedBox(height: 12),
                              // National Code
                              _buildInfoRow(
                                label: 'کد ملی', value: '{{form.receiver_national_code}}',
                              ),
                              StacSizedBox(height: 8),
                              // Mobile Number
                              _buildInfoRow(label: 'شماره موبایل', value: '{{form.receiver_mobile}}'),
                              StacSizedBox(height: 8),
                              // Full Name (from receiver inquiry)
                              _buildInfoRow(
                                label: 'نام و نام خانوادگی',
                                value: '{{receiverIdentity.fullName}}',
                              ),
                            ],
                          ),
                        ),
                        StacSizedBox(height: 24),

                        StacContainer(
                          decoration: StacBoxDecoration(
                            color:
                            '{{appColors.current.background.surfaceContainer}}',
                            borderRadius: StacBorderRadius.all(8),
                            border: StacBorder.all(
                              color: '{{appColors.current.input.borderEnabled}}',
                              width: 0.5,
                            ),
                          ),
                          padding: StacEdgeInsets.all(16),
                          child: StacColumn(
                            crossAxisAlignment: StacCrossAxisAlignment.stretch,
                            children: [
                              // Section Title
                              StacText(
                                data: 'اطلاعات سفته',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  fontWeight: StacFontWeight.w700,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacSizedBox(height: 16),

                              // Amount Field with Label and Hint
                              StacRow(
                                textDirection: StacTextDirection.rtl,
                                mainAxisAlignment:
                                StacMainAxisAlignment.spaceBetween,
                                children: [
                                  StacText(
                                    data: 'مبلغ تعهد',
                                    textDirection: StacTextDirection.rtl,
                                    style: StacCustomTextStyle(
                                      fontSize: 14,
                                      fontWeight: StacFontWeight.w600,
                                      color: '{{appColors.current.text.title}}',
                                    ),
                                  ),
                                  StacText(
                                    data: '',
                                    textDirection: StacTextDirection.rtl,
                                    style: StacCustomTextStyle(
                                      fontSize: 13,
                                      fontWeight: StacFontWeight.w600,
                                      color: '{{appColors.current.text.subtitle}}',
                                    ),
                                  ),
                                ],
                              ),
                              StacSizedBox(height: 8),
                              StacRawJsonWidget({
                                'type': 'textFormField',
                                'id': 'promissory_amount',
                                'textDirection': 'rtl',
                                'textAlign': 'right',
                                'decoration': StacInputDecoration(
                                  hintText: '{{appStrings.promissory.enterAmountt}}',
                                  hintStyle: StacTextStyle(
                                    fontSize: 12,
                                    fontWeight: StacFontWeight.w600,
                                    color: '{{appColors.current.text.subtitle}}',
                                  ),
                                  filled: false,
                                  contentPadding: StacEdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ).toJson(),
                                'keyboardType': 'number',
                                'inputFormatters': [
                                  {'type': 'allow', 'rule': '[0-9]'},
                                ],
                                'validatorRules': [
                                  {
                                    'rule': r'^\d+$',
                                    'message':
                                    '{{appStrings.promissory.amountRequired}}',
                                  },
                                ],
                                'onChanged': _getFullValidationAction().toJson(),
                              }),
                              StacSizedBox(height: 16),

                              // Due Date Toggle
                              StacRow(
                                textDirection: StacTextDirection.rtl,
                                mainAxisAlignment:
                                StacMainAxisAlignment.spaceBetween,
                                children: [
                                  StacText(
                                    data: 'تاریخ پرداخت سفته',
                                    textDirection: StacTextDirection.rtl,
                                    style: StacCustomTextStyle(
                                      fontSize: 14,
                                      fontWeight: StacFontWeight.w600,
                                      color: '{{appColors.current.text.title}}',
                                    ),
                                  ),
                                  StacRow(
                                    textDirection: StacTextDirection.rtl,
                                    mainAxisSize: StacMainAxisSize.min,
                                    children: [
                                      StacText(
                                        data: 'عندالمطالبه',
                                        textDirection: StacTextDirection.rtl,
                                        style: StacCustomTextStyle(
                                          fontSize: 12,
                                          fontWeight: StacFontWeight.w500,
                                        ),
                                      ),
                                      StacSizedBox(width: 8),
                                      StacRawJsonWidget({
                                        'type': 'reactiveSwitch',
                                        'id': 'dueDateSwitch',
                                        'valueKey': 'isOnDemand',
                                        'activeColor':
                                        '{{appColors.current.secondary.color}}',
                                        'onChanged': _getFullValidationAction()
                                            .toJson(),
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                              StacSizedBox(height: 8),
                              StacRawJsonWidget({
                                'type': 'visibility',
                                'visible': '{{!isOnDemand}}',
                                'child': StacGestureDetector(
                                  onTap: StacPersianDatePickerAction(
                                    formFieldId: 'promissory_due_date',
                                    firstDate: '1403/01/01', // Example constraint
                                    lastDate: '1450/12/29',
                                    onDateSelected: _getFullValidationAction().toJson(),
                                  ),
                                  child: StacTextFormField(
                                    id: 'promissory_due_date',
                                    readOnly: true,
                                    enabled: false,
                                    style: StacCustomTextStyle(
                                      fontSize: 13,
                                      fontWeight: StacFontWeight.w600,
                                      color: '{{appColors.current.text.title}}',
                                    ),
                                    textDirection: StacTextDirection.rtl,
                                    textAlign: StacTextAlign.right,
                                    decoration: StacInputDecoration(
                                      hintText: '{{appStrings.promissory.selectDate}}',
                                      hintStyle: StacTextStyle(
                                        fontSize: 12,
                                        fontWeight: StacFontWeight.w600,
                                        color: '{{appColors.current.text.hint}}',
                                      ),
                                      filled: false,
                                      contentPadding: StacEdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      prefixIcon: StacIcon(
                                        icon: StacIcons.calendar_today,
                                        color: '{{appColors.current.text.subtitle}}',
                                        size: 20,
                                      ),
                                    ),
                                    validatorRules: [
                                      StacFormFieldValidator(
                                        rule: r'^\d{4}/\d{2}/\d{2}$',
                                        message: '{{appStrings.promissory.dueDateRequired}}',
                                      ),
                                    ],
                                  ),
                                ).toJson(),
                              }),


                              // Due Date Picker (Hidden if On Demand is true)
                              // StacRawJsonWidget({
                              //   'type': 'visibility',
                              //   'visible': '{{!isOnDemand}}',
                              //   'child': StacGestureDetector(
                              //     onTap: StacPersianDatePickerAction(
                              //       formFieldId: 'promissory_due_date',
                              //       firstDate: '1403/01/01',
                              //       lastDate: '1420/12/29',
                              //       onDateSelected: _getFullValidationAction()
                              //           .toJson(),
                              //     ),
                              //     child: StacTextFormField(
                              //       id: 'promissory_due_date',
                              //       readOnly: true,
                              //       enabled: false,
                              //       textDirection: StacTextDirection.ltr,
                              //       textAlign: StacTextAlign.right,
                              //       decoration: StacInputDecoration(
                              //         hintText:
                              //         'تاریخ سررسید سفته را انتخاب نمایید',
                              //         filled: false,
                              //         contentPadding: StacEdgeInsets.symmetric(
                              //           horizontal: 16,
                              //           vertical: 16,
                              //         ),
                              //         prefixIcon: StacPadding(
                              //           padding: StacEdgeInsets.all(8),
                              //           child: StacImage(
                              //             src: 'assets/icons/ic_calendar.svg',
                              //             imageType: StacImageType.asset,
                              //             width: 24,
                              //             height: 24,
                              //             color:
                              //             '{{appColors.current.text.subtitle}}',
                              //           ),
                              //         ),
                              //       ),
                              //       validatorRules: [
                              //         StacFormFieldValidator(
                              //           rule: r'^\d{4}/\d{2}/\d{2}$',
                              //           message: 'تاریخ سررسید را انتخاب نمایید',
                              //         ),
                              //       ],
                              //     ),
                              //   ).toJson(),
                              // }),
                              StacSizedBox(height: 16),

                              // Transferable Toggle
                              StacRow(
                                textDirection: StacTextDirection.rtl,
                                mainAxisAlignment:
                                StacMainAxisAlignment.spaceBetween,
                                children: [
                                  StacExpanded(
                                    child: StacText(
                                      data: 'امکان انتقال به شخص ثالث',
                                      textDirection: StacTextDirection.rtl,
                                      style: StacCustomTextStyle(
                                        fontSize: 14,
                                        fontWeight: StacFontWeight.w600,
                                        color: '{{appColors.current.text.title}}',
                                      ),
                                    ),
                                  ),
                                  StacRawJsonWidget({
                                    'type': 'reactiveSwitch',
                                    'id': 'transferableSwitch',
                                    'valueKey': 'isTransferable',
                                    'activeColor':
                                    '{{appColors.current.secondary.color}}',
                                  }),
                                ],
                              ),
                              StacSizedBox(height: 16),

                              // Payment Place Field (Optional)
                              StacText(
                                data:
                                '{{appStrings.promissory.paymentPlaceOptional}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 14,
                                  fontWeight: StacFontWeight.w600,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacSizedBox(height: 8),
                              StacTextFormField(
                                id: 'promissory_payment_place',
                                textDirection: StacTextDirection.rtl,
                                textAlign: StacTextAlign.right,
                                minLines: 3,
                                maxLines: 5,
                                decoration: StacInputDecoration(
                                  hintText:
                                  '{{appStrings.promissory.paymentPlaceHint}}',
                                  filled: false,
                                  contentPadding: StacEdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                              StacSizedBox(height: 16),

                              // Description Field (Optional)
                              StacText(
                                data:
                                '{{appStrings.promissory.amountOptionalSuffix}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 14,
                                  fontWeight: StacFontWeight.w600,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacSizedBox(height: 8),
                              StacTextFormField(
                                id: 'description',
                                textDirection: StacTextDirection.rtl,
                                textAlign: StacTextAlign.right,
                                minLines: 3,
                                maxLines: 5,
                                decoration: StacInputDecoration(
                                  hintText:
                                  '{{appStrings.promissory.descriptionHint}}',
                                  filled: false,
                                  contentPadding: StacEdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                              ),
                              StacSizedBox(height: 16),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                // Continue Button (Navigation Update)
                StacPadding(
                  padding: StacEdgeInsets.all(16),
                  child: StacRawJsonWidget({
                    'type': 'reactiveElevatedButton',
                    'enabledKey': 'isDataFormValid',
                    'onPressed': StacSequenceAction(
                      actions: [
                        // Save form data to registry
                        StacCustomSetValueAction(
                          key: 'form.promissory_amount',
                          value: StacGetFormValueAction(
                            id: 'promissory_amount',
                          ),
                        ),
                        StacCustomSetValueAction(
                          key: 'form.promissory_due_date',
                          value: StacGetFormValueAction(
                            id: 'promissory_due_date',
                          ),
                        ),
                        StacCustomSetValueAction(
                          key: 'form.description',
                          value: StacGetFormValueAction(id: 'description'),
                        ),
                        StacCustomSetValueAction(
                          key: 'form.promissory_payment_place',
                          value: StacGetFormValueAction(
                            id: 'promissory_payment_place',
                          ),
                        ),
                        // Ensure compact birth date exists for later steps
                        StacCustomSetValueAction(
                          key: 'receiver.birthDateCompact',
                          value: "{{replace(receiver.birthDate,'/','')}}",
                        ),
                        // Fetch Fees API Call
                        StacCustomSetValueAction(
                          key: 'isIdentityLoading',
                          value: true,
                        ),
                        StacNetworkRequestAction(
                          url:
                              'http://192.168.107.22:8280/api/digitalbanking/collateral/v1.0/promissories/fees?amount={{form.promissory_amount}}',
                          method: 'get',
                          headers: {
                            'accept': 'application/json',
                            'authorization': '{{auth.accessToken}}',
                          },
                          results: [
                            {
                              'statusCode': 200,
                              'action': StacSequenceAction(
                                actions: [
                                  StacCustomSetValueAction(
                                    values: [
                                      {
                                        'key': 'promissory.fees.stampFee',
                                        'value': '{{data_payload.stampFee}}',
                                      },
                                      {
                                        'key': 'promissory.fees.wage',
                                        'value': '{{data_payload.wage}}',
                                      },
                                      {
                                        'key': 'promissory.fees.total',
                                        'value': '{{data_payload.total}}',
                                      },
                                      {
                                        'key': 'isIdentityLoading',
                                        'value': false,
                                      },
                                    ],
                                  ),
                                  StacRawJsonAction({
                                    'actionType': 'navigate',
                                    'widgetType': 'promissory_real_confirm',
                                    'navigationStyle': 'push',
                                  }),
                                ],
                              ).toJson(),
                            },
                            {
                              'statusCode': -1, // Fallback for errors
                              'action': StacSequenceAction(
                                actions: [
                                  StacCustomSetValueAction(
                                    key: 'isIdentityLoading',
                                    value: false,
                                  ),
                                  StacRawJsonAction({
                                    'actionType': 'showDialog',
                                    'widget': StacAlertDialog(
                                      title: StacText(data: 'خطا'),
                                      content: StacText(
                                        data:
                                            'خطا در دریافت اطلاعات کارمزد. لطفا مجددا تلاش کنید.',
                                      ),
                                      actions: [
                                        StacTextButton(
                                          onPressed: StacRawJsonAction({
                                            'actionType': 'closeDialog',
                                          }),
                                          child: StacText(data: 'باشه'),
                                        ),
                                      ],
                                    ).toJson(),
                                  }),
                                ],
                              ).toJson(),
                            },
                          ],
                        ),
                      ],
                    ).toJson(),
                    'style': StacButtonStyle(
                      backgroundColor: '{{appColors.current.primary.color}}',
                      elevation: 0,
                      fixedSize: StacSize(999999, 56),
                      shape: StacRoundedRectangleBorder(
                        borderRadius: StacBorderRadius.all(12),
                      ),
                    ).toJson(),
                    'child': StacText(
                      data:
                          "{{isIdentityLoading ? appStrings.promissory.loadingText : appStrings.common.continue}}",
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
          ],
        ),
      ),
    ),
  );
}


/// Builds a key-value row for displaying information
StacWidget _buildInfoRow({required String label, required String value}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 14,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacText(
        data: value,
        textDirection: StacTextDirection.ltr,
        style: StacCustomTextStyle(
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}


StacValidateFieldsAction _getFullValidationAction() {
  final fields = <Map<String, dynamic>>[
    {'id': 'promissory_amount', 'rule': r'^\d+$'},
    {
      'id': 'promissory_due_date',
      'rule': r'^\d{4}/\d{2}/\d{2}$',
      'optional': 'isOnDemand'
    },
  ];
  return StacValidateFieldsAction(
    resultKey: 'isDataFormValid',
    fields: fields,
  );
}
