import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'child_loan_child_check')
StacWidget childLoanChildCheckScreen() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'childLoanChildNationalHasValue', 'value': false},
        {'key': 'childLoanChildCheckNextEnabled', 'value': false},
        {'key': 'childLoanDoc1HasImage', 'value': false},
        {'key': 'childLoanDoc2HasImage', 'value': false},
        {'key': 'childLoanDoc3HasImage', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        title: 'بارگذاری اطلاعات هویتی فرزند',
        showBack: true,
        showSupport: true,
      ),
      body: StacForm(
        child: StacSingleChildScrollView(
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              _title('اطلاعات هویتی فرزند'),
              StacSizedBox(height: 16),
              StacText(
                data:
                    'کاربر گرامی، لطفا تصویر تمامی صفحات شناسنامه فرزند خود را بارگذاری نمایید.',
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
              _documentPickerCard(
                title: 'صفحه اول و دوم شناسنامه',
                hasImageKey: 'childLoanDoc1HasImage',
                imageKey: 'childLoanDoc1Image',
                imageNameKey: 'childLoanDoc1ImageName',
              ),
              StacSizedBox(height: 16),
              _documentPickerCard(
                title: 'صفحه سوم و چهارم شناسنامه',
                hasImageKey: 'childLoanDoc2HasImage',
                imageKey: 'childLoanDoc2Image',
                imageNameKey: 'childLoanDoc2ImageName',
              ),
              StacSizedBox(height: 16),
              _documentPickerCard(
                title: 'صفحه پنجم و ششم شناسنامه',
                hasImageKey: 'childLoanDoc3HasImage',
                imageKey: 'childLoanDoc3Image',
                imageNameKey: 'childLoanDoc3ImageName',
              ),
              StacSizedBox(height: 40),
              _nextButton(),
            ],
          ),
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
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainerLowest}}',
            borderRadius: StacBorderRadius.vertical(top: 10),
          ),
          child: StacPadding(
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
                'visible': '[[!$hasImageKey]]',
                'child': _documentSourceRow(
                  hasImageKey: hasImageKey,
                  imageKey: imageKey,
                  imageNameKey: imageNameKey,
                ).toJson(),
              }),
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '[[$hasImageKey]]',
                'child': _uploadedDocumentRow(
                  hasImageKey: hasImageKey,
                  imageKey: imageKey,
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
        _updateNextButtonEnabledAction(),
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
            color: '{{appColors.current.text.title}}',
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
              'width': 48,
              'height': 48,
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
          data: 'بارگذاری موفق',
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
        _updateNextButtonEnabledAction(),
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
            fontSize: 13,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacCustomSetValueAction _updateNextButtonEnabledAction() {
  return const StacCustomSetValueAction(
    values: [
      {'key': 'childLoanChildCheckNextEnabled', 'value': false},
      {
        'key': 'childLoanChildCheckNextEnabled',
        'value': true,
        'condition':
            'childLoanDoc1HasImage && childLoanDoc2HasImage && childLoanDoc3HasImage',
      },
    ],
  );
}

StacWidget _nextButton() {
  return StacCustomReactiveElevatedButton(
    enabledKey: 'childLoanChildCheckNextEnabled',
    onPressed: const StacFingerPrintAction(
      title: 'احراز هویت',
      description: 'لطفا برای ادامه از اثر انگشت استفاده کنید',
      onSuccess: {
        'actionType': 'sequence',
        'actions': [
          {
            'actionType': 'setValue',
            'key': 'childLoanTaskChildInfoCompleted',
            'value': true,
          },
          {
            'actionType': 'customSnackBar',
            'title': 'ثبت',
            'detail': 'مرحله با موفقیت ثبت شد',
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
        fontSize: 22,
        fontWeight: StacFontWeight.w700,
        color: '#FFFFFF',
      ),
    ).toJson(),
  );
}
