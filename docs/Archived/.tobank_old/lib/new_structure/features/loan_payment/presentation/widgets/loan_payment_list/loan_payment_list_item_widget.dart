import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../util/date_picker/month_name_handler.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../../core/entities/installment_list_data_entity.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../pages/loan_payment_detail_main_page.dart';

class LoanPaymentListItemWidget extends StatelessWidget {
  final InstallmentListDataEntity installmentData;

  const LoanPaymentListItemWidget({
    required this.installmentData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: MainTheme.of(context).onSurfaceVariant),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          SvgIcon(
            ///todo: use dark icon for dark mode
            (Get.isDarkMode) ? SvgIcons.loanListItemLight : SvgIcons.loanListItemLight,
            size: 41.0,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            installmentData.loan,
            textAlign: TextAlign.center,
              style: MainTheme.of(context).textTheme.titleMedium
          ),
          if ((installmentData.delayedInstallmentNumber) == 0)
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                locale.next_pay_date(installmentData.nextPayDate),
                textAlign: TextAlign.center,
                  style: MainTheme.of(context).textTheme.bodyLarge.copyWith(color: MainTheme.of(context).surfaceContainer)
              ),
            )
          else
            const SizedBox(height: 24),
          InkWell(
            onTap: () {
              Get.to(() => LoanPaymentDetailMainPage(
                    fileNumber: installmentData.fileNumber,
                    loanName: installmentData.loan,
                  ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: ShapeDecoration(
                color: const Color(0xFFD61F2C),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Center(
                child: Text(
                  locale.view_details,
                  textAlign: TextAlign.center,
                  style: MainTheme.of(context).textTheme.titleSmall.copyWith(color: Colors.white)
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if ((installmentData.delayedInstallmentNumber) > 0)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: const Color(0x19F7941D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Center(
                child: Row(
                  children: [
                    const SvgIcon(
                      SvgIcons.loanListItemAlert,
                      size: 20.0,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      locale.unpayed_loans_number(installmentData.delayedInstallmentNumber),
                      textAlign: TextAlign.center,
                      style:MainTheme.of(context).textTheme.bodyLarge.copyWith(color: MainTheme.of(context).surfaceContainer)
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                color: MainTheme.of(context).surface,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Color(0xFFEAECF0)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Center(
                child: Row(
                  children: [
                     SvgIcon(
                      Get.isDarkMode ? SvgIcons.alertDark : SvgIcons.alertLight,
                      size: 20.0,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${locale.payment_deadline_without_penalty_installments} ${installmentData.firstUnpaidInstallmentNumber} ${locale.until_end_of_the_day} ${dateToPersian(dateString: installmentData.deliveryDate)} ${locale.is_}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2, // Ensure it does not exceed two lines
                        textAlign: TextAlign.right,
                        style: MainTheme.of(context).textTheme.bodyLarge.copyWith(color: MainTheme.of(context).surfaceContainer)
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

String dateToPersian({required String dateString}) {
  return "${dateString.split('/')[2]} ${int.parse(dateString.split('/')[1]).getMonthName(true)} ${dateString.split('/')[0]}";
}
