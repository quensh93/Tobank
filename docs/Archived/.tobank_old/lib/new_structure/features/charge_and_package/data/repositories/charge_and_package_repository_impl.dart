import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/base/base_response_entity.dart';
import '../../../../core/entities/charge_and_package_list_data_entity.dart';
import '../../../../core/entities/charge_and_package_list_params.dart';
import '../../../../core/entities/edit_sim_params.dart';
import '../../../../core/entities/sim_list_entity.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../../core/services/network/failures/app_failure/app_failure_factory.dart';
import '../../../../core/services/network/mapper/map_response_to_entity.dart';
import '../../domain/repositories/charge_and_package_repository.dart';
import '../datasources/charge_and_package_remote_data_source.dart';

@LazySingleton(as: ChargeAndPackageRepository)
class ChargeAndPackageRepositoryImpl implements ChargeAndPackageRepository {
  final ChargeAndPackageRemoteDataSource remoteDataSource;
  final AppFailureFactory appFailureFactory;

  ChargeAndPackageRepositoryImpl({
    required this.remoteDataSource,
    required this.appFailureFactory,
  });

  @override
  Future<
      Either<AppFailure,
          BaseResponseEntity<ChargeAndPackageListDataEntity>>>
  getProductList({
    required ChargeAndPackageListParams request,
  }) async {
    final result = await remoteDataSource.getProductList(request);
    return result.fold(
          (failure) => Left(failure),
          (response) => mapResponseToEntity(
        response: response,
        path: request.toString(),
        mapper: (json) =>
            ChargeAndPackageListDataEntity.fromJson(json as Map<String, dynamic>),
        failureFactory: appFailureFactory,
        entityType: 'ChargeAndPackageListDataEntity',
      ),
    );
  }

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<SimListEntity>>>>
  getSimList() async {
    final result = await remoteDataSource.getSimList();
    return result.fold(
          (failure) => Left(failure),
          (response) => mapResponseToEntity(
        response: response,
        path: 'getSimList',
        mapper: (json) => (json as List<dynamic>)
            .map((item) => SimListEntity.fromJson(item as Map<String, dynamic>))
            .toList(),
        failureFactory: appFailureFactory,
        entityType: 'List<SimListEntity>',
      ),
    );
  }

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<SimListEntity>>>> editSim({
    required EditSimCardParams request,
  }) async {
    final result = await remoteDataSource.editSim(request);
    return result.fold(
          (failure) => Left(failure),
          (response) => mapResponseToEntity(
        response: response,
        path: request.toString(),
        mapper: (json) => (json as List<dynamic>)
            .map((item) => SimListEntity.fromJson(item as Map<String, dynamic>))
            .toList(),
        failureFactory: appFailureFactory,
        entityType: 'List<SimListEntity>',
      ),
    );
  }
}