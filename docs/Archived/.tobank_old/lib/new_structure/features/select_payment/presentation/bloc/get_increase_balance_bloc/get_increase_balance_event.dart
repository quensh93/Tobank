part of 'get_increase_balance_bloc.dart';

@freezed
abstract class GetIncreaseBalanceEvent with _$GetIncreaseBalanceEvent {
  const factory GetIncreaseBalanceEvent.getGetIncreaseBalance(IncreaseBalanceParams params) =
      _GetGetIncreaseBalance;
}
