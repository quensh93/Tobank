import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/deposits_list_entity.dart';
import '../../../../../core/entities/deposits_list_params.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../domain/usecases/select_payment.dart';

part 'select_payment_list_bloc.freezed.dart';
part 'select_payment_list_event.dart';
part 'select_payment_list_state.dart';

@injectable
class SelectPaymentListBloc extends Bloc<SelectPaymentListEvent, SelectPaymentListState> {
  final GetDepositsListUseCase _getDepositsListUseCase;

  SelectPaymentListBloc(this._getDepositsListUseCase) : super(const SelectPaymentListState.initial()) {
    on<_GetSelectPaymentList>(_getSelectPaymentList);
  }

  FutureOr<void> _getSelectPaymentList(event, Emitter<SelectPaymentListState> emit) async {
    emit(const SelectPaymentListState.loading());
    final result = await _getDepositsListUseCase(params: event.params);
    result.fold((f) {
      emit(SelectPaymentListState.loadFailure(f));
    }, (data) {
      emit(SelectPaymentListState.loadSuccess(data.data));
    });
  }
}
