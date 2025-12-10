import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_requests_history_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../widget/promissory_requests_history_item_widget.dart';

class PromissoryRequestsHistoryPage extends StatelessWidget {
  const PromissoryRequestsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryRequestsHistoryController>(builder: (controller) {
      return Column(
        children: [
          Expanded(
            child: controller.promissoryRequests.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                        height: 200,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.no_request_found,
                        style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 14.0),
                      ),
                    ],
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    itemBuilder: (context, index) {
                      final request = controller.promissoryRequests[index];
                      return PromissoryRequestsHistoryItemWidget(
                          promissoryRequest: request,
                          cancelRequestFunction: () {
                            controller.cancelRequest(request);
                          },
                          continueRequestFunction: () {
                            controller.showContinueRequestScreen(request);
                          });
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 16.0,
                      );
                    },
                    itemCount: controller.promissoryRequests.length,
                  ),
          ),
        ],
      );
    });
  }
}
