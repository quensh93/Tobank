import 'package:fpdart/fpdart.dart';

import '../../../../core/entities/charge_and_package_payment_plan_params.dart';
import '../../../../core/entities/deposits_list_params.dart';
import '../../../../core/entities/increase_balance_params.dart';
import '../../../../core/entities/installment_payment_plan_params.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';


abstract class SelectPaymentRemoteDataSource {
  Future<Either<AppFailure, Map<String, dynamic>>> getDepositsList(DepositsListParams params);
  Future<Either<AppFailure, Map<String, dynamic>>> getIncreaseBalance(IncreaseBalanceParams params);
  Future<Either<AppFailure, Map<String, dynamic>>> getInstallmentPaymentPlan(InstallmentPaymentPlanParams params);
  Future<Either<AppFailure, Map<String, dynamic>>> getInstallmentSettlementPaymentPlan(InstallmentPaymentPlanParams params);
  Future<Either<AppFailure, Map<String, dynamic>>> getChargeAndPackagePaymentPlan(ChargeAndPackagePaymentPlanParams params);

}