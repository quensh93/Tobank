import 'package:flutter/material.dart';

/// Builder widget for creating columns with indexed items.
class ISpectColumnBuilder extends StatelessWidget {
  const ISpectColumnBuilder({
    required this.itemBuilder,
    required this.itemCount,
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.verticalDirection = VerticalDirection.down,
  });

  final IndexedWidgetBuilder itemBuilder;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final VerticalDirection verticalDirection;
  final int itemCount;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        verticalDirection: verticalDirection,
        children:
            List.generate(itemCount, (index) => itemBuilder(context, index)),
      );
}

