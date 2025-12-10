part of 'installment_list_bloc.dart';

@freezed
abstract class InstallmentListEvent with _$InstallmentListEvent {
  const factory InstallmentListEvent.getInstallmentList(InstallmentListParams params) =
      _GetInstallmentList;
}
