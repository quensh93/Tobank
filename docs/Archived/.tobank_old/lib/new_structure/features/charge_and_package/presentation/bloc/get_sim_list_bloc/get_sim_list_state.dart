part of 'get_sim_list_bloc.dart';


@freezed
abstract class GetSimListState with _$GetSimListState {
  const factory GetSimListState.initial() = _Initial;
  const factory GetSimListState.loadFailure(AppFailure error) = _LoadFailure;
  const factory GetSimListState.loading() = _Loading;
  const factory GetSimListState.loadSuccess(
      List<SimListEntity> getSimListResponse) = _LoadSuccess;
}
