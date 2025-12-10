import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

import '../../app_config/app_config.dart';
import '../../constants/addresses/url_addresses.dart';
import '../../services/logger_service/talker/talker.dart';
import '../../services/network/api_middleware/api_middleware.dart';
import '../../services/network/dio/dio_config.dart';
import '../../services/network/dio/dio_interceptors.dart';
import '../../services/network/dio/dio_manager.dart';
import '../../services/network/dio/dio_transformer.dart';
import '../../services/network/failures/app_failure/app_failure_factory.dart';

@module
abstract class RegisterModule {

  @singleton
  AppConfigDataSource get appConfigDataSource => SharedPrefsAppConfigDataSource();

  @preResolve
  @singleton
  Future<AppConfigService> appConfigService(AppConfigDataSource ds) async {
    final service = AppConfigService(ds);
    await service.init();
    return service;
  }


  @singleton
  TalkerService get talkerService => TalkerService();

  @lazySingleton
  Connectivity connectionChecker() => Connectivity();

  @lazySingleton
  DioManager dioManager(
      DioConfig dioConfig,
      DioInterceptors dioInterceptors,
      DioTransformer dioTransformer,
      AppFailureFactory appFailureFactory,
      ApiMiddleware apiMiddleware,
      UrlAddresses addresses,
      ) {
    return DioManager(
      dioConfig,
      dioInterceptors,
      dioTransformer,
      appFailureFactory,
      apiMiddleware,
      addresses,
    );
  }
}