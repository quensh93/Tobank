import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/dashboard_controller.dart';
import '../../../widget/svg/svg_icon.dart';

class TobankServicesWidget extends StatelessWidget {
  const TobankServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DashboardController>(builder: (controller) {
      return Column(
        children: [
          ListTile(
            title: Text(
              locale.tobank_special_services,
              style: context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(children: [
              Expanded(
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: context.theme.dividerColor,
                      width: 0.5,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      controller.showFacilityScreen();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgIcon(
                                Get.isDarkMode ? SvgIcons.creditCardDark : SvgIcons.creditCard,
                                size: 24.0,
                              ),
                              const SizedBox(width: 12.0),
                              Text(
                               locale.loan_types,
                                style: context.theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            locale.loan_types_description,
                            // style: context.theme.textTheme.titleSmall,
                            style: context.theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: context.theme.dividerColor,
                      width: 0.5,
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      controller.showTobankServicesScreen();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgIcon(
                                Get.isDarkMode ? SvgIcons.promissoryDark : SvgIcons.promissory,
                                size: 24.0,
                              ),
                              const SizedBox(width: 12.0),
                              Text(
                               locale.other_services,
                                style: context.theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            locale.other_services_description,
                            style: context.theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      );
    });
  }
}
