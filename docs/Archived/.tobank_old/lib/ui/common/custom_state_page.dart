import 'package:flutter/material.dart';

import '/util/app_state.dart';
import 'custom_error.dart';
import 'custom_loading.dart';

class CustomStatePage extends StatelessWidget {
  const CustomStatePage({
    required this.state,
    required this.retryFunction,
    super.key,
    this.padding,
    this.backFunction,
  });

  final AppState state;
  final EdgeInsetsGeometry? padding;
  final Function retryFunction;
  final Function? backFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (state is AppLoading)
            const Expanded(
              child: CustomLoading(),
            )
          else if (state is AppError)
            Expanded(
              child: CustomError(
                message: (state as AppError).message,
                retryFunction: retryFunction,
                backFunction: backFunction,
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }
}
