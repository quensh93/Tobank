import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';

class TobankBannerCarouselModel {
  const TobankBannerCarouselModel({
    required this.imageUrls,
    this.height = 146,
    this.borderRadius = 20,
    this.autoScrollSeconds = 15,
    this.showIndicators = true,
    this.indicatorActiveColor = '#E31A2F',
    this.indicatorInactiveColor = '#4C5E7A',
    this.indicatorSpacing = 8,
  });

  final List<String> imageUrls;
  final double height;
  final double borderRadius;
  final int autoScrollSeconds;
  final bool showIndicators;
  final String indicatorActiveColor;
  final String indicatorInactiveColor;
  final double indicatorSpacing;

  factory TobankBannerCarouselModel.fromJson(Map<String, dynamic> json) {
    final rawImageUrls = (json['imageUrls'] as List<dynamic>? ?? const [])
        .map((e) => e.toString())
        .where((e) => e.isNotEmpty)
        .toList();

    return TobankBannerCarouselModel(
      imageUrls: rawImageUrls,
      height: (json['height'] as num?)?.toDouble() ?? 146,
      borderRadius: (json['borderRadius'] as num?)?.toDouble() ?? 20,
      autoScrollSeconds: json['autoScrollSeconds'] as int? ?? 15,
      showIndicators: json['showIndicators'] as bool? ?? true,
      indicatorActiveColor:
          json['indicatorActiveColor'] as String? ?? '#E31A2F',
      indicatorInactiveColor:
          json['indicatorInactiveColor'] as String? ?? '#4C5E7A',
      indicatorSpacing: (json['indicatorSpacing'] as num?)?.toDouble() ?? 8,
    );
  }
}

class TobankBannerCarouselParser extends StacParser<TobankBannerCarouselModel> {
  const TobankBannerCarouselParser();

  @override
  String get type => 'tobankBannerCarousel';

  @override
  TobankBannerCarouselModel getModel(Map<String, dynamic> json) =>
      TobankBannerCarouselModel.fromJson(json);

  @override
  Widget parse(BuildContext context, TobankBannerCarouselModel model) {
    return _TobankBannerCarouselWidget(model: model);
  }
}

class _TobankBannerCarouselWidget extends StatefulWidget {
  const _TobankBannerCarouselWidget({required this.model});

  final TobankBannerCarouselModel model;

  @override
  State<_TobankBannerCarouselWidget> createState() =>
      _TobankBannerCarouselWidgetState();
}

class _TobankBannerCarouselWidgetState
    extends State<_TobankBannerCarouselWidget> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScrollIfNeeded();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScrollIfNeeded() {
    final imageCount = widget.model.imageUrls.length;
    if (imageCount <= 1 || widget.model.autoScrollSeconds <= 0) {
      return;
    }

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: widget.model.autoScrollSeconds), (
      _,
    ) {
      if (!mounted || !_pageController.hasClients) return;

      final nextIndex = (_currentIndex + 1) % imageCount;
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageUrls = widget.model.imageUrls;
    if (imageUrls.isEmpty) return const SizedBox.shrink();

    final activeDotColor = _parseColor(widget.model.indicatorActiveColor);
    final inactiveDotColor = _parseColor(widget.model.indicatorInactiveColor);

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.model.borderRadius),
      child: SizedBox(
        height: widget.model.height,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                itemCount: imageUrls.length,
                onPageChanged: (index) {
                  if (!mounted) return;
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFF22304A),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.white70,
                        size: 28,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (widget.model.showIndicators && imageUrls.length > 1)
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    imageUrls.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: _currentIndex == index ? 16 : 8,
                      height: 8,
                      margin: EdgeInsets.symmetric(
                        horizontal: widget.model.indicatorSpacing / 2,
                      ),
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? activeDotColor
                            : inactiveDotColor,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _parseColor(String value) {
    var hex = value.replaceAll('#', '').trim();
    if (hex.length == 6) hex = 'FF$hex';
    if (hex.length != 8) return const Color(0xFFE31A2F);
    return Color(int.parse(hex, radix: 16));
  }
}

void registerTobankBannerCarouselParser() {
  CustomComponentRegistry.instance.registerWidget(
    const TobankBannerCarouselParser(),
  );
}
