import 'package:stac_core/stac_core.dart';

/// Promissory Real Onboarding Screen
@StacScreen(screenName: 'promissory_real_onboarding')
StacWidget promissoryRealOnboarding() {
  return StacStatefulWidget(
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      body: StacTobankOnboardingSlider(
        pages: [
          {
            'title': '{{appStrings.onboarding.page1.title}}',
            'description': '{{appStrings.onboarding.page1.description}}',
            'image': '{{appAssets.onboarding.page1}}',
            'buttonText': '{{appStrings.onboarding.startButton}}',
          },
          {
            'title': '{{appStrings.onboarding.page2.title}}',
            'description': '{{appStrings.onboarding.page2.description}}',
            'image': '{{appAssets.onboarding.page2}}',
            'buttonText': '{{appStrings.onboarding.startButton}}',
          },
          {
            'title': '{{appStrings.onboarding.page3.title}}',
            'description': '{{appStrings.onboarding.page3.description}}',
            'image': '{{appAssets.onboarding.page3}}',
            'buttonText': '{{appStrings.onboarding.startButton}}',
          },
          {
            'title': '{{appStrings.onboarding.page4.title}}',
            'description': '{{appStrings.onboarding.page4.description}}',
            'image': '{{appAssets.onboarding.page4}}',
            'buttonText': '{{appStrings.onboarding.startButton}}',
          },
        ],
        onFinish: {
          'actionType': 'navigate',
          'navigationStyle': 'push',
          'widgetType': 'promissory_real_login_form',
        },
      ),
    ),
  );
}

// ==========================================
// Local Helper Classes (Inlined to avoid import issues)
// ==========================================

/// Dart builder for 'stateFull' STAC widgets.
class StacStatefulWidget extends StacWidget {
  final dynamic onInit;
  final dynamic onBuild;
  final dynamic onDependenciesChanged;
  final dynamic onWidgetUpdated;
  final dynamic onReassemble;
  final dynamic onDeactivate;
  final dynamic onDispose;
  final dynamic onResume;
  final dynamic onPause;
  final dynamic onInactive;
  final dynamic onHidden;
  final dynamic onDetached;
  final StacWidget child;

  const StacStatefulWidget({
    this.onInit,
    this.onBuild,
    this.onDependenciesChanged,
    this.onWidgetUpdated,
    this.onReassemble,
    this.onDeactivate,
    this.onDispose,
    this.onResume,
    this.onPause,
    this.onInactive,
    this.onHidden,
    this.onDetached,
    required this.child,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'stateFull',
      if (onInit != null) 'onInit': _actionToJson(onInit),
      if (onBuild != null) 'onBuild': _actionToJson(onBuild),
      if (onDependenciesChanged != null)
        'onDependenciesChanged': _actionToJson(onDependenciesChanged),
      if (onWidgetUpdated != null)
        'onWidgetUpdated': _actionToJson(onWidgetUpdated),
      if (onReassemble != null) 'onReassemble': _actionToJson(onReassemble),
      if (onDeactivate != null) 'onDeactivate': _actionToJson(onDeactivate),
      if (onDispose != null) 'onDispose': _actionToJson(onDispose),
      if (onResume != null) 'onResume': _actionToJson(onResume),
      if (onPause != null) 'onPause': _actionToJson(onPause),
      if (onInactive != null) 'onInactive': _actionToJson(onInactive),
      if (onHidden != null) 'onHidden': _actionToJson(onHidden),
      if (onDetached != null) 'onDetached': _actionToJson(onDetached),
      'child': child.toJson(),
    };
  }

  dynamic _actionToJson(dynamic action) {
    if (action == null) return null;
    if (action is Map) return action;
    try {
      return action.toJson();
    } catch (e) {
      return action;
    }
  }
}

/// Builder for 'tobank_onboarding_slider' widget.
class StacTobankOnboardingSlider extends StacWidget {
  const StacTobankOnboardingSlider({required this.pages, this.onFinish});

  final List<Map<String, dynamic>> pages;
  final Map<String, dynamic>? onFinish;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'tobank_onboarding_slider',
      'pages': pages,
      'onFinish': onFinish,
    };
  }
}
