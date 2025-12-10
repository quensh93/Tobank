import 'package:flutter/material.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../../core/entities/enums.dart';
import '../../../../core/entities/payment_data.dart';
import '../../../../core/theme/main_theme.dart';
import '../widgets/select_payment_list_main_page_scaffold_widget.dart';

class SelectPaymentListMainPage extends StatefulWidget {
  final PaymentData paymentData;

  const SelectPaymentListMainPage({
    required this.paymentData,
    super.key,
  });

  @override
  State<SelectPaymentListMainPage> createState() => _SelectPaymentListMainPageState();
}

class _SelectPaymentListMainPageState extends State<SelectPaymentListMainPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                height: 24.0,
              ),
              if (widget.paymentData.paymentType == PaymentListType.myselfLoan ||
                  widget.paymentData.paymentType == PaymentListType.othersLoan)
                Text(
                  widget.paymentData.paymentType.getString(context),
                  style: ThemeUtil.titleStyle,
                )
              else
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: MainTheme.of(context).white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: MainTheme.of(context).surfaceContainerLowest)),
                  child: SvgIcon(
                    widget.paymentData.getChargeAndPackagePaymentData().operatorType.getIcon(context),
                    size: 40.0,
                  ),
                ),
              const SizedBox(
                height: 16.0,
              ),
              SelectPaymentListMainPageScaffoldWidget(
                paymentData: widget.paymentData,
                // nationalCode: nationalCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
