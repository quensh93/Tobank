import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/transfer/deposit_transfer_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/theme/theme_util.dart';
import 'transfer_method_item_widget.dart';

class DepositTransferTypeBottomSheet extends StatelessWidget {
  const DepositTransferTypeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<DepositTransferController>(
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
                Text(locale.select_transfer_method, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: AppUtil.getTransferMethodDataList(
                          [0,1,2,4])
                      .length,
                  itemBuilder: (BuildContext context, int index) {
                    return TransferMethodItemWidget(
                      transferMethodData: AppUtil.getTransferMethodDataList(
                          [0,1,2,4])[index],
                      selectedTransferMethodData: controller.selectedTransferMethodData,
                      tapToSelectFunction: (transferMethodData) {
                        controller.setSelectedTransferMethodData(transferMethodData);
                      },
                      supportedTransferTypes: controller.ibanInquiryResponseData!.data!.supportedTransferTypes ?? [],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 12.0,
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
