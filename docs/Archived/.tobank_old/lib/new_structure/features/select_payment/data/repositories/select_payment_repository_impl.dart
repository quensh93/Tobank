import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/base/base_response_entity.dart';
import '../../../../core/entities/charge_and_package_payment_plan_entity.dart';
import '../../../../core/entities/charge_and_package_payment_plan_params.dart';
import '../../../../core/entities/deposits_list_entity.dart';
import '../../../../core/entities/deposits_list_params.dart';
import '../../../../core/entities/increase_balance_entity.dart';
import '../../../../core/entities/increase_balance_params.dart';
import '../../../../core/entities/installment_payment_plan_entity.dart';
import '../../../../core/entities/installment_payment_plan_params.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../../../../core/services/network/failures/app_failure/app_failure_factory.dart';
import '../../../../core/services/network/mapper/map_response_to_entity.dart';
import '../../domain/repositories/select_payment_repository.dart';
import '../datasources/select_payment_remote_data_source.dart';

@LazySingleton(as: SelectPaymentRepository)
class SelectPaymentRepositoryImpl implements SelectPaymentRepository {
  final SelectPaymentRemoteDataSource remoteDataSource;
  final AppFailureFactory appFailureFactory;

  SelectPaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.appFailureFactory,
  });

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<DepositsListEntity>>>> getDepositsList({
    required DepositsListParams request,
  }) async {
    final result = await remoteDataSource.getDepositsList(request);
    return result.fold(
      (failure) => Left(failure),
      (response) => mapResponseToEntity(
        response: response,
        path: request.toString(),
        mapper: (json) => (json as List<dynamic>)
            .map((item) => DepositsListEntity.fromJson(item as Map<String, dynamic>))
            .toList(),
        failureFactory: appFailureFactory,
        entityType: 'List<DepositsListEntity>',
      ),
    );
  }

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<IncreaseBalanceEntity>>>> getIncreaseBalance({
    required IncreaseBalanceParams request,
  }) async {
    final result = await remoteDataSource.getIncreaseBalance(request);
    return result.fold(
      (failure) => Left(failure),
      (response) => mapResponseToEntity(
        response: response,
        path: request.toString(),
        mapper: (json) => [IncreaseBalanceEntity.fromJson(json as Map<String, dynamic>)],
        failureFactory: appFailureFactory,
        entityType: 'List<IncreaseBalanceEntity>',
      ),
    );
  }

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<InstallmentPaymentPlanEntity>>>>
      getInstallmentPaymentPlan({
    required InstallmentPaymentPlanParams request,
  }) async {
    final result = await remoteDataSource.getInstallmentPaymentPlan(request);
    return result.fold(
      (failure) => Left(failure),
      (response) => mapResponseToEntity(
        response: response,
        path: request.toString(),
        mapper: (json) => [InstallmentPaymentPlanEntity.fromJson(json as Map<String, dynamic>)],
        failureFactory: appFailureFactory,
        entityType: 'List<InstallmentPaymentPlanEntity>',
      ),
    );
  }

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<InstallmentPaymentPlanEntity>>>>
      getInstallmentSettlementPaymentPlan({
    required InstallmentPaymentPlanParams request,
  }) async {
    final result = await remoteDataSource.getInstallmentSettlementPaymentPlan(request);
    return result.fold(
      (failure) => Left(failure),
      (response) => mapResponseToEntity(
        response: response,
        path: request.toString(),
        mapper: (json) => [InstallmentPaymentPlanEntity.fromJson(json as Map<String, dynamic>)],
        failureFactory: appFailureFactory,
        entityType: 'List<InstallmentPaymentPlanEntity>',
      ),
    );
  }

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<ChargeAndPackagePaymentPlanEntity>>>>
      getChargeAndPackagePaymentPlan({
    required ChargeAndPackagePaymentPlanParams request,
  }) async {
    final result = await remoteDataSource.getChargeAndPackagePaymentPlan(request);
    return result.fold(
      (failure) => Left(failure),
      (response) => mapResponseToEntity(
        response: response,
        path: request.toString(),
        mapper: (json) => [ChargeAndPackagePaymentPlanEntity.fromJson(json as Map<String, dynamic>)],
        failureFactory: appFailureFactory,
        entityType: 'List<ChargeAndPackagePaymentPlanEntity>',
      ),
    );
  }
}
