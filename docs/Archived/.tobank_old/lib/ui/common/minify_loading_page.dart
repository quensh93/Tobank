import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/theme/theme_util.dart';

class MinifyLoadingPage extends StatelessWidget {
  const MinifyLoadingPage(
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
    final locale = AppLocalizations.of(Get.context!)!;
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isLoading!)
            SpinKitFadingCircle(
              itemBuilder: (_, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.theme.iconTheme.color,
                  ),
                );
              },
              size: 32.0,
            )
          else
            hasError!
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        height: 24.0,
                      ),
                      SizedBox(
                        height: 56.0,
                        child: OutlinedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: context.theme.dividerColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            retryFunction!();
                          },
                          child: isLoading!
                              ? SpinKitFadingCircle(
                                  itemBuilder: (_, int index) {
                                    return DecoratedBox(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: context.theme.colorScheme.secondary),
                                    );
                                  },
                                  size: 24.0,
                                )
                              : Text(
                                 locale.try_again,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  )
                : Container(),
        ],
      ),
    );
  }
}
