import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/base/base_response_entity.dart';
import '../../../../core/entities/installment_details_params.dart';
import '../../../../core/entities/installment_list_data_entity.dart';
import '../../../../core/entities/installment_list_params.dart';
import '../../../../core/entities/loan_details_entity.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../../core/services/network/failures/app_failure/app_failure_factory.dart';
import '../../../../core/services/network/mapper/map_response_to_entity.dart';
import '../../domain/repositories/installment_repository.dart';
import '../datasources/installment_remote_data_source.dart';

@LazySingleton(as: InstallmentRepository)
class InstallmentRepositoryImpl implements InstallmentRepository {
  final InstallmentRemoteDataSource remoteDataSource;
  final AppFailureFactory appFailureFactory;

  InstallmentRepositoryImpl({
    required this.remoteDataSource,
    required this.appFailureFactory,
  });

  @override
  Future<
      Either<AppFailure, BaseResponseEntity<List<InstallmentListDataEntity>>>>
  getInstallmentList({
    required InstallmentListParams request,
  }) async {
    final result = await remoteDataSource.getInstallmentList(request);
    return result.fold(
          (failure) => Left(failure),
          (response) => mapResponseToEntity(
        response: response,
        path: request.toString(),
        mapper: (json) => (json as List<dynamic>)
            .map((item) =>
            InstallmentListDataEntity.fromJson(item as Map<String, dynamic>))
            .toList(),
        failureFactory: appFailureFactory,
        entityType: 'List<InstallmentListDataEntity>',
      ),
    );
  }

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<LoanDetailsEntity>>>>
  getInstallmentDetails({
    required InstallmentDetailsParams request,
  }) async {
    final result = await remoteDataSource.getInstallmentDetails(request);
    return result.fold(
          (failure) => Left(failure),
          (response) => mapResponseToEntity(
        response: response,
        path: request.toString(),
        mapper: (json) => (json as List<dynamic>)
            .map((item) =>
            LoanDetailsEntity.fromJson(item as Map<String, dynamic>))
            .toList(),
        failureFactory: appFailureFactory,
        entityType: 'List<LoanDetailsEntity>',
      ),
    );
  }
}