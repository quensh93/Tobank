import 'package:flutter/cupertino.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../../../util/theme/theme_util.dart';
import '../../../../../core/entities/charge_and_package_list_data_entity.dart';
import '../../../../../core/entities/charge_and_package_payment_plan_params.dart';
import '../../../../../core/entities/enums.dart';
import '../../../../../core/entities/payment_data.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import '../../../../../core/widgets/buttons/main_button.dart';
import '../../../../../core/widgets/buttons/main_text_field.dart';
import '../../../../select_payment/presentation/pages/select_payment_list_main_page.dart';

class GetAmountBottomSheet extends StatefulWidget {
  final String mobile;
  final ChargeAndPackageListDataEntity data;

  const GetAmountBottomSheet({
    required this.data,
    required this.mobile,
    super.key,
  });

  @override
  State<GetAmountBottomSheet> createState() => _GetAmountBottomSheetState();
}

class _GetAmountBottomSheetState extends State<GetAmountBottomSheet> {
  final TextEditingController textController = TextEditingController();
  List<ChargeAmount> mainAmountList = [];
  late ChargeAndPackageTagType productType;

  String? errorText;
  bool isAmazing = false;
  bool isOptional = false;

  int selectedIndex = -1;

  void onAmountSelected(int index) {
    setState(() {
      isOptional = false;
      textController.text = '';
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    //locale
    if (widget.data.findAllResponse!.content != null && widget.data.findAllResponse!.content!.isNotEmpty) {
      if (widget.data.findAllResponse!.content!
          .where((item) => item.tags?[0] == ChargeAndPackageTagType.NORMAL)
          .isNotEmpty) {
        mainAmountList = widget.data.findAllResponse!.content!
            .where((item) => item.tags?[0] == ChargeAndPackageTagType.NORMAL)
            .first
            .amounts!;
        mainAmountList.sort((a, b) => a.amount!.compareTo(b.amount!));
        productType = ChargeAndPackageTagType.NORMAL;
      } else if (widget.data.findAllResponse!.content!
          .where((item) => item.tags?[0] == ChargeAndPackageTagType.OPTIONARY)
          .isNotEmpty) {
        selectedIndex = -1;
        isOptional = true;
        productType = ChargeAndPackageTagType.OPTIONARY;
      } else {
        Get.back();
      }
    } else {
      Get.back();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: MainTheme.of(context).onSurfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                locale.charge_amount,
                style: ThemeUtil.titleStyle,
              ),
              if (widget.data.findAllResponse!.content!
                  .where((item) => item.tags?[0] == ChargeAndPackageTagType.NORMAL)
                  .isNotEmpty)
                const SizedBox(
                  height: 45.0,
                ),
              if (widget.data.findAllResponse!.content!
                  .where((item) => item.tags?[0] == ChargeAndPackageTagType.NORMAL)
                  .isNotEmpty)
                SelectChargeAmountFromPreSets(
                  changeAmount: (int index) {
                    onAmountSelected(index);
                  },
                  selectedIndex: selectedIndex,
                  isAmazing: isAmazing,
                  mainAmountList: mainAmountList,
                ),
              const SizedBox(
                height: 32.0,
              ),
              if (!isAmazing)
                MainTextField(
                  textController: textController,
                  onChanged: () {
                    setState(() {
                      selectedIndex = -1;
                      isOptional = true;
                      productType = ChargeAndPackageTagType.OPTIONARY;
                      if (errorText != null) {
                        errorText = null;
                      }
                    });
                  },
                  hintText: locale.desired_amount,
                  hasRialBadge: true,
                  hasSeparator: true,
                  hasError: errorText != null,
                  errorText: errorText,
                ),
              if (!isAmazing &&
                  widget.data.findAllResponse!.content!
                      .where((item) =>
                          item.tags?[0] ==
                          widget.data.simTypesResponse!.result!.operator.getTagTypeByOperatorType(context))
                      .isNotEmpty)
                const SizedBox(
                  height: 32.0,
                ),
              if (widget.data.findAllResponse!.content!
                  .where((item) =>
                      item.tags?[0] ==
                      widget.data.simTypesResponse!.result!.operator.getTagTypeByOperatorType(context))
                  .isNotEmpty)
                Row(
                  children: [
                    SwitchButton(
                      initialValue: false,
                      onChanged: (bool value) {
                        setState(() {
                          selectedIndex = -1;
                          isOptional = false;
                          textController.text = '';
                          isAmazing = value;
                          if (value) {
                            mainAmountList = widget.data.findAllResponse!.content!
                                .where(
                                  (item) =>
                                      item.tags?[0] ==
                                      (widget.data.simTypesResponse!.result!.operator
                                          .getTagTypeByOperatorType(context)),
                                )
                                .first
                                .amounts!;
                            productType = (widget.data.simTypesResponse!.result!.operator
                                .getTagTypeByOperatorType(context));
                          } else {
                            mainAmountList = widget.data.findAllResponse!.content!
                                .where((item) => item.tags?[0] == ChargeAndPackageTagType.NORMAL)
                                .first
                                .amounts!;
                            productType = ChargeAndPackageTagType.NORMAL;
                          }
                        });
                      },
                    ),
                  ],
                ),
              const SizedBox(
                height: 32.0,
              ),
              MainButton(
                title: locale.confirm_continue,
                onTap: () {
                  if (isOptional &&
                      (textController.text.isEmpty ||
                          int.parse(textController.text.replaceAll('.', '')) <
                              (widget.data.minimumAmount ?? 0) ||
                          int.parse(textController.text.replaceAll('.', '')) >
                              (widget.data.maximumAmount ?? 10000001))) {
                    setState(() {
                      errorText = locale.charge_amount_hint((widget.data.minimumAmount ?? 0).toString(),
                          (widget.data.maximumAmount ?? 10000001).toString());
                    });
                  } else if (isOptional &&
                      (textController.text.isEmpty ||
                          int.parse(textController.text.replaceAll('.', '')) % 1000 != 0)) {
                    setState(() {
                      errorText = locale.recharge_amount_must_multiple_of_10000_rials;
                    });
                  } else {
                    Get.back();
                    showMainBottomSheet(
                        context: context,
                        bottomSheetWidget: SelectPaymentListMainPage(
                          paymentData: PaymentData(
                            paymentType: PaymentListType.charge,
                            data: ChargeAndPackagePaymentPlanParams(
                              taxPercent: widget.data.taxPercent ?? 0,
                              minimumAmount: widget.data.minimumAmount ?? 0,
                              maximumAmount: widget.data.maximumAmount ?? 0,
                              operatorType: widget.data.simTypesResponse!.result!.operator,
                              chargeAndPackageType: ChargeAndPackageType.CHARGE,
                              amount: isOptional
                                  ? int.parse(textController.text.replaceAll('.', ''))
                                  : mainAmountList[selectedIndex].amountWithTax!,
                              depositNumber: '',
                              serviceType: ChargeAndPackageType.CHARGE,
                              mobile: widget.mobile,
                              productCode: isOptional
                                  ? widget.data.findAllResponse!.content!
                                      .where((item) => item.tags?[0] == ChargeAndPackageTagType.OPTIONARY)
                                      .first
                                      .amounts!.first.code!
                                  : mainAmountList[selectedIndex].code!,
                              productType: productType,
                              wallet: false,
                            ),
                            title: widget.mobile.toString(),
                          ),
                        ));
                  }
                },
                disable: isOptional ? textController.text.length < 4 : selectedIndex == -1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Model Class

// Main Screen
class SelectChargeAmountFromPreSets extends StatefulWidget {
  final List<ChargeAmount> mainAmountList;
  final bool isAmazing;
  final int selectedIndex;
  final Function changeAmount;

  const SelectChargeAmountFromPreSets({
    required this.mainAmountList,
    required this.selectedIndex,
    required this.changeAmount,
    required this.isAmazing,
    super.key,
  });

  @override
  SelectChargeAmountFromPreSetsState createState() => SelectChargeAmountFromPreSetsState();
}

class SelectChargeAmountFromPreSetsState extends State<SelectChargeAmountFromPreSets> {
  final formatter = intl.NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 items per row
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.5, // Adjust for card size
          ),
          itemCount: widget.mainAmountList.length,
          itemBuilder: (context, index) {
            final locale = AppLocalizations.of(context)!;
            final bool isSelected = index == widget.selectedIndex;

            return GestureDetector(
              onTap: () {
                widget.changeAmount(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? MainTheme.of(context).onSecondary.withAlpha(10)
                      : MainTheme.of(context).white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected ? MainTheme.of(context).onSecondary : MainTheme.of(context).onSurface,
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  locale.amount_format(formatter.format(widget.mainAmountList[index].amount!)),
                  style: MainTheme.of(context).textTheme.titleSmall,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SwitchButton extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const SwitchButton({
    required this.initialValue,
    required this.onChanged,
    super.key,
  });

  @override
  SwitchButtonState createState() => SwitchButtonState();
}

class SwitchButtonState extends State<SwitchButton> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.initialValue;
  }

  void _toggleSwitch(bool value) {
    setState(() {
      isSwitched = value;
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            activeTrackColor: MainTheme.of(context).secondary,
            value: isSwitched,
            onChanged: _toggleSwitch,
          ),
        ),
        Text(
          locale.amazing_charge,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
