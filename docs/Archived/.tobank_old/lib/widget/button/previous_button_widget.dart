import 'package:flutter/material.dart';

import '../../util/theme/theme_util.dart';

class PreviousButtonWidget extends StatelessWidget {
  const PreviousButtonWidget({
    required this.callback,
    required this.buttonTitle,
    required this.isLoading,
    super.key,
  });

  final Function callback;
  final String buttonTitle;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        onTap: () {
          if (!isLoading) {
            callback();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(
            8.0,
          ),
          child: Center(
            child: Text(
              buttonTitle,
              style: TextStyle(
                color: ThemeUtil.textTitleColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
