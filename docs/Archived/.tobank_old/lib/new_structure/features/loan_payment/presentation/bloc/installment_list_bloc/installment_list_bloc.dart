import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/installment_list_data_entity.dart';
import '../../../../../core/entities/installment_list_params.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../domain/usecases/installment.dart';

part 'installment_list_bloc.freezed.dart';
part 'installment_list_event.dart';
part 'installment_list_state.dart';

@injectable
class InstallmentListBloc extends Bloc<InstallmentListEvent, InstallmentListState> {
  final GetInstallmentListUseCase _getInstallmentListUseCase;

  InstallmentListBloc(this._getInstallmentListUseCase) : super(const InstallmentListState.initial()) {
    on<_GetInstallmentList>(_getInstallmentList);
  }

  FutureOr<void> _getInstallmentList(
      _GetInstallmentList event, Emitter<InstallmentListState> emit) async {
    emit(const InstallmentListState.loading());
    final result = await _getInstallmentListUseCase(params: event.params);
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
        emit(InstallmentListState.loadFailure(failure));
      },
          (data) => emit(InstallmentListState.loadSuccess(data.data)),
    );
  }
}