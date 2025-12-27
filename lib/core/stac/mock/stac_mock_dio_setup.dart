import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:stac/stac.dart';
import '../loaders/tobank/tobank_styles_loader.dart';
import '../../helpers/logger.dart';

/// Sets up Dio instance with custom mock interceptor for STAC dynamicView
///
/// This allows STAC's dynamicView to use mocked API responses from JSON files
/// stored in `stac/tobank/{feature}/api/` directories.
///
/// **Usage:**
/// ```dart
/// final dio = setupStacMockDio();
/// await Stac.initialize(options: defaultStacOptions, dio: dio);
/// ```
///
/// **Mock File Structure:**
/// - `stac/tobank/login/api/GET_tobank_login.json` - Screen JSONs organized by feature
/// - `stac/tobank/menu/api/GET_menu-items.json` - Data APIs organized by feature
///
/// **File Naming Convention:**
/// - Format: `{METHOD}_{name}.json`
/// - Example: `GET_tobank_login.json` for screen JSONs
/// - Example: `GET_menu-items.json` for data APIs
///
/// **URL Mapping:**
/// - Screen URLs like `https://api.tobank.com/screens/tobank_login` map to
///   `stac/tobank/login/api/GET_tobank_login.json` (returns JSON directly, not wrapped)
/// - Data URLs like `https://api.tobank.com/menu-items` map to
///   `stac/tobank/menu/api/GET_menu-items.json` (returns wrapped in {"data": {...}})
Dio setupStacMockDio() {
  final dio = Dio();

  // Add custom interceptor to load mock files from stac/tobank/{feature}/api/
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Log Request (AppLogger respects category settings)
        AppLogger.dc(
          LogCategory.network,
          '📤 STAC ${options.method} ${options.uri}',
        );
        if (options.data != null) {
          AppLogger.dc(LogCategory.network, '   Request data: ${options.data}');
        }

        try {
          // Extract path from full URL
          // Convert: https://api.tobank.com/menu-labels -> menu-labels
          String path = options.uri.path;
          if (path.startsWith('/')) {
            path = path.substring(1);
          }

          final method = options.method.toUpperCase();
          String? assetPath;
          bool isScreenJson = false;

          // Determine file location based on URL pattern
          if (path.startsWith('screens/')) {
            // Screen JSON: https://api.tobank.com/screens/tobank_login
            // Map screen name to feature folder:
            // tobank_login -> login/GET_tobank_login.json
            // tobank_menu -> menu/GET_tobank_menu.json
            final screenName = path.replaceFirst('screens/', '');
            final filename = '${method}_$screenName.json';

            // Map screen names to feature folders
            String? featureFolder;
            if (screenName.startsWith('tobank_')) {
              final feature = screenName.replaceFirst('tobank_', '');
              // Handle special cases
              if (feature == 'verify_otp') {
                featureFolder = 'otp';
              } else if (feature == 'account_overview') {
                featureFolder = 'account';
              } else if (feature == 'transfer_form') {
                featureFolder = 'transfer';
              } else if (feature == 'transaction_history') {
                featureFolder = 'transactions';
              } else {
                featureFolder = feature;
              }
            }

            // Try new structure: lib/stac/tobank/{feature}/api/GET_{screen}.json
            // Pattern: screens/login/tobank_login -> lib/stac/tobank/login/api/GET_tobank_login.json
            if (featureFolder != null) {
              assetPath = 'lib/stac/tobank/$featureFolder/api/$filename';
            } else {
              // Try to find in any feature folder
              final featureFolders = [
                'login',
                'otp',
                'menu',
                'home',
                'account',
                'transfer',
                'transactions',
                'profile',
                'stateful_example',
              ];
              for (final folder in featureFolders) {
                final testPath = 'lib/stac/tobank/$folder/api/$filename';
                try {
                  await rootBundle.loadString(testPath);
                  assetPath = testPath;
                  break;
                } catch (_) {
                  // Continue to next folder
                }
              }
            }
            isScreenJson = true;
          } else if (path == 'strings') {
            // Localization strings: https://api.tobank.com/strings
            // -> lib/stac/config/GET_strings.json
            assetPath = 'lib/stac/config/GET_strings.json';
          } else if (path == 'assets') {
            // Assets: https://api.tobank.com/assets
            // -> lib/stac/config/GET_assets.json
            assetPath = 'lib/stac/config/GET_assets.json';
          } else if (path == 'styles') {
            // Component styles: https://api.tobank.com/styles
            // -> lib/stac/design_system/GET_styles.json
            assetPath = 'lib/stac/design_system/GET_styles.json';
            AppLogger.d('🔍 Loading styles from: $assetPath');
          } else if (path == 'colors') {
            // Color schema: https://api.tobank.com/colors
            // -> lib/stac/design_system/GET_colors.json
            assetPath = 'lib/stac/design_system/GET_colors.json';
          } else {
            // Data API: Try to find in feature-specific API locations
            // Pattern: menu-items -> lib/stac/tobank/menu/api/GET_menu-items.json
            final filename = '${method}_$path.json';

            // Try tobank feature-specific API locations (e.g., lib/stac/tobank/menu/api/)
            // This takes priority for Dart STAC screens that separate data layer
            // Note: menu-items is a DATA API, not a screen JSON, so don't set isScreenJson = true
            if (path.contains('menu-items') || path == 'menu-items') {
              final testPath = 'lib/stac/tobank/menu/api/$filename';
              try {
                await rootBundle.loadString(testPath);
                assetPath = testPath;
                // menu-items is a data API, not a screen JSON - it should be wrapped in {"data": {...}}
                // isScreenJson remains false
              } catch (_) {
                // Continue to feature folders
              }
            }

            // Try new structure: lib/stac/tobank/{feature}/api/GET_{screen}.json
            // Pattern: login/tobank_login -> lib/stac/tobank/login/api/GET_tobank_login.json
            if (assetPath == null && path.contains('/')) {
              final parts = path.split('/');
              if (parts.length == 2) {
                final feature = parts[0];
                final screen = parts[1];
                // Construct filename: GET_{screen}.json
                final testPath =
                    'lib/stac/tobank/$feature/api/GET_$screen.json';
                try {
                  await rootBundle.loadString(testPath);
                  assetPath = testPath;
                  isScreenJson = true; // Screen JSONs need variable resolution
                } catch (_) {
                  // Continue to feature folders
                }
              }
            }

            // Special handling for verify-identity endpoint
            if (assetPath == null && path == 'verify-identity') {
              final testPath = 'lib/stac/tobank/login/api/$filename';
              try {
                await rootBundle.loadString(testPath);
                assetPath = testPath;
                // verify-identity is a data API response, not a screen JSON
                isScreenJson = false;
              } catch (_) {
                // Continue to feature folders
              }
            }

            // Try feature folders (login, otp, menu, home, account, transfer, transactions, profile)
            if (assetPath == null) {
              final featureFolders = [
                'login',
                'otp',
                'menu',
                'home',
                'account',
                'transfer',
                'transactions',
                'profile',
                'stateful_example',
                'flows/login_flow',
              ];
              for (final folder in featureFolders) {
                final testPath = 'lib/stac/tobank/$folder/api/$filename';
                try {
                  await rootBundle.loadString(testPath);
                  assetPath = testPath;
                  // Treat stateful_example_* endpoints as data APIs (not screens).
                  isScreenJson = folder != 'stateful_example';
                  break;
                } catch (_) {
                  // Continue to next folder
                }
              }
            }

            // Special handling for login-flow endpoint for flows
            if (assetPath == null && path == 'login-flow') {
              final testPath =
                  'lib/stac/tobank/flows/login_flow/api/GET_tobank_login_flow.json';
              try {
                await rootBundle.loadString(testPath);
                assetPath = testPath;
                // login-flow now contains screen JSON (not just data)
                isScreenJson = true;
              } catch (_) {
                // Continue
              }
            }

            // Special handling for flows screen JSONs (flows/login_flow/tobank_login_flow pattern)
            if (assetPath == null && path.startsWith('flows/')) {
              final pathParts = path.split('/');
              if (pathParts.length >= 2) {
                // flows/login_flow/tobank_login_flow -> flows/login_flow/api/GET_tobank_login_flow.json
                final flowName = pathParts[1]; // e.g., 'login_flow'
                final screenName = pathParts.length >= 3
                    ? pathParts[2]
                    : 'tobank_$flowName';
                final testPath =
                    'lib/stac/tobank/flows/$flowName/api/GET_$screenName.json';
                try {
                  await rootBundle.loadString(testPath);
                  assetPath = testPath;
                  isScreenJson = true; // Screen JSON needs variable resolution
                  AppLogger.d('✅ Mock interceptor: Found flow file: $testPath');
                } catch (e) {
                  AppLogger.d(
                    '⚠️ Mock interceptor: Failed to load $testPath: $e',
                  );
                  // Continue
                }
              }
            }

            // Fallback handling for incorrectly formatted flow URLs
            // Pattern: login_flow_linear_splash/tobank_login_flow_linear_splash
            // Should map to: flows/login_flow_linear/api/GET_login_flow_linear_splash.json
            if (assetPath == null &&
                path.contains('/') &&
                path.contains('_flow_')) {
              final pathParts = path.split('/');
              if (pathParts.length == 2) {
                final firstPart =
                    pathParts[0]; // e.g., 'login_flow_linear_splash'
                final secondPart =
                    pathParts[1]; // e.g., 'tobank_login_flow_linear_splash'

                // Extract flow name by removing last segment from first part
                // login_flow_linear_splash -> login_flow_linear
                final firstParts = firstPart.split('_');
                if (firstParts.length > 1) {
                  final flowNameParts = firstParts.sublist(
                    0,
                    firstParts.length - 1,
                  );
                  final flowName = flowNameParts.join(
                    '_',
                  ); // e.g., 'login_flow_linear'

                  // Remove 'tobank_' prefix from second part to get screen name
                  final screenName = secondPart.startsWith('tobank_')
                      ? secondPart.substring(7) // Remove 'tobank_' prefix
                      : secondPart;

                  final testPath =
                      'lib/stac/tobank/flows/$flowName/api/GET_$screenName.json';
                  try {
                    await rootBundle.loadString(testPath);
                    assetPath = testPath;
                    isScreenJson = true;
                  } catch (_) {
                    // Continue
                  }
                }
              }
            }

            // If still not found, assetPath will be null and will throw error below
          }

          // Try to load the mock file
          if (assetPath == null) {
            AppLogger.w(
              '⚠️ Mock interceptor: No asset path found for URL: ${options.uri}',
            );
            return handler.next(options);
          }

          // assetPath is guaranteed to be non-null here (checked above)
          final finalAssetPath = assetPath;

          try {
            AppLogger.d(
              '🔍 Mock interceptor: Looking for file: $finalAssetPath',
            );
            final jsonString = await rootBundle.loadString(finalAssetPath);

            // DEBUG: Check for light/current references in the raw JSON string
            if (finalAssetPath.contains('GET_styles.json')) {
              final lightCount = RegExp(
                r'appColors\.light\.',
              ).allMatches(jsonString).length;
              final currentCount = RegExp(
                r'appColors\.current\.',
              ).allMatches(jsonString).length;
              AppLogger.i('🔍 STYLES JSON CONTENT CHECK:');
              AppLogger.i('   File: $finalAssetPath');
              AppLogger.i('   appColors.light.* references: $lightCount');
              AppLogger.i('   appColors.current.* references: $currentCount');
              if (lightCount > 0) {
                AppLogger.e(
                  '   ❌ ERROR: Found $lightCount appColors.light.* references!',
                );
                AppLogger.e(
                  '   These should be appColors.current.* for theme awareness!',
                );
              }
              if (currentCount == 0 && lightCount > 0) {
                AppLogger.e(
                  '   ❌ CRITICAL: No appColors.current.* references found!',
                );
              }
            }

            final jsonData = json.decode(jsonString) as Map<String, dynamic>;

            // For screen JSONs, return the JSON directly (it's already a STAC screen JSON)
            // BUT: Pre-resolve variables to preserve numeric types (STAC's resolver converts everything to strings)
            if (isScreenJson) {
              AppLogger.d(
                '✅ Mock interceptor: Returning screen JSON for $method $path',
              );

              // Check if JSON is wrapped in API format (e.g., {"GET": {"data": {...}}})
              // Screen JSONs in API files are wrapped, so extract the data field first
              Map<String, dynamic> widgetJson = jsonData;
              if (jsonData.containsKey(method) &&
                  jsonData[method] is Map<String, dynamic>) {
                final methodData = jsonData[method] as Map<String, dynamic>;
                if (methodData.containsKey('data') &&
                    methodData['data'] is Map<String, dynamic>) {
                  widgetJson = methodData['data'] as Map<String, dynamic>;
                  AppLogger.d(
                    '   📦 Extracted widget JSON from API wrapper (${method}.data)',
                  );
                }
              }

              // Debug: Check a sample variable before resolution
              final sampleVar = StacRegistry.instance.getValue(
                'appStyles.text.pageTitle.fontSize',
              );
              AppLogger.d(
                '   🔍 Sample variable from registry: appStyles.text.pageTitle.fontSize',
              );
              AppLogger.d(
                '      Type: ${sampleVar.runtimeType}, Value: $sampleVar',
              );

              // Pre-resolve variables to preserve types (especially for numeric style values)
              final resolvedJson = resolveVariablesPreservingTypes(
                widgetJson,
                StacRegistry.instance,
              );

              // Debug: Check a sample resolved value
              if (resolvedJson is Map) {
                final sampleStyle = _getNestedValue(resolvedJson, [
                  'appBar',
                  'title',
                  'style',
                  'fontSize',
                ]);
                if (sampleStyle != null) {
                  AppLogger.d(
                    '   🔍 Sample resolved fontSize type: ${sampleStyle.runtimeType}, value: $sampleStyle',
                  );
                }

                // Also check padding values
                final samplePadding = _getNestedValue(resolvedJson, [
                  'body',
                  'children',
                  '0',
                  'child',
                  'padding',
                  'left',
                ]);
                if (samplePadding != null) {
                  AppLogger.d(
                    '   🔍 Sample padding.left type: ${samplePadding.runtimeType}, value: $samplePadding',
                  );
                }
              }

              // Log Response (AppLogger respects category settings)
              AppLogger.dc(LogCategory.network, '📥 STAC 200 ${options.uri}');
              final dataStr1 = resolvedJson.toString();
              if (dataStr1.length < 500) {
                AppLogger.dc(LogCategory.network, '   Response: $dataStr1');
              } else {
                AppLogger.dc(
                  LogCategory.network,
                  '   Response: ${dataStr1.substring(0, 500)}... (truncated)',
                );
              }

              return handler.resolve(
                Response(
                  requestOptions: options,
                  statusCode: 200,
                  data:
                      resolvedJson, // Screen JSONs with variables pre-resolved
                ),
              );
            }

            // For config and data APIs, extract from method wrapper
            final methodData = jsonData[method] as Map<String, dynamic>?;
            if (methodData != null) {
              final statusCode = methodData['statusCode'] as int? ?? 200;
              final innerData = methodData['data'];

              // STAC's targetPath expects the response structure to match
              // If targetPath is 'data.menuItems', response should be {"data": {"menuItems": [...]}}
              // Our mock files have: {"GET": {"data": {"menuItems": [...]}}}
              // So we need to wrap innerData in {"data": innerData} to match targetPath expectations
              AppLogger.d(
                '✅ Mock interceptor: Returning response for $method $path (status: $statusCode)',
              );

              // Wrap the data to match targetPath structure
              // If targetPath is 'data.menuItems', response should be {"data": {"menuItems": [...]}}
              final wrappedResponse = {'data': innerData};

              // Log Response (AppLogger respects category settings)
              AppLogger.dc(
                LogCategory.network,
                '📥 STAC $statusCode ${options.uri}',
              );
              final dataStr2 = wrappedResponse.toString();
              if (dataStr2.length < 500) {
                AppLogger.dc(LogCategory.network, '   Response: $dataStr2');
              } else {
                AppLogger.dc(
                  LogCategory.network,
                  '   Response: ${dataStr2.substring(0, 500)}... (truncated)',
                );
              }

              return handler.resolve(
                Response(
                  requestOptions: options,
                  statusCode: statusCode,
                  data: wrappedResponse,
                ),
              );
            } else {
              AppLogger.w(
                '⚠️ Mock interceptor: Method $method not found in $finalAssetPath',
              );
            }
          } catch (e) {
            // File not found or error loading - let request continue normally
            // This allows real API calls if mock file doesn't exist
            AppLogger.wc(
              LogCategory.network,
              '⚠️ Mock file not found or error loading: $finalAssetPath - $e',
            );
          }
        } catch (e) {
          // Error in interceptor - let request continue
          AppLogger.ec(LogCategory.network, 'Error in mock interceptor: $e');
        }

        // Continue with normal request if mock file not found
        handler.next(options);
      },
    ),
  );

  return dio;
}

/// Resolve variables in JSON while preserving value types (numbers, bools, etc.)
///
/// This is a workaround for STAC's variable resolver which always converts values to strings.
/// When a string is EXACTLY a variable reference (like "{{appStyles.button.primary.elevation}}"),
/// we return the actual value type (number, bool, etc.) instead of converting it to a string.
///
/// Made public so it can be used by CustomNavigateActionParser for JSON file loading.
dynamic resolveVariablesPreservingTypes(dynamic json, StacRegistry registry) {
  if (json is String) {
    // Check if the entire string is a variable reference (no other text)
    final exactMatch = RegExp(r'^{{\s*([^}]+)\s*}}$').firstMatch(json);
    if (exactMatch != null) {
      // Entire string is a variable reference - return the value directly (preserve type)
      final variableName = exactMatch.group(1)?.trim() ?? '';
      if (variableName.startsWith('appStyles.')) {
        final base = variableName.substring('appStyles.'.length);
        final parts = base.split('.');
        final isStyleObjectRef =
            parts.length == 1 ||
            (parts.length == 2 &&
                (parts.first == 'text' ||
                    parts.first == 'button' ||
                    parts.first == 'input'));
        if (isStyleObjectRef) {
          final built = TobankStylesLoader.buildStyleObject(variableName);
          if (built != null) {
            return built;
          }
        }
      }
      final value = registry.getValue(variableName);
      if (value != null) {
        // Debug: Log all variable resolutions for numeric values (to catch issues)
        if (variableName.contains('fontSize') ||
            variableName.contains('height') ||
            variableName.contains('width') ||
            variableName.contains('padding') ||
            variableName.contains('margin') ||
            variableName.contains('elevation') ||
            variableName.contains('borderRadius')) {
          AppLogger.dc(
            LogCategory.json,
            '   🔍 Resolving numeric variable: $variableName',
          );
          AppLogger.dc(
            LogCategory.json,
            '      Retrieved type: ${value.runtimeType}, value: $value',
          );
        }

        // If value is a string that looks like a number, convert it back to a number
        // This handles cases where StacRegistry might have stored numbers as strings
        final converted = _convertStringToTypeIfNeeded(value);

        // Debug: Log if conversion changed the type (helps identify issues)
        // Debug: Log if conversion changed the type (helps identify issues)
        if (value is String && converted is! String) {
          AppLogger.dc(
            LogCategory.json,
            '   🔄 Converted $variableName from String to ${converted.runtimeType}: "$value" -> $converted',
          );
        } else if (value is! String && converted is num) {
          AppLogger.dc(
            LogCategory.json,
            '   ✅ Preserved numeric type for $variableName: ${converted.runtimeType} = $converted',
          );
        }

        return converted;
      }
      return json; // Variable not found, return original
    }

    // String contains variable references but has other text - do string replacement
    return json.replaceAllMapped(RegExp(r'{{(.*?)}}'), (match) {
      final variableName = match.group(1)?.trim();
      var value = registry.getValue(variableName ?? '');

      // Fallback for appData.* variables: try form.* if not found
      if (value == null &&
          variableName != null &&
          variableName.startsWith('appData.')) {
        final formKey = variableName.replaceFirst('appData.', 'form.');
        value = registry.getValue(formKey);
        if (value != null) {
          // Also store it in appData.* for future use
          registry.setValue(variableName, value);
        }
      }

      return value != null ? value.toString() : match.group(0) ?? '';
    });
  } else if (json is Map<String, dynamic>) {
    if (json.containsKey('type') && json['type'] == 'alias') {
      final val = json['value'];
      if (val is String) {
        final built = TobankStylesLoader.buildStyleObject(val);
        if (built != null) {
          return built;
        }
      }
    }
    return json.map(
      (key, value) =>
          MapEntry(key, resolveVariablesPreservingTypes(value, registry)),
    );
  } else if (json is List) {
    return json
        .map((item) => resolveVariablesPreservingTypes(item, registry))
        .toList();
  }
  return json;
}

/// Convert string representations back to their original types (numbers, bools)
///
/// This handles cases where values might have been stored as strings in StacRegistry
/// but need to be numbers or booleans for JSON parsing.
dynamic _convertStringToTypeIfNeeded(dynamic value) {
  // If already the correct type, return as-is
  if (value is num || value is bool) {
    return value;
  }

  // If it's a string, try to convert it back to a number or bool
  if (value is String) {
    // Try to parse as integer first
    final intValue = int.tryParse(value);
    if (intValue != null) {
      return intValue;
    }

    // Try to parse as double
    final doubleValue = double.tryParse(value);
    if (doubleValue != null) {
      return doubleValue;
    }

    // Try to parse as boolean
    if (value.toLowerCase() == 'true') {
      return true;
    }
    if (value.toLowerCase() == 'false') {
      return false;
    }

    // Not a number or bool, return as string
    return value;
  }

  // Unknown type, return as-is
  return value;
}

/// Helper to get nested value from map for debugging
dynamic _getNestedValue(Map map, List<String> keys) {
  dynamic current = map;
  for (final key in keys) {
    if (current is Map && current.containsKey(key)) {
      current = current[key];
    } else {
      return null;
    }
  }
  return current;
}
