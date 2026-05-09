import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';

class TobankCardManagementSliderModel {
  const TobankCardManagementSliderModel({
    required this.pages,
    this.enabledStates = const [],
    this.selectedEnabledKey = 'cardsManagement.selectedEnabled',
    this.height = 430,
    this.initialPage = 0,
    this.indicatorTopSpacing = 16,
    this.indicatorActiveColor = '#E31A2F',
    this.indicatorInactiveColor = '#F2F4F7',
    this.indicatorSpacing = 8,
    this.indicatorSize = 12,
  });

  final List<Map<String, dynamic>> pages;
  final List<bool> enabledStates;
  final String selectedEnabledKey;
  final double height;
  final int initialPage;
  final double indicatorTopSpacing;
  final String indicatorActiveColor;
  final String indicatorInactiveColor;
  final double indicatorSpacing;
  final double indicatorSize;

  factory TobankCardManagementSliderModel.fromJson(Map<String, dynamic> json) {
    final rawPages = json['pages'] as List<dynamic>? ?? const [];
    final pages = rawPages.whereType<Map<String, dynamic>>().toList(
      growable: false,
    );
    final rawEnabledStates = json['enabledStates'] as List<dynamic>? ?? const [];
    final enabledStates = rawEnabledStates
        .map((value) => value == true)
        .toList(growable: false);

    return TobankCardManagementSliderModel(
      pages: pages,
      enabledStates: enabledStates,
      selectedEnabledKey:
          json['selectedEnabledKey'] as String? ??
          'cardsManagement.selectedEnabled',
      height: (json['height'] as num?)?.toDouble() ?? 430,
      initialPage: json['initialPage'] as int? ?? 0,
      indicatorTopSpacing:
          (json['indicatorTopSpacing'] as num?)?.toDouble() ?? 16,
      indicatorActiveColor:
          json['indicatorActiveColor'] as String? ?? '#E31A2F',
      indicatorInactiveColor:
          json['indicatorInactiveColor'] as String? ?? '#F2F4F7',
      indicatorSpacing: (json['indicatorSpacing'] as num?)?.toDouble() ?? 8,
      indicatorSize: (json['indicatorSize'] as num?)?.toDouble() ?? 12,
    );
  }
}

class TobankCardManagementSliderParser
    extends StacParser<TobankCardManagementSliderModel> {
  const TobankCardManagementSliderParser();

  @override
  String get type => 'tobankCardManagementSlider';

  @override
  TobankCardManagementSliderModel getModel(Map<String, dynamic> json) =>
      TobankCardManagementSliderModel.fromJson(json);

  @override
  Widget parse(BuildContext context, TobankCardManagementSliderModel model) {
    return _TobankCardManagementSliderWidget(model: model);
  }
}

class _TobankCardManagementSliderWidget extends StatefulWidget {
  const _TobankCardManagementSliderWidget({required this.model});

  final TobankCardManagementSliderModel model;

  @override
  State<_TobankCardManagementSliderWidget> createState() =>
      _TobankCardManagementSliderWidgetState();
}

class _TobankCardManagementSliderWidgetState
    extends State<_TobankCardManagementSliderWidget> {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _publishEnabledState(safeInitialPage);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _publishEnabledState(int pageIndex) {
    if (widget.model.enabledStates.isEmpty) return;
    final boundedIndex =
        pageIndex.clamp(0, widget.model.enabledStates.length - 1);
    StacRegistry.instance.setValue(
      widget.model.selectedEnabledKey,
      widget.model.enabledStates[boundedIndex],
    );
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
                _publishEnabledState(index);
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
        if (pages.length > 1) ...[
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

void registerTobankCardManagementSliderParser() {
  CustomComponentRegistry.instance.registerWidget(
    const TobankCardManagementSliderParser(),
  );
}
