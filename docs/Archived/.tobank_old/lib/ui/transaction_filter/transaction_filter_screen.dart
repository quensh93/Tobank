import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/transaction_filter/transaction_filter_controller.dart';
import '../../model/transaction/request/transaction_filter_data.dart';
import '../../util/app_theme.dart';
import '../../util/enums_constants.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';
import '../../widget/svg/svg_icon.dart';
import '../common/custom_app_bar.dart';
import 'transaction_type_widget.dart';

class TransactionFilterScreen extends StatelessWidget {
  const TransactionFilterScreen({
    required this.transactionFilterData,
    required this.transactionFilterType,
    required this.isWallet,
    required this.returnDataFunction,
    super.key,
  });

  final TransactionFilterData transactionFilterData;
  final Function(TransactionFilterData transactionFilterData) returnDataFunction;
  final String isWallet;
  final TransactionFilterType transactionFilterType;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<TransactionFilterController>(
        init: TransactionFilterController(
          transactionFilterData: transactionFilterData,
          transactionFilterType: transactionFilterType,
          isWallet: isWallet,
          returnData: (transactionData) {
            returnDataFunction(transactionData!);
          },
        ),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              titleString: locale.transaction_filter_title,
              context: context,
            ),
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (controller.isWallet == '1')
                              Row(
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      splashColor: Colors.grey.withOpacity(0.1),
                                      onTap: () {
                                        controller.setValue(1);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          border: Border.all(
                                            color: controller.value == 1
                                                ? Colors.transparent
                                                : context.theme.colorScheme.surface,
                                            width: 2,
                                          ),
                                          color: controller.value == 1 ? AppTheme.successColor : Colors.transparent,
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 8.0,
                                            ),
                                            child: Opacity(
                                              opacity: controller.value == 1 ? 1 : 0.5,
                                              child: Row(
                                                children: <Widget>[
                                                  SvgIcon(
                                                    SvgIcons.inCome,
                                                    colorFilter: ColorFilter.mode(
                                                        controller.value == 1
                                                            ? Colors.white
                                                            : context.theme.iconTheme.color!,
                                                        BlendMode.srcIn),
                                                    size: 18.0,
                                                  ),
                                                  const SizedBox(
                                                    width: 8.0,
                                                  ),
                                                  Text(
                                                    locale.receive_money,
                                                    style: TextStyle(
                                                        color: controller.value == 1
                                                            ? Colors.white
                                                            : ThemeUtil.textTitleColor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                      splashColor: Colors.grey.withOpacity(0.1),
                                      onTap: () {
                                        controller.setValue(2);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          border: Border.all(
                                            color: controller.value == 2
                                                ? Colors.transparent
                                                : context.theme.colorScheme.surface,
                                            width: 2,
                                          ),
                                          color: controller.value == 2 ? AppTheme.warningColor : Colors.transparent,
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 8.0,
                                            ),
                                            child: Opacity(
                                              opacity: controller.value == 2 ? 1 : 0.5,
                                              child: Row(
                                                children: <Widget>[
                                                  SvgIcon(
                                                    SvgIcons.outCome,
                                                    colorFilter: ColorFilter.mode(
                                                        controller.value == 2
                                                            ? Colors.white
                                                            : context.theme.iconTheme.color!,
                                                        BlendMode.srcIn),
                                                    size: 18,
                                                  ),
                                                  const SizedBox(
                                                    width: 8.0,
                                                  ),
                                                  Text(
                                                    locale.send_money,
                                                    style: TextStyle(
                                                        color: controller.value == 2
                                                            ? Colors.white
                                                            : ThemeUtil.textTitleColor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              )
                            else
                              Container(),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              locale.time_range,
                              style: ThemeUtil.titleStyle,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  controller.dateRangePicker();
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          IgnorePointer(
                                            child: TextField(
                                              controller: controller.dateFromController,
                                              enabled: true,
                                              readOnly: true,
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.0,
                                                fontFamily: 'IranYekan',
                                              ),
                                              keyboardType: TextInputType.text,
                                              decoration:  InputDecoration(
                                                filled: false,
                                                hintText: locale.from_date,
                                                hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0,
                                                ),
                                                border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                  vertical: 16.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgIcon(
                                              SvgIcons.calendar,
                                              colorFilter: ColorFilter.mode(
                                                  context.theme.colorScheme.secondary, BlendMode.srcIn),
                                              size: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.centerLeft,
                                        children: <Widget>[
                                          IgnorePointer(
                                            child: TextField(
                                              controller: controller.dateToController,
                                              enabled: true,
                                              readOnly: true,
                                              textDirection: TextDirection.ltr,
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.0,
                                                fontFamily: 'IranYekan',
                                              ),
                                              keyboardType: TextInputType.text,
                                              decoration:  InputDecoration(
                                                filled: false,
                                                hintText: locale.to_date,
                                                hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0,
                                                ),
                                                border: const OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 20.0,
                                                  vertical: 16.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgIcon(
                                              SvgIcons.calendar,
                                              colorFilter: ColorFilter.mode(
                                                  context.theme.colorScheme.secondary, BlendMode.srcIn),
                                              size: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                             locale.transaction_type,
                              style: ThemeUtil.titleStyle,
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Wrap(
                              spacing: 10.0,
                              runSpacing: 16.0,
                              children: controller.transactionServiceDataList
                                  .map((item) {
                                    return TransactionTypeWidget(
                                      transactionServiceData: item,
                                      selectedItems: controller.selectedItems,
                                      returnDataFunction: (transactionServiceData) {
                                        controller.updateSelectedService(transactionServiceData);
                                      },
                                    );
                                  })
                                  .toList()
                                  .cast<Widget>(),
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            Text(locale.transaction_status, style: ThemeUtil.titleStyle),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    splashColor: Colors.grey.withOpacity(0.1),
                                    onTap: () {
                                      controller.setTransactionStatusSuccess();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        border: Border.all(
                                          color: controller.currentTransactionStatus == TransactionStatus.success
                                              ? Colors.transparent
                                              : context.theme.colorScheme.surface,
                                          width: 2,
                                        ),
                                        color: controller.currentTransactionStatus == TransactionStatus.success
                                            ? AppTheme.successColor
                                            : Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 8.0,
                                          ),
                                          child: Opacity(
                                            opacity: controller.currentTransactionStatus == TransactionStatus.success
                                                ? 1
                                                : 0.5,
                                            child: Row(
                                              children: <Widget>[
                                                const SvgIcon(
                                                  SvgIcons.transactionItemSuccess,
                                                  size: 18.0,
                                                ),
                                                const SizedBox(
                                                  width: 8.0,
                                                ),
                                                Text(
                                                  locale.payment_successful,
                                                  style: TextStyle(
                                                      color: controller.currentTransactionStatus ==
                                                              TransactionStatus.success
                                                          ? Colors.white
                                                          : ThemeUtil.textTitleColor,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0),
                                    ),
                                    splashColor: Colors.grey.withOpacity(0.1),
                                    onTap: () {
                                      controller.setTransactionStatusFailed();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        border: Border.all(
                                          color: controller.currentTransactionStatus == TransactionStatus.failed
                                              ? Colors.transparent
                                              : context.theme.colorScheme.surface,
                                          width: 2,
                                        ),
                                        color: controller.currentTransactionStatus == TransactionStatus.failed
                                            ? AppTheme.failColor
                                            : Colors.transparent,
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                            vertical: 8.0,
                                          ),
                                          child: Opacity(
                                            opacity: controller.currentTransactionStatus == TransactionStatus.failed
                                                ? 1
                                                : 0.5,
                                            child: Row(
                                              children: <Widget>[
                                                const SvgIcon(
                                                  SvgIcons.transactionItemFailed,
                                                  size: 18.0,
                                                ),
                                                const SizedBox(
                                                  width: 8.0,
                                                ),
                                                Text(
                                                  locale.payment_unsuccessful,
                                                  style: TextStyle(
                                                      color: controller.currentTransactionStatus ==
                                                              TransactionStatus.failed
                                                          ? Colors.white
                                                          : ThemeUtil.textTitleColor,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            ContinueButtonWidget(
                              callback: () {
                                controller.validate();
                              },
                              isLoading: false,
                              buttonTitle: locale.filter_results,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
