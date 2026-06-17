import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'child_loan_guarantee_address')
StacWidget childLoanGuaranteeAddressScreen() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'childLoanPostalInquiryEnabled', 'value': false},
        {'key': 'childLoanPostalInquirySuccess', 'value': false},
        {'key': 'childLoanOwnershipExpanded', 'value': false},
        {'key': 'childLoanOwnershipHasValue', 'value': false},
        {'key': 'childLoanOwnershipValue', 'value': ''},
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title:
            '{{appStrings.generated.child_loan.child_loan_customer_check.title}}',
        showBack: true,
        showSupport: true,
      ),
      body: StacForm(
        child: StacSingleChildScrollView(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacText(
                data:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.title}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacTextStyle(
                  fontSize: 20,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 16),
              StacText(
                data:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.upload_information_image_user_place}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w500,
                  height: 1.7,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacSizedBox(height: 20),
              StacText(
                data:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.postal_code_place}}',
                textDirection: StacTextDirection.rtl,
                textAlign: StacTextAlign.right,
                style: StacTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 8),
              StacRow(
                textDirection: StacTextDirection.rtl,
                crossAxisAlignment: StacCrossAxisAlignment.center,
                children: [
                  StacExpanded(
                    child: StacSizedBox(
                      height: 58,
                      child: StacRawJsonWidget({
                        'type': 'textFormField',
                        'id': 'child_loan_guarantee_postal_code',
                        'keyboardType': 'number',
                        'maxLength': 10,
                        'inputFormatters': const [
                          {'type': 'allow', 'rule': '[0-9۰-۹]'},
                        ],
                        'onChanged': const StacValidateFieldsAction(
                          resultKey: 'childLoanPostalInquiryEnabled',
                          fields: [
                            {
                              'id': 'child_loan_guarantee_postal_code',
                              'rule': r'^[0-9۰-۹]{10}$',
                            },
                          ],
                        ).toJson(),
                        'supportTextDirection': 'ltr',
                        'textDirection': 'ltr',
                        'textAlign': 'center',
                        'textAlignVertical': 'center',
                        'decoration': {
                          'hintText':
                              '{{appStrings.generated.child_loan.child_loan_guarantee_address.postal_code_place_enter}}',
                          'hintTextDirection': 'rtl',
                          'hintTextAlign': 'center',
                          'counterText': '',
                          'isDense': true,
                          'contentPadding': {
                            'left': 12,
                            'top': 0,
                            'right': 12,
                            'bottom': 0,
                          },
                          'enabledBorder': {
                            'type': 'outlineInputBorder',
                            'borderSide': {
                              'color':
                                  '{{appColors.current.input.borderEnabled}}',
                              'width': 1.0,
                            },
                            'borderRadius': {'all': 6},
                          },
                          'focusedBorder': {
                            'type': 'outlineInputBorder',
                            'borderSide': {
                              'color':
                                  '{{appColors.current.input.borderEnabled}}',
                              'width': 1.0,
                            },
                            'borderRadius': {'all': 6},
                          },
                        },
                        'style': const {
                          'fontSize': 20,
                          'fontWeight': 'w600',
                          'color': '{{appColors.current.text.title}}',
                        },
                      }),
                    ),
                  ),
                  StacSizedBox(width: 12),
                  StacSizedBox(
                    width: 110,
                    height: 58,
                    child: StacCustomReactiveElevatedButton(
                      enabledKey: 'childLoanPostalInquiryEnabled',
                      onPressed: const StacCustomSetValueAction(
                        key: 'childLoanPostalInquirySuccess',
                        value: true,
                      ),
                      style: StacButtonStyle(
                        backgroundColor: '{{appColors.current.primary.color}}',
                        foregroundColor: '#FFFFFF',
                        shape: StacRoundedRectangleBorder(
                          borderRadius: StacBorderRadius.all(8),
                        ),
                        elevation: 0,
                      ).toJson(),
                      child: StacText(
                        data:
                            '{{appStrings.profile.real.bankInfo.inquiryButtonText}}',
                        style: StacTextStyle(
                          fontSize: 16,
                          fontWeight: StacFontWeight.w700,
                          color: '#FFFFFF',
                        ),
                      ).toJson(),
                    ),
                  ),
                ],
              ),
              _inquiryResultSection(),
            ],
          ),
        ),
      ),
    ),
  );
}

StacWidget _inquiryResultSection() {
  return StacCustomVisibility(
    visible: '[[childLoanPostalInquirySuccess]]',
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacSizedBox(height: 16),
        StacContainer(
          padding: StacEdgeInsets.all(16),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainer}}',
            borderRadius: StacBorderRadius.all(10),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              _resultFieldLabel(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.province}}',
              ),
              StacSizedBox(height: 8),
              _readOnlyField(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.sample_city}}',
              ),
              StacSizedBox(height: 16),
              _resultFieldLabel(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.city}}',
              ),
              StacSizedBox(height: 8),
              _readOnlyField(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.sample_city}}',
              ),
              StacSizedBox(height: 16),
              _resultFieldLabel(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.county}}',
              ),
              StacSizedBox(height: 8),
              _readOnlyField(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.sample_city}}',
              ),
              StacSizedBox(height: 16),
              _resultFieldLabel(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.street_main}}',
              ),
              StacSizedBox(height: 8),
              _editableField(
                id: 'child_loan_main_street',
                hint:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.street_main_enter}}',
                initialValue:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.street_city}}',
                showClearIcon: true,
              ),
              StacSizedBox(height: 16),
              _resultFieldLabel(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.street}}',
              ),
              StacSizedBox(height: 8),
              _editableField(
                id: 'child_loan_secondary_street',
                hint:
                    '{{appStrings.generated.deposit_more_options.deposit_card_issue_address.street_enter}}',
                initialValue:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.street_message}}',
                showClearIcon: true,
              ),
              StacSizedBox(height: 16),
              _resultFieldLabel(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.plaque}}',
              ),
              StacSizedBox(height: 8),
              _editableField(
                id: 'child_loan_plaque',
                hint:
                    '{{appStrings.generated.deposit_more_options.deposit_card_issue_address.plaque_enter}}',
                initialValue:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.number_value}}',
                showClearIcon: true,
              ),
              StacSizedBox(height: 16),
              _resultFieldLabel(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.unit}}',
              ),
              StacSizedBox(height: 8),
              _editableField(
                id: 'child_loan_unit',
                hint:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.unit_enter_message}}',
                initialValue:
                    '{{appStrings.generated.child_loan.child_loan_guarantee_address.number_value_text}}',
                showClearIcon: true,
              ),
              StacSizedBox(height: 16),
              _resultFieldLabel(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.ownership_type_label}}',
              ),
              StacSizedBox(height: 8),
              _ownershipSelectorField(),
              StacSizedBox(height: 16),
              _documentPickerCard(),
            ],
          ),
        ),
        StacSizedBox(height: 16),
        StacCustomReactiveElevatedButton(
          enabledKey: 'childLoanPostalInquirySuccess',
          onPressed: const StacFingerPrintAction(
            title: '{{appStrings.menu.items.authentication}}',
            description:
                '{{appStrings.generated.child_loan.child_loan_child_check.continue}}',
            onSuccess: {
              'actionType': 'sequence',
              'actions': [
                {
                  'actionType': 'setValue',
                  'key': 'childLoanTaskResidenceCompleted',
                  'value': true,
                },
                {
                  'actionType': 'snackbar',
                  'title':
                      '{{appStrings.profile.real.destinations.submitTitle}}',
                  'detail':
                      '{{appStrings.generated.child_loan.child_loan_child_check.successfully_submit}}',
                  'duration': 1800,
                },
                {'actionType': 'navigate', 'navigationStyle': 'pop'},
              ],
            },
          ).toJson(),
          style: StacButtonStyle(
            fixedSize: StacSize(999999, 56),
            backgroundColor: '{{appColors.current.primary.color}}',
            shape: StacRoundedRectangleBorder(
              borderRadius: StacBorderRadius.all(12),
            ),
          ).toJson(),
          child: StacText(
            data: '{{appStrings.profile.real.destinations.submitTitle}}',
            textDirection: StacTextDirection.rtl,
            style: StacTextStyle(
              fontSize: 20,
              fontWeight: StacFontWeight.w700,
              color: '#FFFFFF',
            ),
          ).toJson(),
        ),
      ],
    ).toJson(),
  );
}

StacWidget _resultFieldLabel(String text) {
  return StacText(
    data: text,
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacTextStyle(
      fontSize: 18,
      fontWeight: StacFontWeight.w700,
      color: '{{appColors.current.text.title}}',
    ),
  );
}

StacWidget _readOnlyField(String value) {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 16),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacText(
      data: value,
      textDirection: StacTextDirection.rtl,
      textAlign: StacTextAlign.right,
      style: StacTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w600,
        color: '{{appColors.current.text.subtitle}}',
      ),
    ),
  );
}

StacWidget _editableField({
  required String id,
  required String hint,
  String? initialValue,
  bool showClearIcon = false,
}) {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 2),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacExpanded(
          child: StacCustomTextFormField(
            id: id,
            initialValue: initialValue,
            textDirection: 'rtl',
            textAlign: 'right',
            decoration: {
              'hintText': hint,
              'hintStyle': {
                'fontSize': 14,
                'fontWeight': 'w500',
                'color': '{{appColors.current.text.subtitle}}',
              },
              'counterText': '',
              'border': {'type': 'none'},
              'enabledBorder': {'type': 'none'},
              'focusedBorder': {'type': 'none'},
              'contentPadding': {
                'left': 0,
                'top': 14,
                'right': 0,
                'bottom': 14,
              },
            },
            style: const {
              'fontSize': 16,
              'fontWeight': 'w600',
              'color': '{{appColors.current.text.title}}',
            },
          ),
        ),
        if (showClearIcon) ...[
          StacSizedBox(width: 8),
          StacGestureDetector(
            onTap: StacCustomSetValueAction(key: id, value: ''),
            child: StacImage(
              src: 'assets/icons/ic_close.svg',
              imageType: StacImageType.asset,
              width: 18,
              height: 18,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ],
      ],
    ),
  );
}

StacWidget _ownershipSelectorField() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacGestureDetector(
        onTap: const StacCustomSetValueAction(
          key: 'childLoanOwnershipExpanded',
          value: true,
        ),
        child: StacContainer(
          padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 16),
          decoration: StacBoxDecoration(
            borderRadius: StacBorderRadius.all(10),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '[[!childLoanOwnershipHasValue]]',
                'child': StacText(
                  data:
                      '{{appStrings.generated.child_loan.child_loan_guarantee_address.select}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ).toJson(),
              }),
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '[[childLoanOwnershipHasValue]]',
                'child': StacText(
                  data: '{{childLoanOwnershipValue}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ).toJson(),
              }),
              StacImage(
                src: '{{appAssets.icons.arrowCircleDown}}',
                imageType: StacImageType.asset,
                width: 20,
                height: 20,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ],
          ),
        ),
      ),
      StacRawJsonWidget({
        'type': 'visibility',
        'visible': '[[childLoanOwnershipExpanded]]',
        'child': StacContainer(
          margin: StacEdgeInsets.only(top: 2),
          padding: StacEdgeInsets.symmetric(vertical: 8),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainer}}',
            borderRadius: StacBorderRadius.all(8),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              _ownershipOption(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.owner_option}}',
              ),
              _ownershipOption(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.rental_option}}',
              ),
              _ownershipOption(
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.other_option}}',
              ),
            ],
          ),
        ).toJson(),
      }),
    ],
  );
}

StacWidget _ownershipOption(String title) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(key: 'childLoanOwnershipValue', value: title),
        const StacCustomSetValueAction(
          key: 'childLoanOwnershipHasValue',
          value: true,
        ),
        const StacCustomSetValueAction(
          key: 'childLoanOwnershipExpanded',
          value: false,
        ),
      ],
    ),
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 14),
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
  );
}

StacWidget _documentPickerCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacText(
            data:
                '{{appStrings.generated.child_loan.child_loan_guarantee_address.image_place}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        StacContainer(
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
        StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '[[!childLoanResidenceDocumentHasImage]]',
                'child': _documentSourceRow().toJson(),
              }),
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '[[childLoanResidenceDocumentHasImage]]',
                'child': _uploadedDocumentRow().toJson(),
              }),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _documentSourceRow() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceEvenly,
    children: [
      _pickerAction(
        title: '{{appStrings.authentication.cameraLabel}}',
        iconPath: '{{appAssets.icons.cameraCurrent}}',
        source: 'camera',
      ),
      StacContainer(
        width: 1,
        height: 28,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
      _pickerAction(
        title: '{{appStrings.authentication.galleryLabel}}',
        iconPath: '{{appAssets.icons.galleryCurrent}}',
        source: 'gallery',
      ),
    ],
  );
}

StacWidget _uploadedDocumentRow() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      StacRow(
        textDirection: StacTextDirection.rtl,
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        children: [
          StacClipRRect(
            borderRadius: StacBorderRadius.all(2),
            child: StacRawJsonWidget({
              'type': 'image',
              'src': '{{childLoanResidenceDocumentImage}}',
              'registryKey': 'childLoanResidenceDocumentImage',
              'fit': 'cover',
              'width': 48,
              'height': 48,
            }),
          ),
          StacSizedBox(width: 10),
          _uploadSuccessChip(),
        ],
      ),
      _deleteDocumentButton(),
    ],
  );
}

StacWidget _uploadSuccessChip() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.secondary.secondaryContainer}}',
      borderRadius: StacBorderRadius.all(6),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisSize: StacMainAxisSize.min,
      children: [
        StacContainer(
          width: 12,
          height: 12,
          decoration: StacBoxDecoration(
            color: '{{appColors.current.secondary.color}}',
            borderRadius: StacBorderRadius.all(999),
          ),
        ),
        StacSizedBox(width: 6),
        StacText(
          data:
              '{{appStrings.generated.child_loan.child_loan_child_check.upload_success}}',
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 12,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.secondary.color}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _deleteDocumentButton() {
  return StacGestureDetector(
    onTap: const StacCustomSetValueAction(
      values: [
        {'key': 'childLoanResidenceDocumentImage', 'value': ''},
        {'key': 'childLoanResidenceDocumentHasImage', 'value': false},
      ],
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisSize: StacMainAxisSize.min,
      children: [
        StacImage(
          src: '{{appAssets.icons.deleteCurrent}}',
          imageType: StacImageType.asset,
          width: 20,
          height: 20,
        ),
        StacSizedBox(width: 6),
        StacText(
          data:
              '{{appStrings.generated.authentication.authentication_selfie.delete}}',
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 13,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _pickerAction({
  required String title,
  required String iconPath,
  required String source,
}) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacFilePickerAction(
          fileType: 'image',
          targetKey: 'childLoanResidenceDocumentImage',
          hasValueKey: 'childLoanResidenceDocumentHasImage',
          fileNameKey: 'childLoanResidenceDocumentImageName',
          source: source,
          cropImage: true,
          cropMaxWidth: 1000,
          cropMaxHeight: 1000,
          cropCompressQuality: 80,
        ),
      ],
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacImage(
          src: iconPath,
          imageType: StacImageType.asset,
          width: 30,
          height: 30,
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
  );
}
