import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/deposit_main_page_controller.dart';
import '../../../util/theme/theme_util.dart';
import 'open_deposit_type_item.dart';

class SelectDepositTypeBottomSheet extends StatelessWidget {
  const SelectDepositTypeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<DepositMainPageController>(
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
                Text(locale.select_deposit_message, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 24.0,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return OpenDepositTypeItemWidget(
                            depositType: controller.depositTypeResponseData!.data!.depositTypes![index],
                            returnDataFunction: (depositType) {
                              controller.validateSelectedDepositType(depositType);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 16.0,
                          );
                        },
                        itemCount: controller.depositTypeResponseData!.data!.depositTypes!.length),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
