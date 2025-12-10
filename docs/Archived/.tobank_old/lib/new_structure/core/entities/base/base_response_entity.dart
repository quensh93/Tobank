// base_response_entity.dart
class BaseResponseEntity<T> {
  final String message;
  final bool success;
  final T data;

  BaseResponseEntity({
    required this.message,
    required this.success,
    required this.data,
  });

  factory BaseResponseEntity.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return BaseResponseEntity(
      message: json['message'] as String,
      success: json['success'] as bool,
      data: fromJsonT(json['data']),
    );
  }

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) {
    return {
      'message': message,
      'success': success,
      'data': toJsonT(data),
    };
  }

  @override
  String toString() {
    return '🔵 BaseResponseEntity<$T>(\n'
        'message: $message\n'
        'success: $success\n'
        'data: $data\n'
        ')';
  }
}