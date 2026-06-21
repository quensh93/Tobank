import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

@StacScreen(screenName: 'marriage_loan_customer_document')
StacWidget marriageLoanCustomerDocumentScreen() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'marriageLoanNoSmartNationalCard', 'value': false},
        {'key': 'marriageLoanPaperTrackingCode', 'value': ''},
        {'key': 'marriageLoanDoc1HasImage', 'value': false},
        {'key': 'marriageLoanDoc2HasImage', 'value': false},
        {'key': 'marriageLoanDoc3HasImage', 'value': false},
        {'key': 'marriageLoanDoc4HasImage', 'value': false},
        {'key': 'marriageLoanDoc5HasImage', 'value': false},
        {'key': 'marriageLoanDocNextEnabled', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title:
            '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.title}}',
        showBack: true,
        showSupport: true,
        titleStyle: StacTextStyle(
          fontSize: 13,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      body: StacForm(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    _title(
                      '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.upload_title}}',
                    ),
                    StacSizedBox(height: 14),
                    StacText(
                      data:
                          '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.upload_description}}',
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
                    _noSmartNationalCardToggle(),
                    StacRawJsonWidget({
                      'type': 'visibility',
                      'visible': '[[marriageLoanNoSmartNationalCard]]',
                      'child': StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          StacSizedBox(height: 20),
                          _paperTrackingCodeSection(),
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 20),
                    _documentPickerCard(
                      title:
                          '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.birth_certificate_page_1_2}}',
                      hasImageKey: 'marriageLoanDoc1HasImage',
                      imageKey: 'marriageLoanDoc1Image',
                      imageNameKey: 'marriageLoanDoc1ImageName',
                    ),
                    StacSizedBox(height: 16),
                    _documentPickerCard(
                      title:
                          '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.birth_certificate_page_3_4}}',
                      hasImageKey: 'marriageLoanDoc2HasImage',
                      imageKey: 'marriageLoanDoc2Image',
                      imageNameKey: 'marriageLoanDoc2ImageName',
                    ),
                    StacSizedBox(height: 16),
                    _documentPickerCard(
                      title:
                          '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.birth_certificate_page_5_6}}',
                      hasImageKey: 'marriageLoanDoc3HasImage',
                      imageKey: 'marriageLoanDoc3Image',
                      imageNameKey: 'marriageLoanDoc3ImageName',
                    ),
                    StacSizedBox(height: 16),
                    StacRawJsonWidget({
                      'type': 'visibility',
                      'visible': '[[!marriageLoanNoSmartNationalCard]]',
                      'child': StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          _documentPickerCard(
                            title:
                                '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.national_card_front}}',
                            hasImageKey: 'marriageLoanDoc4HasImage',
                            imageKey: 'marriageLoanDoc4Image',
                            imageNameKey: 'marriageLoanDoc4ImageName',
                          ),
                          StacSizedBox(height: 16),
                          _documentPickerCard(
                            title:
                                '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.national_card_back}}',
                            hasImageKey: 'marriageLoanDoc5HasImage',
                            imageKey: 'marriageLoanDoc5Image',
                            imageNameKey: 'marriageLoanDoc5ImageName',
                          ),
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 24),
                  ],
                ),
              ),
            ),
            StacPadding(
              padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: _submitButton(),
            ),
          ],
        ),
      ),
    ),
  );
}

StacWidget _title(String text) {
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

StacWidget _noSmartNationalCardToggle() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: [
      StacText(
        data:
            '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.no_smart_national_card}}',
        textDirection: StacTextDirection.rtl,
        style: StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacRawJsonWidget({
        'type': 'reactiveSwitch',
        'valueKey': 'marriageLoanNoSmartNationalCard',
        'onChanged': {
          'actionType': 'sequence',
          'actions': [
            {
              'actionType': 'setValue',
              'values': [
                {'key': 'marriageLoanDoc4HasImage', 'value': false},
                {'key': 'marriageLoanDoc5HasImage', 'value': false},
                {'key': 'marriageLoanDoc4Image', 'value': ''},
                {'key': 'marriageLoanDoc5Image', 'value': ''},
                {'key': 'marriageLoanPaperTrackingCode', 'value': ''},
              ],
            },
            _updateSubmitEnabledAction().toJson(),
          ],
        },
      }),
    ],
  );
}

StacWidget _paperTrackingCodeSection() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data:
            '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.paper_tracking_code_title}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 8),
      StacCustomTextFormField(
        id: 'marriage_loan_paper_tracking_code',
        textDirection: 'ltr',
        textAlign: 'right',
        supportTextDirection: 'rtl',
        maxLength: 10,
        inputFormatters: const [
          {'type': 'allow', 'rule': '[0-9]'},
        ],
        decoration: {
          'hintText':
              '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.paper_tracking_code_hint}}',
          'hintStyle': StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.hint}}',
          ).toJson(),
          'counterText': '',
          'contentPadding': {'horizontal': 16, 'vertical': 14},
        },
        style: StacTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ).toJson(),
        keyboardType: 'number',
        onChanged: const StacCustomSetValueAction(
          key: 'marriageLoanPaperTrackingCode',
          value: '{{form.marriage_loan_paper_tracking_code}}',
        ),
      ),
    ],
  );
}

StacWidget _documentPickerCard({
  required String title,
  required String hasImageKey,
  required String imageKey,
  required String imageNameKey,
}) {
  return StacContainer(
    clipBehavior: StacClip.antiAlias,
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
        StacContainer(
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainerLowest}}',
            borderRadius: StacBorderRadius.only(topLeft: 10, topRight: 10),
          ),
          padding: StacEdgeInsets.all(16),
          child: StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
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
                'visible': '[[$hasImageKey]]',
                'child': _uploadedDocumentRow(
                  hasImageKey: hasImageKey,
                  imageKey: imageKey,
                ).toJson(),
              }),
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '[[!$hasImageKey]]',
                'child': _documentSourceRow(
                  hasImageKey: hasImageKey,
                  imageKey: imageKey,
                  imageNameKey: imageNameKey,
                ).toJson(),
              }),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _documentSourceRow({
  required String hasImageKey,
  required String imageKey,
  required String imageNameKey,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceEvenly,
    children: [
      _pickerAction(
        title: '{{appStrings.authentication.cameraLabel}}',
        iconPath: '{{appAssets.icons.cameraCurrent}}',
        source: 'camera',
        hasImageKey: hasImageKey,
        imageKey: imageKey,
        imageNameKey: imageNameKey,
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
        hasImageKey: hasImageKey,
        imageKey: imageKey,
        imageNameKey: imageNameKey,
      ),
    ],
  );
}

StacWidget _pickerAction({
  required String title,
  required String iconPath,
  required String source,
  required String hasImageKey,
  required String imageKey,
  required String imageNameKey,
}) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacFilePickerAction(
          fileType: 'image',
          targetKey: imageKey,
          hasValueKey: hasImageKey,
          fileNameKey: imageNameKey,
          source: source,
          cropImage: true,
          cropMaxWidth: 1000,
          cropMaxHeight: 1000,
          cropCompressQuality: 80,
        ),
        _updateSubmitEnabledAction(),
      ],
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      children: [
        StacContainer(
          width: 34,
          height: 34,
          decoration: StacBoxDecoration(
            color: source == 'camera'
                ? '{{appColors.current.error.withOpacity(0.1)}}'
                : '{{appColors.current.secondary.withOpacity(0.1)}}',
            borderRadius: StacBorderRadius.all(8),
            border: StacBorder.all(
              color: source == 'camera'
                  ? '{{appColors.current.error}}'
                  : '{{appColors.current.secondary}}',
              width: 2,
            ),
          ),
          child: StacCenter(
            child: StacImage(
              src: iconPath,
              imageType: StacImageType.asset,
              width: 31,
              height: 31,
              color: source == 'camera'
                  ? '{{appColors.current.error}}'
                  : '{{appColors.current.secondary}}',
            ),
          ),
        ),
        StacSizedBox(width: 10),
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _uploadedDocumentRow({
  required String hasImageKey,
  required String imageKey,
}) {
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
              'src': '{{$imageKey}}',
              'registryKey': imageKey,
              'fit': 'cover',
              'width': 56,
              'height': 56,
            }),
          ),
          StacSizedBox(width: 10),
          _uploadSuccessChip(),
        ],
      ),
      _deleteDocumentButton(hasImageKey: hasImageKey, imageKey: imageKey),
    ],
  );
}

StacWidget _uploadSuccessChip() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.secondary.secondaryContainer}}',
      borderRadius: StacBorderRadius.all(8),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisSize: StacMainAxisSize.min,
      children: [
        StacContainer(
          width: 14,
          height: 14,
          decoration: StacBoxDecoration(
            color: '{{appColors.current.secondary.color}}',
            borderRadius: StacBorderRadius.all(999),
          ),
        ),
        StacSizedBox(width: 6),
        StacText(
          data:
              '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.upload_success}}',
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.secondary.color}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _deleteDocumentButton({
  required String hasImageKey,
  required String imageKey,
}) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': imageKey, 'value': ''},
            {'key': hasImageKey, 'value': false},
          ],
        ),
        _updateSubmitEnabledAction(),
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
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacCustomSetValueAction _updateSubmitEnabledAction() {
  return const StacCustomSetValueAction(
    values: [
      {'key': 'marriageLoanDocNextEnabled', 'value': false},
      {
        'key': 'marriageLoanDocNextEnabled',
        'value': true,
        'condition':
            '!marriageLoanNoSmartNationalCard && marriageLoanDoc1HasImage && marriageLoanDoc2HasImage && marriageLoanDoc3HasImage && marriageLoanDoc4HasImage && marriageLoanDoc5HasImage',
      },
      {
        'key': 'marriageLoanDocNextEnabled',
        'value': true,
        'condition':
            'marriageLoanNoSmartNationalCard && marriageLoanDoc1HasImage && marriageLoanDoc2HasImage && marriageLoanDoc3HasImage',
      },
    ],
  );
}

StacWidget _submitButton() {
  return StacCustomReactiveElevatedButton(
    enabledKey: 'marriageLoanDocNextEnabled',
    onPressed: const StacFingerPrintAction(
      title: 'احراز هویت',
      description: 'برای ثبت مدارک متقاضی احراز هویت کنید',
      onSuccess: {
        'actionType': 'sequence',
        'actions': [
          {
            'actionType': 'setValue',
            'key': 'marriageLoanTaskSpouseFlowCompleted',
            'value': true,
          },
          {
            'actionType': 'customSnackBar',
            'title': 'ثبت مدارک',
            'detail': 'مدارک متقاضی با موفقیت ثبت شد',
            'duration': 1800,
          },
          {'actionType': 'navigate', 'navigationStyle': 'pop'},
        ],
      },
    ).toJson(),
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 56),
      backgroundColor: '{{appColors.current.primary.color}}',
      disabledBackgroundColor: '{{appColors.current.input.borderEnabled}}',
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(14)),
    ).toJson(),
    child: StacText(
      data:
          '{{appStrings.generated.marriage_loan.marriage_loan_customer_document.submit}}',
      textDirection: StacTextDirection.rtl,
      style: StacTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w700,
        color: '#FFFFFF',
      ),
    ).toJson(),
  );
}
