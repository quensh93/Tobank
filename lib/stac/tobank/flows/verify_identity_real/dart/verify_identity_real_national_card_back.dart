import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/verify_identity_real/dart/widgets/verify_identity_real_app_bar.dart';

const _backNationalCardSampleAsset = 'assets/images/back_national.PNG';
const _backHasImageKey = 'verifyIdentityBackHasImage';

@StacScreen(screenName: 'verify_identity_real_national_card_back')
StacWidget verifyIdentityRealNationalCardBack() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'verifyIdentityBackImage', 'value': ''},
        {'key': _backHasImageKey, 'value': false},
      ],
    ),
    onDispose: const StacCustomSetValueAction(
      values: [
        {'key': 'verifyIdentityBackImage', 'value': ''},
        {'key': _backHasImageKey, 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildVerifyIdentityRealAppBar(
        title: '{{appStrings.menu.items.verifyIdentity}}',
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  _buildUploadPickerCard(),
                  StacSizedBox(height: 16),
                  _buildSampleCard(),
                  StacSizedBox(height: 12),
                  _buildTips(),
                ],
              ),
            ),
          ),
          StacPadding(
            padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
            child: StacRawJsonWidget({
              'type': 'reactiveElevatedButton',
              'enabledKey': _backHasImageKey,
              'enabled': false,
              'style': StacButtonStyle(
                backgroundColor: '{{appColors.current.primary.color}}',
                elevation: 0,
                fixedSize: const StacSize(999999, 56),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ).toJson(),
              'disabledStyle': StacButtonStyle(
                backgroundColor:
                    '{{appColors.current.background.surfaceContainerHigh}}',
                elevation: 0,
                fixedSize: const StacSize(999999, 56),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ).toJson(),
              'child': StacText(
                data: '{{appStrings.authentication.continueLabel}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ).toJson(),
              'onPressed': {
                    // 'actionType': 'navigate',
                    // 'widgetType': 'verify_identity_real_selfie',
                    // 'navigationStyle': 'push',
                  },
            }),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildUploadPickerCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(16),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacContainer(
          padding: StacEdgeInsets.all(16),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainer}}',
            borderRadius: StacBorderRadius.only(
              topLeft: 16,
              topRight: 16,
            ),
          ),
          child: StacText(
            data: '{{appStrings.authentication.backNationalCardTitle}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        StacPadding(
          padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '{{!verifyIdentityBackHasImage}}',
                'child': StacRow(
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacExpanded(
                      child: _buildSourceOption(
                        title: '{{appStrings.authentication.cameraLabel}}',
                        iconAsset: 'assets/icons/ic_camera.svg',
                      ),
                    ),
                    StacContainer(
                      width: 1,
                      height: 28,
                      color: '{{appColors.current.input.borderEnabled}}',
                    ),
                    StacExpanded(
                      child: _buildSourceOption(
                        title: '{{appStrings.authentication.galleryLabel}}',
                        iconAsset: 'assets/icons/ic_gallery.svg',
                      ),
                    ),
                  ],
                ).toJson(),
              }),
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '{{verifyIdentityBackHasImage}}',
                'child': StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    _buildSelectedImagePreview(),
                    StacSizedBox(height: 12),
                    _buildRetakeButton(),
                  ],
                ).toJson(),
              }),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildSourceOption({
  required String title,
  required String iconAsset,
}) {
  return StacGestureDetector(
    onTap: const StacFilePickerAction(
      fileType: 'image',
      targetKey: 'verifyIdentityBackImage',
      hasValueKey: _backHasImageKey,
      previewBeforeConfirm: true,
      previewSheetTitle: 'پیش نمایش تصویر کارت ملی',
      confirmButtonText: 'تایید',
      retryButtonText: 'بازگشت',
    ),
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.center,
        textDirection: StacTextDirection.rtl,
        children: [
          StacImage(
            src: iconAsset,
            imageType: StacImageType.asset,
            width: 32,
            height: 32,
          ),
          StacSizedBox(width: 8),
          StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 15,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildSelectedImagePreview() {
  return StacContainer(
    height: 190,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(14),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacClipRRect(
      borderRadius: StacBorderRadius.all(14),
      child: StacRawJsonWidget({
        'type': 'registryReactive',
        'child': {
          'type': 'image',
          'src': '{{verifyIdentityBackImage}}',
          'registryKey': 'verifyIdentityBackImage',
          'fit': 'cover',
          'width': 999999,
          'height': 190,
          'errorBuilder': {
            'type': 'center',
            'child': {
              'type': 'text',
              'data': '{{appStrings.authentication.imagePreviewUnavailable}}',
              'textDirection': 'rtl',
              'style': {
                'type': 'custom',
                'fontSize': 14,
                'fontWeight': 'w500',
                'color': '{{appColors.current.text.subtitle}}',
              },
            },
          },
        },
      }),
    ),
  );
}

StacWidget _buildRetakeButton() {
  return StacRow(
    mainAxisAlignment: StacMainAxisAlignment.center,
    children: [
      StacGestureDetector(
        onTap: const StacCustomSetValueAction(
          values: [
            {'key': 'verifyIdentityBackImage', 'value': ''},
            {'key': _backHasImageKey, 'value': false},
          ],
        ),
        child: StacText(
          data: 'عکسبرداری مجدد',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      StacSizedBox(width: 3),
      StacImage(
        src: 'assets/icons/ic_refresh.svg',
        imageType: StacImageType.asset,
        width: 24,
        height: 24,
      ),
    ],
  );
}

StacWidget _buildSampleCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(16),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacContainer(
          padding: StacEdgeInsets.all(16),
          decoration: StacBoxDecoration(
            color: '{{appColors.current.background.surfaceContainer}}',
            borderRadius: StacBorderRadius.only(
              topLeft: 16,
              topRight: 16,
            ),
          ),
          child: StacText(
            data: '{{appStrings.authentication.correctBackNationalCardSampleTitle}}',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.center,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        StacPadding(
          padding: StacEdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16),
          child: StacCenter(
            child: StacImage(
              src: _backNationalCardSampleAsset,
              imageType: StacImageType.asset,
              width: 240,
              fit: StacBoxFit.contain,
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildTips() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      _buildTipItem('{{appStrings.authentication.tipHoldPhoneVertical}}'),
      StacSizedBox(height: 6),
      _buildTipItem('{{appStrings.authentication.tipNoReflection}}'),
    ],
  );
}

StacWidget _buildTipItem(String text) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacText(
        data: '•',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.subtitle}}',
        ),
      ),
      StacSizedBox(width: 8),
      StacExpanded(
        child: StacText(
          data: text,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
            height: 1.7,
          ),
        ),
      ),
    ],
  );
}
