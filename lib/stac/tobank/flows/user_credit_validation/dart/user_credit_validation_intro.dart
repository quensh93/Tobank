import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';

/// First validation screen (CBS style) based on old app layout.
@StacScreen(screenName: 'user_credit_validation_intro')
StacWidget tobankLoginDart() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'uvCanContinue', 'value': false},
        {'key': 'uvEnteredPhone', 'value': ''},
        {'key': 'uvPayWalletSel', 'value': true},
        {'key': 'uvPayDepositSel', 'value': false},
        {'key': 'uvReportFilterAll', 'value': true},
        {'key': 'uvReportFilterMine', 'value': false},
        {'key': 'uvReportFilterOthers', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title: '{{appStrings.authentication.stepValidation}}',
        showSupport: true,
        showBack: true,
      ),
      body: StacDefaultTabController(
        length: 2,
        initialIndex: 1,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacSizedBox(height: 8),
            _buildTopTabs(),
            StacSizedBox(height: 12),
            StacExpanded(
              child: StacTabBarView(
                children: [_buildReportsTab(), _buildValidationTab()],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildTopTabs() {
  return StacContainer(
    margin: StacEdgeInsets.symmetric(horizontal: 16),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.circular(14),
    ),
    child: StacStack(
      children: [
        StacTabBar(
          dividerColor: '#00000000',
          indicatorColor: '{{appColors.current.primary.color}}',
          indicatorWeight: 3,
          indicatorSize: StacTabBarIndicatorSize.tab,
          indicatorPadding: StacEdgeInsets.only(left: 48, top: 50, right: 48),
          labelStyle: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
          ),
          unselectedLabelStyle: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w500,
          ),
          labelColor: '{{appColors.current.text.title}}',
          unselectedLabelColor: '{{appColors.current.text.hint}}',
          tabs: const [
            StacTab(
              text:
                  '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.sample_message}}',
              height: 54,
            ),
            StacTab(
              text: '{{appStrings.authentication.stepValidation}}',
              height: 54,
            ),
          ],
        ),
        StacPositioned(
          top: 12,
          bottom: 12,
          left: 0,
          right: 0,
          child: StacCenter(
            child: StacContainer(
              width: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildReportsTab() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: StacSingleChildScrollView(
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.start,
            children: [
              _buildReportFilterChip(
                label:
                    '{{appStrings.generated.cartable.cartable_intro.all_filter}}',
                selectedKey: 'uvReportFilterAll',
                onTap: const StacCustomSetValueAction(
                  values: [
                    {'key': 'uvReportFilterAll', 'value': true},
                    {'key': 'uvReportFilterMine', 'value': false},
                    {'key': 'uvReportFilterOthers', 'value': false},
                  ],
                ),
              ),
              StacSizedBox(width: 8),
              _buildReportFilterChip(
                label:
                    '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.title}}',
                selectedKey: 'uvReportFilterMine',
                onTap: const StacCustomSetValueAction(
                  values: [
                    {'key': 'uvReportFilterAll', 'value': false},
                    {'key': 'uvReportFilterMine', 'value': true},
                    {'key': 'uvReportFilterOthers', 'value': false},
                  ],
                ),
              ),
              StacSizedBox(width: 8),
              _buildReportFilterChip(
                label:
                    '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.others_tab}}',
                selectedKey: 'uvReportFilterOthers',
                onTap: const StacCustomSetValueAction(
                  values: [
                    {'key': 'uvReportFilterAll', 'value': false},
                    {'key': 'uvReportFilterMine', 'value': false},
                    {'key': 'uvReportFilterOthers', 'value': true},
                  ],
                ),
              ),
            ],
          ),
          StacSizedBox(height: 14),
          StacCustomVisibility(
            visible: '[[uvReportFilterAll]]',
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _buildReportItemCard(
                  applicant:
                      '{{appStrings.profile.real.destinations.depositItem2Title}}',
                  date:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.amount_value_message}}',
                  tracking:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_receipt.card_number}}',
                ),
                StacSizedBox(height: 12),
                _buildReportItemCard(
                  applicant:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.zahra_habibi_name}}',
                  date:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.amount_value_label}}',
                  tracking:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.card_number}}',
                ),
                StacSizedBox(height: 12),
                _buildReportItemCard(
                  applicant:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.mohammadreza_nowruzi_name}}',
                  date:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.amount_value_description}}',
                  tracking:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.card_number_text}}',
                ),
                StacSizedBox(height: 12),
                _buildReportItemCard(
                  applicant:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.maryam_ahmadi_name}}',
                  date:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.amount_value_hint}}',
                  tracking:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.card_number_label}}',
                ),
              ],
            ).toJson(),
            replacement: StacSizedBox().toJson(),
          ),
          StacCustomVisibility(
            visible: '[[uvReportFilterMine]]',
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _buildReportItemCard(
                  applicant:
                      '{{appStrings.profile.real.destinations.depositItem2Title}}',
                  date:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.amount_value_message}}',
                  tracking:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_receipt.card_number}}',
                ),
              ],
            ).toJson(),
            replacement: StacSizedBox().toJson(),
          ),
          StacCustomVisibility(
            visible: '[[uvReportFilterOthers]]',
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _buildReportItemCard(
                  applicant:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.zahra_habibi_name}}',
                  date:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.amount_value_label}}',
                  tracking:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.card_number}}',
                ),
                StacSizedBox(height: 12),
                _buildReportItemCard(
                  applicant:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.mohammadreza_nowruzi_name}}',
                  date:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.amount_value_description}}',
                  tracking:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.card_number_text}}',
                ),
                StacSizedBox(height: 12),
                _buildReportItemCard(
                  applicant:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.maryam_ahmadi_name}}',
                  date:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.amount_value_hint}}',
                  tracking:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.card_number_label}}',
                ),
              ],
            ).toJson(),
            replacement: StacSizedBox().toJson(),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildReportFilterChip({
  required String label,
  required String selectedKey,
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: '[[$selectedKey]]',
      child: StacContainer(
        padding: StacEdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: StacBoxDecoration(
          color: '#EAF9FC',
          borderRadius: StacBorderRadius.all(12),
          border: StacBorder.all(color: '#20C4D8', width: 1),
        ),
        child: StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '#0F6B7A',
          ),
        ),
      ).toJson(),
      replacement: StacContainer(
        padding: StacEdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surfaceContainer}}',
          borderRadius: StacBorderRadius.all(12),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ).toJson(),
    ),
  );
}

StacWidget _buildReportItemCard({
  required String applicant,
  required String date,
  required String tracking,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(12),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacPadding(
          padding: StacEdgeInsets.all(14),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacRow(
                textDirection: StacTextDirection.rtl,
                children: [
                  StacContainer(
                    width: 42,
                    height: 42,
                    decoration: StacBoxDecoration(
                      shape: StacBoxShape.circle,
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 1,
                      ),
                    ),
                    child: StacCenter(
                      child: StacImage(
                        src: 'assets/icons/ic_cbs_search.svg',
                        imageType: StacImageType.asset,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                  StacSizedBox(width: 10),
                  StacText(
                    data:
                        '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.report_credit_validation}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ],
              ),
              StacSizedBox(height: 14),
              _reportKeyValue(
                '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.applicant_role}}',
                applicant,
              ),
              _reportDottedDivider(),
              _reportKeyValue(
                '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.date}}',
                date,
              ),
              _reportDottedDivider(),
              _reportKeyValue(
                '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.code}}',
                tracking,
              ),
            ],
          ),
        ),
        StacGestureDetector(
          onTap: NavigationAction(
            fileName: 'user_credit_validation_report_detail',
            navMode: NavModes.dart,
            navigationStyle: NavigationStyle.push,
          ),
          child: StacContainer(
            padding: StacEdgeInsets.symmetric(vertical: 12),
            decoration: StacBoxDecoration(
              color: '#F2F4F7',
              borderRadius: StacBorderRadius.only(
                bottomLeft: 12,
                bottomRight: 12,
              ),
            ),
            child: StacRow(
              mainAxisAlignment: StacMainAxisAlignment.center,
              textDirection: StacTextDirection.rtl,
              children: [
                StacImage(
                  src: 'assets/icons/ic_show.svg',
                  imageType: StacImageType.asset,
                  width: 22,
                  height: 22,
                  color: '{{appColors.current.text.title}}',
                ),
                StacSizedBox(width: 8),
                StacText(
                  data:
                      '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.sample_label}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _reportKeyValue(String key, String value) {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(vertical: 8),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacText(
          data: key,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
        StacExpanded(child: StacSizedBox()),
        StacText(
          data: value,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _reportDottedDivider() {
  return StacRow(
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: List.generate(
      42,
      (_) => StacContainer(
        width: 3,
        height: 1,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
    ),
  );
}

StacWidget _buildValidationTab() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: StacForm(
      autovalidateMode: StacAutovalidateMode.onUserInteraction,
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        textDirection: StacTextDirection.rtl,
        children: [
          StacText(
            data:
                '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.sim_card_number}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 12),
          StacRow(
            textDirection: StacTextDirection.rtl,
            crossAxisAlignment: StacCrossAxisAlignment.start,
            children: [
              StacExpanded(
                child: StacContainer(
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.surface}}',
                    borderRadius: StacBorderRadius.all(8),
                    border: StacBorder.all(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 1,
                    ),
                  ),
                  child: StacRawJsonWidget({
                    'type': 'textFormField',
                    'id': 'mobile_number',
                    'textDirection': 'rtl',
                    'textAlign': 'right',
                    'maxLength': 11,
                    'keyboardType': 'number',
                    'inputFormatters': [
                      {'type': 'allow', 'rule': '[0-9]'},
                    ],
                    'onChanged': const StacSequenceAction(
                      actions: [
                        StacCustomSetValueAction(
                          key: 'uvEnteredPhone',
                          value: StacGetFormValueAction(id: 'mobile_number'),
                        ),
                        StacValidateFieldsAction(
                          resultKey: 'uvCanContinue',
                          fields: [
                            {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                          ],
                        ),
                      ],
                    ).toJson(),
                    'style': StacTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.title}}',
                    ).toJson(),
                    'decoration': {
                      ...StacInputDecoration(
                        hintText:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.amount_value}}',
                        hintStyle: StacTextStyle(
                          fontSize: 17,
                          fontWeight: StacFontWeight.w500,
                          color: '{{appColors.current.text.subtitle}}',
                        ),
                        filled: true,
                        fillColor: '#00000000',
                        contentPadding: StacEdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ).toJson(),
                      'border': {'type': 'none'},
                      'enabledBorder': {'type': 'none'},
                      'focusedBorder': {'type': 'none'},
                      'counterText': '',
                    },
                  }),
                ),
              ),
              StacSizedBox(width: 10),
              StacGestureDetector(
                onTap: const StacSequenceAction(
                  actions: [
                    StacCustomSetValueAction(
                      key: 'mobile_number',
                      value: '{{userData.mobile}}',
                    ),
                    StacCustomSetValueAction(
                      key: 'form.mobile_number',
                      value: '{{userData.mobile}}',
                    ),
                    StacCustomSetValueAction(
                      key: 'uvEnteredPhone',
                      value: '{{userData.mobile}}',
                    ),
                    StacValidateFieldsAction(
                      resultKey: 'uvCanContinue',
                      fields: [
                        {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                      ],
                    ),
                  ],
                ),
                child: _buildIconBox('assets/icons/ic_user_profile.svg'),
              ),
              StacSizedBox(width: 10),
              StacGestureDetector(
                onTap: const StacPickContactPhoneAction(
                  formFieldId: 'mobile_number',
                  targetKey: 'uvEnteredPhone',
                  onContactSelected: StacValidateFieldsAction(
                    resultKey: 'uvCanContinue',
                    fields: [
                      {'id': 'mobile_number', 'rule': r'^09\d{9}$'},
                    ],
                  ),
                  permissionDeniedMessage:
                      '{{appStrings.generated.card_management.card_management_root.not}}',
                  invalidMobileMessage:
                      '{{appStrings.generated.card_management.card_management_root.mobile_number}}',
                ),
                child: _buildIconBox('assets/icons/ic_contact_list.svg'),
              ),
            ],
          ),
          StacExpanded(child: StacSizedBox()),
          StacCustomReactiveElevatedButton(
            enabledKey: 'uvCanContinue',
            enabled: false,
            onPressed: _buildPaymentBottomSheetAction(),
            style: StacButtonStyle(
              backgroundColor: '{{appColors.current.primary.color}}',
              elevation: 0,
              fixedSize: StacSize(999999, 55),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(11),
              ),
            ).toJson(),
            disabledStyle: StacButtonStyle(
              backgroundColor:
                  '{{appColors.current.background.surfaceContainerHigh}}',
              elevation: 0,
              fixedSize: StacSize(999999, 55),
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(11),
              ),
            ).toJson(),
            child: StacText(
              data: '{{appStrings.common.continue}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ).toJson(),
          ),
          StacSizedBox(height: 6),
        ],
      ),
    ),
  );
}

StacAction _buildPaymentBottomSheetAction() {
  return StacSequenceAction(
    actions: [
      const StacCustomSetValueAction(
        values: [
          {'key': 'uvPayWalletSel', 'value': true},
          {'key': 'uvPayDepositSel', 'value': false},
          {'key': 'uvDepositOption1Sel', 'value': true},
          {'key': 'uvDepositOption2Sel', 'value': false},
        ],
      ),
      StacShowBottomSheetAction(
        isScrollControlled: true,
        useSafeArea: false,
        isDismissible: true,
        enableDrag: true,
        backgroundColor: '#00000000',
        barrierColor: '#55000000',
        sheet: StacSafeArea(
          top: false,
          bottom: false,
          child: StacContainer(
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.only(topLeft: 24, topRight: 24),
            ),
            child: StacPadding(
              padding: StacEdgeInsets.only(
                left: 16,
                top: 10,
                right: 16,
                bottom: 24,
              ),
              child: StacSingleChildScrollView(
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    StacCenter(
                      child: StacContainer(
                        width: 40,
                        height: 4,
                        decoration: StacBoxDecoration(
                          color: '{{appColors.current.input.borderEnabled}}',
                          borderRadius: StacBorderRadius.all(99),
                        ),
                      ),
                    ),
                    StacSizedBox(height: 30),
                    StacCenter(
                      child: StacContainer(
                        width: 72,
                        height: 72,
                        decoration: StacBoxDecoration(
                          borderRadius: StacBorderRadius.all(40),
                          border: StacBorder.all(
                            color: '{{appColors.current.input.borderEnabled}}',
                            width: 1,
                          ),
                        ),
                        child: StacCenter(
                          child: StacImage(
                            src: 'assets/icons/ic_cbs_search.svg',
                            imageType: StacImageType.asset,
                            width: 34,
                            height: 34,
                          ),
                        ),
                      ),
                    ),
                    StacSizedBox(height: 20),
                    StacCenter(
                      child: StacText(
                        data: '{{appStrings.authentication.stepValidation}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacTextStyle(
                          fontSize: 18,
                          fontWeight: StacFontWeight.w700,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                    ),
                    StacSizedBox(height: 24),
                    StacRow(
                      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                      textDirection: StacTextDirection.rtl,
                      children: [
                        StacSizedBox(width: 15),
                        StacText(
                          data: '{{appStrings.promissory.payableAmount}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacTextStyle(
                            fontSize: 16,
                            fontWeight: StacFontWeight.w500,
                            color: '{{appColors.current.text.subtitle}}',
                          ),
                        ),
                        StacSizedBox(width: 15),
                        StacText(
                          data:
                              '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.rial}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacTextStyle(
                            fontSize: 21,
                            fontWeight: StacFontWeight.w700,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                        StacSizedBox(width: 15),
                      ],
                    ),
                    StacSizedBox(height: 28),
                    StacText(
                      data: '{{appStrings.promissory.paymentMethod}}',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w700,
                        color: '{{appColors.current.text.title}}',
                      ),
                    ),
                    StacSizedBox(height: 12),
                    StacGestureDetector(
                      onTap: const StacCustomSetValueAction(
                        values: [
                          {'key': 'uvPayWalletSel', 'value': true},
                          {'key': 'uvPayDepositSel', 'value': false},
                        ],
                      ),
                      child: _buildPaymentMethodRow(
                        selectedKey: 'uvPayWalletSel',
                        title: '{{appStrings.promissory.walletPayment}}',
                        amount:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.rial_message}}',
                        iconPath: 'assets/icons/ic_wallet.svg',
                      ),
                    ),
                    StacSizedBox(height: 12),
                    StacGestureDetector(
                      onTap: const StacCustomSetValueAction(
                        values: [
                          {'key': 'uvPayWalletSel', 'value': false},
                          {'key': 'uvPayDepositSel', 'value': true},
                          {'key': 'uvDepositOption1Sel', 'value': true},
                          {'key': 'uvDepositOption2Sel', 'value': false},
                        ],
                      ),
                      child: _buildPaymentMethodRow(
                        selectedKey: 'uvPayDepositSel',
                        title:
                            '{{appStrings.profile.real.destinations.tabDeposit}}',
                        amount: '',
                        iconPath: 'assets/icons/ic_gateway.svg',
                      ),
                    ),
                    StacSizedBox(height: 28),
                    StacCustomVisibility(
                      visible: '[[uvPayDepositSel]]',
                      child: _buildPayButtonInSheet(
                        onPressed: _buildSelectDepositBottomSheetAction(),
                      ).toJson(),
                      replacement: _buildPayButtonInSheet(
                        onPressed: _showPaymentConfirmDialogAction(
                          paymentMethod:
                              '{{appStrings.promissory.walletPayment}}',
                        ),
                      ).toJson(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ).toJson(),
      ),
    ],
  );
}

StacWidget _buildPayButtonInSheet({required StacAction onPressed}) {
  return StacFilledButton(
    onPressed: onPressed,
    style: StacButtonStyle(
      backgroundColor: '{{appColors.current.primary.color}}',
      elevation: 0,
      fixedSize: StacSize(999999, 58),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(14)),
    ),
    child: StacText(
      data:
          '{{appStrings.generated.card_management.card_management_root.payment}}',
      textDirection: StacTextDirection.rtl,
      style: StacTextStyle(
        fontSize: 18,
        fontWeight: StacFontWeight.w700,
        color: '{{appColors.current.primary.onPrimary}}',
      ),
    ),
  );
}

StacAction _buildSelectDepositBottomSheetAction() {
  return StacShowBottomSheetAction(
    isScrollControlled: true,
    useSafeArea: false,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: '#00000000',
    barrierColor: '#55000000',
    sheet: StacSafeArea(
      top: false,
      bottom: false,
      child: StacContainer(
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surfaceContainer}}',
          borderRadius: StacBorderRadius.only(topLeft: 24, topRight: 24),
        ),
        child: StacPadding(
          padding: StacEdgeInsets.only(
            left: 16,
            top: 10,
            right: 16,
            bottom: 24,
          ),
          child: StacColumn(
            mainAxisSize: StacMainAxisSize.min,
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacCenter(
                child: StacContainer(
                  width: 40,
                  height: 4,
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.input.borderEnabled}}',
                    borderRadius: StacBorderRadius.all(99),
                  ),
                ),
              ),
              StacSizedBox(height: 24),
              StacText(
                data: '{{appStrings.promissory.selectDepositForPromissory}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacTextStyle(
                  fontSize: 22,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 16),
              StacFlexible(
                child: StacSingleChildScrollView(
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      _buildDepositOptionCard(
                        selectedKey: 'uvDepositOption1Sel',
                        onTap: const StacCustomSetValueAction(
                          values: [
                            {'key': 'uvDepositOption1Sel', 'value': true},
                            {'key': 'uvDepositOption2Sel', 'value': false},
                          ],
                        ),
                        title:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.deposit}}',
                        depositNo:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.amount_value_text}}',
                        iban:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.ir960640011300700763020001}}',
                        cardNo:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.card_number_message}}',
                        balance:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.rial_label}}',
                      ),
                      StacSizedBox(height: 10),
                      _buildDepositOptionCard(
                        selectedKey: 'uvDepositOption2Sel',
                        onTap: const StacCustomSetValueAction(
                          values: [
                            {'key': 'uvDepositOption1Sel', 'value': false},
                            {'key': 'uvDepositOption2Sel', 'value': true},
                          ],
                        ),
                        title:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.deposit_account}}',
                        depositNo:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.amount_value_item}}',
                        iban:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.ir960640011300700763020001}}',
                        cardNo:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.card_number_message}}',
                        balance:
                            '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.rial_description}}',
                      ),
                    ],
                  ),
                ),
              ),
              StacSizedBox(height: 16),
              _buildPayButtonInSheet(
                onPressed: _showPaymentConfirmDialogAction(
                  paymentMethod:
                      '{{appStrings.profile.real.destinations.tabDeposit}}',
                ),
              ),
            ],
          ),
        ),
      ),
    ).toJson(),
  );
}

StacAction _showPaymentConfirmDialogAction({required String paymentMethod}) {
  return StacShowDialogAction(
    barrierDismissible: true,
    barrierColor: '#8B63708C',
    dialog: _buildPaymentConfirmDialog(paymentMethod: paymentMethod).toJson(),
  );
}

StacWidget _buildPaymentConfirmDialog({required String paymentMethod}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(18),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 18, right: 16, bottom: 16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacImage(
              src: 'assets/icons/ic_warning_red.svg',
              imageType: StacImageType.asset,
              width: 56,
              height: 56,
            ),
          ),
          StacSizedBox(height: 18),
          StacText(
            data:
                '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.payment}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
              height: 1.6,
            ),
          ),
          StacSizedBox(height: 18),
          StacRow(
            textDirection: StacTextDirection.rtl,
            children: [
              StacExpanded(
                child: StacFilledButton(
                  onPressed: StacSequenceAction(
                    actions: [
                      const StacCloseDialogAction(),
                      _navigateToValidationReceiptAction(
                        paymentMethod: paymentMethod,
                      ),
                    ],
                  ),
                  style: StacButtonStyle(
                    fixedSize: StacSize(999999, 54),
                    backgroundColor:
                        '{{appColors.current.button.primary.backgroundColor}}',
                    foregroundColor:
                        '{{appColors.current.button.primary.foregroundColor}}',
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                    elevation: 0,
                  ),
                  child: StacText(
                    data: '{{appStrings.common.confirm}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color:
                          '{{appColors.current.button.primary.foregroundColor}}',
                    ),
                  ),
                ),
              ),
              StacSizedBox(width: 12),
              StacExpanded(
                child: StacOutlinedButton(
                  onPressed: const StacCloseDialogAction(),
                  style: StacButtonStyle(
                    fixedSize: StacSize(999999, 54),
                    side: StacBorderSide(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 1.2,
                    ),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                  ),
                  child: StacText(
                    data:
                        '{{appStrings.generated.user_credit_validation.user_credit_validation_intro.cancel}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

StacAction _navigateToValidationReceiptAction({required String paymentMethod}) {
  return NavigationAction(
    fileName: 'user_credit_validation_receipt',
    navMode: NavModes.dart,
    navigationStyle: NavigationStyle.push,
  );
}

StacWidget _buildDepositOptionCard({
  required String selectedKey,
  required StacAction onTap,
  required String title,
  required String depositNo,
  required String iban,
  required String cardNo,
  required String balance,
}) {
  final content = StacContainer(
    padding: StacEdgeInsets.all(12),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          crossAxisAlignment: StacCrossAxisAlignment.start,
          textDirection: StacTextDirection.rtl,
          children: [
            StacContainer(
              width: 20,
              height: 20,
              decoration: StacBoxDecoration(
                shape: StacBoxShape.circle,
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacCustomVisibility(
                visible: '[[$selectedKey]]',
                child: StacCenter(
                  child: StacContainer(
                    width: 10,
                    height: 10,
                    decoration: StacBoxDecoration(
                      shape: StacBoxShape.circle,
                      color: '#20C4D8',
                    ),
                  ),
                ).toJson(),
                replacement: StacSizedBox().toJson(),
              ),
            ),
            StacSizedBox(width: 10),
            StacExpanded(
              child: StacText(
                data: title,
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
          ],
        ),
        StacSizedBox(height: 12),
        _buildDepositMetaRow(
          label:
              '{{appStrings.generated.card_management.card_management_root.deposit_number}}',
          value: depositNo,
        ),
        StacSizedBox(height: 8),
        _buildDepositMetaRow(
          label:
              '{{appStrings.generated.deposit_more_options.deposit_more_options_intro.iban_number}}',
          value: iban,
        ),
        StacSizedBox(height: 8),
        _buildDepositMetaRow(
          label: '{{appStrings.profile.real.destinations.cardNumberLabel}}',
          value: cardNo,
        ),
        StacContainer(
          margin: StacEdgeInsets.only(top: 10, bottom: 10),
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacText(
              data: '{{appStrings.homePage.cards.balance}}',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
            StacSizedBox(width: 8),
            StacText(
              data: balance,
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '#13A780',
              ),
            ),
          ],
        ),
      ],
    ),
  );

  return StacGestureDetector(
    onTap: onTap,
    child: StacCustomVisibility(
      visible: '[[$selectedKey]]',
      child: StacContainer(
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surfaceContainerHigh}}',
          borderRadius: StacBorderRadius.all(12),
          border: StacBorder.all(color: '#20C4D8', width: 1),
        ),
        child: content,
      ).toJson(),
      replacement: StacContainer(
        decoration: StacBoxDecoration(
          color: 'transparent',
          borderRadius: StacBorderRadius.all(12),
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        child: content,
      ).toJson(),
    ),
  );
}

StacWidget _buildDepositMetaRow({
  required String label,
  required String value,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacText(
        data: label,
        textDirection: StacTextDirection.rtl,
        style: StacTextStyle(
          fontSize: 13,
          fontWeight: StacFontWeight.w500,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacSizedBox(width: 8),
      StacExpanded(
        child: StacText(
          data: value,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.left,
          style: StacTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
    ],
  );
}

StacWidget _buildPaymentMethodRow({
  required String selectedKey,
  required String title,
  required String amount,
  required String iconPath,
}) {
  final row = StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 19),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      textDirection: StacTextDirection.rtl,
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          children: [
            StacImage(
              src: iconPath,
              imageType: StacImageType.asset,
              width: 24,
              height: 24,
            ),
            StacSizedBox(width: 10),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
        StacText(
          data: amount,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );

  return StacCustomVisibility(
    visible: '[[$selectedKey]]',
    child: StacContainer(
      decoration: StacBoxDecoration(
        color: '{{appColors.current.background.surfaceContainerHigh}}',
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(color: '#20C4D8', width: 1),
      ),
      child: row,
    ).toJson(),
    replacement: StacContainer(
      decoration: StacBoxDecoration(
        color: 'transparent',
        borderRadius: StacBorderRadius.all(10),
        border: StacBorder.all(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: row,
    ).toJson(),
  );
}

StacWidget _buildIconBox(String iconPath) {
  return StacContainer(
    width: 52,
    height: 52,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder(
        width: 1,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
    ),
    child: StacCenter(
      child: StacImage(
        src: iconPath,
        imageType: StacImageType.asset,
        width: 30,
        height: 30,
      ),
    ),
  );
}
