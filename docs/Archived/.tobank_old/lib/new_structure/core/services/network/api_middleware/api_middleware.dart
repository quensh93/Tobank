import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../failures/app_failure/app_failure.dart';
import '../failures/app_failure/app_failure_handler.dart';

@lazySingleton
class ApiMiddleware {
  final AppFailureHandler appFailureHandler;

  ApiMiddleware(this.appFailureHandler);

  Either<AppFailure, T> handleResponse<T>(
      Response<T> response, {
        Map<String, dynamic> Function(Map<String, dynamic> response, int statusCode)? errorModelFromJson,
      }) {
    if (response.statusCode == null) {
      return const Left(AppFailure.checkInternetFailure());
    }

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return Right(response.data as T);
    }

    if (response.data is Map<String, dynamic>) {
      final errorData = errorModelFromJson != null
          ? errorModelFromJson(response.data as Map<String, dynamic>, response.statusCode!)
          : response.data as Map<String, dynamic>;
      final failure = appFailureHandler.handleResponse(
        errorData,
        response.statusCode,
      );
      return Left(failure);
    }

    return Left(AppFailure.unexpectedFailure(
      error :DioException(requestOptions: response.requestOptions),
    ));
  }
}