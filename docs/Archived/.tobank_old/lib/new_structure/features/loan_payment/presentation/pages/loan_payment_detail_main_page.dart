import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../ui/common/custom_app_bar.dart';
import '../../../../core/entities/loan_details_entity.dart';
import '../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../widgets/loan_payment_bottom_sheet/loan_payment_more_bottom_sheet.dart';
import '../widgets/loan_payment_detail/loan_payment_detail_main_page_scaffold_widget.dart';

class LoanPaymentDetailMainPage extends StatefulWidget {
  final String loanName;
  final String fileNumber;

  const LoanPaymentDetailMainPage({
    required this.loanName,
    required this.fileNumber,
    super.key,
  });

  @override
  State<LoanPaymentDetailMainPage> createState() => _LoanPaymentDetailMainPageState();
}

class _LoanPaymentDetailMainPageState extends State<LoanPaymentDetailMainPage> {

  late LoanDetailsEntity data ;
  bool dataHasInit = false;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(
          moreFunction: dataHasInit ? () {
            showMainBottomSheet(
                context: Get.context!,
                bottomSheetWidget: LoanPaymentMoreBottomSheet(
                  title: locale.loan_format(widget.loanName), data: data,
                ));
          }:null,
          titleString: locale.loan_format(widget.loanName),
          context: context,
        ),
        body: SafeArea(
            child: LoanPaymentDetailMainPageScaffoldWidget(
          fileNumber: widget.fileNumber, getData: (LoanDetailsEntity mainData){
            setState(() {
              data = mainData;
              dataHasInit = true;
            });
            },

        )),
      ),
    );
  }
}
