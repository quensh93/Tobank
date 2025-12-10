import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';
import '../../widget/button/previous_button_widget.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage(
    this.title, {
    super.key,
    this.hasError,
    this.isLoading,
    this.retryFunction,
    this.padding,
  });

  final bool? hasError;
  final String? title;
  final bool? isLoading;
  final Function? retryFunction;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading!)
            Expanded(
              child: SpinKitFadingCircle(
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.iconTheme.color,
                    ),
                  );
                },
                size: 40.0,
              ),
            )
          else
            hasError!
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          title!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        ContinueButtonWidget(
                          callback: () {
                            retryFunction!();
                          },
                          isLoading: isLoading ?? false,
                          buttonTitle: locale.try_again,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        PreviousButtonWidget(
                          callback: () {
                            Get.back();
                          },
                          buttonTitle: locale.return_,
                          isLoading: isLoading ?? false,
                        ),
                      ],
                    ),
                  )
                : Container(),
        ],
      ),
    );
  }
}
