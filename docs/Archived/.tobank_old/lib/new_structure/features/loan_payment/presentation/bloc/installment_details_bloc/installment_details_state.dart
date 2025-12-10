part of 'installment_details_bloc.dart';

@freezed
abstract class InstallmentDetailsState with _$InstallmentDetailsState {
  const factory InstallmentDetailsState.initial() = _Initial;
  const factory InstallmentDetailsState.loadFailure(AppFailure error) = _LoadFailure;
  const factory InstallmentDetailsState.loading() = _Loading;
  const factory InstallmentDetailsState.loadSuccess(
      List<LoanDetailsEntity> installmentDetailsResponse) = _LoadSuccess;
}
