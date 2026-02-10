import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'promissory_real_splash')
StacWidget promissoryRealSplash() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        StacRawJsonAction({
          'actionType': 'delay',
          'duration': 5000,
        }),
        StacRawJsonAction({
          'actionType': 'navigate',
          'widgetType': 'promissory_real_onboarding',
          'navigationStyle': 'pushReplacement',
        }),
      ],
    ),
    child: StacScaffold(
      backgroundColor: '#FFFFFF',
      body: StacCenter(
        child: StacContainer(
          decoration: StacBoxDecoration(
            borderRadius: StacBorderRadius.all(24),
            boxShadow: [
              StacBoxShadow(
                color: '#1A000000',
                blurRadius: 90,
                offset: StacOffset( dx: 0, dy: 4),

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
    ),
  );
}
