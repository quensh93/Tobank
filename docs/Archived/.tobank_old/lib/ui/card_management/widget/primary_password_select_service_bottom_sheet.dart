import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/card_management/card_management_controller.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import 'service_item_widget.dart';

class PrimaryPasswordSelectServiceBottomSheet extends StatelessWidget {
  const PrimaryPasswordSelectServiceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CardManagementController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 36,
                        height: 4,
                        decoration:
                            BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(locale.select_service_you_want, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 24.0,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DataConstants.getPrimaryPinTypeDataList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return ServiceItemWidget(
                      serviceTypeData: DataConstants.getPrimaryPinTypeDataList()[index],
                      selectedService: controller.selectedPrimaryService,
                      returnDataFunction: (serviceType) {
                        controller.setPrimarySelectService(serviceType);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 12.0,
                    );
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.goToPrimaryPasswordScreen();
                  },
                  isLoading: false,
                  buttonTitle: locale.continue_label,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
