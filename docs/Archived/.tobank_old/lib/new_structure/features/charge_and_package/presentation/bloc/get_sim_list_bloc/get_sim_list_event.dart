part of 'get_sim_list_bloc.dart';


@freezed
abstract class GetSimListEvent with _$GetSimListEvent {
  const factory GetSimListEvent.getSimList(NoParams params) =
      _GetGetSimList;
}
