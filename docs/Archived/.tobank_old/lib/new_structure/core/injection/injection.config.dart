// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/charge_and_package/data/datasources/charge_and_package_remote_data_source.dart'
    as _i215;
import '../../features/charge_and_package/data/datasources/charge_and_package_remote_data_source_impl.dart'
    as _i73;
import '../../features/charge_and_package/data/repositories/charge_and_package_repository_impl.dart'
    as _i697;
import '../../features/charge_and_package/domain/repositories/charge_and_package_repository.dart'
    as _i697;
import '../../features/charge_and_package/domain/usecases/charge_and_package.dart'
    as _i60;
import '../../features/charge_and_package/presentation/bloc/charge_and_package_list_bloc/charge_and_package_list_bloc.dart'
    as _i1040;
import '../../features/charge_and_package/presentation/bloc/edit_sim_bloc/edit_sim_bloc.dart'
    as _i638;
import '../../features/charge_and_package/presentation/bloc/get_sim_list_bloc/get_sim_list_bloc.dart'
    as _i422;
import '../../features/loan_payment/data/datasources/installment_remote_data_source.dart'
    as _i417;
import '../../features/loan_payment/data/datasources/installment_remote_data_source_impl.dart'
    as _i28;
import '../../features/loan_payment/data/repositories/installment_repository_impl.dart'
    as _i462;
import '../../features/loan_payment/domain/repositories/installment_repository.dart'
    as _i234;
import '../../features/loan_payment/domain/usecases/installment.dart' as _i88;
import '../../features/loan_payment/presentation/bloc/installment_details_bloc/installment_details_bloc.dart'
    as _i489;
import '../../features/loan_payment/presentation/bloc/installment_list_bloc/installment_list_bloc.dart'
    as _i135;
import '../../features/select_payment/data/datasources/select_payment_remote_data_source.dart'
    as _i410;
import '../../features/select_payment/data/datasources/select_payment_remote_data_source_impl.dart'
    as _i879;
import '../../features/select_payment/data/repositories/select_payment_repository_impl.dart'
    as _i981;
import '../../features/select_payment/domain/repositories/select_payment_repository.dart'
    as _i401;
import '../../features/select_payment/domain/usecases/select_payment.dart'
    as _i26;
import '../../features/select_payment/presentation/bloc/charge_and_package_payment_plan_bloc/charge_and_package_payment_plan_bloc.dart'
    as _i77;
import '../../features/select_payment/presentation/bloc/get_increase_balance_bloc/get_increase_balance_bloc.dart'
    as _i280;
import '../../features/select_payment/presentation/bloc/installment_payment_plan_bloc/installment_payment_plan_bloc.dart'
    as _i1019;
import '../../features/select_payment/presentation/bloc/installment_Settlement_payment_plan_bloc/installment_settlement_payment_plan_bloc.dart'
    as _i937;
import '../../features/select_payment/presentation/bloc/select_payment_list_bloc/select_payment_list_bloc.dart'
    as _i194;
import '../app_config/app_config.dart' as _i850;
import '../constants/addresses/url_addresses.dart' as _i491;
import '../constants/addresses/url_addresses_impl.dart' as _i264;
import '../services/logger_service/talker/talker.dart' as _i314;
import '../services/network/api_middleware/api_middleware.dart' as _i176;
import '../services/network/dio/dio_config.dart' as _i417;
import '../services/network/dio/dio_interceptors.dart' as _i221;
import '../services/network/dio/dio_manager.dart' as _i491;
import '../services/network/dio/dio_transformer.dart' as _i67;
import '../services/network/failures/api_failure/api_failure_factory.dart'
    as _i805;
import '../services/network/failures/api_failure/api_failure_handler.dart'
    as _i665;
import '../services/network/failures/app_failure/app_failure_factory.dart'
    as _i919;
import '../services/network/failures/app_failure/app_failure_handler.dart'
    as _i26;
import '../services/network/log_service.dart' as _i937;
import 'modules/module.dart' as _i555;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.singleton<_i850.AppConfigDataSource>(
      () => registerModule.appConfigDataSource);
  gh.singleton<_i314.TalkerService>(() => registerModule.talkerService);
  gh.lazySingleton<_i895.Connectivity>(
      () => registerModule.connectionChecker());
  gh.lazySingleton<_i417.DioConfig>(() => _i417.DioConfig());
  gh.lazySingleton<_i67.DioTransformer>(() => _i67.DioTransformer());
  gh.lazySingleton<_i805.ApiFailureFactory>(() => _i805.ApiFailureFactory());
  gh.lazySingleton<_i919.AppFailureFactory>(() => _i919.AppFailureFactory());
  await gh.singletonAsync<_i850.AppConfigService>(
    () => registerModule.appConfigService(gh<_i850.AppConfigDataSource>()),
    preResolve: true,
  );
  gh.singleton<_i491.UrlAddresses>(() => _i264.UrlAddressesImpl());
  gh.lazySingleton<_i665.ApiFailureHandler>(
      () => _i665.ApiFailureHandler(gh<_i805.ApiFailureFactory>()));
  gh.lazySingleton<_i937.LogService>(() => _i937.ApiLogService());
  gh.lazySingleton<_i221.DioInterceptors>(() => _i221.DioInterceptors(
        gh<_i937.LogService>(),
        gh<_i314.TalkerService>(),
      ));
  gh.lazySingleton<_i26.AppFailureHandler>(() => _i26.AppFailureHandler(
        gh<_i919.AppFailureFactory>(),
        gh<_i665.ApiFailureHandler>(),
      ));
  gh.lazySingleton<_i176.ApiMiddleware>(
      () => _i176.ApiMiddleware(gh<_i26.AppFailureHandler>()));
  gh.lazySingleton<_i491.DioManager>(() => registerModule.dioManager(
        gh<_i417.DioConfig>(),
        gh<_i221.DioInterceptors>(),
        gh<_i67.DioTransformer>(),
        gh<_i919.AppFailureFactory>(),
        gh<_i176.ApiMiddleware>(),
        gh<_i491.UrlAddresses>(),
      ));
  gh.lazySingleton<_i215.ChargeAndPackageRemoteDataSource>(
      () => _i73.ChargeAndPackageRemoteDataSourceImpl(
            dioManager: gh<_i491.DioManager>(),
            addresses: gh<_i491.UrlAddresses>(),
          ));
  gh.lazySingleton<_i697.ChargeAndPackageRepository>(
      () => _i697.ChargeAndPackageRepositoryImpl(
            remoteDataSource: gh<_i215.ChargeAndPackageRemoteDataSource>(),
            appFailureFactory: gh<_i919.AppFailureFactory>(),
          ));
  gh.lazySingleton<_i417.InstallmentRemoteDataSource>(
      () => _i28.InstallmentRemoteDataSourceImpl(
            addresses: gh<_i491.UrlAddresses>(),
            dioManager: gh<_i491.DioManager>(),
          ));
  gh.lazySingleton<_i410.SelectPaymentRemoteDataSource>(
      () => _i879.SelectPaymentRemoteDataSourceImpl(
            addresses: gh<_i491.UrlAddresses>(),
            dioManager: gh<_i491.DioManager>(),
          ));
  gh.lazySingleton<_i60.GetChargeAndPackageListUseCase>(() =>
      _i60.GetChargeAndPackageListUseCase(
          gh<_i697.ChargeAndPackageRepository>()));
  gh.lazySingleton<_i60.GetSimListUseCase>(
      () => _i60.GetSimListUseCase(gh<_i697.ChargeAndPackageRepository>()));
  gh.lazySingleton<_i60.EditSimUseCase>(
      () => _i60.EditSimUseCase(gh<_i697.ChargeAndPackageRepository>()));
  gh.factory<_i638.EditSimBloc>(
      () => _i638.EditSimBloc(gh<_i60.EditSimUseCase>()));
  gh.factory<_i1040.ChargeAndPackageListBloc>(() =>
      _i1040.ChargeAndPackageListBloc(
          gh<_i60.GetChargeAndPackageListUseCase>()));
  gh.lazySingleton<_i401.SelectPaymentRepository>(
      () => _i981.SelectPaymentRepositoryImpl(
            remoteDataSource: gh<_i410.SelectPaymentRemoteDataSource>(),
            appFailureFactory: gh<_i919.AppFailureFactory>(),
          ));
  gh.lazySingleton<_i234.InstallmentRepository>(
      () => _i462.InstallmentRepositoryImpl(
            remoteDataSource: gh<_i417.InstallmentRemoteDataSource>(),
            appFailureFactory: gh<_i919.AppFailureFactory>(),
          ));
  gh.factory<_i422.GetSimListBloc>(
      () => _i422.GetSimListBloc(gh<_i60.GetSimListUseCase>()));
  gh.lazySingleton<_i88.GetInstallmentListUseCase>(
      () => _i88.GetInstallmentListUseCase(gh<_i234.InstallmentRepository>()));
  gh.lazySingleton<_i88.GetInstallmentDetailsUseCase>(() =>
      _i88.GetInstallmentDetailsUseCase(gh<_i234.InstallmentRepository>()));
  gh.factory<_i489.InstallmentDetailsBloc>(() =>
      _i489.InstallmentDetailsBloc(gh<_i88.GetInstallmentDetailsUseCase>()));
  gh.factory<_i135.InstallmentListBloc>(
      () => _i135.InstallmentListBloc(gh<_i88.GetInstallmentListUseCase>()));
  gh.lazySingleton<_i26.GetDepositsListUseCase>(
      () => _i26.GetDepositsListUseCase(gh<_i401.SelectPaymentRepository>()));
  gh.lazySingleton<_i26.GetIncreaseBalanceUseCase>(() =>
      _i26.GetIncreaseBalanceUseCase(gh<_i401.SelectPaymentRepository>()));
  gh.lazySingleton<_i26.GetInstallmentPaymentPlanUseCase>(() =>
      _i26.GetInstallmentPaymentPlanUseCase(
          gh<_i401.SelectPaymentRepository>()));
  gh.lazySingleton<_i26.GetInstallmentSettlementPaymentPlanUseCase>(() =>
      _i26.GetInstallmentSettlementPaymentPlanUseCase(
          gh<_i401.SelectPaymentRepository>()));
  gh.lazySingleton<_i26.GetChargeAndPackagePaymentPlanUseCase>(() =>
      _i26.GetChargeAndPackagePaymentPlanUseCase(
          gh<_i401.SelectPaymentRepository>()));
  gh.factory<_i77.ChargeAndPackagePaymentPlanBloc>(() =>
      _i77.ChargeAndPackagePaymentPlanBloc(
          gh<_i26.GetChargeAndPackagePaymentPlanUseCase>()));
  gh.factory<_i1019.InstallmentPaymentPlanBloc>(() =>
      _i1019.InstallmentPaymentPlanBloc(
          gh<_i26.GetInstallmentPaymentPlanUseCase>()));
  gh.factory<_i194.SelectPaymentListBloc>(
      () => _i194.SelectPaymentListBloc(gh<_i26.GetDepositsListUseCase>()));
  gh.factory<_i937.InstallmentSettlementPaymentPlanBloc>(() =>
      _i937.InstallmentSettlementPaymentPlanBloc(
          gh<_i26.GetInstallmentSettlementPaymentPlanUseCase>()));
  gh.factory<_i280.GetIncreaseBalanceBloc>(
      () => _i280.GetIncreaseBalanceBloc(gh<_i26.GetIncreaseBalanceUseCase>()));
  return getIt;
}

class _$RegisterModule extends _i555.RegisterModule {}
