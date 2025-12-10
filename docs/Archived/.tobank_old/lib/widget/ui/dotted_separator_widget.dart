import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DottedSeparatorWidget extends StatelessWidget {
  final double height;
  final double padding;

  const DottedSeparatorWidget({
    super.key,
    this.height = 1,
    this.padding = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: padding,
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final boxWidth = constraints.constrainWidth();
            const dashWidth = 3.0;
            final dashHeight = height;
            final dashCount = (boxWidth / (2.5 * dashWidth)).floor();
            return Flex(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              direction: Axis.horizontal,
              children: List.generate(dashCount, (_) {
                return SizedBox(
                  width: dashWidth,
                  height: dashHeight,
                  child: DecoratedBox(
                    decoration:
                        BoxDecoration(color: Get.isDarkMode ? const Color(0xff545454) : const Color(0xffbac5cf)),
                  ),
                );
              }),
            );
          },
        ),
        SizedBox(
          height: padding,
        ),
      ],
    );
  }
}
