import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/safe_box/request_visit_safe_box_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/key_value_widget.dart';

class RequestVisitSafeBoxFinalPage extends StatelessWidget {
  const RequestVisitSafeBoxFinalPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RequestVisitSafeBoxController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Card(
                elevation: 1,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const SvgIcon(
                            SvgIcons.successNew,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            locale.request_visit_box_successful,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      KeyValueWidget(
                        valueString: controller.getSelectedDate(),
                        keyString: locale.visit_date,
                      ),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        valueString: controller.getSelectedDate(),
                        keyString: locale.selected_time_period,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        locale.branch_address,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          height: 1.6,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        controller.getAddressOfBranch(),
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          height: 1.6,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
