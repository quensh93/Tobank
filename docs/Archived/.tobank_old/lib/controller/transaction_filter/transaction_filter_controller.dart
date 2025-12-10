import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../model/transaction/request/transaction_filter_data.dart';
import '../../model/transaction/transaction_service_data.dart';
import '../../util/data_constants.dart';
import '../../util/date_converter_util.dart';
import '../../util/enums_constants.dart';
import '../../util/snack_bar_util.dart';

class TransactionFilterController extends GetxController {
  TransactionFilterController({
    this.transactionFilterData,
    this.transactionFilterType,
    this.isWallet,
    this.returnData,
  });

  TransactionFilterData? transactionFilterData;
  Function(TransactionFilterData? transactionFilterData)? returnData;
  String? isWallet;
  TransactionFilterType? transactionFilterType;
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();
  String? _dateFromJalali;
  String? _dateToJalali;
  List<int> selectedItems = [];
  TransactionStatus? currentTransactionStatus;

  String? _dateFromGregorian;
  String? _dateToGregorian;

  int? value;
  List<TransactionServiceData> transactionServiceDataList = [];
  late JalaliRange selectedDateRange;

  @override
  void onInit() {
    _setValues();
    super.onInit();
  }

  void _setValues() {
    if (transactionFilterType == TransactionFilterType.tourism) {
      transactionServiceDataList = DataConstants.getTransactionServiceDataTourismList();
    } else if (transactionFilterType == TransactionFilterType.wallet) {
      transactionServiceDataList = DataConstants.getTransactionServiceDataWalletList();
    } else {
      transactionServiceDataList = DataConstants.getTransactionServiceDataList();
    }
    selectedItems = transactionFilterData!.services;
    if (transactionFilterData!.dateFromGregorian != null) {
      _dateFromJalali = transactionFilterData!.dateFromJalali;
      _dateToJalali = transactionFilterData!.dateToJalali;
      _dateFromGregorian = transactionFilterData!.dateFromGregorian;
      _dateToGregorian = transactionFilterData!.dateToGregorian;
      dateFromController.text = _dateFromJalali ?? '';
      dateToController.text = _dateToJalali ?? '';
    }
    if (transactionFilterData!.isSuccess != null) {
      currentTransactionStatus =
          transactionFilterData!.isSuccess == 'True' ? TransactionStatus.success : TransactionStatus.failed;
    }
  }

  void validate() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool isValid = true;
    if (transactionFilterType == TransactionFilterType.tourism) {
      if (selectedItems.isEmpty) {
        isValid = false;
      }
    }
    if (isValid) {
      if (currentTransactionStatus == null) {
        transactionFilterData!.isSuccess = null;
      } else {
        transactionFilterData!.isSuccess = currentTransactionStatus == TransactionStatus.success ? 'True' : 'False';
      }
      transactionFilterData!.dateFromGregorian = _dateFromGregorian;
      transactionFilterData!.dateToGregorian = _dateToGregorian;
      transactionFilterData!.dateFromJalali = _dateFromJalali;
      transactionFilterData!.dateToJalali = _dateToJalali;
      transactionFilterData!.services = selectedItems;
      if (value == null) {
        transactionFilterData!.isCredit = null;
      } else {
        transactionFilterData!.isCredit = value == 1 ? '1' : '0';
      }
      returnData!(transactionFilterData);
      Get.back();
    } else {
      SnackBarUtil.showInfoSnackBar(
        locale.select_transaction_type,
      );
    }
  }

  void setValue(int value) {
    this.value = value;
    update();
  }

  void updateSelectedService(TransactionServiceData transactionServiceData) {
    if (selectedItems.contains(transactionServiceData.id)) {
      selectedItems.remove(transactionServiceData.id);
    } else {
      selectedItems.add(transactionServiceData.id);
    }
    update();
  }

  void setTransactionStatusSuccess() {
    if (currentTransactionStatus == TransactionStatus.success) {
      currentTransactionStatus = null;
    } else {
      currentTransactionStatus = TransactionStatus.success;
    }
    update();
  }

  void setTransactionStatusFailed() {
    if (currentTransactionStatus == TransactionStatus.failed) {
      currentTransactionStatus = null;
    } else {
      currentTransactionStatus = TransactionStatus.failed;
    }
    update();
  }

  Future<void> dateRangePicker() async {
    selectedDateRange = JalaliRange(
      start: Jalali.now().addDays(-7),
      end: Jalali.now(),
    );
    final picked = await showPersianDateRangePicker(
      context: Get.context!,
      initialDateRange: selectedDateRange,
      firstDate: Jalali(1398, 10),
      lastDate: Jalali.now(),
      fontFamily: 'IranYekan',
      showEntryModeIcon: false,
    );
    if (picked != null) {
      selectedDateRange = picked;
      _dateFromJalali = picked.start.formatCompactDate();
      _dateToJalali = picked.end.formatCompactDate();
      dateFromController.text = _dateFromJalali ?? '';
      dateToController.text = _dateToJalali ?? '';
      _dateFromGregorian = DateConverterUtil.getDateGregorian(jalaliDate: _dateFromJalali!);
      _dateToGregorian = DateConverterUtil.getDateGregorianTransactionFilter(jalaliDate: _dateToJalali!);
      update();
    }
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
