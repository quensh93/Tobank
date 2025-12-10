// lib/new_structure/data/datasources/charge_and_package_remote_data_source.dart

import 'package:fpdart/fpdart.dart';
import '../../../../core/entities/charge_and_package_list_params.dart';
import '../../../../core/entities/edit_sim_params.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';

abstract class ChargeAndPackageRemoteDataSource {
  Future<Either<AppFailure, Map<String, dynamic>>> getProductList(ChargeAndPackageListParams params);
  Future<Either<AppFailure, Map<String, dynamic>>> getSimList();
  Future<Either<AppFailure, Map<String, dynamic>>> editSim(EditSimCardParams params);
}