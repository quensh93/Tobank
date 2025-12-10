import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/bank_info/bank_info_controller.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';
import '../common/custom_app_bar.dart';

class BankInfoScreen extends StatelessWidget {
  const BankInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<BankInfoController>(
        init: BankInfoController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              titleString: locale.bank_information,
              context: context,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 64.0,
                      child: Card(
                        elevation: Get.isDarkMode ? 1 : 0,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(locale.customer_number,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(controller.getCustomerNumber() ?? '-',
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        controller.handleCustomerAddress();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: context.theme.dividerColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              SvgIcon(
                                SvgIcons.location,
                                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                child: Text(
                                  locale.address_registered_in_the_bank,
                                  style: ThemeUtil.titleStyle,
                                ),
                              ),
                              SvgIcon(
                                SvgIcons.arrowLeft,
                                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
