import 'dart:ui';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';

import '../../../registry/custom_component_registry.dart';

class TobankCardsCarouselModel {
  const TobankCardsCarouselModel({
    required this.pages,
    this.height = 258,
    this.initialPage = 0,
    this.showIndicators = true,
    this.indicatorTopSpacing = 16,
    this.indicatorActiveColor = '#E31A2F',
    this.indicatorInactiveColor = '#D0D5DD',
    this.indicatorSpacing = 8,
    this.indicatorSize = 12,
  });

  final List<Map<String, dynamic>> pages;
  final double height;
  final int initialPage;
  final bool showIndicators;
  final double indicatorTopSpacing;
  final String indicatorActiveColor;
  final String indicatorInactiveColor;
  final double indicatorSpacing;
  final double indicatorSize;

  factory TobankCardsCarouselModel.fromJson(Map<String, dynamic> json) {
    final rawPages = json['pages'] as List<dynamic>? ?? const [];
    final pages = rawPages.whereType<Map<String, dynamic>>().toList(
      growable: false,
    );

    return TobankCardsCarouselModel(
      pages: pages,
      height: (json['height'] as num?)?.toDouble() ?? 258,
      initialPage: json['initialPage'] as int? ?? 0,
      showIndicators: json['showIndicators'] as bool? ?? true,
      indicatorTopSpacing:
          (json['indicatorTopSpacing'] as num?)?.toDouble() ?? 16,
      indicatorActiveColor:
          json['indicatorActiveColor'] as String? ?? '#E31A2F',
      indicatorInactiveColor:
          json['indicatorInactiveColor'] as String? ?? '#D0D5DD',
      indicatorSpacing: (json['indicatorSpacing'] as num?)?.toDouble() ?? 8,
      indicatorSize: (json['indicatorSize'] as num?)?.toDouble() ?? 12,
    );
  }
}

class TobankCardsCarouselParser extends StacParser<TobankCardsCarouselModel> {
  const TobankCardsCarouselParser();

  @override
  String get type => 'tobankCardsCarousel';

  @override
  TobankCardsCarouselModel getModel(Map<String, dynamic> json) =>
      TobankCardsCarouselModel.fromJson(json);

  @override
  Widget parse(BuildContext context, TobankCardsCarouselModel model) {
    return _TobankCardsCarouselWidget(model: model);
  }
}

class _TobankCardsCarouselWidget extends StatefulWidget {
  const _TobankCardsCarouselWidget({required this.model});

  final TobankCardsCarouselModel model;

  @override
  State<_TobankCardsCarouselWidget> createState() =>
      _TobankCardsCarouselWidgetState();
}

class _TobankCardsCarouselWidgetState
    extends State<_TobankCardsCarouselWidget> {
  late final PageController _controller;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    final pageCount = widget.model.pages.length;
    final safeInitialPage = pageCount == 0
        ? 0
        : widget.model.initialPage.clamp(0, pageCount - 1);
    _currentPage = safeInitialPage;
    _controller = PageController(initialPage: safeInitialPage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = widget.model.pages;
    if (pages.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.model.height,
          child: ScrollConfiguration(
            behavior: const _MouseDragScrollBehavior(),
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                if (!mounted) return;
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Stac.fromJson(pages[index], context) ??
                    const SizedBox.shrink();
              },
            ),
          ),
        ),
        if (widget.model.showIndicators && pages.length > 1) ...[
          SizedBox(height: widget.model.indicatorTopSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: widget.model.indicatorSize,
                height: widget.model.indicatorSize,
                margin: EdgeInsets.symmetric(
                  horizontal: widget.model.indicatorSpacing / 2,
                ),
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? _parseColor(widget.model.indicatorActiveColor)
                      : _parseColor(widget.model.indicatorInactiveColor),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Color _parseColor(String value) {
    var hex = value.replaceAll('#', '').trim();
    if (hex.length == 6) hex = 'FF$hex';
    if (hex.length != 8) return const Color(0xFFE31A2F);
    return Color(int.parse(hex, radix: 16));
  }
}

class _MouseDragScrollBehavior extends MaterialScrollBehavior {
  const _MouseDragScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
  };
}

void registerTobankCardsCarouselParser() {
  CustomComponentRegistry.instance.registerWidget(
    const TobankCardsCarouselParser(),
  );
}
