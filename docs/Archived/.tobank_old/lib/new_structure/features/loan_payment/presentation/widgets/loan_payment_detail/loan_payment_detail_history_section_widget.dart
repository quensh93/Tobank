import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../util/app_util.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../../core/entities/installment_details_entity.dart';
import '../../../../../core/entities/loan_details_entity.dart';
import '../../../../../core/theme/main_theme.dart';

class LoanPaymentDetailHistorySectionWidget extends StatefulWidget {
  final LoanDetailsEntity detailData;

  const LoanPaymentDetailHistorySectionWidget({
    required this.detailData,
    super.key,
  });

  @override
  State<LoanPaymentDetailHistorySectionWidget> createState() =>
      _LoanPaymentDetailHistorySectionWidgetState();
}

class _LoanPaymentDetailHistorySectionWidgetState
    extends State<LoanPaymentDetailHistorySectionWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<InstallmentDetailsEntity> payedList = [];
  final List<InstallmentDetailsEntity> unPayedList = [];
  bool payedListHasProblem = false;
  bool unPayedListHasProblem = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    for (final element in widget.detailData.installments) {
      if (element.isPayed) {
        payedList.add(element);
        if (element.isAfterDelivery ||
            element.isDoubtful ||
            element.isOverUsance ||
            element.isPostPoned) {
          payedListHasProblem = true;
        }
      } else {
        if (element.isAfterDelivery ||
            element.isDoubtful ||
            element.isOverUsance ||
            element.isPostPoned) {
          unPayedListHasProblem = true;
        }
        unPayedList.add(element);
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        TabBar(
          onTap: (int index) {
            setState(() {});
          },
          indicatorColor: MainTheme.of(context).primary,
          dividerColor:  MainTheme.of(context).onSurfaceVariant,
          controller: _tabController,
          indicatorWeight: 3,
          tabs: [
            Tab(
              child: Text(
                locale.unpaid,
                textAlign: TextAlign.center,
                style: MainTheme.of(context).textTheme.titleMedium
              ),
            ),
            Tab(
              child: Text(
                locale.paid,
                textAlign: TextAlign.center,
                style: MainTheme.of(context).textTheme.titleMedium
              ),
            ),
          ],
        ),
        if (_tabController.index == 0)
          historyListWidget(
              historyDataList: unPayedList, hasProblem: unPayedListHasProblem , isPayed: false)
        else if (_tabController.index == 1)
          historyListWidget(
              historyDataList: payedList, hasProblem: payedListHasProblem , isPayed: true)
      ],
    );
  }

  Widget historyListWidget(
      {required List<InstallmentDetailsEntity> historyDataList,
      required bool hasProblem , required bool isPayed}) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {

        //locale
        final locale = AppLocalizations.of(context)!;
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            if (hasProblem) Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21.0),
                  child: getHasProblemWidget(historyDataList[index]),
                ),
              ],
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child:  isPayed ?
              const SvgIcon(
                SvgIcons.loanDetailHistoryItemPayed,
                size: 17.0,
              ):
              SvgIcon(
              SvgIcons.calendar,
                size: 17.0,
                colorFilter: ColorFilter.mode(
                  MainTheme.of(context).black,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        historyDataList[index].deliveryDate,
                        textAlign: TextAlign.center,
                        style:MainTheme.of(context).textTheme.bodyLarge
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${locale.installment_} ${historyDataList[index].installmentNumber}',
                        textAlign: TextAlign.center,
                          style:MainTheme.of(context).textTheme.bodyLarge.copyWith(color: MainTheme.of(context).surfaceContainer)
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        getAmount(historyDataList[index]),
                        textAlign: TextAlign.center,
                        style:MainTheme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        locale.amount,
                        textAlign: TextAlign.center,
                          style:MainTheme.of(context).textTheme.bodyLarge.copyWith(color: MainTheme.of(context).surfaceContainer)
                      ),
                    ],
                  ),
                  if (hasProblem)
                    const SizedBox(width: 70,),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 1,
          color:MainTheme.of(context).onSurfaceVariant,
          thickness: 1,
        );
      },
      itemCount: historyDataList.length,
    );
  }

  String getAmount(InstallmentDetailsEntity data) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final int amount = data.isPayed
        ? (int.parse(data.amount))
        : (int.parse(data.installmentPenalty) +
            int.parse(data.remainingAmount));
    return locale.amount_format(AppUtil.formatMoney(amount));
  }

  Widget getHasProblemWidget(InstallmentDetailsEntity data) {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (data.isPostPoned) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: ShapeDecoration(
          color: MainTheme.of(context).tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Center(
          child: Text(
            locale.postponed,
            textAlign: TextAlign.center,
            style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else if (data.isOverUsance) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: ShapeDecoration(
          color: MainTheme.of(context).tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Center(
          child: Text(
            locale.postponed,
            textAlign: TextAlign.center,
            style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else if (data.isDoubtful) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: ShapeDecoration(
          color: MainTheme.of(context).tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Center(
          child: Text(
            locale.suspicious_arrival,
            textAlign: TextAlign.center,
            style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else if (data.isAfterDelivery) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: ShapeDecoration(
          color: MainTheme.of(context).tertiary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Center(
          child: Text(
            locale.after_maturity,
            textAlign: TextAlign.center,
            style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return const SizedBox(
        width: 8,
      );
    }
  }
}
