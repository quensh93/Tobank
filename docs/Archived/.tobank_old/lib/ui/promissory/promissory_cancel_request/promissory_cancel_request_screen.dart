import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/promissory/promissory_cancel_request_controller.dart';
import '../../../../model/promissory/response/promissory_request_history_response_data.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../common/custom_app_bar.dart';

class PromissoryCancelRequestScreen extends StatelessWidget {
  const PromissoryCancelRequestScreen({
    required this.promissoryRequest,
    super.key,
  });

  final PromissoryRequest promissoryRequest;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<PromissoryCancelRequestController>(
          init: PromissoryCancelRequestController(promissoryRequest: promissoryRequest),
          builder: (controller) {
            return Scaffold(
              appBar: CustomAppBar(
                titleString: locale.cancel_request_button,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    // TODO: change UI
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: Container()),
                            const SvgIcon(
                              SvgIcons.signPdf,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              locale.finalize_cancel_request,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                            Expanded(child: Container()),
                            ContinueButtonWidget(
                              callback: () {
                                controller.cancelRequest();
                              },
                              isLoading: controller.isLoading,
                              buttonTitle: locale.cancel_request_button,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
