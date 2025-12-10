part of 'installment_settlement_payment_plan_bloc.dart';

@freezed
abstract class InstallmentSettlementPaymentPlanEvent with _$InstallmentSettlementPaymentPlanEvent {
  const factory InstallmentSettlementPaymentPlanEvent.getInstallmentSettlementPaymentPlan(InstallmentPaymentPlanParams params) =
      _GetInstallmentSettlementPaymentPlan;
}
