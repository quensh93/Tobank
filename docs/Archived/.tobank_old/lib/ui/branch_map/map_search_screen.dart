import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/branch_map/map_search_controller.dart';
import '../../model/bank_branch_list_data.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';
import '../common/custom_app_bar.dart';
import '../common/text_field_clear_icon_widget.dart';
import 'widget/branch_item_widget.dart';

class MapSearchScreen extends StatelessWidget {
  const MapSearchScreen({required this.bankBranchListData, super.key});

  final List<BankBranchListData> bankBranchListData;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MapSearchController>(
        init: MapSearchController(bankBranchListData: bankBranchListData, allBankBranchListData: bankBranchListData),
        builder: (controller) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.bank_branches,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: SizedBox(
                              height: 48.0,
                              child: TextField(
                                onChanged: (value) {
                                  controller.search();
                                },
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                                textInputAction: TextInputAction.search,
                                onSubmitted: (term) {
                                  controller.search();
                                },
                                controller: controller.searchController,
                                decoration: InputDecoration(
                                  filled: false,
                                  hintText: locale.search_by_name_and_branch_code,
                                  hintStyle: ThemeUtil.hintStyle,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 16.0,
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: SvgIcon(
                                      SvgIcons.search,
                                    ),
                                  ),
                                  suffixIcon: TextFieldClearIconWidget(
                                    isVisible: controller.searchController.text.isNotEmpty,
                                    clearFunction: () {
                                      controller.searchController.clear();
                                      controller.search();
                                      controller.update();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              itemCount: controller.bankBranchListData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return BankBranchItemWidget(
                                  bankBranchListData: controller.bankBranchListData[index],
                                  returnDataFunction: (bankBranchListData) {
                                    controller.returnData(bankBranchListData);
                                  },
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 16.0);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
