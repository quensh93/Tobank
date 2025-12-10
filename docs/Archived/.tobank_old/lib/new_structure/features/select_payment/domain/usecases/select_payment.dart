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
import '../../../../core/interfaces/usecases/usecase.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../repositories/select_payment_repository.dart';

@lazySingleton
class GetDepositsListUseCase implements UseCase<BaseResponseEntity<List<DepositsListEntity>>, DepositsListParams> {
  final SelectPaymentRepository _repository;

  GetDepositsListUseCase(this._repository);

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<DepositsListEntity>>>> call({
    required DepositsListParams params,

  }) async {
    return await _repository.getDepositsList(request: params);
  }
}

@lazySingleton
class GetIncreaseBalanceUseCase implements UseCase<BaseResponseEntity<List<IncreaseBalanceEntity>>, IncreaseBalanceParams> {
  final SelectPaymentRepository _repository;

  GetIncreaseBalanceUseCase(this._repository);

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<IncreaseBalanceEntity>>>> call({
    required IncreaseBalanceParams params,

  }) async {
    return await _repository.getIncreaseBalance(request: params);
  }
}


@lazySingleton
class GetInstallmentPaymentPlanUseCase implements UseCase<BaseResponseEntity<List<InstallmentPaymentPlanEntity>>, InstallmentPaymentPlanParams> {
  final SelectPaymentRepository _repository;

  GetInstallmentPaymentPlanUseCase(this._repository);

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<InstallmentPaymentPlanEntity>>>> call({
    required InstallmentPaymentPlanParams params,

  }) async {
    return await _repository.getInstallmentPaymentPlan(request: params);
  }
}

@lazySingleton
class GetInstallmentSettlementPaymentPlanUseCase implements UseCase<BaseResponseEntity<List<InstallmentPaymentPlanEntity>>, InstallmentPaymentPlanParams> {
  final SelectPaymentRepository _repository;

  GetInstallmentSettlementPaymentPlanUseCase(this._repository);

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<InstallmentPaymentPlanEntity>>>> call({
    required InstallmentPaymentPlanParams params,

  }) async {
    return await _repository.getInstallmentSettlementPaymentPlan(request: params);
  }
}


@lazySingleton
class GetChargeAndPackagePaymentPlanUseCase implements UseCase<BaseResponseEntity<List<ChargeAndPackagePaymentPlanEntity>>, ChargeAndPackagePaymentPlanParams> {
  final SelectPaymentRepository _repository;

  GetChargeAndPackagePaymentPlanUseCase(this._repository);

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<ChargeAndPackagePaymentPlanEntity>>>> call({
    required ChargeAndPackagePaymentPlanParams params,

  }) async {
    return await _repository.getChargeAndPackagePaymentPlan(request: params);
  }
}