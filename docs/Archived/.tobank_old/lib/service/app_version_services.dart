import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../model/common/error_response_data.dart';
import '../model/other/app_version_data.dart';
import '../model/other/menu_response_data.dart';
import '../util/web_only_utils/menu_web_util.dart';
import 'core/api_core.dart';

class AppVersionServices {
  AppVersionServices._();

  // Configuration flag
  static bool useLocalMenu = true;

  static Future<ApiResult<(AppVersionData, int), ApiException>> getAppVersion(String platform) async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.config,
      slug: platform,
      modelFromJson: (responseBody, statusCode) => AppVersionData.fromJson(responseBody),
    );
  }

  static Future<ApiResult<(MenuResponseModel, int), ApiException<ErrorResponseData>>> getMenu() async {
    // Use local data if flag is set
    if (useLocalMenu) {
      try {
        // Get menu data directly from MenuWebUtil
        final Map<String, dynamic> menuData = MenuWebUtil.getMenuData();
        print("🚀🚀🚀🚀 Successfully loaded JSON data from MenuWebUtil");

        // Create a response that mimics the API response
        final Map<String, dynamic> responseJson = {
          "success": true,
          "data": menuData,
          "lastest_menu_update": "2025-03-06 12:00:00"
        };

        final model = MenuResponseModel.fromJson(responseJson);
        return Success<(MenuResponseModel, int), ApiException<ErrorResponseData>>((model, 200));
      } catch (e) {
        // If anything else fails, fall back to API
        print("🚀🚀🚀🚀 Falling back to API call for menu data: $e");
        return await _fetchMenuFromApi();
      }
    } else {
      return await _fetchMenuFromApi();
    }
  }

  // Helper method to make the API call
  static Future<ApiResult<(MenuResponseModel, int), ApiException<ErrorResponseData>>> _fetchMenuFromApi() async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.configMenu,
      modelFromJson: (responseBody, statusCode) {
        return MenuResponseModel.fromJson(responseBody);
      },
    );
  }
}