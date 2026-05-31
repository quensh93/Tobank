import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';

class TobankCardManagementSliderModel {
  const TobankCardManagementSliderModel({
    required this.pages,
    this.enabledStates = const [],
    this.cardTypes = const [],
    this.selectedEnabledKey = 'cardsManagement.selectedEnabled',
    this.selectedIndexKey = 'cardsManagement.selectedIndex',
    this.selectedTypeKey = 'cardsManagement.selectedType',
    this.selectedIsWalletKey = 'cardsManagement.selectedIsWallet',
    this.selectedIsGardeshgaryKey = 'cardsManagement.selectedIsGardeshgary',
    this.selectedIsNonTobankKey = 'cardsManagement.selectedIsNonTobank',
    this.selectedIsBlockedKey = 'cardsManagement.selectedIsBlocked',
    this.height = 430,
    this.initialPage = 0,
    this.initialPageKey,
    this.indicatorTopSpacing = 16,
    this.indicatorActiveColor = '#E31A2F',
    this.indicatorInactiveColor = '#F2F4F7',
    this.indicatorSpacing = 8,
    this.indicatorSize = 12,
  });

  final List<Map<String, dynamic>> pages;
  final List<bool> enabledStates;
  final List<String> cardTypes;
  final String selectedEnabledKey;
  final String selectedIndexKey;
  final String selectedTypeKey;
  final String selectedIsWalletKey;
  final String selectedIsGardeshgaryKey;
  final String selectedIsNonTobankKey;
  final String selectedIsBlockedKey;
  final double height;
  final int initialPage;
  final String? initialPageKey;
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
    final rawEnabledStates =
        json['enabledStates'] as List<dynamic>? ?? const [];
    final enabledStates = rawEnabledStates
        .map((value) => value == true)
        .toList(growable: false);
    final rawCardTypes = json['cardTypes'] as List<dynamic>? ?? const [];
    final cardTypes = rawCardTypes
        .map((value) => value?.toString().trim() ?? '')
        .where((value) => value.isNotEmpty)
        .toList(growable: false);

    return TobankCardManagementSliderModel(
      pages: pages,
      enabledStates: enabledStates,
      cardTypes: cardTypes,
      selectedEnabledKey:
          json['selectedEnabledKey'] as String? ??
          'cardsManagement.selectedEnabled',
      selectedIndexKey:
          json['selectedIndexKey'] as String? ??
          'cardsManagement.selectedIndex',
      selectedTypeKey:
          json['selectedTypeKey'] as String? ?? 'cardsManagement.selectedType',
      selectedIsWalletKey:
          json['selectedIsWalletKey'] as String? ??
          'cardsManagement.selectedIsWallet',
      selectedIsGardeshgaryKey:
          json['selectedIsGardeshgaryKey'] as String? ??
          'cardsManagement.selectedIsGardeshgary',
      selectedIsNonTobankKey:
          json['selectedIsNonTobankKey'] as String? ??
          'cardsManagement.selectedIsNonTobank',
      selectedIsBlockedKey:
          json['selectedIsBlockedKey'] as String? ??
          'cardsManagement.selectedIsBlocked',
      height: (json['height'] as num?)?.toDouble() ?? 430,
      initialPage: json['initialPage'] as int? ?? 0,
      initialPageKey: json['initialPageKey'] as String?,
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
    final requestedInitialPage = _readInitialPage();
    final safeInitialPage = pageCount == 0
        ? 0
        : requestedInitialPage.clamp(0, pageCount - 1);
    _currentPage = safeInitialPage;
    _controller = PageController(initialPage: safeInitialPage);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _publishSelection(safeInitialPage);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _publishEnabledState(int pageIndex) {
    if (widget.model.enabledStates.isEmpty) return;
    final boundedIndex = pageIndex.clamp(
      0,
      widget.model.enabledStates.length - 1,
    );
    StacRegistry.instance.setValue(
      widget.model.selectedEnabledKey,
      widget.model.enabledStates[boundedIndex],
    );
  }

  void _publishSelectedIndex(int pageIndex) {
    StacRegistry.instance.setValue(widget.model.selectedIndexKey, pageIndex);
  }

  void _publishSelectedType(int pageIndex) {
    if (widget.model.cardTypes.isEmpty) return;
    final boundedIndex = pageIndex.clamp(0, widget.model.cardTypes.length - 1);
    final selectedType = widget.model.cardTypes[boundedIndex];
    StacRegistry.instance.setValue(widget.model.selectedTypeKey, selectedType);
    StacRegistry.instance.setValue(
      widget.model.selectedIsWalletKey,
      selectedType == 'wallet',
    );
    StacRegistry.instance.setValue(
      widget.model.selectedIsGardeshgaryKey,
      selectedType == 'gardeshgary',
    );
    StacRegistry.instance.setValue(
      widget.model.selectedIsNonTobankKey,
      selectedType == 'nonTobank',
    );
    StacRegistry.instance.setValue(
      widget.model.selectedIsBlockedKey,
      selectedType == 'blocked',
    );
  }

  void _publishSelection(int pageIndex) {
    _publishEnabledState(pageIndex);
    _publishSelectedIndex(pageIndex);
    _publishSelectedType(pageIndex);
    RegistryNotifier.instance.notify();
  }

  int _readInitialPage() {
    final key = widget.model.initialPageKey;
    if (key == null || key.isEmpty) return widget.model.initialPage;

    final value = StacRegistry.instance.getValue(key);
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value) ?? widget.model.initialPage;
    }
    return widget.model.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    final pages = widget.model.pages;
    if (pages.isEmpty) return const SizedBox.shrink();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
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
                  _publishSelection(index);
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
