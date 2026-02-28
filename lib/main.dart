import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/storage/storage_util.dart';
import 'core/stac/registry/register_custom_parsers.dart';
import 'core/stac/mock/stac_mock_dio_setup.dart';
import 'core/stac/loaders/tobank/tobank_strings_loader.dart';
import 'core/stac/loaders/tobank/tobank_styles_loader.dart';
import 'core/stac/loaders/tobank/tobank_colors_loader.dart';
import 'core/stac/loaders/tobank/tobank_assets_loader.dart';
import 'core/stac/utils/variable_resolver_debug.dart';
import 'core/bootstrap/bootstrap.dart';
import 'core/helpers/logger.dart';
import 'stac/default_stac_options.dart';

void main() async {
  // CRITICAL: Initialize Flutter bindings FIRST
  // Required for rootBundle.loadString() in mock interceptor
  WidgetsFlutterBinding.ensureInitialized();

  // Load log settings from storage BEFORE any logging happens
  // This ensures disabled log categories are respected from the start
  await AppLogger.loadSettingsFromStorage();

  // Override logging early to catch initialization logs
  AppLogger.overrideFlutterDebugPrint();

  // Setup Dio with MockInterceptor for STAC dynamicView
  // This allows dynamicView to use mocked API responses from stac/tobank/{feature}/api/
  final stacDio = setupStacMockDio();

  // Initialize STAC framework with options and mocked Dio
  await Stac.initialize(options: defaultStacOptions, dio: stacDio);

  // Register custom STAC parsers
  await registerCustomParsers();

  // Load localization strings ONCE at app startup
  // Strings are stored in StacRegistry and accessible via {{appStrings.*}} syntax
  await TobankStringsLoader.loadStrings(stacDio);

  // Load color schema ONCE at app startup
  // Colors are stored in StacRegistry and accessible via {{appColors.*}} syntax
  await TobankColorsLoader.loadColors(stacDio);

  // Load component styles ONCE at app startup
  // Styles are stored in StacRegistry and accessible via {{appStyles.*}} syntax
  // NOTE: Styles should be loaded AFTER colors since styles reference colors
  await TobankStylesLoader.loadStyles(stacDio);

  // Load assets configuration ONCE at app startup
  // Assets are stored in StacRegistry and accessible via {{appAssets.*}} syntax
  await TobankAssetsLoader.loadAssets(stacDio);

  // Seed defaults for shared promissory API request wrapper.
  _seedPromissoryApiDefaults();

  // Debug: Test variable resolution after strings are loaded
  if (kDebugMode) {
    VariableResolverDebug.testCommonVariables();
  }

  // Use bootstrap for app initialization
  await bootstrap();

  await StorageUtil.setUserCertificate(
    "MIIFUDCCBDigAwIBAgIKFdo4if1Yg9CT1jANBgkqhkiG9w0BAQsFADCBnTELMAkGA1UEBhMCSVIxDzANBgNVBAgTBlRlaHJhbjEZMBcGA1UEChMQTm9uLUdvdmVybm1lbnRhbDEWMBQGA1UECxMNUmFhaGJhciBUcnVzdDEQMA4GA1UECxMHUmFhaGJhcjE4MDYGA1UEAxMvUmFhaGJhciBUcnVzdCBQcml2YXRlIEludGVybWVkaWF0ZSBCcm9uemUgQ0EtRzMwHhcNMjYwMjE0MDgxMjU1WhcNMjcwMjE0MDgxMjU1WjCB4jELMAkGA1UEBhMCSVIxEzARBgNVBAgMCtiq2YfYsdin2YYxEzARBgNVBAcMCtiq2YfYsdin2YYxFTATBgNVBAoMDFVuYWZmaWxpYXRlZDEZMBcGA1UEBAwQ2KzZhdi024zYr9m+2YjYsTERMA8GA1UEKgwI2YXZh9iv24wxEzARBgNVBAUTCjA0NDA2MzY3MTExKjAoBgNVBAMMIW1hYWhkaSBqYWFtc2hpZHBvZHIgW01vYmlsZSBTaWduXTEjMCEGCSqGSIb3DQEJARYUMDQ0MDYzNjcxMUBUZW5pYW4uaXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDHEA8enmpo0wuXSmhLyWWX7z4mPqTsmCneX7kTasnOLAwo2s8vrio50hkL7D/EHi3M4hTLckk6JBUGPICyYOx4OAvLGIoyv9raoTPDxbXzoPD9TQIWDwzIP6i5KFViEeAMcSaslrofxzdrjbAALnx4R+7HmYw3yW4GYtRYSq5gcsnHdAzNBw/AqmCu8vqOIDqdEA0ThMztAuCc5CKELWxI65g1FXAGWJg3jJ0HnQEv9Dc6vHrT7ZFFTBnqX9akS8MWYYRWZbffAIxqH8T+S/bsO1FzNB5gYMI5rqzODzu8vPFy0WjHrVxtdVxfBnWYDtk61BuHo83+8cwEK+1LPo6dAgMBAAGjggFJMIIBRTAfBgNVHSMEGDAWgBSGYsbbYF7OhlHeC67agiParpQ+4DA7BggrBgEFBQcBAQQvMC0wKwYIKwYBBQUHMAGGH2h0dHA6Ly92YTEucmFhaGJhcnRydXN0LmlyL29jc3AwYwYDVR0gBFwwWjBYBgdggmxlAQEBME0wSwYIKwYBBQUHAgEWP2h0dHA6Ly9jYS5yYWFoYmFydHJ1c3QuaXIvZGwvUmVwb3NpdG9yeS9SSUNBQ1BTUmFhaGJhclRydXN0LnBkZjATBgNVHSUEDDAKBggrBgEFBQcDAjA8BgNVHR8ENTAzMDGgL6AthitodHRwOi8vdmExLnJhYWhiYXJ0cnVzdC5pci9Ccm9uemUtTDEtRzMuY3JsMB0GA1UdDgQWBBR5GUKX5ZkImMFZ/AfILCrWFqGhpTAOBgNVHQ8BAf8EBAMCBsAwDQYJKoZIhvcNAQELBQADggEBAFlHlaVhSQZCOc4V/Iq6KgS4bbnYZKWWYjVRy+8cd50mBZWQ6OHjloVTpmlxBgx8JVEQ49GzkiL82nfoTIGqm0okM8ij1O6cV7kIa4HolruWxPNO8n/LMmJ5XjbV8V+DBcViRlE0Km+AfJQLkGYLJi+LoZQ6ZcmASEkQe6Dsh7iL72VNZgliZntg42JiooADI3/mUhRHpmrEgMTCtNP69tgRNDYY+JA9yiR9yORvLIZkb857Fa8a3x5Y8+9my4gjEbRZL83DQElVLjkXDs43CTx6TSmzliDQaT5x6kpqhXe//IwG5P36kxkUwRxxCaYzHrIdUyG3kn7gylnNo/eh1p4=",
  );

  await StorageUtil.setBase64UserSignatureImage(
    "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",
  );
}

void _seedPromissoryApiDefaults() {
  const baseUrlKey = 'promissory.api.baseUrl';
  const headersKey = 'promissory.api.headers.common';

  if (StacRegistry.instance.getValue(baseUrlKey) == null) {
    StacRegistry.instance.setValue(baseUrlKey, 'http://192.168.107.22:8280');
  }

  if (StacRegistry.instance.getValue(headersKey) == null) {
    StacRegistry.instance.setValue(headersKey, <String, dynamic>{
      'accept': 'application/json',
      'content-type': 'application/json',
      'app-platform': 'android',
      'app-store': 'application/json',
      'app-version': '456',
      'device-uuid': '5109ab4c-77ca-4f0c-9858-da4df58031d2',
      'serviceauthorization':
          'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==',
      'authorization': '{{auth.accessToken}}',
    });
  }
}
