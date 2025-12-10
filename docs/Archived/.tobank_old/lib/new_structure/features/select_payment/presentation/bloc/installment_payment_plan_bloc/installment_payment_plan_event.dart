part of 'installment_payment_plan_bloc.dart';

@freezed
abstract class InstallmentPaymentPlanEvent with _$InstallmentPaymentPlanEvent {
  const factory InstallmentPaymentPlanEvent.getInstallmentPaymentPlan(InstallmentPaymentPlanParams params) =
      _GetInstallmentPaymentPlan;
}
