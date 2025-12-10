import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/daran/daran_controller.dart';
import '../../model/common/menu_data_model.dart';
import '../../widget/svg/svg_icon.dart';
import '../common/loading_page.dart';
import 'view/daran_web_view.dart';

class DaranScreen extends StatelessWidget {
  const DaranScreen({
    super.key,
    this.menuItemData,
  });

  final MenuItemData? menuItemData;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<DaranController>(
      init: DaranController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: PopScope(
            canPop: false,
            onPopInvoked: controller.onBackPressed,
            child: Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    DaranHeaderWidget(
                      showSupportButton: false,
                      hideBackButton: true,
                      returnFunction: () {
                        controller.onBackPressed(false);
                      },
                    ),
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          LoadingPage(
                            controller.errorTitle,
                            hasError: controller.hasError,
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            isLoading: controller.isLoading,
                            retryFunction: () {
                              controller.getDaranRequest();
                            },
                          ),
                          const DaranWebView(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DaranHeaderWidget extends StatelessWidget {
  const DaranHeaderWidget({
    super.key,
    this.returnFunction,
    this.hideBackButton,
    this.showSupportButton = true,
  });

  final Function? returnFunction;
  final bool? hideBackButton;
  final bool showSupportButton;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          height: 48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                width: 80.0,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: SvgIcon(
                  SvgIcons.tobankRed,
                  size: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 1,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        locale.close,
                        style: context.theme.textTheme.bodyLarge,
                      )),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
      ],
    );
  }
}
