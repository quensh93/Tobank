import 'charge_and_package_payment_plan_params.dart';
import 'enums.dart';
import 'installment_payment_plan_params.dart';

class PaymentData <T> {
  final PaymentListType paymentType;
  final String title;
  final T data;
  const PaymentData({
    required this.paymentType,
    required this.data,
    required this.title,
  });

  ChargeAndPackagePaymentPlanParams getChargeAndPackagePaymentData (){
    return data as ChargeAndPackagePaymentPlanParams;
  }
  InstallmentPaymentPlanParams getInstallmentPaymentData (){
    return data as InstallmentPaymentPlanParams;
  }

}


