import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/edit_sim_params.dart';
import '../../../../../core/entities/sim_list_entity.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../domain/usecases/charge_and_package.dart';

part 'edit_sim_bloc.freezed.dart';
part 'edit_sim_event.dart';
part 'edit_sim_state.dart';

@injectable
class EditSimBloc extends Bloc<EditSimEvent, EditSimState> {
  final EditSimUseCase _getEditSimUseCase;

  EditSimBloc(this._getEditSimUseCase) : super(const EditSimState.initial()) {
    on<_GetEditSim>(_getEditSim);
  }

  FutureOr<void> _getEditSim(event, Emitter<EditSimState> emit) async {
    emit(const EditSimState.loading());
    final result = await _getEditSimUseCase(params: event.params);
    result.fold((f) {
      emit(EditSimState.loadFailure(f));
    }, (data) {
      emit(EditSimState.loadSuccess(data.data));
    });
  }
}
