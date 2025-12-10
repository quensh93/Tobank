import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/sim_list_entity.dart';
import '../../../../../core/interfaces/usecases/usecase.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../domain/usecases/charge_and_package.dart';

part 'get_sim_list_bloc.freezed.dart';
part 'get_sim_list_event.dart';
part 'get_sim_list_state.dart';

@injectable
class GetSimListBloc extends Bloc<GetSimListEvent, GetSimListState> {
  final GetSimListUseCase _getGetSimListUseCase;

  GetSimListBloc(this._getGetSimListUseCase) : super(const GetSimListState.initial()) {
    on<_GetGetSimList>(_getSimList);
  }

  FutureOr<void> _getSimList(_GetGetSimList event, Emitter<GetSimListState> emit) async {
    emit(const GetSimListState.loading());
    final result = await _getGetSimListUseCase(params: NoParams());
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
        emit(GetSimListState.loadFailure(failure));
      },
          (data) => emit(GetSimListState.loadSuccess(data.data)),
    );
  }
}