/// Models for Configuration API (Server-Driven UI)
///
/// These models are used to parse the response from the configuration API
/// which returns SDUI (Server-Driven UI) content.
library;

/// Root response from the configuration API
class ConfigApiResponse {
  final ConfigApiStatus status;
  final ConfigApiData? data;
  final ConfigApiMeta? meta;

  ConfigApiResponse({required this.status, this.data, this.meta});

  factory ConfigApiResponse.fromJson(Map<String, dynamic> json) {
    return ConfigApiResponse(
      status: ConfigApiStatus.fromJson(json['status'] ?? {}),
      data: json['data'] != null ? ConfigApiData.fromJson(json['data']) : null,
      meta: json['meta'] != null ? ConfigApiMeta.fromJson(json['meta']) : null,
    );
  }

  bool get isSuccess => status.code == 'CONFIG-200';

  /// Get the first content item's value (the SDUI JSON)
  Map<String, dynamic>? get sduiContent {
    if (data?.content != null && data!.content!.isNotEmpty) {
      return data!.content![0].value;
    }
    return null;
  }
}

/// Status object from API response
class ConfigApiStatus {
  final String code;
  final List<String> message;
  final String description;

  ConfigApiStatus({
    required this.code,
    required this.message,
    required this.description,
  });

  factory ConfigApiStatus.fromJson(Map<String, dynamic> json) {
    return ConfigApiStatus(
      code: json['code'] ?? '',
      message: (json['message'] as List?)?.cast<String>() ?? [],
      description: json['description'] ?? '',
    );
  }
}

/// Data wrapper containing pagination and content
class ConfigApiData {
  final int pages;
  final int total;
  final List<ConfigApiContent>? content;

  ConfigApiData({required this.pages, required this.total, this.content});

  factory ConfigApiData.fromJson(Map<String, dynamic> json) {
    return ConfigApiData(
      pages: json['pages'] ?? 0,
      total: json['total'] ?? 0,
      content: (json['content'] as List?)
          ?.map((e) => ConfigApiContent.fromJson(e))
          .toList(),
    );
  }
}

/// Individual configuration content item
class ConfigApiContent {
  final String id;
  final String? parentId;
  final String? rootId;
  final int depth;
  final String pathKey;
  final int childrenCount;
  final String key;
  final int build;
  final int reversion;
  final String title;
  final Map<String, dynamic>? dimension;
  final Map<String, dynamic>? value; // This is the SDUI JSON
  final Map<String, dynamic>? schema;
  final String? createdBy;
  final String? createdOn;
  final String? updatedBy;
  final String? updatedOn;
  final String? endTime;
  final String activity;

  ConfigApiContent({
    required this.id,
    this.parentId,
    this.rootId,
    required this.depth,
    required this.pathKey,
    required this.childrenCount,
    required this.key,
    required this.build,
    required this.reversion,
    required this.title,
    this.dimension,
    this.value,
    this.schema,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
    this.endTime,
    required this.activity,
  });

  factory ConfigApiContent.fromJson(Map<String, dynamic> json) {
    return ConfigApiContent(
      id: json['id'] ?? '',
      parentId: json['parentId'],
      rootId: json['rootId'],
      depth: json['depth'] ?? 0,
      pathKey: json['pathKey'] ?? '',
      childrenCount: json['childrenCount'] ?? 0,
      key: json['key'] ?? '',
      build: json['build'] ?? 0,
      reversion: json['reversion'] ?? 0,
      title: json['title'] ?? '',
      dimension: json['dimension'],
      value: json['value'],
      schema: json['schema'],
      createdBy: json['createdBy'],
      createdOn: json['createdOn'],
      updatedBy: json['updatedBy'],
      updatedOn: json['updatedOn'],
      endTime: json['endTime'],
      activity: json['activity'] ?? '',
    );
  }
}

/// Meta information about the API request
class ConfigApiMeta {
  final String time;
  final String traceId;

  ConfigApiMeta({required this.time, required this.traceId});

  factory ConfigApiMeta.fromJson(Map<String, dynamic> json) {
    return ConfigApiMeta(
      time: json['time'] ?? '',
      traceId: json['traceId'] ?? '',
    );
  }
}

/// Request model for configuration API
class ConfigApiRequest {
  final String pathKey;
  final int build;
  final String operator;
  final Map<String, String> dimension;
  final int page;
  final int size;

  ConfigApiRequest({
    required this.pathKey,
    required this.build,
    this.operator = 'contains',
    this.dimension = const {'app': 'mobile'},
    this.page = 0,
    this.size = 10,
  });

  Map<String, dynamic> toRequestBody() {
    return {'operator': operator, 'dimension': dimension};
  }

  Map<String, dynamic> toQueryParams() {
    return {'page': page, 'size': size};
  }

  String get endpoint =>
      '/api/configurations/v1.0/configs/resolve/$pathKey/$build';
}
