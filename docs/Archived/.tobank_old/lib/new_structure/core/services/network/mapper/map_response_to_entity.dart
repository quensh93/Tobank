import 'package:fpdart/fpdart.dart';

import '../../../entities/base/base_response_entity.dart';
import '../failures/app_failure/app_failure.dart';
import '../failures/app_failure/app_failure_factory.dart';

Either<AppFailure, BaseResponseEntity<T>> mapResponseToEntity<T>({
  required Map<String, dynamic> response,
  required String path,
  required T Function(dynamic) mapper,
  required AppFailureFactory failureFactory,
  required String entityType, // To specify entity (e.g., "ChargeAndPackageListDataEntity")
}) {
  try {
    // Try to map the inner entity
    T mappedData;
    try {
      mappedData = mapper(response['data']); // Adjust 'data' key if needed
    } catch (e, stackTrace) {
      return Left(
        failureFactory.createModelMapFailure(
          message: 'Failed to map inner entity ($entityType): ${e.toString()}',
          path: path,
          stackTrace: stackTrace,
          entityType: entityType,
        ),
      );
    }

    // Parse BaseResponseEntity
    return Right(
      BaseResponseEntity.fromJson(response, (_) => mappedData),
    );
  } on Exception catch (e, stackTrace) {
    return Left(
      failureFactory.createModelMapFailure(
        message: 'Failed to map BaseResponseEntity: ${e.toString()}',
        path: path,
        stackTrace: stackTrace,
        entityType: 'BaseResponseEntity',
      ),
    );
  }
}