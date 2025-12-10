part of 'installment_details_bloc.dart';

@freezed
abstract class InstallmentDetailsEvent with _$InstallmentDetailsEvent {
  const factory InstallmentDetailsEvent.getInstallmentDetails(InstallmentDetailsParams params) =
      _GetInstallmentDetails;
}
