part of 'installment_list_bloc.dart';

@freezed
abstract class InstallmentListState with _$InstallmentListState {
  const factory InstallmentListState.initial() = _Initial;
  const factory InstallmentListState.loadFailure(AppFailure error) = _LoadFailure;
  const factory InstallmentListState.loading() = _Loading;
  const factory InstallmentListState.loadSuccess(
      List<InstallmentListDataEntity> installmentListResponse) = _LoadSuccess;
}
