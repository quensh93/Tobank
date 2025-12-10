import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../widget/button/continue_button_widget.dart';
import '../../widget/button/previous_button_widget.dart';

class VirtualBranchLoadingPage extends StatelessWidget {
  const VirtualBranchLoadingPage(
    this.title, {
    super.key,
    this.hasError,
    this.isLoading,
    this.retryFunction,
    this.backFunction,
    this.padding,
  });

  final bool? hasError;
  final String? title;
  final bool? isLoading;
  final Function? retryFunction;
  final EdgeInsetsGeometry? padding;
  final Function? backFunction;

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
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            height: 1.6,
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
                            if (backFunction == null) {
                              Get.back();
                            } else {
                              backFunction!();
                            }
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
