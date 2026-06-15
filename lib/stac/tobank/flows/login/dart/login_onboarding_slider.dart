import 'package:stac_core/stac_core.dart';

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
