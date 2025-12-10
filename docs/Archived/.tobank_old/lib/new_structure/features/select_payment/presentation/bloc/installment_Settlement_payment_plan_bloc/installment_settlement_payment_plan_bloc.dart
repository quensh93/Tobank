import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/installment_payment_plan_entity.dart';
import '../../../../../core/entities/installment_payment_plan_params.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../domain/usecases/select_payment.dart';

part 'installment_settlement_payment_plan_bloc.freezed.dart';
part 'installment_settlement_payment_plan_event.dart';
part 'installment_settlement_payment_plan_state.dart';

@injectable
class InstallmentSettlementPaymentPlanBloc
    extends Bloc<InstallmentSettlementPaymentPlanEvent, InstallmentSettlementPaymentPlanState> {
  final GetInstallmentSettlementPaymentPlanUseCase _getInstallmentSettlementPaymentPlanUseCase;

  InstallmentSettlementPaymentPlanBloc(this._getInstallmentSettlementPaymentPlanUseCase)
      : super(const InstallmentSettlementPaymentPlanState.initial()) {
    on<_GetInstallmentSettlementPaymentPlan>(_getInstallmentSettlementPaymentPlan);
  }

  FutureOr<void> _getInstallmentSettlementPaymentPlan(
      event, Emitter<InstallmentSettlementPaymentPlanState> emit) async {
    emit(const InstallmentSettlementPaymentPlanState.loading());
    final result = await _getInstallmentSettlementPaymentPlanUseCase(params: event.params);
    result.fold((f) {
      emit(InstallmentSettlementPaymentPlanState.loadFailure(f));
    }, (data) {
      emit(InstallmentSettlementPaymentPlanState.loadSuccess(data.data));
    });
  }
}
