import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/check_receive_controller.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';

class CheckReceiveResultPage extends StatelessWidget {
  const CheckReceiveResultPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CheckReceiveController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SvgIcon(
                SvgIcons.transactionSuccess,
                size: 56,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                controller.isConfirm ? locale.cheque_confirmation_success : locale.cheque_confirmation_failed,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 40.0,
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
                        valueString: controller.confirmationResponse.data!.trackingNumber,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.request_registration_time,
                        valueString: DateConverterUtil.getJalaliFromTimestamp(
                            controller.confirmationResponse.data!.registrationDate!),
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.request_registration_status,
                        valueString: controller.confirmationResponse.data!.status == 1 ? locale.request_status_success : locale.request_status_failed,
                      ),
                      const SizedBox(height: 16.0),
                      MySeparator(color: context.theme.dividerColor),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.request_id,
                        valueString: controller.confirmationResponse.data!.requestId,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
