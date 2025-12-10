// charge_and_package_remote_data_source.dart
import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/installment_details_params.dart';
import '../../../../core/entities/installment_list_params.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';

abstract class InstallmentRemoteDataSource {
  Future<Either<AppFailure, Map<String, dynamic>>> getInstallmentList(InstallmentListParams params);
  Future<Either<AppFailure, Map<String, dynamic>>> getInstallmentDetails(InstallmentDetailsParams params);
}