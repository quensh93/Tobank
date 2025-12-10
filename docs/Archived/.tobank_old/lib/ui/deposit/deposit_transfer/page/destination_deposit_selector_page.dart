import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/transfer/deposit_transfer_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../widget/destination_deposit_item.dart';

class DestinationDepositSelectorPage extends StatelessWidget {
  const DestinationDepositSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DepositTransferController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24.0),
                  Text(
                   locale.deposit_destination_tourism_bank_number,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: controller.depositDestinationController,
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      fontFamily: 'IranYekan',
                    ),
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      controller.update();
                    },
                    decoration: InputDecoration(
                      filled: false,
                      hintText: locale.enter_destination_deposit_tourism_banknumber,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      errorText:
                          controller.isDestinationNumberValid ? null : locale.enter_destination_deposit_tourism_banknumber,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 16.0,
                      ),
                      suffixIcon: TextFieldClearIconWidget(
                        isVisible: controller.depositDestinationController.text.isNotEmpty,
                        clearFunction: () {
                          controller.depositDestinationController.clear();
                          controller.update();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: controller.destinationDepositDataModelList.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 16.0,
                          ),
                          Image.asset(
                            Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                            height: 140,
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Text(
                            locale.no_number_saved,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              height: 1.6,
                            ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.destinationDepositDataModelList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DestinationDepositItemWidget(
                            depositDataModel: controller.destinationDepositDataModelList[index],
                            selectDepositDataFunction: (depositData) {
                              controller.setSelectedDepositData(depositData);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 12.0);
                        },
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: ContinueButtonWidget(
                callback: () => controller.validateDepositSelector(),
                isLoading: controller.isLoading,
                buttonTitle: locale.continue_label,
                isEnabled: controller.isDepositContinueButtonEnabled(),
              ),
            ),
          ],
        );
      },
    );
  }
}
