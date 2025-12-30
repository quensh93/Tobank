/// File Picker Action Model
///
/// A custom STAC action model for picking files using file_picker package.
class FilePickerActionModel {
  /// Type of file to pick: 'image', 'video', 'audio', 'media', 'any'
  final String fileType;

  /// Optional list of allowed file extensions (e.g., ['jpg', 'png'])
  final List<String>? allowedExtensions;

  /// Whether to allow multiple file selection
  final bool allowMultiple;

  /// State key to store the result (e.g., 'selectedImage')
  final String targetKey;

  const FilePickerActionModel({
    required this.fileType,
    this.allowedExtensions,
    this.allowMultiple = false,
    required this.targetKey,
  });

  factory FilePickerActionModel.fromJson(Map<String, dynamic> json) {
    return FilePickerActionModel(
      fileType: json['fileType'] as String? ?? 'image',
      allowedExtensions: (json['allowedExtensions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      allowMultiple: json['allowMultiple'] as bool? ?? false,
      targetKey: json['targetKey'] as String? ?? 'selectedFile',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionType': 'pickFile',
      'fileType': fileType,
      if (allowedExtensions != null) 'allowedExtensions': allowedExtensions,
      'allowMultiple': allowMultiple,
      'targetKey': targetKey,
    };
  }

  List<Object?> get props => [
    fileType,
    allowedExtensions,
    allowMultiple,
    targetKey,
  ];
}
