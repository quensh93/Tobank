import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

@StacScreen(screenName: 'marriage_loan_marriage_license')
StacWidget marriageLoanMarriageLicenseScreen() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'marriageLoanLicenseIsSinglePage', 'value': true},
        {'key': 'marriageLoanLicenseDoc1HasImage', 'value': false},
        {'key': 'marriageLoanLicenseDoc2HasImage', 'value': false},
        {'key': 'marriageLoanLicenseDoc3HasImage', 'value': false},
        {'key': 'marriageLoanLicenseDoc4HasImage', 'value': false},
        {'key': 'marriageLoanLicenseDoc5HasImage', 'value': false},
        {'key': 'marriageLoanLicenseNextEnabled', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title:
            '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.title}}',
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
                      '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.title}}',
                    ),
                    StacSizedBox(height: 16),
                    StacText(
                      data:
                          '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.description}}',
                      textDirection: StacTextDirection.rtl,
                      textAlign: StacTextAlign.right,
                      style: StacTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w500,
                        height: 1.7,
                        color: '{{appColors.current.text.subtitle}}',
                      ),
                    ),
                    StacSizedBox(height: 16),
                    _title(
                      '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.type_title}}',
                    ),
                    StacSizedBox(height: 8),
                    _licenseTypeSelector(),
                    StacSizedBox(height: 16),
                    StacRawJsonWidget({
                      'type': 'visibility',
                      'visible': '[[marriageLoanLicenseIsSinglePage]]',
                      'child': StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          _documentPickerCard(
                            title:
                                '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.front_page}}',
                            hasImageKey: 'marriageLoanLicenseDoc1HasImage',
                            imageKey: 'marriageLoanLicenseDoc1Image',
                            imageNameKey: 'marriageLoanLicenseDoc1ImageName',
                          ),
                          StacSizedBox(height: 16),
                          _documentPickerCard(
                            title:
                                '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.back_page}}',
                            hasImageKey: 'marriageLoanLicenseDoc2HasImage',
                            imageKey: 'marriageLoanLicenseDoc2Image',
                            imageNameKey: 'marriageLoanLicenseDoc2ImageName',
                          ),
                        ],
                      ).toJson(),
                    }),
                    StacRawJsonWidget({
                      'type': 'visibility',
                      'visible': '[[!marriageLoanLicenseIsSinglePage]]',
                      'child': StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.stretch,
                        children: [
                          _documentPickerCard(
                            title:
                                '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.second_third_pages}}',
                            hasImageKey: 'marriageLoanLicenseDoc3HasImage',
                            imageKey: 'marriageLoanLicenseDoc3Image',
                            imageNameKey: 'marriageLoanLicenseDoc3ImageName',
                          ),
                          StacSizedBox(height: 16),
                          _documentPickerCard(
                            title:
                                '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.fourth_fifth_pages}}',
                            hasImageKey: 'marriageLoanLicenseDoc4HasImage',
                            imageKey: 'marriageLoanLicenseDoc4Image',
                            imageNameKey: 'marriageLoanLicenseDoc4ImageName',
                          ),
                          StacSizedBox(height: 16),
                          _documentPickerCard(
                            title:
                                '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.notary_information}}',
                            hasImageKey: 'marriageLoanLicenseDoc5HasImage',
                            imageKey: 'marriageLoanLicenseDoc5Image',
                            imageNameKey: 'marriageLoanLicenseDoc5ImageName',
                          ),
                        ],
                      ).toJson(),
                    }),
                    StacSizedBox(height: 40),
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

StacWidget _licenseTypeSelector() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacExpanded(
        child: _licenseTypeOption(
          title:
              '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.single_page}}',
          isSelected: '[[marriageLoanLicenseIsSinglePage]]',
          value: true,
        ),
      ),
      StacSizedBox(width: 8),
      StacExpanded(
        child: _licenseTypeOption(
          title:
              '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.booklet}}',
          isSelected: '[[!marriageLoanLicenseIsSinglePage]]',
          value: false,
        ),
      ),
    ],
  );
}

StacWidget _licenseTypeOption({
  required String title,
  required String isSelected,
  required bool value,
}) {
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'marriageLoanLicenseIsSinglePage', 'value': value},
            {'key': 'marriageLoanLicenseDoc1HasImage', 'value': false},
            {'key': 'marriageLoanLicenseDoc2HasImage', 'value': false},
            {'key': 'marriageLoanLicenseDoc3HasImage', 'value': false},
            {'key': 'marriageLoanLicenseDoc4HasImage', 'value': false},
            {'key': 'marriageLoanLicenseDoc5HasImage', 'value': false},
            {'key': 'marriageLoanLicenseNextEnabled', 'value': false},
          ],
        ),
      ],
    ),
    child: StacContainer(
      padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 15),
      decoration: StacBoxDecoration(
        borderRadius: StacBorderRadius.all(8),
        border: StacBorder.all(
          color:
              '{{${isSelected.substring(2, isSelected.length - 2)} ? "#000000" : appColors.current.input.borderEnabled}}',
          width: 1,
        ),
      ),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
        children: [
          StacContainer(
            width: 24,
            height: 24,
            decoration: StacBoxDecoration(
              borderRadius: StacBorderRadius.all(999),
              border: StacBorder.all(color: '#000000', width: 2),
            ),
            child: StacCenter(
              child: StacCustomOpacity(
                opacity:
                    '{{${isSelected.substring(2, isSelected.length - 2)} ? 1.0 : 0.0}}',
                child: StacContainer(
                  width: 12,
                  height: 12,
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.text.title}}',
                    borderRadius: StacBorderRadius.all(999),
                  ),
                ).toJson(),
              ),
            ),
          ),
          StacSizedBox(width: 7),
          StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            style: StacTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ],
      ),
    ),
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
        StacContainer(
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surface}}',
            borderRadius: StacBorderRadius.only(
              bottomLeft: 10,
              bottomRight: 10,
            ),
          ),
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
              '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.upload_success}}',
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
      {'key': 'marriageLoanLicenseNextEnabled', 'value': false},
      {
        'key': 'marriageLoanLicenseNextEnabled',
        'value': true,
        'condition':
            'marriageLoanLicenseIsSinglePage && marriageLoanLicenseDoc1HasImage && marriageLoanLicenseDoc2HasImage',
      },
      {
        'key': 'marriageLoanLicenseNextEnabled',
        'value': true,
        'condition':
            '!marriageLoanLicenseIsSinglePage && marriageLoanLicenseDoc3HasImage && marriageLoanLicenseDoc4HasImage && marriageLoanLicenseDoc5HasImage',
      },
    ],
  );
}

StacWidget _submitButton() {
  return StacCustomReactiveElevatedButton(
    enabledKey: 'marriageLoanLicenseNextEnabled',
    onPressed: const StacFingerPrintAction(
      title: 'احراز هویت',
      description: 'برای ثبت اطلاعات عقدنامه احراز هویت کنید',
      onSuccess: {
        'actionType': 'sequence',
        'actions': [
          {
            'actionType': 'setValue',
            'key': 'marriageLoanTaskMarriageLicenseCompleted',
            'value': true,
          },
          {
            'actionType': 'customSnackBar',
            'title': 'ثبت مدارک',
            'detail': 'اطلاعات عقدنامه با موفقیت ثبت شد',
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
          '{{appStrings.generated.marriage_loan.marriage_loan_marriage_license.submit}}',
      textDirection: StacTextDirection.rtl,
      style: StacTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w700,
        color: '#FFFFFF',
      ),
    ).toJson(),
  );
}
