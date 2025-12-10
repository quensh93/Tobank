part of 'charge_and_package_list_bloc.dart';


@freezed
abstract class ChargeAndPackageListState with _$ChargeAndPackageListState {
  const factory ChargeAndPackageListState.initial() = _Initial;
  const factory ChargeAndPackageListState.loadFailure(AppFailure error) = _LoadFailure;
  const factory ChargeAndPackageListState.loading() = _Loading;
  const factory ChargeAndPackageListState.loadSuccess(
      ChargeAndPackageListDataEntity chargeAndPackageListResponse) = _LoadSuccess;
}
