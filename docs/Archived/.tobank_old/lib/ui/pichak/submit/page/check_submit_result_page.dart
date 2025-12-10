import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/check_submit_controller.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';

class CheckSubmitResultPage extends StatelessWidget {
  const CheckSubmitResultPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CheckSubmitController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SvgIcon(
                    controller.registrationResponse.data!.status == 1
                        ? SvgIcons.transactionSuccess
                        : SvgIcons.transactionFailed,
                    size: 56,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    controller.registrationResponse.data!.status == 1 ? locale.cheque_success : locale.cheque_failure,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Card(
                    elevation: 1,
                    margin: EdgeInsets.zero,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          KeyValueWidget(
                            keyString: locale.tracking_id,
                            valueString: controller.registrationResponse.data!.trackingNumber,
                          ),
                          const SizedBox(height: 16.0),
                          MySeparator(color: context.theme.dividerColor),
                          const SizedBox(height: 16.0),
                          KeyValueWidget(
                            keyString: locale.request_registration_time,
                            valueString: DateConverterUtil.getJalaliFromTimestamp(
                                controller.registrationResponse.data!.registrationDate!),
                          ),
                          const SizedBox(height: 16.0),
                          MySeparator(color: context.theme.dividerColor),
                          const SizedBox(height: 16.0),
                          KeyValueWidget(
                            keyString: locale.request_registration_status,
                            valueString: controller.registrationResponse.data!.status == 1 ?locale.request_status_success : locale.request_status_failed,
                          ),
                          const SizedBox(height: 16.0),
                          MySeparator(color: context.theme.dividerColor),
                          const SizedBox(height: 16.0),
                          KeyValueWidget(
                            keyString: locale.request_id,
                            valueString: controller.registrationResponse.data!.requestId,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
