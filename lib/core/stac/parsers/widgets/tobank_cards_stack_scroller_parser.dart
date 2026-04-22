import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';

class TobankCardsStackScrollerModel {
  const TobankCardsStackScrollerModel({
    required this.walletCard,
    required this.cards,
    this.scrollHandle,
    this.topSpacerHeight = 170,
    this.bottomSpacerHeight = 130,
    this.itemHeight = 125,
    this.itemHeightFactor = 0.72,
    this.scaleDistance = 300,
    this.minScale = 0.86,
    this.fadeStart = 0.2,
    this.horizontalPadding = 0,
    this.maxWidthInset = 14,
    this.handleTop = 0,
  });

  final Map<String, dynamic> walletCard;
  final List<Map<String, dynamic>> cards;
  final Map<String, dynamic>? scrollHandle;
  final double topSpacerHeight;
  final double bottomSpacerHeight;
  final double itemHeight;
  final double itemHeightFactor;
  final double scaleDistance;
  final double minScale;
  final double fadeStart;
  final double horizontalPadding;
  final double maxWidthInset;
  final double handleTop;

  factory TobankCardsStackScrollerModel.fromJson(Map<String, dynamic> json) {
    final rawCards = json['cards'] as List<dynamic>? ?? const [];
    final cards = rawCards.whereType<Map<String, dynamic>>().toList(
      growable: false,
    );

    return TobankCardsStackScrollerModel(
      walletCard:
          (json['walletCard'] as Map<String, dynamic>?) ?? const <String, dynamic>{},
      cards: cards,
      scrollHandle: json['scrollHandle'] as Map<String, dynamic>?,
      topSpacerHeight: (json['topSpacerHeight'] as num?)?.toDouble() ?? 170,
      bottomSpacerHeight:
          (json['bottomSpacerHeight'] as num?)?.toDouble() ?? 130,
      itemHeight: (json['itemHeight'] as num?)?.toDouble() ?? 125,
      itemHeightFactor: (json['itemHeightFactor'] as num?)?.toDouble() ?? 0.72,
      scaleDistance: (json['scaleDistance'] as num?)?.toDouble() ?? 300,
      minScale: (json['minScale'] as num?)?.toDouble() ?? 0.86,
      fadeStart: (json['fadeStart'] as num?)?.toDouble() ?? 0.2,
      horizontalPadding: (json['horizontalPadding'] as num?)?.toDouble() ?? 0,
      maxWidthInset: (json['maxWidthInset'] as num?)?.toDouble() ?? 14,
      handleTop: (json['handleTop'] as num?)?.toDouble() ?? 0,
    );
  }
}

class TobankCardsStackScrollerParser
    extends StacParser<TobankCardsStackScrollerModel> {
  const TobankCardsStackScrollerParser();

  @override
  String get type => 'tobankCardsStackScroller';

  @override
  TobankCardsStackScrollerModel getModel(Map<String, dynamic> json) =>
      TobankCardsStackScrollerModel.fromJson(json);

  @override
  Widget parse(BuildContext context, TobankCardsStackScrollerModel model) {
    return _TobankCardsStackScrollerWidget(model: model);
  }
}

class _TobankCardsStackScrollerWidget extends StatefulWidget {
  const _TobankCardsStackScrollerWidget({required this.model});

  final TobankCardsStackScrollerModel model;

  @override
  State<_TobankCardsStackScrollerWidget> createState() =>
      _TobankCardsStackScrollerWidgetState();
}

class _TobankCardsStackScrollerWidgetState
    extends State<_TobankCardsStackScrollerWidget> {
  late final ScrollController _scrollController;
  double _offset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    setState(() {
      _offset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = <Map<String, dynamic>>[
      widget.model.walletCard,
      ...widget.model.cards,
    ];

    if (items.isEmpty) return const SizedBox.shrink();

    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.topCenter,
      children: [
        CustomScrollView(
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          clipBehavior: Clip.none,
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: widget.model.topSpacerHeight),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final itemWidget = Stac.fromJson(items[index], context);
                  if (itemWidget == null) return const SizedBox.shrink();

                  final itemPositionOffset = index * widget.model.itemHeight;
                  final difference =
                      _offset - itemPositionOffset * widget.model.itemHeightFactor;
                  final rawPercent = 1 - (difference / widget.model.scaleDistance);
                  final clampedPercent = rawPercent.clamp(0.0, 1.0);

                  final easedScale = lerpDouble(
                    widget.model.minScale,
                    1.0,
                    Curves.easeOut.transform(clampedPercent),
                  )!;

                  final opacity = ((clampedPercent - widget.model.fadeStart) /
                          (1 - widget.model.fadeStart))
                      .clamp(0.0, 1.0);
                  final widthInset =
                      lerpDouble(0, widget.model.maxWidthInset, 1 - clampedPercent)!;
                  final totalHorizontalInset =
                      widget.model.horizontalPadding + widthInset;

                  return Align(
                    heightFactor: widget.model.itemHeightFactor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: totalHorizontalInset,
                      ),
                      child: Opacity(
                        opacity: opacity,
                        child: Transform.scale(
                          scale: easedScale,
                          alignment: Alignment.topCenter,
                          child: itemWidget,
                        ),
                      ),
                    ),
                  );
                },
                childCount: items.length,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: widget.model.bottomSpacerHeight),
            ),
          ],
        ),
        if (widget.model.scrollHandle != null)
          Positioned(
            top: widget.model.handleTop,
            child: IgnorePointer(
              child:
                  Stac.fromJson(widget.model.scrollHandle!, context) ??
                  const SizedBox.shrink(),
            ),
          ),
      ],
    );
  }
}

void registerTobankCardsStackScrollerParser() {
  CustomComponentRegistry.instance.registerWidget(
    const TobankCardsStackScrollerParser(),
  );
}
