import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/base/base_response_entity.dart';
import '../../../../core/entities/installment_details_params.dart';
import '../../../../core/entities/installment_list_data_entity.dart';
import '../../../../core/entities/installment_list_params.dart';
import '../../../../core/entities/loan_details_entity.dart';
import '../../../../core/interfaces/usecases/usecase.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../repositories/installment_repository.dart';

@lazySingleton
class GetInstallmentListUseCase implements UseCase<BaseResponseEntity<List<InstallmentListDataEntity>>, InstallmentListParams> {
  final InstallmentRepository _repository;

  GetInstallmentListUseCase(this._repository);

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<InstallmentListDataEntity>>>> call({
    required InstallmentListParams params,

  }) async {
    return await _repository.getInstallmentList(request: params);
  }
}


@lazySingleton
class GetInstallmentDetailsUseCase implements UseCase<BaseResponseEntity<List<LoanDetailsEntity>>, InstallmentDetailsParams> {
  final InstallmentRepository _repository;

  GetInstallmentDetailsUseCase(this._repository);

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<LoanDetailsEntity>>>> call({
    required InstallmentDetailsParams params,

  }) async {
    return await _repository.getInstallmentDetails(request: params);
  }
}