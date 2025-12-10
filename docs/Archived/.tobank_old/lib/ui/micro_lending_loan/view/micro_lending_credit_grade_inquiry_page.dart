import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../widget/button/continue_button_widget.dart';
import '../../../../controller/micro_lending_loan/micro_lending_loan_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class MicroLendingLoanCreditGradeInquiryPage extends StatelessWidget {
  const MicroLendingLoanCreditGradeInquiryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MicroLendingLoanController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                locale.services_list_title,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SvgIcon(
                    SvgIcons.success,
                    colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    locale.credit_check_service,
                    style: ThemeUtil.hintStyle,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  SvgIcon(
                    SvgIcons.success,
                    colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    locale.returned_cheque_service,
                    style: ThemeUtil.hintStyle,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  SvgIcon(
                    SvgIcons.success,
                    colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    locale.bank_blacklist_service,
                    style: ThemeUtil.hintStyle,
                  ),
                ],
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  controller.checkSamatCbs();
                },
                isLoading: controller.isLoading,
                buttonTitle:locale.inquiry,
              ),
            ],
          ),
        );
      },
    );
  }
}
