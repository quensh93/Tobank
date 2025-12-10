part of 'edit_sim_bloc.dart';


@freezed
abstract class EditSimState with _$EditSimState {
  const factory EditSimState.initial() = _Initial;
  const factory EditSimState.loadFailure(AppFailure error) = _LoadFailure;
  const factory EditSimState.loading() = _Loading;
  const factory EditSimState.loadSuccess(
      List<SimListEntity> editSimResponse) = _LoadSuccess;
}
