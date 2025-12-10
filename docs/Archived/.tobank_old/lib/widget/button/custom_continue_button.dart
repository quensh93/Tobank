import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '/util/app_state.dart';
import '/util/theme/theme_util.dart';

class CustomContinueButton extends StatelessWidget {
  const CustomContinueButton({
    required this.callback,
    required this.buttonTitle,
    required this.state,
    this.isEnabled = true,
    super.key,
  });

  final Function callback;
  final String buttonTitle;
  final AppState state;
  final bool? isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          if (state is! AppLoading && isEnabled == true) {
            callback();
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isEnabled ?? true ? ThemeUtil.primaryColor : context.theme.disabledColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
          ),
          child: (state is AppLoading)
              ? SpinKitFadingCircle(
                  itemBuilder: (_, int index) {
                    return const DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    );
                  },
                  size: 24.0,
                )
              : Text(
                  buttonTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
        ),
      ),
    );
  }
}
