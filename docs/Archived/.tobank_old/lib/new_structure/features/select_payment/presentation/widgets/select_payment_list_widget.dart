import 'package:flutter/material.dart';
import '../../../../core/entities/deposits_list_entity.dart';
import 'select_payment_item_widget.dart';

class SelectPaymentListWidget extends StatefulWidget {
  final List<DepositsListEntity> paymentList;
  final int selectedIndex;
  final Function onTap;
  final int amount;

  const SelectPaymentListWidget({
    required this.paymentList,
    required this.selectedIndex,
    required this.onTap,
    required this.amount,
    super.key,
  });

  @override
  State<SelectPaymentListWidget> createState() => _SelectPaymentListWidgetState();
}

class _SelectPaymentListWidgetState extends State<SelectPaymentListWidget> {


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(() {
              widget.onTap(index);
            });
          },
          child: SelectPaymentItemWidget(
            isSingleCard: widget.paymentList.length==1,
            depositsData: widget.paymentList[index],
            isSelected: widget.selectedIndex == index,
            amount: widget.amount,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 16,
        );
      },
      itemCount: widget.paymentList.length,
    );
  }
}
