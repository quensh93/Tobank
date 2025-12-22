import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac/tobank/onboarding/dart/stac_tobank_onboarding_slider.dart';

/// Linear Login Flow - Onboarding Screen
///
/// This is the linear version of the onboarding screen.
/// When finished, it navigates directly to the login screen.
/// No config file is used - navigation is handled internally.
@StacScreen(screenName: 'tobank_login_flow_linear_onboarding')
StacWidget tobankLoginFlowLinearOnboarding() {
  return StacScaffold(
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
        'widgetType': 'tobank_login_flow_linear_login',
        'navigationStyle': 'pushReplacement',
      },
    ),
  );
}

