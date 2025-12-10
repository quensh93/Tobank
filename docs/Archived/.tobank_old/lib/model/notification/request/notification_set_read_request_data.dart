import '../../../service/core/api_request_model.dart';

class NotificationSetReadRequest extends ApiRequestModel {
  NotificationSetReadRequest({required this.isRead});

  bool isRead;

  @override
  Map<String, dynamic> toJson() => {
        'is_read': isRead,
      };
}
