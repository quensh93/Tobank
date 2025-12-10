import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/safe_box/request_visit_safe_box_controller.dart';
import '../../../../model/safe_box/response/user_safe_box_list_response_data.dart';
import '../../common/custom_app_bar.dart';
import '../../common/virtual_branch_loading_page.dart';
import 'view/request_visit_safe_box_final_page.dart';
import 'view/request_visit_select_date_page.dart';

class RequestVisitSafeBoxScreen extends StatelessWidget {
  const RequestVisitSafeBoxScreen({
    required this.safeBoxData,
    super.key,
  });

  final SafeBoxData safeBoxData;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RequestVisitSafeBoxController>(
      init: RequestVisitSafeBoxController(safeBoxData: safeBoxData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.visit_request,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          VirtualBranchLoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.getListOfReferDateTimeRequest();
                            },
                          ),
                          const RequestVisitSelectDatePage(),
                          const RequestVisitSafeBoxFinalPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
