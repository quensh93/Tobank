import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory_real/dart/widgets/promissory_app_bar.dart';

@StacScreen(screenName: 'verify_identity_real_intro')
StacWidget verifyIdentityRealIntro() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      key: 'isVerifyIdentityRulesAccepted',
      value: false,
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
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.only(
                left: 16,
                top: 16,
                right: 16,
                bottom: 24,
              ),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.stretch,
                children: [
                  _buildStepsCard(),
                  StacSizedBox(height: 16),
                  _buildRulesToggleCard(),
                ],
              ),
            ),
          ),
          _buildContinueButton(),
        ],
      ),
    ),
  );
}

StacWidget _buildStepsCard() {
  return StacContainer(
    padding: StacEdgeInsets.all(20),
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
        StacText(
          data: '{{appStrings.authentication.introTitle}}',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 20),
        _buildStepItem('{{appStrings.authentication.stepValidation}}'),
        _buildStepItem('{{appStrings.authentication.stepUploadNationalCard}}'),
        _buildStepItem('{{appStrings.authentication.stepCaptureFacePhoto}}'),
        _buildStepItem('{{appStrings.authentication.stepCaptureFaceVideo}}'),
        _buildStepItem('{{appStrings.authentication.stepCollectUserSignature}}'),
        _buildStepItem('{{appStrings.authentication.stepCollectEnglishInfo}}'),
        _buildStepItem('{{appStrings.authentication.stepCollectDigitalSignature}}'),
      ],
    ),
  );
}

StacWidget _buildStepItem(String title) {
  return StacPadding(
    padding: StacEdgeInsets.only(bottom: 12),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      crossAxisAlignment: StacCrossAxisAlignment.start,
      children: [
        StacText(
          data: '•',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 22,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
            height: 1.2,
          ),
        ),
        StacSizedBox(width: 12),
        StacExpanded(
          child: StacText(
            data: title,
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.title}}',
              height: 1.6,
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildRulesToggleCard() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 11),
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(16),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacRow(
      textDirection: StacTextDirection.rtl,
      mainAxisAlignment: StacMainAxisAlignment.start,
      children: [
        StacContainer(
          width: 45,
          height: 45,
          child: StacFittedBox(
            fit: StacBoxFit.contain,
            child: StacCustomReactiveSwitch(
              id: 'verify_identity_rules_switch',
              valueKey: 'isVerifyIdentityRulesAccepted',
              initialValue: false,
              activeColor: '{{appColors.current.secondary.color}}',
              inactiveTrackColor:
                  '{{appColors.current.background.surfaceContainerHigh}}',
              inactiveThumbColor: '{{appColors.current.background.surface}}',
            ),
          ),
        ),
        StacSizedBox(width: 4),
        StacExpanded(
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisSize: StacMainAxisSize.min,
            children: [
              StacTextButton(
                onPressed: const StacNavigateAction(
                  routeName: 'verify_identity_real_rules',
                  navigationStyle: NavigationStyle.push,
                ),
                style: StacButtonStyle(
                  foregroundColor: '{{appColors.current.secondary.color}}',
                  padding: StacEdgeInsets.all(0),
                  minimumSize: const StacSize(0, 0),
                  tapTargetSize: StacMaterialTapTargetSize.shrinkWrap,
                ),
                child: StacText(
                  data: '{{appStrings.authentication.rulesTitle}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.secondary.color}}',
                  ),
                ),
              ),
              StacSizedBox(width: 3.5),
              StacText(
                data: '{{appStrings.authentication.acceptRulesSuffix}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w500,
                  color: '{{appColors.current.text.title}}',
                ),
              ),

            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildContinueButton() {
  return StacPadding(
    padding: StacEdgeInsets.only(left: 16, right: 16, bottom: 24),
    child: StacCustomReactiveElevatedButton(
      enabledKey: 'isVerifyIdentityRulesAccepted',
      enabled: false,
      onPressed: const StacNavigateAction(
        routeName: 'verify_identity_real_preregister',
        navigationStyle: NavigationStyle.push,
      ),
      style: StacButtonStyle(
        backgroundColor: '{{appColors.current.primary.color}}',
        elevation: 0,
        fixedSize: StacSize(999999, 64),
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(18),
        ),
      ).toJson(),
      disabledStyle: StacButtonStyle(
        backgroundColor:
            '{{appColors.current.background.surfaceContainerHigh}}',
        elevation: 0,
        fixedSize: StacSize(999999, 64),
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(18),
        ),
      ).toJson(),
      child: StacText(
        data: '{{appStrings.authentication.continueLabel}}',
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
