import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_detail_controller.dart';
import '../../../../../model/promissory/promissory_single_info.dart';
import '../widget/promissory_guarantee_item_widget.dart';

class PromissoryGuaranteePage extends StatelessWidget {
  const PromissoryGuaranteePage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryDetailController>(builder: (controller) {
      return Column(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: controller.promissoryInfo!.guarantors!.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                        height: 180,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                       Text(
                       locale.no_guarantor_found,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    itemBuilder: (context, index) {
                      return PromissoryGuaranteeItemWidget(
                        guarantor: controller.promissoryInfo!.guarantors![index],
                        isLoading: controller.isLoading,
                        showFilePdfCallback: (Guarantor guarantor) {
                          controller.fetchGuaranteePdfDocument(guarantor);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16.0,
                      );
                    },
                    itemCount: controller.promissoryInfo!.guarantors!.length,
                  ),
          ),
        ],
      );
    });
  }
}
