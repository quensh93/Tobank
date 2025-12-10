part of 'installment_settlement_payment_plan_bloc.dart';

@freezed
abstract class InstallmentSettlementPaymentPlanState with _$InstallmentSettlementPaymentPlanState {
  const factory InstallmentSettlementPaymentPlanState.initial() = _Initial;
  const factory InstallmentSettlementPaymentPlanState.loadFailure(AppFailure error) = _LoadFailure;
  const factory InstallmentSettlementPaymentPlanState.loading() = _Loading;
  const factory InstallmentSettlementPaymentPlanState.loadSuccess(
      List<InstallmentPaymentPlanEntity> installmentPaymentPlanResponse) = _LoadSuccess;
}