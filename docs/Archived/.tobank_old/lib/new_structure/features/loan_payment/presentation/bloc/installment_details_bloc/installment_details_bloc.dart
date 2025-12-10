import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/installment_details_params.dart';
import '../../../../../core/entities/loan_details_entity.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../domain/usecases/installment.dart';

part 'installment_details_bloc.freezed.dart';
part 'installment_details_event.dart';
part 'installment_details_state.dart';

@injectable
class InstallmentDetailsBloc extends Bloc<InstallmentDetailsEvent, InstallmentDetailsState> {
  final GetInstallmentDetailsUseCase _getInstallmentDetailsUseCase;

  InstallmentDetailsBloc(this._getInstallmentDetailsUseCase) : super(const InstallmentDetailsState.initial()) {
    on<_GetInstallmentDetails>(_getInstallmentDetails);
  }

  FutureOr<void> _getInstallmentDetails(
      _GetInstallmentDetails event, Emitter<InstallmentDetailsState> emit) async {
    emit(const InstallmentDetailsState.loading());
    final result = await _getInstallmentDetailsUseCase(params: event.params);
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
        emit(InstallmentDetailsState.loadFailure(failure));
      },
          (data) => emit(InstallmentDetailsState.loadSuccess(data.data)),
    );
  }
}