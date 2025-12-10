part of 'select_payment_list_bloc.dart';

@freezed
abstract class SelectPaymentListState with _$SelectPaymentListState {
  const factory SelectPaymentListState.initial() = _Initial;
  const factory SelectPaymentListState.loadFailure(AppFailure error) = _LoadFailure;
  const factory SelectPaymentListState.loading() = _Loading;
  const factory SelectPaymentListState.loadSuccess(
      List<DepositsListEntity> selectPaymentListResponse) = _LoadSuccess;
}
