// Abstract repository (charge_and_package_repository.dart)
import 'package:fpdart/fpdart.dart';
import '../../../../core/entities/base/base_response_entity.dart';
import '../../../../core/entities/charge_and_package_list_data_entity.dart';
import '../../../../core/entities/charge_and_package_list_params.dart';
import '../../../../core/entities/edit_sim_params.dart';
import '../../../../core/entities/sim_list_entity.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';

abstract class ChargeAndPackageRepository {
  Future<Either<AppFailure, BaseResponseEntity<ChargeAndPackageListDataEntity>>> getProductList({
    required ChargeAndPackageListParams request,
  });

  Future<Either<AppFailure, BaseResponseEntity<List<SimListEntity>>>> getSimList();

  Future<Either<AppFailure, BaseResponseEntity<List<SimListEntity>>>> editSim({
    required EditSimCardParams request,
  });
}