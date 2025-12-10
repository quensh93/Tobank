import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../core/entities/loan_details_entity.dart';
import '../../../../../core/theme/main_theme.dart';

class LoanPaymentMoreDetailBottomSheet extends StatelessWidget {
  final LoanDetailsEntity data;

  const LoanPaymentMoreDetailBottomSheet({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color:  MainTheme.of(context).onSurfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
           locale.loan_details_,
            style: ThemeUtil.titleStyle,
          ),
          const SizedBox(
            height: 32.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      locale.amount_format(AppUtil.formatMoney(data.approvedAmount)),
                      textAlign: TextAlign.right,
                      style: MainTheme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      locale.loan_amount_,
                      textAlign: TextAlign.right,
                      style: MainTheme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 16,
                thickness: 1,
                color: MainTheme.of(context).onSurface,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      data.debt,
                      textAlign: TextAlign.right,
                      style: MainTheme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      locale.total_loan_remain,
                      textAlign: TextAlign.right,
                      style: MainTheme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 16,
                thickness: 1,
                color:MainTheme.of(context).onSurface,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      data.grantDate,
                      textAlign: TextAlign.right,
                      style: MainTheme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      locale.loan_granting_date,
                      textAlign: TextAlign.right,
                      style: MainTheme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 16,
                thickness: 1,
                color: MainTheme.of(context).onSurface,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      lastPaymentDate(),
                      // data.installments[data.installmentsPaidNumber-1].deliveryDate,
                      textAlign: TextAlign.right,
                      style: MainTheme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      locale.last_repayment_date,
                      textAlign: TextAlign.right,
                      style: MainTheme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 16,
                thickness: 1,
                color: MainTheme.of(context).onSurface,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      data.fileNumber,
                      textAlign: TextAlign.right,
                      style: MainTheme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      locale.facility_file_number,
                      textAlign: TextAlign.right,
                      style: MainTheme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  String lastPaymentDate() {
    if (data.installments[data.installmentsPaidNumber].installmentPayments != null &&
        data.installments[data.installmentsPaidNumber].installmentPayments!.isNotEmpty) {
      return data.installments[data.installmentsPaidNumber].installmentPayments!.last.date;
    }else if(data.installmentsPaidNumber ==0){
      return '-';
    }else{}

    return data.installments[data.installmentsPaidNumber -1].installmentPayments!.last.date;
  }
}
