part of 'charge_and_package_payment_plan_bloc.dart';

@freezed
abstract class ChargeAndPackagePaymentPlanEvent with _$ChargeAndPackagePaymentPlanEvent {
  const factory ChargeAndPackagePaymentPlanEvent.getChargeAndPackagePaymentPlan(ChargeAndPackagePaymentPlanParams params) =
      _GetChargeAndPackagePaymentPlan;
}
