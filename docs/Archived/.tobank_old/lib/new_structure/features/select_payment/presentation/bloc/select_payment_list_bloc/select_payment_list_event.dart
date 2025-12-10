part of 'select_payment_list_bloc.dart';

@freezed
abstract class SelectPaymentListEvent with _$SelectPaymentListEvent {
  const factory SelectPaymentListEvent.getSelectPaymentList(DepositsListParams params) =
      _GetSelectPaymentList;
}
