part of 'get_increase_balance_bloc.dart';

@freezed
abstract class GetIncreaseBalanceState with _$GetIncreaseBalanceState {
  const factory GetIncreaseBalanceState.initial() = _Initial;
  const factory GetIncreaseBalanceState.loadFailure(AppFailure error) = _LoadFailure;
  const factory GetIncreaseBalanceState.loading() = _Loading;
  const factory GetIncreaseBalanceState.loadSuccess(
      List<IncreaseBalanceEntity> getIncreaseBalanceResponse) = _LoadSuccess;
}
