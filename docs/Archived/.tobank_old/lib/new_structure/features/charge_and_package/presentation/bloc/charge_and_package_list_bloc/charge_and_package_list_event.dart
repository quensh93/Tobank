part of 'charge_and_package_list_bloc.dart';

@freezed
abstract class ChargeAndPackageListEvent with _$ChargeAndPackageListEvent {
  const factory ChargeAndPackageListEvent.getChargeAndPackageList(ChargeAndPackageListParams params) =
      _GetChargeAndPackageList;
}
