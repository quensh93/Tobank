import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/transfer/deposit_transfer_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../widget/destination_deposit_item.dart';

class DestinationIbanSelectorPage extends StatelessWidget {
  const DestinationIbanSelectorPage({super.key});

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24.0),
                  Text(
                    locale.destination_shaba,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    crossAxisAlignment:
                        controller.isDestinationNumberValid ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.ibanDestinationController,
                          textDirection: TextDirection.ltr,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(26),
                          ],
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            controller.update();
                          },
                          decoration: InputDecoration(
                            counterText: '',
                            filled: false,
                            hintText: locale.enter_shaba,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isDestinationNumberValid ? null : controller.destinationErrorText,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(8.0),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 16.0,
                            ),
                            suffixIcon: ExcludeFocus(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if (controller.ibanDestinationController.text.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0),
                                      child: InkWell(
                                        onTap: () {
                                          controller.ibanDestinationController.clear();
                                          controller.update();
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.withOpacity(0.2),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.all(6.0),
                                              child: Icon(
                                                Icons.close,
                                                size: 12,
                                              ),
                                            )),
                                      ),
                                    )
                                  else
                                    const SizedBox(
                                      width: 0,
                                    ),
                                  Container(),
                                  const SizedBox(
                                    width: 54.0,
                                    height: 54.0,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 1.0),
                                      child: Center(
                                        child: Text(
                                          'IR',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: controller.destinationIbanDataModelList.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.destinationIbanDataModelList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DestinationDepositItemWidget(
                            isIban: true,
                            depositDataModel: controller.destinationIbanDataModelList[index],
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
                callback: () => controller.validateIbanSelector(),
                isLoading: controller.isLoading,
                buttonTitle: locale.continue_label,
                isEnabled: controller.isIbanContinueButtonEnabled(),
              ),
            )
          ],
        );
      },
    );
  }
}
