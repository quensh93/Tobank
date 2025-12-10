part of 'edit_sim_bloc.dart';

@freezed
abstract class EditSimEvent with _$EditSimEvent {
  const factory EditSimEvent.getEditSim(EditSimCardParams params) =
      _GetEditSim;
}
