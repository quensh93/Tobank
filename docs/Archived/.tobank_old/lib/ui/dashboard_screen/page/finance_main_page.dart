import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/finance_main_page_controller.dart';
import '../../../model/common/main_menu_item_data.dart';
import '../../../model/common/menu_data_model.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class FinanceMainPage extends StatelessWidget {
  const FinanceMainPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<FinanceMainPageController>(
        init: FinanceMainPageController(),
        builder: (controller) {
          final MenuItemData? daranMenuItemData = controller.mainController.menuDataModel.daranService;
          final MainMenuItemData? iconItem =
              DataConstants.getMenuItems().firstWhereOrNull((element) => element.uuid == daranMenuItemData?.uuid);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  if (daranMenuItemData != null)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: context.theme.dividerColor),
                      ),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/sarmayeh.png',
                                height: 160,
                              ),
                              const SvgIcon(
                                SvgIcons.gardeshgariSarmayeh,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 210.0),
                                Text(
                                  locale.tourism_bank_investment_funds,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Padding(
                                  padding: const EdgeInsets.only(right: 32.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgIcon(
                                            SvgIcons.success,
                                            colorFilter:
                                                ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8.0),
                                          Text(
                                            locale.tax_exempt,
                                            style: TextStyle(
                                              color: ThemeUtil.textSubtitleColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16.0),
                                      Row(
                                        children: [
                                          SvgIcon(
                                            SvgIcons.success,
                                            colorFilter:
                                                ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8.0),
                                          Text(
                                            locale.regulated_by_stock_organization,
                                            style: TextStyle(
                                              color: ThemeUtil.textSubtitleColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 36.0),
                                SizedBox(
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.handleDaranButtonClick(daranMenuItemData);
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
                                    child: Text(
                                     locale.start_investing,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(),
                ],
              ),
            ),
          );
        });
  }
}
