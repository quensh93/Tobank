import 'package:injectable/injectable.dart';

import '../../../../util/app_util.dart';
import 'url_addresses.dart';

@Singleton(as: UrlAddresses)
class UrlAddressesImpl implements UrlAddresses {
  static const String loans = 'loans/';
  static const String installment = 'v2/loan/installment/';
  static const String account = 'v2/openbanking/account/';
  static const String transactions = 'v2/transactions/increase/deposit/';
  static const String sim = 'v2/users/';
  static const String telecom = 'v2/openbanking/telecom/';

  @override
  String get getLoansList => '${AppUtil.baseUrl()}$loans';

  @override
  String getLoan(int id) => '${AppUtil.baseUrl()}$loans$id';

  @override
  String get getInstallmentList => '${AppUtil.baseUrl()}${installment}list';

  @override
  String get getInstallmentDetails => '${AppUtil.baseUrl()}${installment}detail';

  @override
  String get getInstallmentPaymentPlan => '${AppUtil.baseUrl()}${installment}payment';

  @override
  String get getInstallmentSettlementPaymentPlan => '${AppUtil.baseUrl()}${installment}settlement';

  @override
  String get getChargeAndPackagePaymentPlan => '${AppUtil.baseUrl()}${telecom}charging';

  @override
  String get getDepositsList => '${AppUtil.baseUrl()}${account}info';

  @override
  String get getIncreaseBalance => '${AppUtil.baseUrl()}${transactions}balance';

  @override
  String get getSim => '${AppUtil.baseUrl()}${sim}simcard';

  @override
  String get getProductList => '${AppUtil.baseUrl()}${telecom}product';
}
