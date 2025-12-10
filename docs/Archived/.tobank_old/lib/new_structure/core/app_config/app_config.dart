import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config.freezed.dart';

enum AppEnvironment { test, stage, production }

@freezed
class AppConfig with _$AppConfig {
  const factory AppConfig({
    required AppEnvironment environment,
    required String baseUrl,
    required String staticUrl,
    required String sslFingerprint,
    required String shaparakHubBaseUrl,
    required String pardakhtsaziBaseUrl,
    required String someFlag,
    @Default("1.0.0") String webVersion,
  }) = _AppConfig;
}

abstract class AppConfigDataSource {
  Future<AppEnvironment> getSavedEnvironment();

  Future<void> saveEnvironment(AppEnvironment env);
}

class SharedPrefsAppConfigDataSource implements AppConfigDataSource {
  static const _envKey = 'app_environment';

  @override
  Future<AppEnvironment> getSavedEnvironment() async {
    if(kIsWeb){
      return AppEnvironment.production;
    }
    final prefs = await SharedPreferences.getInstance();
    final envStr = prefs.getString(_envKey);
    print('🔵 getSavedEnvironment: envStr=$envStr, existing keys: ${prefs.getKeys()}');
    return AppEnvironment.values.firstWhere(
          (e) => e.name == envStr,
      orElse: () => AppEnvironment.production,
    );
  }

  @override
  Future<void> saveEnvironment(AppEnvironment env) async {
    final prefs = await SharedPreferences.getInstance();
    print('🟣 saveEnvironment: Setting _envKey=$_envKey to env.name=${env.name}');
    await prefs.setString(_envKey, env.name);
    print('🟢 saveEnvironment: Value now in prefs: ${prefs.getString(_envKey)}');
  }
}

class AppConfigService {
  final AppConfigDataSource _dataSource;
  late AppConfig _config;

  AppConfigService(this._dataSource);

  AppConfig get config => _config;

  Future<void> init() async {
    if(kIsWeb){
      _config = _configForEnv(AppEnvironment.production);
      print("⭕ ENV kIsWeb: Stage");
      return;
    }else if(kReleaseMode){
      _config = _configForEnv(AppEnvironment.production);
      print("⭕ ENV kReleaseMode: Production");
      return;

    }
    final env = await _dataSource.getSavedEnvironment();
    print("⭕ ENV loaded at app startup: $env");
    _config = _configForEnv(env);
  }

  Future<void> setEnvironment(AppEnvironment env) async {
    await _dataSource.saveEnvironment(env);
    _config = _configForEnv(env);
  }


  Future<AppEnvironment> getSavedEnvironment() async {
    if(kIsWeb){
      return AppEnvironment.production;
    }
    return await _dataSource.getSavedEnvironment();
  }

  AppConfig _configForEnv(AppEnvironment env) {
    switch (env) {
      case AppEnvironment.test:
        return AppConfig(
          environment: env,
          baseUrl: 'https://appapi-test.tobank.ir/api/',
          // you may want to update later for "test" when/if different
          staticUrl: 'https://appapi-test.tobank.ir/api/v1.0',
          sslFingerprint:
              '3b878a917307c4330fe090276d1adfc62559dba52ea86b8ac743949db15e911b',
          shaparakHubBaseUrl: 'https://tsm.shaparak.ir/',
          pardakhtsaziBaseUrl: 'https://api.pardakhtsazi.ir/',
          someFlag: 'Test Mode',
        );
      case AppEnvironment.stage:
        return AppConfig(
          environment: env,
          baseUrl: 'https://appapi-stage.tobank.ir/api/',
          staticUrl: 'https://appapi-stage.tobank.ir/api/v1.0',
          sslFingerprint:
              '3b878a917307c4330fe090276d1adfc62559dba52ea86b8ac743949db15e911b',
          shaparakHubBaseUrl: 'https://tsm.shaparak.ir/',
          pardakhtsaziBaseUrl: 'https://api.pardakhtsazi.ir/',
          someFlag: 'Stage Mode',
        );
      case AppEnvironment.production:
        return AppConfig(
          environment: env,
          baseUrl: 'https://appapi.tobank.ir/stage/api/',
          staticUrl: 'https://appapi.tobank.ir/stage/api/v1.0',
          sslFingerprint:
              '3b878a917307c4330fe090276d1adfc62559dba52ea86b8ac743949db15e911b',
          shaparakHubBaseUrl: 'https://tsm.shaparak.ir/',
          pardakhtsaziBaseUrl: 'https://api.pardakhtsazi.ir/',
          someFlag: 'Production Mode',
        );
    }
  }
}
