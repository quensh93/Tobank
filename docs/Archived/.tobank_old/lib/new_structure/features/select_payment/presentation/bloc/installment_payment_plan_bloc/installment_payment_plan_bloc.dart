import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/installment_payment_plan_entity.dart';
import '../../../../../core/entities/installment_payment_plan_params.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../domain/usecases/select_payment.dart';

part 'installment_payment_plan_bloc.freezed.dart';
part 'installment_payment_plan_event.dart';
part 'installment_payment_plan_state.dart';

@injectable
class InstallmentPaymentPlanBloc extends Bloc<InstallmentPaymentPlanEvent, InstallmentPaymentPlanState> {
  final GetInstallmentPaymentPlanUseCase _getInstallmentPaymentPlanUseCase;

  InstallmentPaymentPlanBloc(this._getInstallmentPaymentPlanUseCase) : super(const InstallmentPaymentPlanState.initial()) {
    on<_GetInstallmentPaymentPlan>(_getInstallmentPaymentPlan);
  }

  FutureOr<void> _getInstallmentPaymentPlan(event, Emitter<InstallmentPaymentPlanState> emit) async {
    emit(const InstallmentPaymentPlanState.loading());
    final result = await _getInstallmentPaymentPlanUseCase(params: event.params);
    result.fold((f) {
      emit(InstallmentPaymentPlanState.loadFailure(f));
    }, (data) {
      emit(InstallmentPaymentPlanState.loadSuccess(data.data));
    });
  }
}
