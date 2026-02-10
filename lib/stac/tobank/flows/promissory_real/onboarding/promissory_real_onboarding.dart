import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../onboarding/dart/stac_tobank_onboarding_slider.dart';

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
