import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/increase_balance_entity.dart';
import '../../../../../core/entities/increase_balance_params.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../domain/usecases/select_payment.dart';

part 'get_increase_balance_bloc.freezed.dart';
part 'get_increase_balance_event.dart';
part 'get_increase_balance_state.dart';

@injectable
class GetIncreaseBalanceBloc extends Bloc<GetIncreaseBalanceEvent, GetIncreaseBalanceState> {
  final GetIncreaseBalanceUseCase _getDepositsListUseCase;

  GetIncreaseBalanceBloc(this._getDepositsListUseCase) : super(const GetIncreaseBalanceState.initial()) {
    on<_GetGetIncreaseBalance>(_getGetIncreaseBalance);
  }

  FutureOr<void> _getGetIncreaseBalance(event, Emitter<GetIncreaseBalanceState> emit) async {
    emit(const GetIncreaseBalanceState.loading());
    final result = await _getDepositsListUseCase(params: event.params);
    result.fold((f) {
      emit(GetIncreaseBalanceState.loadFailure(f));
    }, (data) {
      emit(GetIncreaseBalanceState.loadSuccess(data.data));
    });
  }
}
