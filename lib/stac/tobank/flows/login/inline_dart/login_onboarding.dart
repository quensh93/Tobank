import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac/tobank/onboarding/dart/stac_tobank_onboarding_slider.dart';

/// Login Onboarding Screen
@StacScreen(screenName: 'login_onboarding')
StacWidget loginOnboarding() {
  return StacStatefulWidget(
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      body: StacTobankOnboardingSlider(
        pages: [
          _buildOnboardingPage(
            // عنوان صفحه اول
            title: '{{appStrings.onboarding.page1.title}}',
            // توضیح صفحه اول
            description: '{{appStrings.onboarding.page1.description}}',
            image: '{{appAssets.onboarding.page1}}',
          ),
          _buildOnboardingPage(
            // عنوان صفحه دوم
            title: '{{appStrings.onboarding.page2.title}}',
            // توضیح صفحه دوم
            description: '{{appStrings.onboarding.page2.description}}',
            image: '{{appAssets.onboarding.page2}}',
          ),
          _buildOnboardingPage(
            // عنوان صفحه سوم
            title: '{{appStrings.onboarding.page3.title}}',
            // توضیح صفحه سوم
            description: '{{appStrings.onboarding.page3.description}}',
            image: '{{appAssets.onboarding.page3}}',
          ),
          _buildOnboardingPage(
            // عنوان صفحه چهارم
            title: '{{appStrings.onboarding.page4.title}}',
            // توضیح صفحه چهارم
            description: '{{appStrings.onboarding.page4.description}}',
            image: '{{appAssets.onboarding.page4}}',
          ),
        ],
        onFinish: const StacNavigateAction(
          routeName: 'login_form_dart',
          navigationStyle: NavigationStyle.push,
        ).toJson(),
      ),
    ),
  );
}

Map<String, dynamic> _buildOnboardingPage({
  required String title,
  required String description,
  required String image,
}) {
  return {
    'title': title,
    'description': description,
    'image': image,
    // شروع
    'buttonText': '{{appStrings.onboarding.startButton}}',
  };
}
