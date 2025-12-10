import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../util/app_util.dart';

class CardTextFieldClearSymbolIconWidget extends StatelessWidget {
  const CardTextFieldClearSymbolIconWidget({
    required this.isVisible,
    required this.clearFunction,
    required this.cardSymbol,
    super.key,
  });

  final bool isVisible;
  final Function clearFunction;
  final String? cardSymbol;

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (cardSymbol != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.network(
                    AppUtil.baseUrlStatic() + cardSymbol!,
                    semanticsLabel: '',
                    height: 24.0,
                    width: 24.0,
                    placeholderBuilder: (BuildContext context) => SpinKitFadingCircle(
                      itemBuilder: (_, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.theme.iconTheme.color,
                          ),
                        );
                      },
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox(
              width: 0,
            ),
          if (isVisible)
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: InkWell(
                onTap: () {
                  clearFunction();
                },
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.close,
                        size: 12,
                      ),
                    )),
              ),
            )
          else
            const SizedBox(
              width: 0,
            ),
        ],
      ),
    );
  }
}
