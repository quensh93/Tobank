// Abstract repository (charge_and_package_repository.dart)
import 'package:fpdart/fpdart.dart';
import '../../../../core/entities/base/base_response_entity.dart';
import '../../../../core/entities/installment_details_params.dart';
import '../../../../core/entities/installment_list_data_entity.dart';
import '../../../../core/entities/installment_list_params.dart';
import '../../../../core/entities/loan_details_entity.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';

abstract class InstallmentRepository {
  Future<Either<AppFailure, BaseResponseEntity<List<InstallmentListDataEntity>>>> getInstallmentList({
    required InstallmentListParams request,
  });

  Future<Either<AppFailure, BaseResponseEntity<List<LoanDetailsEntity>>>> getInstallmentDetails({
    required InstallmentDetailsParams request,
  });
}