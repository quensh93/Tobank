part of 'installment_payment_plan_bloc.dart';

@freezed
abstract class InstallmentPaymentPlanState with _$InstallmentPaymentPlanState {
  const factory InstallmentPaymentPlanState.initial() = _Initial;
  const factory InstallmentPaymentPlanState.loadFailure(AppFailure error) = _LoadFailure;
  const factory InstallmentPaymentPlanState.loading() = _Loading;
  const factory InstallmentPaymentPlanState.loadSuccess(
      List<InstallmentPaymentPlanEntity> installmentPaymentPlanResponse) = _LoadSuccess;
}