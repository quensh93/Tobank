import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'child_loan_customer_document')
StacWidget childLoanCustomerDocumentScreen() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'childLoanApplicantIsFather', 'value': true},
        {'key': 'childLoanFatherDoc1HasImage', 'value': false},
        {'key': 'childLoanFatherDoc2HasImage', 'value': false},
        {'key': 'childLoanFatherDoc3HasImage', 'value': false},
        {'key': 'childLoanGuardianDoc1HasImage', 'value': false},
        {'key': 'childLoanGuardianDoc2HasImage', 'value': false},
        {'key': 'childLoanGuardianDoc3HasImage', 'value': false},
        {'key': 'childLoanGuardianDoc4HasImage', 'value': false},
        {'key': 'childLoanCustomerDocNextEnabled', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title: 'تسهیلات فرزندآوری',
        showBack: true,
        showSupport: true,
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
                    _title('بارگذاری اطلاعات هویتی متقاضی'),
                    StacSizedBox(height: 14),
                    StacText(
                      data:
                          'کاربر گرامی، لطفا تصویر صفحات شناسنامه درخواست شده را بارگذاری نمایید. توجه کنید تصاویر می‌بایست از اصل شناسنامه متقاضی باشد.',
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
                    _title('نسبت متقاضی با فرزند:'),
                    StacSizedBox(height: 10),
                    _relationshipSelector(),
                    StacRawJsonWidget({
                      'type': 'visibility',
                      'visible': '[[childLoanApplicantIsFather]]',
                      'child': _documentSection(prefix: 'childLoanFather')
                          .toJson(),
                    }),
                    StacRawJsonWidget({
                      'type': 'visibility',
                      'visible': '[[!childLoanApplicantIsFather]]',
                      'child': _documentSection(
                        prefix: 'childLoanGuardian',
                        includeGuardianshipDoc: true,
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

StacWidget _documentSection({
  required String prefix,
  bool includeGuardianshipDoc = false,
}) {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacSizedBox(height: 16),
      _documentPickerCard(
        title: 'صفحه اول و دوم شناسنامه',
        hasImageKey: '${prefix}Doc1HasImage',
        imageKey: '${prefix}Doc1Image',
        imageNameKey: '${prefix}Doc1ImageName',
      ),
      StacSizedBox(height: 16),
      _documentPickerCard(
        title: 'صفحه سوم و چهارم شناسنامه',
        hasImageKey: '${prefix}Doc2HasImage',
        imageKey: '${prefix}Doc2Image',
        imageNameKey: '${prefix}Doc2ImageName',
      ),
      StacSizedBox(height: 16),
      _documentPickerCard(
        title: 'صفحه پنجم و ششم شناسنامه',
        hasImageKey: '${prefix}Doc3HasImage',
        imageKey: '${prefix}Doc3Image',
        imageNameKey: '${prefix}Doc3ImageName',
      ),
      if (includeGuardianshipDoc) ...[
        StacSizedBox(height: 16),
        _documentPickerCard(
          title: 'مدرک قیمومت',
          hasImageKey: '${prefix}Doc4HasImage',
          imageKey: '${prefix}Doc4Image',
          imageNameKey: '${prefix}Doc4ImageName',
        ),
      ],
    ],
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

StacWidget _relationshipSelector() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    children: [
      StacExpanded(child: _relationCard(title: 'پدر', value: true)),
      StacSizedBox(width: 10),
      StacExpanded(child: _relationCard(title: 'قیم قانونی', value: false)),
    ],
  );
}

StacWidget _relationCard({required String title, required bool value}) {
  final String selectedCondition = value
      ? '[[childLoanApplicantIsFather]]'
      : '[[!childLoanApplicantIsFather]]';
  return StacGestureDetector(
    onTap: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'childLoanApplicantIsFather', 'value': value},
          ],
        ),
        _updateSubmitEnabledAction(),
      ],
    ),
    child: StacCustomVisibility(
      visible: selectedCondition,
      child: _relationCardContainer(
        title: title,
        borderColor: '{{appColors.current.primary.color}}',
        dotColor: '{{appColors.current.primary.color}}',
      ).toJson(),
      replacement: _relationCardContainer(
        title: title,
        borderColor: '{{appColors.current.input.borderEnabled}}',
        dotColor: 'transparent',
      ).toJson(),
    ),
  );
}

StacWidget _relationCardContainer({
  required String title,
  required String borderColor,
  required String dotColor,
}) {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(10),
      border: StacBorder.all(
        color: borderColor,
        width: 1.2,
      ),
      color: '{{appColors.current.background.surfaceContainer}}',
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      children: [
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacContainer(
          width: 26,
          height: 26,
          decoration: StacBoxDecoration(
            borderRadius: StacBorderRadius.all(999),
            border: StacBorder.all(
              color: borderColor,
              width: 2,
            ),
          ),
          child: StacCenter(
            child: StacContainer(
              width: 12,
              height: 12,
              decoration: StacBoxDecoration(
                color: dotColor,
                borderRadius: StacBorderRadius.all(999),
              ),
            ),
          ),
        ),
      ],
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
          color: '{{appColors.current.background.surfaceContainerLowest}}',
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
        title: 'دوربین',
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
        title: 'گالری',
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
          data: 'بارگذاری موفق',
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
          data: 'حذف',
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
      {'key': 'childLoanCustomerDocNextEnabled', 'value': false},
      {
        'key': 'childLoanCustomerDocNextEnabled',
        'value': true,
        'condition':
            'childLoanApplicantIsFather && childLoanFatherDoc1HasImage && childLoanFatherDoc2HasImage && childLoanFatherDoc3HasImage',
      },
      {
        'key': 'childLoanCustomerDocNextEnabled',
        'value': true,
        'condition':
            '!childLoanApplicantIsFather && childLoanGuardianDoc1HasImage && childLoanGuardianDoc2HasImage && childLoanGuardianDoc3HasImage && childLoanGuardianDoc4HasImage',
      },
    ],
  );
}

StacWidget _submitButton() {
  return StacCustomReactiveElevatedButton(
    enabledKey: 'childLoanCustomerDocNextEnabled',
    onPressed: const StacFingerPrintAction(
      title: 'احراز هویت',
      description: 'لطفا برای ادامه از اثر انگشت استفاده کنید',
      onSuccess: {
        'actionType': 'sequence',
        'actions': [
          {
            'actionType': 'setValue',
            'key': 'childLoanTaskDocsCompleted',
            'value': true,
          },
          {
            'actionType': 'customSnackBar',
            'title': 'ثبت',
            'detail': 'مدارک با موفقیت ثبت شد',
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
      data: 'ثبت',
      textDirection: StacTextDirection.rtl,
      style: StacTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w700,
        color: '#FFFFFF',
      ),
    ).toJson(),
  );
}
