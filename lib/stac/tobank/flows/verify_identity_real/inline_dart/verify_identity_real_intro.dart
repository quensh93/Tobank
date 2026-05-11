import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'verify_identity_real_intro')
StacWidget verifyIdentityRealIntro() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      key: 'isVerifyIdentityRulesAccepted',
      value: false,
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        title: '{{appStrings.menu.items.verifyIdentity}}',
      ),
      body: StacSafeArea(
        bottom: true,
        top: false,
        child: StacColumn(
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
            fontSize: 17,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 20),
        _buildStepItem('{{appStrings.authentication.stepValidation}}'),
        _buildStepItem('{{appStrings.authentication.stepUploadNationalCard}}'),
        _buildStepItem('{{appStrings.authentication.stepCaptureFacePhoto}}'),
        _buildStepItem('{{appStrings.authentication.stepCaptureFaceVideo}}'),
        _buildStepItem(
          '{{appStrings.authentication.stepCollectUserSignature}}',
        ),
        _buildStepItem('{{appStrings.authentication.stepCollectEnglishInfo}}'),
        _buildStepItem(
          '{{appStrings.authentication.stepCollectDigitalSignature}}',
        ),
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

class StacStatefulWidget extends StacWidget {
  final dynamic onInit;
  final StacWidget child;

  const StacStatefulWidget({this.onInit, required this.child});

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'stateFull',
      if (onInit != null) 'onInit': _actionToJson(onInit),
      'child': child.toJson(),
    };
  }

  dynamic _actionToJson(dynamic action) {
    if (action is Map<String, dynamic>) {
      return action;
    }
    if (action is StacAction) {
      return action.toJson();
    }
    return (action as dynamic).toJson();
  }

  @override
  String get type => 'stateFull';

  @override
  Map<String, dynamic> get jsonData => toJson();
}

class StacCustomSetValueAction extends StacAction {
  final String? key;
  final dynamic value;
  final List<Map<String, dynamic>>? values;

  const StacCustomSetValueAction({this.key, this.value, this.values});

  @override
  String get actionType => 'setValue';

  @override
  Map<String, dynamic> toJson() {
    if (values != null) {
      return {'actionType': 'setValue', 'values': values};
    }
    dynamic processedValue = value;
    if (value is StacAction) {
      processedValue = value.toJson();
    }
    return {'actionType': 'setValue', 'key': key, 'value': processedValue};
  }
}

class StacShowRulesBottomSheetAction extends StacAction {
  final String routeName;
  final String? title;

  const StacShowRulesBottomSheetAction({required this.routeName, this.title});

  @override
  String get actionType => 'showRulesBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'routeName': routeName,
    if (title != null) 'title': title,
  };
}

class StacCustomReactiveSwitch extends StacWidget {
  const StacCustomReactiveSwitch({
    this.id,
    required this.valueKey,
    this.initialValue,
    this.onChanged,
    this.activeColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
  });

  final String? id;
  final String valueKey;
  final bool? initialValue;
  final dynamic onChanged;
  final String? activeColor;
  final String? inactiveTrackColor;
  final String? inactiveThumbColor;

  @override
  String get type => 'reactiveSwitch';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (id != null) 'id': id,
    'valueKey': valueKey,
    if (initialValue != null) 'initialValue': initialValue,
    if (onChanged != null)
      'onChanged': onChanged is StacAction
          ? (onChanged as StacAction).toJson()
          : onChanged,
    if (activeColor != null) 'activeColor': activeColor,
    if (inactiveTrackColor != null) 'inactiveTrackColor': inactiveTrackColor,
    if (inactiveThumbColor != null) 'inactiveThumbColor': inactiveThumbColor,
  };
}

class StacCustomReactiveElevatedButton extends StacWidget {
  const StacCustomReactiveElevatedButton({
    this.enabledKey,
    this.loadingKey,
    this.enabled,
    this.onPressed,
    this.style,
    this.disabledStyle,
    this.child,
    this.loadingChild,
  });

  final String? enabledKey;
  final String? loadingKey;
  final bool? enabled;
  final dynamic onPressed;
  final Map<String, dynamic>? style;
  final Map<String, dynamic>? disabledStyle;
  final Map<String, dynamic>? child;
  final Map<String, dynamic>? loadingChild;

  @override
  String get type => 'reactiveElevatedButton';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (enabledKey != null) 'enabledKey': enabledKey,
    if (loadingKey != null) 'loadingKey': loadingKey,
    if (enabled != null) 'enabled': enabled,
    if (onPressed != null)
      'onPressed': onPressed is StacAction
          ? (onPressed as StacAction).toJson()
          : onPressed,
    if (style != null) 'style': style,
    if (disabledStyle != null) 'disabledStyle': disabledStyle,
    if (child != null) 'child': child,
    if (loadingChild != null) 'loadingChild': loadingChild,
  };
}

class StacAliasTextStyle implements StacTextStyle {
  final String alias;

  const StacAliasTextStyle(this.alias);

  @override
  StacTextStyleType get type => StacTextStyleType.custom;

  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

StacWidget _buildRulesToggleCard() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                onPressed: const StacShowRulesBottomSheetAction(
                  routeName: 'verify_identity_real_rules',
                  title: 'شرایط و مقررات ارائه خدمات توبانک',
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
              StacSizedBox(width: 4.5),
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
