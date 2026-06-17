import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

/// Old National Card flow - for users who don't have a new (smart) national card.
/// They must enter their tracking code from the paper receipt,
/// capture a photo, and record a video.
@StacScreen(screenName: 'authentication_old_national_card')
StacWidget authenticationRealOldNationalCard() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'oldCardTrackingCode', 'value': ''},
        {'key': 'oldCardPhoto', 'value': ''},
        {'key': 'oldCardVideo', 'value': ''},
        {'key': 'oldCardVideoName', 'value': ''},
        {'key': 'hasOldCardPhoto', 'value': false},
        {'key': 'hasOldCardVideo', 'value': false},
      ],
    ),
    onDispose: const StacSequenceAction(
      actions: [
        {'actionType': 'stopAudioUrl'},
        {
          'actionType': 'setValue',
          'values': [
            {'key': 'oldCardTrackingCode', 'value': ''},
            {'key': 'oldCardPhoto', 'value': ''},
            {'key': 'oldCardVideo', 'value': ''},
            {'key': 'oldCardVideoName', 'value': ''},
            {'key': 'hasOldCardPhoto', 'value': false},
            {'key': 'hasOldCardVideo', 'value': false},
          ],
        },
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        title: '{{appStrings.menu.items.authentication}}',
        backAction: const StacSequenceAction(
          actions: [
            {'actionType': 'stopAudioUrl'},
            {'actionType': 'navigate', 'navigationStyle': 'pop'},
          ],
        ),
      ),
      body: StacSafeArea(
        bottom: true,
        top: false,
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacSingleChildScrollView(
                padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    _buildDescriptionAndGuide(),
                    StacSizedBox(height: 24),
                    _buildTrackingCodeSection(),
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
                onPressed: const StacSequenceAction(
                  actions: [
                    {'actionType': 'stopAudioUrl'},
                    {
                      'actionType': 'showResult',
                      'title': '{{appStrings.common.comingSoon}}',
                      'content': '{{appStrings.common.comingSoon}}',
                    },
                  ],
                ),
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
    ),
  );
}

/// Top section: description text + "??????" guide button
StacWidget _buildDescriptionAndGuide() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacExpanded(
        child: StacText(
          data: '{{appStrings.authentication.oldCardTrackingCodeDescription}}',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 15,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.subtitle}}',
            height: 1.8,
          ),
        ),
      ),
      StacSizedBox(width: 12),
      StacGestureDetector(
        onTap: const StacShowGuideOptionsBottomSheetAction(
          title: '??????',
          options: [
            {
              'title': '??????? ??????',
              'iconAsset': '{{appAssets.icons.visualTutorialCurrent}}',
              'onTap': {
                'actionType': 'launchUrl',
                'url':
                    'https://appapi.tobank.ir/api/v1.0/media/ekyc/face_movement_video.mp4',
                'mode': 'inAppWebView',
              },
            },
            {
              'title': '??????? ????',
              'iconAsset': '{{appAssets.icons.voiceTutorialCurrent}}',
              'onTap': {
                'actionType': 'playAudioUrl',
                'url':
                    'https://appapi.tobank.ir/api/v1.0/media/ekyc/personal_photo_video_receipt_serial.mp3',
                'stopPrevious': true,
              },
            },
          ],
        ),
        child: StacContainer(
          padding: StacEdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: StacBoxDecoration(
            borderRadius: StacBorderRadius.all(8),
            border: StacBorder.all(
              color: '{{appColors.current.input.borderEnabled}}',
              width: 1,
            ),
          ),
          child: StacRow(
            mainAxisSize: StacMainAxisSize.min,
            textDirection: StacTextDirection.rtl,
            children: [
              StacIcon(
                icon: StacIcons.info_outline,
                size: 23,
                color: '{{appColors.current.text.title}}',
              ),
              StacSizedBox(width: 6),
              StacText(
                data: '{{appStrings.authentication.guideLabel}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 15,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

/// Tracking code label + text field
StacWidget _buildTrackingCodeSection() {
  return StacColumn(
    crossAxisAlignment: StacCrossAxisAlignment.stretch,
    children: [
      StacText(
        data: '{{appStrings.authentication.trackingCodeLabel}}',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 16,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacSizedBox(height: 12),
      StacTextFormField(
        id: 'oldCardTrackingCode',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.right,
        style: StacCustomTextStyle(
          fontSize: 17,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
        decoration: StacInputDecoration(
          hintText: '{{appStrings.authentication.trackingCodeHint}}',
          hintStyle: StacTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.hint}}',
          ),
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
        ),
      ),
    ],
  );
}

/// "??? ???" card with camera button
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
            borderRadius: StacBorderRadius.only(topLeft: 16, topRight: 16),
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
                'visible': '[[!hasOldCardPhoto]]',
                'child': _buildPhotoCaptureTrigger().toJson(),
              }),
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '[[hasOldCardPhoto]]',
                'child': _buildSelectedPhotoContent().toJson(),
              }),
            ],
          ),
        ),
      ],
    ),
  );
}

/// "??? ?????" card with video button
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
            borderRadius: StacBorderRadius.only(topLeft: 16, topRight: 16),
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
                'visible': '[[!hasOldCardVideo]]',
                'child': _buildVideoCaptureTrigger().toJson(),
              }),
              StacRawJsonWidget({
                'type': 'visibility',
                'visible': '[[hasOldCardVideo]]',
                'child': _buildSelectedVideoContent().toJson(),
              }),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildPhotoCaptureTrigger() {
  return StacGestureDetector(
    onTap: const StacShowPhotoTipsBottomSheetAction(
      title: '???? ???? ???? ???',
      iconAsset: '{{appAssets.icons.cameraCurrent}}',
      tips: [
        '???? ????? ????? ???',
        '??? ???? ???? ? ???? ???? ????',
        '?? ????? ??????? ????',
        '??? ???? ?????? ??? ???? ?? ?????',
        '????? ?? ???? ???? ??? ?? ???? ??? (???? ???? ??????? ???? ?? ???????? ????)',
      ],
      previewAsset:
          'https://appapi.tobank.ir/api/v1.0/media/ekyc/personal_picture_sample.png',
      continueText: '?????',
      cancelText: '??????',
      continueAction: {
        'actionType': 'pickFile',
        'fileType': 'image',
        'targetKey': 'oldCardPhoto',
        'hasValueKey': 'hasOldCardPhoto',
        'source': 'camera',
        'cameraDevice': 'front',
        'cropImage': true,
        'cropAspectRatioX': 3,
        'cropAspectRatioY': 4,
        'previewBeforeConfirm': true,
        'previewSheetTitle': '??? ????? ??? ???? ????? ??? ????',
        'confirmButtonText': '?????',
        'retryButtonText': '??????',
      },
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      textDirection: StacTextDirection.rtl,
      children: [
        StacImage(
          src: '{{appAssets.icons.cameraCurrent}}',
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
  );
}

StacWidget _buildVideoCaptureTrigger() {
  return StacGestureDetector(
    onTap: const StacShowPhotoTipsBottomSheetAction(
      title: '???? ???? ???? ?????',
      iconAsset: '{{appAssets.icons.videoCurrent}}',
      tips: [
        '???? ????? ????? ???',
        '???? ???? ???? ? ???? ???? ????',
        '???????? ????? (?????? ???? ?? ????)',
        '???? ?? ??? ?? ????? ???? ????? ????',
        '????? ???? ???? ???? ????? ?? ???? ??? (???? ???? ??????? ???? ?? ???? ??? ????)',
      ],
      previewAsset:
          'https://appapi.tobank.ir/api/v1.0/media/ekyc/face_movement_video.mp4',
      continueText: '?????',
      cancelText: '??????',
      continueAction: {
        'actionType': 'pickFile',
        'fileType': 'video',
        'targetKey': 'oldCardVideo',
        'hasValueKey': 'hasOldCardVideo',
        'fileNameKey': 'oldCardVideoName',
        'source': 'camera',
        'cameraDevice': 'front',
        'previewBeforeConfirm': true,
        'previewSheetTitle': '?????? ????? ??? ???? ????? ??? ????',
        'confirmButtonText': '?????',
        'retryButtonText': '??????',
      },
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      textDirection: StacTextDirection.rtl,
      children: [
        StacImage(
          src: '{{appAssets.icons.videoCurrent}}',
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

StacWidget _buildSelectedPhotoContent() {
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
              'src': '{{oldCardPhoto}}',
              'registryKey': 'oldCardPhoto',
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
      _buildDeleteButton(
        onTap: const StacCustomSetValueAction(
          values: [
            {'key': 'oldCardPhoto', 'value': ''},
            {'key': 'hasOldCardPhoto', 'value': false},
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildSelectedVideoContent() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      StacExpanded(
        child: StacText(
          data: '{{oldCardVideoName}}',
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
      _buildDeleteButton(
        onTap: const StacCustomSetValueAction(
          values: [
            {'key': 'oldCardVideo', 'value': ''},
            {'key': 'oldCardVideoName', 'value': ''},
            {'key': 'hasOldCardVideo', 'value': false},
          ],
        ),
      ),
    ],
  );
}

StacWidget _buildDeleteButton({required StacAction onTap}) {
  return StacGestureDetector(
    onTap: onTap,
    child: StacRow(
      mainAxisSize: StacMainAxisSize.min,
      textDirection: StacTextDirection.rtl,
      children: [
        StacImage(
          src: '{{appAssets.icons.deleteCurrent}}',
          imageType: StacImageType.asset,
          width: 20,
          height: 20,
        ),
        StacSizedBox(width: 6),
        StacText(
          data: '???',
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
