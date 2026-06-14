import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'authentication_signature')
StacWidget authenticationRealSignature() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {'key': 'authenticationSignatureImage', 'value': ''},
        {'key': 'authenticationHasSignature', 'value': false},
        {'key': 'authenticationSignatureClearVersion', 'value': 0},
      ],
    ),
    onDispose: const StacSequenceAction(
      actions: [
        {'actionType': 'stopAudioUrl'},
        {
          'actionType': 'setValue',
          'values': [
            {'key': 'authenticationSignatureImage', 'value': ''},
            {'key': 'authenticationHasSignature', 'value': false},
            {'key': 'authenticationSignatureClearVersion', 'value': 0},
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
                    _buildHeaderRow(),
                    StacSizedBox(height: 16),
                    _buildInstructions(),
                    StacSizedBox(height: 16),
                    _buildSignatureCard(),
                    StacSizedBox(height: 18),
                    _buildDeleteButton(),
                  ],
                ),
              ),
            ),
            _buildConfirmButton(),
          ],
        ),
      ),
    ),
  );
}

StacWidget _buildHeaderRow() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      StacText(
        data: 'دریافت امضا',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.text.title}}',
        ),
      ),
      StacOutlinedButton(
        onPressed: const StacShowGuideOptionsBottomSheetAction(
          title: 'راهنما',
          options: [
            {
              'title': 'راهنمای تصویری',
              'iconAsset': '{{appAssets.icons.visualTutorialCurrent}}',
              'onTap': {
                'actionType': 'launchUrl',
                'url': 'https://tobank.ir/app/signature-template/',
                'mode': 'inAppWebView',
              },
            },
            {
              'title': 'راهنمای صوتی',
              'iconAsset': '{{appAssets.icons.voiceTutorialCurrent}}',
              'onTap': {
                'actionType': 'playAudioUrl',
                'url':
                    'https://appapi.tobank.ir/api/v1.0/media/ekyc/signature_page.mp3',
                'stopPrevious': true,
              },
            },
          ],
        ),
        style: StacButtonStyle(
          minimumSize: const StacSize(88, 38),
          foregroundColor: '{{appColors.current.text.title}}',
          side: StacBorderSide(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
          shape: StacRoundedRectangleBorder(
            borderRadius: StacBorderRadius.all(8),
          ),
          padding: StacEdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
        child: StacRow(
          mainAxisSize: StacMainAxisSize.min,
          textDirection: StacTextDirection.rtl,
          children: [
            StacImage(
              src: '{{appAssets.icons.info}}',
              imageType: StacImageType.asset,
              width: 21,
              height: 21,
              color: '{{appColors.current.text.subtitle}}',
            ),
            StacSizedBox(width: 8),

            StacText(
              data: 'راهنما',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 17,
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

StacWidget _buildInstructions() {
  return StacText(
    data:
        'لطفا نمونه امضا خود را در کادر زیر وارد کنید و پس از تایید، دکمه تایید و ادامه را فشار دهید.',
    textDirection: StacTextDirection.rtl,
    textAlign: StacTextAlign.right,
    style: StacCustomTextStyle(
      fontSize: 17,
      fontWeight: StacFontWeight.w500,
      color: '{{appColors.current.text.subtitle}}',
      height: 1.8,
    ),
  );
}

StacWidget _buildSignatureCard() {
  return StacContainer(
    height: 360,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
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
          padding: StacEdgeInsets.all(16),
          child: StacAlign(
            alignment: StacAlignmentDirectional.centerEnd,
            child: StacText(
              data: 'محل امضا',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ),
        ),
        StacExpanded(
          child: StacPadding(
            padding: StacEdgeInsets.only(left: 12, right: 12, bottom: 12),
            child: const StacCustomWidget.fromJson({
              'type': 'signaturePad',
              'valueKey': 'authenticationSignatureImage',
              'hasSignatureKey': 'authenticationHasSignature',
              'clearKey': 'authenticationSignatureClearVersion',
              'strokeColor': '#111111',
              'backgroundColor': '#00000000',
              'strokeWidth': 3.2,
            }),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildDeleteButton() {
  return StacAlign(
    alignment: StacAlignmentDirectional.center,
    child: StacOutlinedButton(
      onPressed: const StacCustomSetValueAction(
        key: 'authenticationSignatureClearVersion',
        value: '{{now()}}',
      ),
      style: StacButtonStyle(
        minimumSize: const StacSize(124, 42),
        foregroundColor: '{{appColors.current.text.title}}',
        side: StacBorderSide(
          color: '{{appColors.current.input.borderEnabled}}',
          width: 1,
        ),
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(48),
        ),
        padding: StacEdgeInsets.symmetric(horizontal: 18, vertical: 8),
      ),
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
          StacSizedBox(width: 8),

          StacText(
            data: 'حذف',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildConfirmButton() {
  return StacPadding(
    padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
    child: StacCustomReactiveElevatedButton(
      enabledKey: 'authenticationHasSignature',
      enabled: false,
      onPressed: const StacSequenceAction(
        actions: [
          {'actionType': 'stopAudioUrl'},
          {
            'actionType': 'navigate',
            'fileName': 'authentication_certificate_generator',
            'navMode': 'dart',
            'navigationStyle': 'push',
          },
        ],
      ),
      style: StacButtonStyle(
        backgroundColor: '{{appColors.current.primary.color}}',
        elevation: 0,
        fixedSize: const StacSize(999999, 56),
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(12),
        ),
      ).toJson(),
      disabledStyle: StacButtonStyle(
        backgroundColor:
            '{{appColors.current.background.surfaceContainerHigh}}',
        elevation: 0,
        fixedSize: const StacSize(999999, 56),
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(12),
        ),
      ).toJson(),
      child: StacText(
        data: 'تایید و ادامه',
        textDirection: StacTextDirection.rtl,
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w700,
          color: '{{appColors.current.primary.onPrimary}}',
        ),
      ).toJson(),
    ),
  );
}

