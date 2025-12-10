import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/entities/charge_and_package_list_data_entity.dart';
import '../../../../../core/entities/charge_and_package_list_params.dart';
import '../../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../domain/usecases/charge_and_package.dart';

part 'charge_and_package_list_bloc.freezed.dart';

part 'charge_and_package_list_event.dart';

part 'charge_and_package_list_state.dart';

@injectable
class ChargeAndPackageListBloc
    extends Bloc<ChargeAndPackageListEvent, ChargeAndPackageListState> {
  final GetChargeAndPackageListUseCase _getChargeAndPackageListUseCase;

  ChargeAndPackageListBloc(this._getChargeAndPackageListUseCase)
      : super(const ChargeAndPackageListState.initial()) {
    on<_GetChargeAndPackageList>(_getChargeAndPackageList);
  }

  FutureOr<void> _getChargeAndPackageList(_GetChargeAndPackageList event,
      Emitter<ChargeAndPackageListState> emit) async {
    emit(const ChargeAndPackageListState.loading());

    final result = await _getChargeAndPackageListUseCase(params: event.params);
    print('⭕ get packages');
    result.fold(
      (failure) {
        // Handle and emit detailed failure information
        _handleFailure(failure, emit);
      },
      (data) {
        print('⭕ success');
        // Emit success state with the data
        emit(ChargeAndPackageListState.loadSuccess(data.data));
      },
    );
  }

  void _handleFailure(
      AppFailure failure, Emitter<ChargeAndPackageListState> emit) {
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
    emit(ChargeAndPackageListState.loadFailure(failure));
  }
}
