import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/process_detail/process_detail_controller.dart';
import '../common/custom_app_bar.dart';
import '../common/virtual_branch_loading_page.dart';
import 'view/process_detail_page.dart';

class ProcessDetailScreen extends StatelessWidget {
  const ProcessDetailScreen({
    required this.processInstanceId,
    super.key,
  });

  final String processInstanceId;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ProcessDetailController>(
        init: ProcessDetailController(processInstanceId: processInstanceId),
        builder: (controller) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.process_details,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
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
                              controller.getProcessDetailRequest();
                            },
                          ),
                          const ProcessDetailPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
