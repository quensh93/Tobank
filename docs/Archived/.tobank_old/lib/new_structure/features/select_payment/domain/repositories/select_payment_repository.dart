import 'package:fpdart/fpdart.dart';
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

abstract class SelectPaymentRepository {
  Future<Either<AppFailure, BaseResponseEntity<List<DepositsListEntity>>>> getDepositsList({
    required DepositsListParams request,
  });
  Future<Either<AppFailure, BaseResponseEntity<List<IncreaseBalanceEntity>>>> getIncreaseBalance({
    required IncreaseBalanceParams request,
  });
  Future<Either<AppFailure, BaseResponseEntity<List<InstallmentPaymentPlanEntity>>>> getInstallmentPaymentPlan({
    required InstallmentPaymentPlanParams request,
  });
  Future<Either<AppFailure, BaseResponseEntity<List<InstallmentPaymentPlanEntity>>>> getInstallmentSettlementPaymentPlan({
    required InstallmentPaymentPlanParams request,
  });
  Future<Either<AppFailure, BaseResponseEntity<List<ChargeAndPackagePaymentPlanEntity>>>> getChargeAndPackagePaymentPlan({
    required ChargeAndPackagePaymentPlanParams request,
  });
}