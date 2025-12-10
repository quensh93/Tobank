import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/charge_and_package_payment_plan_entity.dart';
import '../../../../../core/entities/charge_and_package_payment_plan_params.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../domain/usecases/select_payment.dart';

part 'charge_and_package_payment_plan_bloc.freezed.dart';
part 'charge_and_package_payment_plan_event.dart';
part 'charge_and_package_payment_plan_state.dart';

@injectable
class ChargeAndPackagePaymentPlanBloc
    extends Bloc<ChargeAndPackagePaymentPlanEvent, ChargeAndPackagePaymentPlanState> {
  final GetChargeAndPackagePaymentPlanUseCase _getChargeAndPackagePaymentPlanUseCase;

  ChargeAndPackagePaymentPlanBloc(this._getChargeAndPackagePaymentPlanUseCase)
      : super(const ChargeAndPackagePaymentPlanState.initial()) {
    on<_GetChargeAndPackagePaymentPlan>(_getChargeAndPackagePaymentPlan);
  }

  FutureOr<void> _getChargeAndPackagePaymentPlan(
      _GetChargeAndPackagePaymentPlan event, Emitter<ChargeAndPackagePaymentPlanState> emit) async {
    emit(const ChargeAndPackagePaymentPlanState.loading());
    final result = await _getChargeAndPackagePaymentPlanUseCase(params: event.params);
    result.fold(
          (failure) {
        failure.maybeWhen(
          apiFailureService: (apiFailure) {
            print('API Failure:');
            apiFailure.when(
              generic: (message, apiMessage, response) {
                print('  Type: Generic');
                print('  Message: $message');
                print('  ApiMessage: $apiMessage');
                print('  Response: $response');
              },
              invalidToken: (message, apiMessage, response) {
                print('  Type: InvalidToken');
                print('  Message: $message');
                print('  ApiMessage: $apiMessage');
                print('  Response: $response');
              },
            );
          },
          apiDetailedFailure: (message, statusCode, errorData, _, __) {
            print('API Detailed Failure:');
            print('  Message: $message');
            print('  StatusCode: $statusCode');
            print('  ErrorData: $errorData');
            print('  DisplayMessage: ${failure.displayMessage}');
            print('  DisplayCode: ${failure.displayCode}');
          },
          noConnectionFailure: (_, __) {
            print('No Connection Failure:');
            print('  DisplayMessage: ${failure.displayMessage}');
            print('  DisplayCode: ${failure.displayCode}');
          },
          connectionTimeoutFailure: (_, __) {
            print('Connection Timeout Failure:');
            print('  DisplayMessage: ${failure.displayMessage}');
            print('  DisplayCode: ${failure.displayCode}');
          },
          modelMapFailure: (message, _, __) {
            print('Model Map Failure:');
            print('  Message: $message');
            print('  DisplayMessage: ${failure.displayMessage}');
            print('  DisplayCode: ${failure.displayCode}');
          },
          unexpectedFailure: (error, message, code) {
            print('Unexpected Failure:');
            print('  Error: $error');
            print('  Message: $message');
            print('  Code: $code');
          },
          orElse: () {
            print('Unhandled Failure:');
            print('  DisplayMessage: ${failure.displayMessage}');
            print('  DisplayCode: ${failure.displayCode}');
          },
        );
        emit(ChargeAndPackagePaymentPlanState.loadFailure(failure));
      },
          (data) => emit(ChargeAndPackagePaymentPlanState.loadSuccess(data.data)),
    );
  }
}