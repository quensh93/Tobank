class FingerPrintActionModel {
  final String? title;
  final String? description;
  final String?
  userId; // Optional context only; authenticate path does not register
  final Map<String, dynamic>? onSuccess;
  final Map<String, dynamic>? onFailure;

  FingerPrintActionModel({
    this.title,
    this.description,
    this.userId,
    this.onSuccess,
    this.onFailure,
  });

  factory FingerPrintActionModel.fromJson(Map<String, dynamic> json) {
    return FingerPrintActionModel(
      title: json['title'],
      description: json['description'],
      userId: json['userId'],
      onSuccess: json['onSuccess'],
      onFailure: json['onFailure'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionType': 'fingerPrint',
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (userId != null) 'userId': userId,
      if (onSuccess != null) 'onSuccess': onSuccess,
      if (onFailure != null) 'onFailure': onFailure,
    };
  }
}
