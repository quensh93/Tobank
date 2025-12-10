import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_finalized_history_controller.dart';
import '../../../../../util/data_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import 'promissory_role_type_filter_widget.dart';

class PromissoryFilterBottomSheet extends StatelessWidget {
  const PromissoryFilterBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<PromissoryFinalizedHistoryController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  color: Get.isDarkMode ? context.theme.colorScheme.surface : Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 36,
                                height: 4,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(2)), color: Color(0xffe3e3e3))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.filters,
                              style: TextStyle(
                                  color: ThemeUtil.textTitleColor, fontWeight: FontWeight.bold, fontSize: 18.0),
                            ),
                            InkWell(
                              onTap: () {
                                controller.deleteFilters();
                              },
                              child: Text(
                                locale.remove_filters,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  color: context.theme.colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Text(
                              locale.my_actions,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                fontFamily: 'IranYekan',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 16.0,
                        children: DataConstants.roleFilterList()
                            .map((item) {
                              return PromissoryRoleTypeFilterWidget(
                                filterItemData: item,
                                selectedPromissoryRoleType: controller.selectedRole,
                                returnDataFunction: (filterItemData) {
                                  controller.filterRoleType(filterItemData);
                                },
                              );
                            })
                            .toList()
                            .cast<Widget>(),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
