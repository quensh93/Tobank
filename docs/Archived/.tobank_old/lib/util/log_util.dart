import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

// TALKER:
import 'package:talker/talker.dart';

import '../log/api_log_history_screen.dart';

class ApiLogService extends GetxService {
  // ===== Static feature flags + static talker =====

  /// Enable or disable developer logging using dart:developer.log
  static bool enableDeveloperLog = false;

  /// Enable or disable keeping log history for in-app history screen
  static bool enableLogHistory = false;

  /// Enable or disable Talker info log (for Logger.infoLog usage, non-API)
  static bool enableTalkerInfoLog = true;

  /// Set Talker instance to enable infoLog globally
  static Talker? talker;

  /// Show response headers in log view
  static bool isDisplayResponseHeaders = false;

  /// Show error headers in log view
  static bool isDisplayErrorHeaders = false;

  static bool showTalkerLogsInsteadOfOldScreen = true ;

  // ==== Instance/Service members ====

  final List<ApiLogModel> _logs = [];

  List<ApiLogModel> get logs => _logs;

  void clearLogHistory() {
    if (!enableLogHistory) return;
    _logs.clear();
  }

  /// Go to UI log screen (for debug only)
  void gotoLogHistory() {
    if ((kIsWeb || kDebugMode)) {
      Get.to(() => const ApiLogHistoryScreen());
    }
  }

  int logRequest({
    required String title,
    required String method,
    required String url,
    required Map<String, dynamic> headers,
    required Map<String, dynamic>? queryParameters,
    required String? data,
    required bool requireBase64EncodedBody,
  }) {
    if (!enableLogHistory) return -1;

    final id = _logs.isNotEmpty ? (_logs.first.id + 1) : 1;

    // Generate cURL command
    final curlCommand = _generateCurl(
      method: method,
      url: url,
      headers: headers,
      queryParameters: queryParameters,
      data: data,
      requireBase64EncodedBody: requireBase64EncodedBody,
    );
    final log = ApiLogModel(
      id: id,
      title: title,
      request: ApiLogRequestModel(
        method: method,
        url: url,
        headers: headers,
        queryParameters: queryParameters,
        data: data,
        requireBase64EncodedBody: requireBase64EncodedBody,
        curl:curlCommand,
      ),
    );
    _logs.insert(0, log);
    return id;
  }

  void logResponse({
    required int id,
    required int statusCode,
    required Map<String, dynamic> data,
    required Map<String, List<String>> headers,
  }) {
    if (!enableLogHistory) return;
    final log = _logs.firstWhereOrNull(
          (element) => element.id == id,
    );
    if (log != null) {
      log.isSuccess = true;
      log.response = ApiLogResponseModel(data: data, statusCode: statusCode, headers: headers);
      log.time = log.response!.time.difference(log.request.time);
      _developerLog(log);
    }
  }

  void logError({
    required int id,
    required String type,
    required String displayMessage,
    required int displayCode,
    required int? statusCode,
    required Map<String, dynamic>? headers,
    required String? data,
  }) {
    if (!enableLogHistory) return;
    final log = _logs.firstWhereOrNull(
          (element) => element.id == id,
    );
    if (log != null) {
      log.isSuccess = false;
      log.error = ApiLogErrorModel(
        type: type,
        displayMessage: displayMessage,
        displayCode: displayCode,
        statusCode: statusCode,
        headers: headers,
        data: data,
      );
      log.time = log.error!.time.difference(log.request.time);
      _developerLog(log);
    }
  }

  void _developerLog(ApiLogModel log) {
    if (!enableDeveloperLog || !kDebugMode) return;

    dev.log('****************************************************************', name: 'API');
    dev.log('${log.id}. ${log.title}', name: 'API-TITLE');
    dev.log(log.request.curl, name: 'API-CURL');
    dev.log(log.request.method, name: 'API-REQUEST-METHOD');
    dev.log(log.request.url, name: 'API-REQUEST-URL');
    dev.log(log.request.headers.toString(), name: 'API-REQUEST-HEADERS');
    dev.log(log.request.queryParameters.toString(), name: 'API-REQUEST-PARAMS');
    if (log.request.requireBase64EncodedBody == true) {
      if (log.request.data == null) {
        dev.log('null', name: 'API-REQUEST-DATA');
      } else {
        final jsonData = jsonDecode(log.request.data.toString());
        dev.log(utf8.decode(base64.decode(jsonData['data'])), name: 'API-REQUEST-DATA');
      }
    } else {
      dev.log(log.request.data ?? 'null', name: 'API-REQUEST-DATA');
    }

    dev.log((log.time?.inMilliseconds ?? 0).toString(), name: 'API-TIME-Mili');

    if (isResponse(log)) {
      dev.log(log.response!.statusCode.toString(), name: 'API-RESPONSE-STATUSCODE');
      if (isDisplayResponseHeaders) {
        dev.log(log.response!.headers.toString(), name: 'API-RESPONSE-HEADERS');
      }

      try {
        // Convert to string first, then find and replace file content
        String responseJson = jsonEncode(log.response!.data);
        responseJson = _sanitizeJsonString(responseJson);
        dev.log(responseJson, name: 'API-RESPONSE-DATA');
      } catch (e) {
        dev.log('Error formatting response data: $e', name: 'API-RESPONSE-DATA');
        // Fallback to original data if error occurs
        dev.log(jsonEncode(log.response!.data), name: 'API-RESPONSE-DATA');
      }
    } else if (isError(log)) {
      dev.log(log.error!.type, name: 'API-ERROR-TYPE');
      dev.log(log.error!.displayMessage, name: 'API-ERROR-MESSAGE');
      dev.log(log.error!.displayCode.toString(), name: 'API-ERROR-DISPLAYCODE');
      dev.log(log.error!.statusCode.toString(), name: 'API-ERROR-STATUSCODE');
      if (isDisplayErrorHeaders) {
        dev.log(log.error!.headers.toString(), name: 'API-ERROR-HEADERS');
      }

      try {
        if (log.error!.data != null) {
          String errorData = log.error!.data!;
          errorData = _sanitizeJsonString(errorData);
          dev.log(errorData, name: 'API-ERROR-DATA');
        } else {
          dev.log('null', name: 'API-ERROR-DATA');
        }
      } catch (e) {
        dev.log('Error formatting error data: $e', name: 'API-ERROR-DATA');
        // Fallback to original data if error occurs
        dev.log(log.error!.data ?? 'null', name: 'API-ERROR-DATA');
      }
    }
  }

  // Helper method to safely sanitize JSON content
  String _sanitizeJsonString(String jsonString) {
    // This regex matches base64 content inside JSON string quotes
    final regex = RegExp(r'"(JVBERi[A-Za-z0-9+/=]{50,})"');
    final base64Regex = RegExp(r'"([A-Za-z0-9+/=]{100,})"');

    // Replace PDF content first (they start with JVBERi)
    jsonString = jsonString.replaceAllMapped(regex, (match) {
      return '"[FILE CONTENT]"';
    });

    // Then replace other long base64 content
    jsonString = jsonString.replaceAllMapped(base64Regex, (match) {
      return '"[FILE CONTENT]"';
    });

    return jsonString;
  }

  bool isResponse(ApiLogModel log) {
    return (log.isSuccess == true) && (log.response != null);
  }

  bool isError(ApiLogModel log) {
    return (log.isSuccess == false) && (log.error != null);
  }

  String _generateCurl({
    required String method,
    required String url,
    required Map<String, dynamic> headers,
    required Map<String, dynamic>? queryParameters,
    required String? data,
    required bool requireBase64EncodedBody,
  }) {
    final List<String> components = ['\n\ncurl -i'];

    // Add method if not GET
    if (method.toUpperCase() != 'GET') {
      components.add('-X $method');
    }

    // Add headers
    headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    // Handle data
    if (data != null) {
      if (requireBase64EncodedBody) {
        try {
          final jsonData = jsonDecode(data);
          if (jsonData['data'] != null) {
            final decodedData = utf8.decode(base64.decode(jsonData['data']));
            components.add('-d \'${jsonEncode(jsonDecode(decodedData))}\'');
          }
        } catch (e) {
          components.add('-d "$data"');
        }
      } else {
        components.add('-d \'$data\'');
      }
    }

    // Add query parameters to URL if present
    String finalUrl = url;
    if (queryParameters != null && queryParameters.isNotEmpty) {
      final Uri uri = Uri.parse(url);
      final newUri = uri.replace(queryParameters: {
        ...uri.queryParameters,
        ...queryParameters.map((key, value) => MapEntry(key, value.toString())),
      });
      finalUrl = newUri.toString();
    }

    components.add('"$finalUrl"');

    return components.join(' \\\n\t');
  }

  // ====================
  // SUGGESTED: Example of generic info log use in your app
  static void info(String message) {
    // For quick calls
    if (enableTalkerInfoLog && talker != null) {
      talker!.info(message);
    }
  }
// ====================
}

class ApiLogModel {
  int id;
  String title;
  Duration? time;
  ApiLogRequestModel request;
  bool? isSuccess;
  ApiLogResponseModel? response;
  ApiLogErrorModel? error;

  ApiLogModel({
    required this.id,
    required this.title,
    required this.request,
  });

  @override
  String toString() {
    final logService = Get.find<ApiLogService>();
    String string = '';
    string += 'Curl: ${request.method}\n\n';
    string += 'Curl Command:\n${request.curl}\n\n';
    string += 'Request Method: ${request.method}\n\n';
    string += 'Request URL: ${request.url}\n\n';
    string += 'Request Headers: ${request.headers}\n\n';
    string += 'Request Params: ${request.queryParameters}\n\n';
    string += 'Request Data: ${request.data}\n\n';
    string += 'Time: $time\n';
    if (logService.isResponse(this)) {
      string += 'Response StatusCode: ${response!.statusCode}\n\n';
      if (ApiLogService.isDisplayResponseHeaders) {
        string += 'Response Headers: ${response!.headers}\n\n';
      }
      string += 'Response Data: ${response!.data}\n\n';
    } else if (logService.isError(this)) {
      string += 'Error Type: ${error!.type}\n\n';
      string += 'Error DisplayMessage: ${error!.displayMessage}\n\n';
      string += 'Error DisplayCode: ${error!.displayCode}\n\n';
      string += 'Error StatusCode: ${error!.statusCode}\n\n';
      if (ApiLogService.isDisplayErrorHeaders) {
        string += 'Error Headers: ${error!.headers}\n\n';
      }
      string += 'Error Data: ${error!.data}\n\n';
    }
    return string;
  }
}

class ApiLogRequestModel {
  DateTime time = DateTime.now();
  String method;
  String url;
  Map<String, dynamic> headers;
  Map<String, dynamic>? queryParameters;
  String? data;
  bool requireBase64EncodedBody;
  String curl;

  ApiLogRequestModel({
    required this.method,
    required this.url,
    required this.headers,
    required this.queryParameters,
    required this.data,
    required this.requireBase64EncodedBody,
    required this.curl,
  });
}

class ApiLogResponseModel {
  DateTime time = DateTime.now();
  int statusCode;
  Map<String, dynamic> headers;
  Map<String, dynamic> data;

  ApiLogResponseModel({
    required this.statusCode,
    required this.headers,
    required this.data,
  });
}

class ApiLogErrorModel {
  DateTime time = DateTime.now();
  String type;
  String displayMessage;
  int displayCode;
  int? statusCode;
  Map<String, dynamic>? headers;
  String? data;

  ApiLogErrorModel({
    required this.type,
    required this.displayMessage,
    required this.displayCode,
    required this.statusCode,
    required this.headers,
    required this.data,
  });
}
