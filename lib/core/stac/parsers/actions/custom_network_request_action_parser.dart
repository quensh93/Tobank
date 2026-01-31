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
      response = await StacNetworkService.request(context, model);
    } on DioException catch (e) {
      response = e.response;
      Log.e(e.response);
    }

    // Store response data in registry so {{data.data.*}} variables can be resolved
    if (response?.data != null) {
      StacRegistry.instance.setValue('data', response!.data);
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
}

