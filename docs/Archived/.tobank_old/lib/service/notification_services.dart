import 'dart:async';

import '../model/common/base_response_data.dart';
import '../model/notification/request/notification_set_read_request_data.dart';
import '../model/notification/response/list_notification_data.dart';
import '../model/notification/response/notification_set_read_response_data.dart';
import 'core/api_core.dart';

class NotificationServices {
  NotificationServices._();

  static Future<ApiResult<(ListNotificationData, int), ApiException>> getNotificationRequest({
    required String type,
    required String category,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    queryParameters['type'] = type;
    queryParameters['category'] = category;
    queryParameters['per_page'] = 20;

    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getNotifications,
        queryParameters: queryParameters,
        modelFromJson: (responseBody, statusCode) => ListNotificationData.fromJson(responseBody));
  }

  static Future<ApiResult<(NotificationSetReadResponse, int), ApiException>> notificationReadRequest({
    required int notificationId,
    required NotificationSetReadRequest notificationSetReadRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.setNotificationRead,
        slug: notificationId.toString(),
        data: notificationSetReadRequest,
        modelFromJson: (responseBody, statusCode) => NotificationSetReadResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(BaseResponseData, int), ApiException>> deleteNotificationRequest({
    required NotificationData notificationData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.deleteNotification,
        slug: notificationData.id.toString(),
        modelFromJson: (responseBody, statusCode) => BaseResponseData.fromJson(responseBody));
  }
}
