import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/destination_notebook/deposit_notebook_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../widget/deposit_notebook_item.dart';

class DepositListPage extends StatelessWidget {
  const DepositListPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DepositNotebookController>(
      builder: (controller) {
        return Container(
          child: controller.notebookDepositDataList.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: 16.0,
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                        itemCount: controller.notebookDepositDataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DepositNotebookItem(
                            depositDataModel: controller.notebookDepositDataList[index],
                            selectedDepositDataModel: controller.selectedDepositDataModel,
                            editCallBack: (cardDataModel) => controller.showEditDepositPage(cardDataModel),
                            deleteCallBack: (depositDataModel) {
                              controller.deleteDeposit(depositDataModel);
                            },
                            isDeleteLoading: controller.isDeleteLoading,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 16.0);
                        },
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                      height: 180,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      locale.no_number_saved,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
