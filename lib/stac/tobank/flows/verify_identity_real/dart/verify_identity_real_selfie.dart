import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/verify_identity_real/dart/widgets/verify_identity_real_app_bar.dart';

/// User selfie photo & video capture page.
/// Shows the serial number from the back of the smart national card,
/// plus camera/video capture options.
@StacScreen(screenName: 'verify_identity_real_selfie')
StacWidget verifyIdentityRealSelfie() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'selfiePhoto', 'value': ''},
        {'key': 'selfieVideo', 'value': ''},
        {'key': 'selfieVideoName', 'value': ''},
        {'key': 'hasSelfiePhoto', 'value': false},
        {'key': 'hasSelfieVideo', 'value': false},
      ],
    ),
    onDispose: const StacCustomSetValueAction(
      values: [
        {'key': 'selfiePhoto', 'value': ''},
        {'key': 'selfieVideo', 'value': ''},
        {'key': 'selfieVideoName', 'value': ''},
        {'key': 'hasSelfiePhoto', 'value': false},
        {'key': 'hasSelfieVideo', 'value': false},
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
                  _buildSerialSection(),
                  StacSizedBox(height: 16),
                  _buildCapturePhotoCard(),
                  StacSizedBox(height: 16),
                  _buildCaptureVideoCard(),
                ],
              ),
            ),
          ),
          StacPadding(
            padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
            child: StacFilledButton(
              onPressed: StacRawJsonAction({
                'actionType': 'navigate',
                'widgetType': 'verify_identity_real_postal_code',
                'navigationStyle': 'push',
              }),
              style: StacButtonStyle(
                backgroundColor: '{{appColors.current.primary.color}}',
                foregroundColor: '{{appColors.current.primary.onPrimary}}',
                elevation: 0,
                fixedSize: const StacSize(999999, 56),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(12),
                ),
              ),
              child: StacText(
                data: '{{appStrings.authentication.confirmLabel}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '{{appColors.current.primary.onPrimary}}',
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Serial number from the back of the smart national card
StacWidget _buildSerialSection() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data: '{{appStrings.authentication.smartCardSerialTitle}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 12),
      StacRawJsonWidget({
        'type': 'textFormField',
        'id': 'smartCardSerial',
        'textDirection': 'rtl',
        'textAlign': 'right',
        'keyboardType': 'number',
        'inputFormatters': [
          {'type': 'allow', 'rule': '[0-9]'},
        ],
        'style': StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ).toJson(),
        'decoration': StacInputDecoration(
          hintText: 'سریال پشت کارت ملی خود را وارد کنید',
          hintStyle: StacTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.hint}}',
          ),
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ).toJson(),
      }),
    ],
  );
}

/// "ثبت عکس" card with camera button
StacWidget _buildCapturePhotoCard() {
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
            data: '{{appStrings.authentication.capturePhotoTitle}}',
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
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '{{!hasSelfiePhoto}}',
                'child': _buildSelfiePhotoTrigger().toJson(),
              }),
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '{{hasSelfiePhoto}}',
                'child': _buildSelectedSelfiePhotoContent().toJson(),
              }),
            ],
          ),
        ),
      ],
    ),
  );
}

/// "ثبت ویدیو" card with video button
StacWidget _buildCaptureVideoCard() {
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
            data: '{{appStrings.authentication.captureVideoTitle}}',
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
          padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '{{!hasSelfieVideo}}',
                'child': _buildSelfieVideoTrigger().toJson(),
              }),
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '{{hasSelfieVideo}}',
                'child': _buildSelectedSelfieVideoContent().toJson(),
              }),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildSelfiePhotoTrigger() {
  return StacGestureDetector(
    onTap: const StacShowPhotoTipsBottomSheetAction(
      title: 'نکات قابل توجه عکس',
      iconAsset: 'assets/icons/ic_camera.svg',
      tips: [
        'پوشش مناسب رعایت شود',
        'عکس باید واضح و بدون تاری باشد',
        'پس زمینه یکنواخت باشد',
        'عدم وجود هرگونه فرد دیگر در تصویر',
        'تصویر رخ کامل صورت فرد را نشان دهد (بدون عینک آفتابی، ماسک یا سایه‌های شدید)',
      ],
      previewAsset: 'assets/icons/face_id.svg',
      continueText: 'ادامه',
      cancelText: 'بازگشت',
      continueAction: {
        'actionType': 'pickFile',
        'fileType': 'image',
        'targetKey': 'selfiePhoto',
        'hasValueKey': 'hasSelfiePhoto',
        'previewBeforeConfirm': true,
        'previewSheetTitle': 'عکس گرفته شده مورد تایید شما است؟',
        'confirmButtonText': 'تایید',
        'retryButtonText': 'بازگشت',
      },
    ),
    child: StacPadding(
      padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: StacRow(
        mainAxisAlignment: StacMainAxisAlignment.center,
        textDirection: StacTextDirection.rtl,
        children: [
          StacImage(
            src: 'assets/icons/ic_camera.svg',
            imageType: StacImageType.asset,
            width: 32,
            height: 32,
          ),
          StacSizedBox(width: 8),
          StacText(
            data: '{{appStrings.authentication.capturePhotoButton}}',
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

StacWidget _buildSelfieVideoTrigger() {
  return StacGestureDetector(
    onTap: const StacShowPhotoTipsBottomSheetAction(
      title: 'نکات قابل توجه ویدیو',
      iconAsset: 'assets/icons/video_light.svg',
      tips: [
        'پوشش مناسب رعایت شود',
        'فیلم باید واضح و بدون تاری باشد',
        'پس‌زمینه یکدست (ترجیحا سفید یا روشن)',
        'تنها یک نفر در تصویر حضور داشته باشد',
        'ویدیو باید کامل صورت کاربر را پوشش دهد (بدون عینک افتابی، ماسک یا سایه های شدید)',
      ],
      previewAsset: 'assets/icons/video_light.svg',
      continueText: 'ادامه',
      cancelText: 'بازگشت',
      continueAction: {
        'actionType': 'pickFile',
        'fileType': 'video',
        'targetKey': 'selfieVideo',
        'hasValueKey': 'hasSelfieVideo',
        'fileNameKey': 'selfieVideoName',
        'previewBeforeConfirm': true,
        'previewSheetTitle': 'ویدیوی گرفته شده مورد تایید شما است؟',
        'confirmButtonText': 'تایید',
        'retryButtonText': 'بازگشت',
      },
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      textDirection: StacTextDirection.rtl,
      children: [
        StacImage(
          src: 'assets/icons/video_light.svg',
          imageType: StacImageType.asset,
          width: 32,
          height: 32,
        ),
        StacSizedBox(width: 8),
        StacText(
          data: '{{appStrings.authentication.captureVideoButton}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildSelectedSelfiePhotoContent() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      StacContainer(
        width: 36,
        height: 48,
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surface}}',
          borderRadius: StacBorderRadius.all(8),
        ),
        child: StacClipRRect(
          borderRadius: StacBorderRadius.all(8),
          child: StacRawJsonWidget({
            'type': 'registryReactive',
            'child': {
              'type': 'image',
              'src': '{{selfiePhoto}}',
              'registryKey': 'selfiePhoto',
              'fit': 'cover',
              'width': 36,
              'height': 48,
              'errorBuilder': {
                'type': 'center',
                'child': {
                  'type': 'icon',
                  'icon': 'image_outlined',
                  'size': 18,
                  'color': '{{appColors.current.text.subtitle}}',
                },
              },
            },
          }),
        ),
      ),
      StacExpanded(child: StacSizedBox()),
      _buildSelfieDeleteButton(
        onTap: const StacCustomSetValueAction(
          values: [
            {'key': 'selfiePhoto', 'value': ''},
            {'key': 'hasSelfiePhoto', 'value': false},
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildSelectedSelfieVideoContent() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      StacExpanded(
        child: StacText(
          data: '{{selfieVideoName}}',
          textDirection: StacTextDirection.ltr,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 12,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.primary.color}}',
          ),
        ),
      ),
      StacSizedBox(width: 12),
      _buildSelfieDeleteButton(
        onTap: const StacCustomSetValueAction(
          values: [
            {'key': 'selfieVideo', 'value': ''},
            {'key': 'selfieVideoName', 'value': ''},
            {'key': 'hasSelfieVideo', 'value': false},
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildSelfieDeleteButton({
  required StacAction onTap,
}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacRow(
      mainAxisSize: StacMainAxisSize.min,
      textDirection: StacTextDirection.rtl,
      children: [
        StacImage(
          src: 'assets/icons/ic_delete.svg',
          imageType: StacImageType.asset,
          width: 20,
          height: 20,
        ),
        StacSizedBox(width: 6),
        StacText(
          data: 'حذف',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}
