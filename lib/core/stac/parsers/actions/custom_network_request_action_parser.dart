import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import 'package:stac_framework/stac_framework.dart';
import 'package:stac_logger/stac_logger.dart';
import '../../../helpers/logger.dart';
import '../../utils/registry_notifier.dart';

/// Custom network request parser that stores response data in registry
/// so that {{data.data.*}} variables can be resolved in results actions.
class CustomNetworkRequestActionParser
    extends StacActionParser<StacNetworkRequest> {
  const CustomNetworkRequestActionParser();

  @override
  String get actionType => ActionType.networkRequest.name;

  @override
  StacNetworkRequest getModel(Map<String, dynamic> json) =>
      StacNetworkRequest.fromJson(json);

  @override
  FutureOr onCall(BuildContext context, StacNetworkRequest model) async {
    Response<dynamic>? response;

    try {
      final resolvedModel = _resolveNetworkRequestTemplates(model);
      response = await StacNetworkService.request(context, resolvedModel);
    } on DioException catch (e) {
      response = e.response;
      Log.e(e.response);
    }

    // Store response data in registry so {{data.data.*}} variables can be resolved
    if (response?.data != null) {
      final responseData = response!.data;
      StacRegistry.instance.setValue('data', responseData);

      dynamic payload;
      if (responseData is Map) {
        payload = responseData['data'];
        if (payload == null && responseData['result'] is Map) {
          payload = (responseData['result'] as Map)['data'];
        }
      }
      if (payload != null) {
        StacRegistry.instance.setValue('data_payload', payload);
      }

      RegistryNotifier.instance.notify();
      AppLogger.dc(
        LogCategory.network,
        'Network response data stored in registry under "data" key',
      );
    }

    if (response?.statusCode != null) {
      try {
        final result = model.results.firstWhere(
          (element) => element.statusCode == response?.statusCode,
        );

        if (context.mounted) {
          return Stac.onCallFromJson(result.action, context);
        }
      } catch (e) {
        // No matching status code found in results
        AppLogger.wc(
          LogCategory.network,
          'No result handler for status code ${response?.statusCode}',
        );
      }
    }

    return null;
  }

  StacNetworkRequest _resolveNetworkRequestTemplates(StacNetworkRequest model) {
    final resolvedUrl = _resolveTemplates(model.url);

    Map<String, String>? resolvedHeaders;
    final headers = model.headers;
    if (headers != null) {
      resolvedHeaders = headers.map((key, value) {
        return MapEntry(key, _resolveTemplates(value));
      });
    }

    if (resolvedHeaders != null) {
      final authValue = resolvedHeaders.entries
          .firstWhere(
            (e) => e.key.toLowerCase() == 'authorization',
            orElse: () => const MapEntry('', ''),
          )
          .value;
      final hasAuth = authValue.trim().isNotEmpty;
      AppLogger.dc(
        LogCategory.network,
        'STAC request headers resolved (hasAuthorization=$hasAuth): '
            '${resolvedHeaders.map((k, v) => MapEntry(k, k.toLowerCase() == 'authorization' ? '***' : v))}',
      );
    }

    return StacNetworkRequest(
      url: resolvedUrl,
      method: model.method,
      headers: resolvedHeaders,
      body: model.body,
    );
  }

  String _resolveTemplates(String input) {
    final decodedInput = _tryDecodeUriComponent(input);
    if (!decodedInput.contains('{{') || !decodedInput.contains('}}')) {
      return decodedInput;
    }

    return decodedInput.replaceAllMapped(RegExp(r'\{\{([^}]+)\}\}'), (match) {
      final expr = match.group(1)?.trim();
      if (expr == null || expr.isEmpty) return match.group(0) ?? '';

      final value = StacRegistry.instance.getValue(expr);
      if (value == null) return '';
      return value.toString();
    });
  }

  String _tryDecodeUriComponent(String input) {
    try {
      // StacNetworkService may percent-encode the URL early; decode to allow {{...}} resolution.
      return Uri.decodeFull(input);
    } catch (_) {
      return input;
    }
  }
}

