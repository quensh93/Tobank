part of 'charge_and_package_payment_plan_bloc.dart';

@freezed
abstract class ChargeAndPackagePaymentPlanState with _$ChargeAndPackagePaymentPlanState {
  const factory ChargeAndPackagePaymentPlanState.initial() = _Initial;
  const factory ChargeAndPackagePaymentPlanState.loadFailure(AppFailure error) = _LoadFailure;
  const factory ChargeAndPackagePaymentPlanState.loading() = _Loading;
  const factory ChargeAndPackagePaymentPlanState.loadSuccess(
      List<ChargeAndPackagePaymentPlanEntity> chargeAndPackagePaymentPlanResponse) = _LoadSuccess;
}