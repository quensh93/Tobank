import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

/// Old National Card flow - for users who don't have a new (smart) national card.
/// They must enter their tracking code from the paper receipt,
/// capture a photo, and record a video.
@StacScreen(screenName: 'verify_identity_real_old_national_card')
StacWidget verifyIdentityRealOldNationalCard() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'oldCardTrackingCode', 'value': ''},
        {'key': 'oldCardPhoto', 'value': ''},
        {'key': 'oldCardVideo', 'value': ''},
        {'key': 'hasOldCardPhoto', 'value': false},
        {'key': 'hasOldCardVideo', 'value': false},
      ],
    ),
    onDispose: const StacCustomSetValueAction(
      values: [
        {'key': 'oldCardTrackingCode', 'value': ''},
        {'key': 'oldCardPhoto', 'value': ''},
        {'key': 'oldCardVideo', 'value': ''},
        {'key': 'hasOldCardPhoto', 'value': false},
        {'key': 'hasOldCardVideo', 'value': false},
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: StacAppBar(
        title: buildPromissoryAppBar(
          title: '{{appStrings.menu.items.verifyIdentity}}',
        ).title,
        centerTitle: true,
        leading: buildPromissoryAppBar(
          title: '{{appStrings.menu.items.verifyIdentity}}',
        ).leading,
        actions: [
          StacPadding(
            padding: StacEdgeInsets.only(right: 15),
            child: StacContainer(
              width: 44,
              height: 44,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surfaceContainer}}',
                borderRadius: StacBorderRadius.all(22),
                border: StacBorder.all(
                  color: '{{appColors.current.input.borderEnabled}}',
                  width: 1,
                ),
              ),
              child: StacCenter(
                child: StacImage(
                  src: 'assets/icons/ic_support.svg',
                  imageType: StacImageType.asset,
                  width: 24,
                  height: 24,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ),
          ),
        ],
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
              onPressed: const StacShowResultAction(
                title: '{{appStrings.common.comingSoon}}',
                content: '{{appStrings.common.comingSoon}}',
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
  );
}

/// Top section: description text + "راهنما" guide button
StacWidget _buildDescriptionAndGuide() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacExpanded(
        child: StacText(
          data:
              '{{appStrings.authentication.oldCardTrackingCodeDescription}}',
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
      StacOutlinedButton(
        onPressed: const StacShowResultAction(
          title: '{{appStrings.authentication.guideLabel}}',
          content: '{{appStrings.authentication.oldCardGuideContent}}',
        ),
        style: StacButtonStyle(
          foregroundColor: '{{appColors.current.text.title}}',
          padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: StacRoundedRectangleBorder(
            borderRadius: StacBorderRadius.all(8),
          ),
          side: StacBorderSide(
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
              size: 18,
              color: '{{appColors.current.text.title}}',
            ),
            StacSizedBox(width: 6),
            StacText(
              data: '{{appStrings.authentication.guideLabel}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
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
          fontSize: 14,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
        decoration: StacInputDecoration(
          hintText:
              '{{appStrings.authentication.trackingCodeHint}}',
          hintStyle: StacTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.hint}}',
          ),
          filled: false,
          contentPadding: StacEdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ),
      ),
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
          child: StacGestureDetector(
            onTap: const StacFilePickerAction(
              fileType: 'image',
              targetKey: 'oldCardPhoto',
            ),
            child: StacRow(
              mainAxisAlignment: StacMainAxisAlignment.center,
              textDirection: StacTextDirection.rtl,
              children: [
                StacImage(
                  src: 'assets/icons/ic_camera.svg',
                  imageType: StacImageType.asset,
                  width: 32,
                  height: 32,
                  color: '{{appColors.current.primary.color}}',
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
          child: StacGestureDetector(
            onTap: const StacFilePickerAction(
              fileType: 'video',
              targetKey: 'oldCardVideo',
            ),
            child: StacRow(
              mainAxisAlignment: StacMainAxisAlignment.center,
              textDirection: StacTextDirection.rtl,
              children: [
                StacImage(
                  src: 'assets/icons/ic_recording.svg',
                  imageType: StacImageType.asset,
                  width: 32,
                  height: 32,
                  color: '{{appColors.current.primary.color}}',
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
          ),
        ),
      ],
    ),
  );
}
