import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/addresses/url_addresses.dart';
import '../../../../core/entities/charge_and_package_payment_plan_params.dart';
import '../../../../core/entities/deposits_list_params.dart';
import '../../../../core/entities/increase_balance_params.dart';
import '../../../../core/entities/installment_payment_plan_params.dart';
import '../../../../core/services/network/dio/dio_manager.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';
import 'select_payment_remote_data_source.dart';

@LazySingleton(as: SelectPaymentRemoteDataSource)
class SelectPaymentRemoteDataSourceImpl
    implements SelectPaymentRemoteDataSource {
  final DioManager dioManager;
  final UrlAddresses addresses;

  SelectPaymentRemoteDataSourceImpl({
    required this.addresses,
    required this.dioManager,
  });

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getDepositsList(
      DepositsListParams params) async {
    return await dioManager.postRequest(
      endpoint: addresses.getDepositsList,
      data: params.toJson(),
      requireToken: true,
    );
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getIncreaseBalance(
      IncreaseBalanceParams params) async {
    return await dioManager.postRequest(
      endpoint:addresses.getIncreaseBalance,
      data: params.toJson(),
      requireToken: true,
    );
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getInstallmentPaymentPlan(
      InstallmentPaymentPlanParams params) async {
    return await dioManager.postRequest(
      endpoint:addresses.getInstallmentPaymentPlan,
      data: params.toJson(),
      requireToken: true,
    );
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getInstallmentSettlementPaymentPlan(
      InstallmentPaymentPlanParams params) async {
    return await dioManager.postRequest(
      endpoint:addresses.getInstallmentSettlementPaymentPlan,
      data: params.toJson(),
      requireToken: true,
    );
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>>
      getChargeAndPackagePaymentPlan(
          ChargeAndPackagePaymentPlanParams params) async {
    return await dioManager.postRequest(
      endpoint:addresses.getChargeAndPackagePaymentPlan,
      data: params.toJson(),
      requireToken: true,
    );
  }
}
