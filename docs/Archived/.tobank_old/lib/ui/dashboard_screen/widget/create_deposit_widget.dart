import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/deposit_main_page_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class CreateDepositWidget extends StatelessWidget {
  const CreateDepositWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DepositMainPageController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          constraints: const BoxConstraints(minHeight: 258),
          child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SvgIcon(
                        SvgIcons.gardeshgari,
                        size: 32.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                       locale.bank_deposit_opening,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgIcon(
                        SvgIcons.success,
                        colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        size: 16,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        locale.deposit_description,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.getDepositTypeRequest();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: ThemeUtil.primaryColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                      ),
                      child: controller.isDepositTypeLoading
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
                          :  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Icon(Icons.add, color: Colors.white),
                                const SizedBox(width: 8.0),
                                Text(
                                  locale.deposit_button_opening,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
