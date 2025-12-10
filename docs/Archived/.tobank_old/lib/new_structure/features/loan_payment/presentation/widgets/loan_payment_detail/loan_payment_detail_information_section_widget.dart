import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:string_validator/string_validator.dart';

import '../../../../../../util/app_util.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../../core/entities/loan_details_entity.dart';
import '../../../../../core/theme/main_theme.dart';
class LoanPaymentDetailInformationSectionWidget extends StatelessWidget {
  final LoanDetailsEntity detailData;

  const LoanPaymentDetailInformationSectionWidget({
    required this.detailData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    final percentage = (detailData.installmentsPaidNumber / detailData.installmentsNumber.toInt()) * 100 ;
    final ValueNotifier<double> _valueNotifier = ValueNotifier(0);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(color:MainTheme.of(context).onSurfaceVariant),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: DashedCircularProgressBar.aspectRatio(
                aspectRatio:1, // width ÷ height
                valueNotifier: _valueNotifier,
                progress: percentage,
                corners: StrokeCap.butt,
                foregroundColor: MainTheme.of(context).primary,


                backgroundColor: MainTheme.of(context).onSurface,
                foregroundStrokeWidth: 6,
                backgroundStrokeWidth: 6,
                animation: true,
                child:  Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Container(

                      decoration:  ShapeDecoration(
                        color: MainTheme.of(context).onSurface,
                        shape: const OvalBorder(),
                      ),
                      child: Center(
                        child:  SvgIcon(
                          color: ThemeUtil.primaryColor,
                          SvgIcons.loanDetailInformation,
                          size: 43.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              locale.amount_format(AppUtil.formatMoney(detailData.approvedAmount)),
              textAlign: TextAlign.center,
              style: MainTheme.of(context).textTheme.titleMedium
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              locale.installments_pay_date_range(detailData.installmentsPaidNumber,detailData.installmentsNumber),
              textAlign: TextAlign.center,
              style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
                color: MainTheme.of(context).surfaceContainer
              )
            ),
            const SizedBox(height: 31),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 44,
                  child: VerticalDivider(
                    width: 1,
                    color: MainTheme.of(context).onSurfaceVariant,
                    thickness: 1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          locale.settled,
                          textAlign: TextAlign.center,
                          style:MainTheme.of(context).textTheme.bodyLarge.copyWith(
                          color: MainTheme.of(context).surfaceContainer
                          )
                        ),
                        const SizedBox(height: 8),
                        Text(
                          locale.amount_format(AppUtil.formatMoney(detailData.settlement)),
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.titleMedium
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          locale.outstanding_debt,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
                          color: MainTheme.of(context).surfaceContainer)
                        ),
                        const SizedBox(height: 8),
                        Text(
                          locale.amount_format(AppUtil.formatMoney(detailData.debt)),
                          textAlign: TextAlign.center,
                            style: MainTheme.of(context).textTheme.titleMedium
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
