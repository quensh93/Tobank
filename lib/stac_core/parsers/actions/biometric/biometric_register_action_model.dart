class BiometricRegisterActionModel {
  final String? title;
  final String? description;
  final String? userId;
  final bool passkeyOnly;
  final Map<String, dynamic>? onSuccess;
  final Map<String, dynamic>? onFailure;

  const BiometricRegisterActionModel({
    this.title,
    this.description,
    this.userId,
    this.passkeyOnly = true,
    this.onSuccess,
    this.onFailure,
  });

  factory BiometricRegisterActionModel.fromJson(Map<String, dynamic> json) {
    return BiometricRegisterActionModel(
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      userId: json['userId']?.toString(),
      passkeyOnly: json['passkeyOnly'] != false,
      onSuccess: json['onSuccess'] is Map<String, dynamic>
          ? json['onSuccess'] as Map<String, dynamic>
          : null,
      onFailure: json['onFailure'] is Map<String, dynamic>
          ? json['onFailure'] as Map<String, dynamic>
          : null,
    );
  }
}
