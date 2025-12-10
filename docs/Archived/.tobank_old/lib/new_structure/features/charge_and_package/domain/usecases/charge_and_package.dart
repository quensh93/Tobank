import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/entities/base/base_response_entity.dart';
import '../../../../core/entities/charge_and_package_list_data_entity.dart';
import '../../../../core/entities/charge_and_package_list_params.dart';
import '../../../../core/entities/edit_sim_params.dart';
import '../../../../core/entities/sim_list_entity.dart';
import '../../../../core/interfaces/usecases/usecase.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';
import '../repositories/charge_and_package_repository.dart';

@lazySingleton
class GetChargeAndPackageListUseCase
    implements UseCase<BaseResponseEntity<ChargeAndPackageListDataEntity>, ChargeAndPackageListParams> {
  final ChargeAndPackageRepository _repository;

  GetChargeAndPackageListUseCase(this._repository);

  @override
  Future<Either<AppFailure, BaseResponseEntity<ChargeAndPackageListDataEntity>>> call({
    required ChargeAndPackageListParams params,
  }) async {
    return await _repository.getProductList(request: params);
  }
}

@lazySingleton
class GetSimListUseCase implements UseCase<BaseResponseEntity<List<SimListEntity>>, NoParams> {
  final ChargeAndPackageRepository _repository;

  GetSimListUseCase(this._repository);

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<SimListEntity>>>> call({
    required NoParams params,
  }) async {
    return await _repository.getSimList();
  }
}

@lazySingleton
class EditSimUseCase implements UseCase<BaseResponseEntity<List<SimListEntity>>, EditSimCardParams> {
  final ChargeAndPackageRepository _repository;

  EditSimUseCase(this._repository);

  @override
  Future<Either<AppFailure, BaseResponseEntity<List<SimListEntity>>>> call({
    required EditSimCardParams params,
  }) async {
    return await _repository.editSim(request: params);
  }
}
