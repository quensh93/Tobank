import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stac/stac.dart';
import '../../../helpers/logger.dart';

class TobankOnboardingSliderModel {
  final List<OnboardingPageModel> pages;
  final Map<String, dynamic>? onFinish;

  TobankOnboardingSliderModel({required this.pages, this.onFinish});

  factory TobankOnboardingSliderModel.fromJson(Map<String, dynamic> json) {
    return TobankOnboardingSliderModel(
      pages: (json['pages'] as List<dynamic>)
          .map((e) => OnboardingPageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      onFinish: json['onFinish'] as Map<String, dynamic>?,
    );
  }
}

class OnboardingPageModel {
  final String title;
  final String description;
  final String image;
  final String buttonText;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.image,
    required this.buttonText,
  });

  factory OnboardingPageModel.fromJson(Map<String, dynamic> json) {
    return OnboardingPageModel(
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      buttonText: json['buttonText'] as String,
    );
  }
}

class TobankOnboardingSliderParser
    extends StacParser<TobankOnboardingSliderModel> {
  const TobankOnboardingSliderParser();

  @override
  String get type => 'tobank_onboarding_slider';

  @override
  TobankOnboardingSliderModel getModel(Map<String, dynamic> json) =>
      TobankOnboardingSliderModel.fromJson(json);

  @override
  Widget parse(BuildContext context, TobankOnboardingSliderModel model) {
    return _TobankOnboardingSlider(model: model);
  }
}

class _TobankOnboardingSlider extends StatefulWidget {
  final TobankOnboardingSliderModel model;

  const _TobankOnboardingSlider({required this.model});

  @override
  State<_TobankOnboardingSlider> createState() =>
      _TobankOnboardingSliderState();
}

class _TobankOnboardingSliderState extends State<_TobankOnboardingSlider> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  // Get theme colors from StacRegistry
  // These methods take BuildContext to ensure we have a dependency on Theme
  Color _getTitleColor(BuildContext context) {
    // Access Theme.of(context) to create dependency for theme changes
    // ignore: unused_local_variable
    final _ = Theme.of(context).brightness;

    final colorStr = StacRegistry.instance.getValue(
      'appColors.current.text.title',
    );
    return _parseColor(colorStr) ?? const Color(0xFF101828);
  }

  Color _getDescriptionColor(BuildContext context) {
    // Access Theme.of(context) to create dependency for theme changes
    // ignore: unused_local_variable
    final _ = Theme.of(context).brightness;

    final colorStr = StacRegistry.instance.getValue(
      'appColors.current.text.subtitle',
    );
    return _parseColor(colorStr) ?? const Color(0xFF667085);
  }

  Color _getPrimaryColor(BuildContext context) {
    // Access Theme.of(context) to create dependency for theme changes
    // ignore: unused_local_variable
    final _ = Theme.of(context).brightness;

    final colorStr = StacRegistry.instance.getValue(
      'appColors.current.button.primary.backgroundColor',
    );
    return _parseColor(colorStr) ?? const Color(0xFFD61F2C);
  }

  Color _getInactiveIndicatorColor(BuildContext context) {
    // Use theme brightness to determine inactive indicator color
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // In dark mode use a darker gray, in light mode use lighter gray
    return isDark ? const Color(0xFF475467) : const Color(0xFFEAEAEA);
  }

  Color? _parseColor(String? colorStr) {
    if (colorStr == null || colorStr.isEmpty) return null;
    try {
      final hex = colorStr.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (e) {
      return null;
    }
  }

  /// Navigate to next screen (e.g., login page)
  /// This button is for exiting onboarding, NOT for moving between slides
  /// Slides are controlled by swipe gestures only
  void _navigateToNextScreen() {
    _onFinish();
  }

  void _onFinish() {
    if (widget.model.onFinish != null) {
      try {
        AppLogger.dc(
          LogCategory.action,
          '🔵 Onboarding: Calling onFinish action: ${widget.model.onFinish}',
        );
        Stac.onCallFromJson(widget.model.onFinish!, context);
        AppLogger.dc(
          LogCategory.action,
          '✅ Onboarding: onFinish action completed successfully',
        );
      } catch (e, stackTrace) {
        AppLogger.e('❌ Error calling onFinish', e, stackTrace);
      }
    } else {
      AppLogger.wc(
        LogCategory.action,
        '⚠️ Onboarding: No onFinish action defined, popping...',
      );
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Capture colors at start of build to use throughout
    final titleColor = _getTitleColor(context);
    final descriptionColor = _getDescriptionColor(context);
    final primaryColor = _getPrimaryColor(context);
    final inactiveIndicatorColor = _getInactiveIndicatorColor(context);

    return SafeArea(
      child: Column(
        children: [
          // Page content - takes most of the space
          // Wrapped with ScrollConfiguration to enable mouse drag on desktop
          Expanded(
            child: ScrollConfiguration(
              behavior: _MouseDragScrollBehavior(),
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.model.pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = widget.model.pages[index];
                  return _buildPage(page, titleColor, descriptionColor);
                },
              ),
            ),
          ),

          // Bottom Controls - fixed at bottom
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left side: Next button (icon + "شروع" text) - entire row is tappable
                GestureDetector(
                  onTap: _navigateToNextScreen,
                  behavior:
                      HitTestBehavior.opaque, // Makes the entire area tappable
                  child: Padding(
                    // Invisible padding for better tap area (doesn't change visual position)
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Next Button SVG icon
                        SvgPicture.asset(
                          StacRegistry.instance.getValue(
                                'appAssets.icons.buttonNext',
                              ) ??
                              'assets/icons/ic_button_next.svg',
                          width: 39,
                          height: 39,
                        ),
                        const SizedBox(width: 16),
                        // "شروع" text from localization
                        Text(
                          StacRegistry.instance.getValue(
                                'appStrings.onboarding.startButton',
                              ) ??
                              'شروع',
                          style: TextStyle(
                            fontFamily: 'IranYekan',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: titleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right side: Indicators (RTL layout, so this appears on right)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(widget.model.pages.length, (index) {
                    // Reverse order for RTL - last indicator first
                    final reversedIndex = widget.model.pages.length - 1 - index;
                    final isActive = _currentPage == reversedIndex;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive ? primaryColor : inactiveIndicatorColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(
    OnboardingPageModel page,
    Color titleColor,
    Color descriptionColor,
  ) {
    final isSvg = page.image.toLowerCase().endsWith('.svg');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Spacer(flex: 1),
          // Image section
          Expanded(
            flex: 5,
            child: isSvg
                ? SvgPicture.asset(
                    page.image,
                    fit: BoxFit.contain,
                    placeholderBuilder: (context) =>
                        const Center(child: CircularProgressIndicator()),
                  )
                : Image.asset(
                    page.image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.image, size: 64, color: Colors.grey),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 48),
          // Title
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'IranYekan',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
          const SizedBox(height: 16),
          // Description
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'IranYekan',
              fontSize: 16,
              color: descriptionColor,
              height: 1.6,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

/// Custom scroll behavior that enables mouse drag scrolling
/// This is needed for desktop platforms (Windows, macOS, Linux)
/// where PageView doesn't respond to mouse drag by default
class _MouseDragScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
  };
}
