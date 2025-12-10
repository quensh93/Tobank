import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/safe_box/add_safe_box_controller.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../widget/branch_item_widget.dart';
import '../widget/city_item_widget.dart';

class AddSafeBoxBranchListPage extends StatelessWidget {
  const AddSafeBoxBranchListPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AddSafeBoxController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) {
                controller.searchBranch(value);
              },
              controller: controller.searchTextController,
              textDirection: TextDirection.rtl,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                fontFamily: 'IranYekan',
              ),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                filled: false,
                hintText: locale.search_box_placeholder,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SvgIcon(
                    SvgIcons.search,
                  ),
                ),
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
                suffixIcon: TextFieldClearIconWidget(
                  isVisible: controller.searchTextController.text.isNotEmpty,
                  clearFunction: () {
                    controller.clearSearchTextField();
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CityItemWidget(
                    safeBoxCityData: controller.safeBoxCityListResponseData!.data![index],
                    selectedSafeBoxCityData: controller.selectedSafeBoxCityData,
                    returnDataFunction: (safeBoxCityData) {
                      controller.setSelectedSafeBoxCityData(safeBoxCityData);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 8.0,
                  );
                },
                itemCount: controller.safeBoxCityListResponseData!.data!.length),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              itemBuilder: (context, index) {
                return BranchItemWidget(
                  selectedBranchResult: controller.selectedBranchResult,
                  branchResult: controller.branchResultList![index],
                  returnDataFunction: (branchResult) {
                    controller.setSelectedBranch(branchResult);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16.0,
                );
              },
              itemCount: controller.branchResultList!.length,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ContinueButtonWidget(
                  callback: () {
                    controller.validateSecondPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle:locale.continue_label,
                  isEnabled: controller.selectedBranchResult != null,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      );
    });
  }
}
