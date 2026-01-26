/// Config API - Server-Driven UI Configuration Layer
///
/// This module provides a Dio-based layer for fetching SDUI (Server-Driven UI)
/// configurations from the real API endpoint.
///
/// ## Architecture
/// - [ConfigApiService] - Main service for API calls
/// - [ConfigApiModels] - Data models for parsing responses
///
/// ## Usage
/// ```dart
/// import 'package:tobank_sdui/core/api/config_api/config_api.dart';
///
/// final service = ConfigApiService();
/// final sduiJson = await service.fetchSduiConfig(
///   pathKey: 'flutter_key_1.flutter_promissory_key_1',
///   build: 1,
/// );
/// ```

library config_api;

export 'config_api_models.dart';
export 'config_api_service.dart';
