import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';

@StacScreen(screenName: 'login_splash')
StacWidget loginSplash() {
  return StacWidget(
    jsonData: {
      'type': 'onMountAction',
      'delay': 5000,
      'action': NavigationAction(fileName: 'login_onboarding', navMode: NavModes.dart, navigationStyle: NavigationStyle.pushReplacement).toJson(),
      'child': _buildSplashBody().toJson(),
    },
  );
}

StacWidget _buildSplashBody() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    body: StacCenter(
      child: StacContainer(
        decoration: StacBoxDecoration(
          borderRadius: StacBorderRadius.all(24),
          boxShadow: [
            StacBoxShadow(
              color: '#1A000000',
              blurRadius: 90,
              offset: StacOffset(dx: 0, dy: 4),
            ),
          ],
        ),
        child: StacClipRRect(
          borderRadius: StacBorderRadius.all(24),
          child: StacImage(
            src: 'assets/icons/ic_tobank_logo.svg',
            imageType: StacImageType.asset,
            width: 150,
            height: 150,
            fit: StacBoxFit.contain,
          ),
        ),
      ),
    ),
  );
}
