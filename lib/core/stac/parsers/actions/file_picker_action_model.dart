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

  /// Optional state key used to store whether a file is currently selected.
  final String? hasValueKey;

  /// Optional state key used to store the selected file name.
  final String? fileNameKey;

  /// Whether to show a preview bottom sheet before committing the file.
  final bool previewBeforeConfirm;

  /// Optional title shown on the preview bottom sheet.
  final String? previewSheetTitle;

  /// Optional primary button text for the preview bottom sheet.
  final String? confirmButtonText;

  /// Optional secondary button text for the preview bottom sheet.
  final String? retryButtonText;

  const FilePickerActionModel({
    required this.fileType,
    this.allowedExtensions,
    this.allowMultiple = false,
    required this.targetKey,
    this.hasValueKey,
    this.fileNameKey,
    this.previewBeforeConfirm = false,
    this.previewSheetTitle,
    this.confirmButtonText,
    this.retryButtonText,
  });

  factory FilePickerActionModel.fromJson(Map<String, dynamic> json) {
    return FilePickerActionModel(
      fileType: json['fileType'] as String? ?? 'image',
      allowedExtensions: (json['allowedExtensions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      allowMultiple: json['allowMultiple'] as bool? ?? false,
      targetKey: json['targetKey'] as String? ?? 'selectedFile',
      hasValueKey: json['hasValueKey'] as String?,
      fileNameKey: json['fileNameKey'] as String?,
      previewBeforeConfirm: json['previewBeforeConfirm'] as bool? ?? false,
      previewSheetTitle: json['previewSheetTitle'] as String?,
      confirmButtonText: json['confirmButtonText'] as String?,
      retryButtonText: json['retryButtonText'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionType': 'pickFile',
      'fileType': fileType,
      if (allowedExtensions != null) 'allowedExtensions': allowedExtensions,
      'allowMultiple': allowMultiple,
      'targetKey': targetKey,
      if (hasValueKey != null) 'hasValueKey': hasValueKey,
      if (fileNameKey != null) 'fileNameKey': fileNameKey,
      'previewBeforeConfirm': previewBeforeConfirm,
      if (previewSheetTitle != null) 'previewSheetTitle': previewSheetTitle,
      if (confirmButtonText != null) 'confirmButtonText': confirmButtonText,
      if (retryButtonText != null) 'retryButtonText': retryButtonText,
    };
  }

  List<Object?> get props => [
    fileType,
    allowedExtensions,
    allowMultiple,
    targetKey,
    hasValueKey,
    fileNameKey,
    previewBeforeConfirm,
    previewSheetTitle,
    confirmButtonText,
    retryButtonText,
  ];
}
