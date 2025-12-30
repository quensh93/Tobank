import 'package:stac_core/stac_core.dart';
import '../../../../core/stac/builders/stac_custom_actions.dart';
import '../../../../core/stac/builders/stac_stateful_widget.dart';

/// Image Picker Test Screen
///
/// This screen tests the STAC package's ability to handle file picking and
/// image display, particularly for testing blob handling on web platforms.
///
/// Features:
/// - File picker button to select an image
/// - Container to display the selected image
/// - State management for storing selected image
@StacScreen(screenName: 'tobank_image_picker_test')
StacWidget tobankImagePickerTestDart() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(
          values: [
            {'key': 'screenId', 'value': 'image_picker_test'},
          ],
        ),
        StacLogAction(message: 'screen=image_picker_test action=onInit'),
      ],
    ),
    onDispose: StacLogAction(
      message: 'screen=image_picker_test action=onDispose',
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: 'نمایش و اپلود تصویر',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.bold,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        centerTitle: true,
      ),
      body: StacSingleChildScrollView(
        child: StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            textDirection: StacTextDirection.rtl,
            children: [
              // Title and description
              StacText(
                data: 'تست فایل پیکر و نمایش تصویر',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 20,
                  fontWeight: StacFontWeight.bold,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 8),
              StacText(
                data:
                    'این صفحه برای تست قابلیت‌های پکیج STAC در انتخاب فایل و نمایش تصویر طراحی شده است. همچنین چالش‌های مربوط به Blob در وب را بررسی می‌کند.',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacSizedBox(height: 24),

              // File Picker Button
              StacFilledButton(
                onPressed: StacFilePickerAction(
                  fileType: 'image',
                  targetKey: 'selectedImage',
                ),
                style: StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  foregroundColor: '{{appColors.current.primary.onPrimary}}',
                  minimumSize: StacSize(999999, 52),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ),
                child: StacRow(
                  mainAxisAlignment: StacMainAxisAlignment.center,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacIcon(
                      icon: 'image',
                      size: 24,
                      color: '{{appColors.current.primary.onPrimary}}',
                    ),
                    StacSizedBox(width: 8),
                    StacText(
                      data: 'انتخاب تصویر',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 16,
                        fontWeight: StacFontWeight.w600,
                        color: '{{appColors.current.primary.onPrimary}}',
                      ),
                    ),
                  ],
                ),
              ),
              StacSizedBox(height: 24),

              // Section title for image display
              StacText(
                data: 'تصویر انتخاب شده:',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              StacSizedBox(height: 12),

              // Image Display Container
              StacRegistryReactive(
                child: StacContainer(
                  width: 999999,
                  height: 300,
                  decoration: StacBoxDecoration(
                    color: '{{appColors.current.background.surface}}',
                    borderRadius: StacBorderRadius.all(16),
                    border: StacBorder.all(
                      color: '{{appColors.current.input.borderEnabled}}',
                      width: 2,
                    ),
                  ),
                  child: StacClipRRect(
                    borderRadius: StacBorderRadius.all(14),
                    child: StacCustomImage(
                      src: '{{selectedImage}}',
                      registryKey: 'selectedImage',
                      // registryKey is not a standard StacImage property in some versions,
                      // but if it was in JSON 'registryKey': 'selectedImage', it might be supported.
                      // However, StacRegistryReactive wrapper should handle the rebuild.
                      // The JSON had 'registryKey': 'selectedImage' inside the image.
                      // If StacImage class doesn't support it, we might need to pass it in extra args if possible.
                      // But effectively StacRegistryReactive makes the whole subtree rebuild on registry change.
                      // The explicit 'registryKey' in JSON might be for the parser to know what to listen to if it wasn't wrapped?
                      // Actually, StacRegistryReactive parser listens to ALL registry changes.
                      // The JSON had: 'registryKey': 'selectedImage' in the image widget.
                      // Let's assume StacImage might have it OR it's just a custom prop.
                      // Since I am wrapping it in StacRegistryReactive, the rebuild happens.
                      fit: StacBoxFit.contain,
                      width: 999999,
                      height: 296,
                      errorBuilder: StacCenter(
                        child: StacColumn(
                          mainAxisSize: StacMainAxisSize.min,
                          textDirection: StacTextDirection.rtl,
                          children: [
                            StacIcon(
                              icon: 'image_outlined',
                              size: 64,
                              color: '{{appColors.current.text.subtitle}}',
                            ),
                            StacSizedBox(height: 16),
                            StacText(
                              data: 'تصویری انتخاب نشده',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 16,
                                color: '{{appColors.current.text.subtitle}}',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              StacSizedBox(height: 24),

              // Clear button
              StacOutlinedButton(
                onPressed: StacSequenceAction(
                  actions: [
                    StacCustomSetValueAction(key: 'selectedImage', value: ''),
                    StacLogAction(
                      message: 'screen=image_picker_test action=clearImage',
                    ),
                  ],
                ),
                style: StacButtonStyle(
                  foregroundColor: '{{appColors.current.error.color}}',
                  minimumSize: StacSize(999999, 48),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.circular(12),
                  ),
                  side: StacBorderSide(
                    color: '{{appColors.current.error.color}}',
                    width: 1.5,
                  ),
                ),
                child: StacRow(
                  mainAxisAlignment: StacMainAxisAlignment.center,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacIcon(
                      icon: 'delete_outline',
                      size: 20,
                      color: '{{appColors.current.error.color}}',
                    ),
                    StacSizedBox(width: 8),
                    StacText(
                      data: 'پاک کردن تصویر',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 14,
                        fontWeight: StacFontWeight.w500,
                        color: '{{appColors.current.error.color}}',
                      ),
                    ),
                  ],
                ),
              ),
              StacSizedBox(height: 32),

              // Info section
              StacContainer(
                padding: StacEdgeInsets.all(16),
                decoration: StacBoxDecoration(
                  color: '{{appColors.current.info.background}}',
                  borderRadius: StacBorderRadius.circular(12),
                  border: StacBorder.all(
                    color: '{{appColors.current.info.color}}',
                    width: 1,
                  ),
                ),
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.start,
                  textDirection: StacTextDirection.rtl,
                  children: [
                    StacRow(
                      textDirection: StacTextDirection.rtl,
                      children: [
                        StacIcon(
                          icon: 'info_outline',
                          size: 20,
                          color: '{{appColors.current.info.color}}',
                        ),
                        StacSizedBox(width: 8),
                        StacText(
                          data: 'توضیحات تست',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 14,
                            fontWeight: StacFontWeight.bold,
                            color: '{{appColors.current.info.color}}',
                          ),
                        ),
                      ],
                    ),
                    StacSizedBox(height: 8),
                    StacText(
                      data:
                          '• در وب: تصویر به صورت Base64 Data URL ذخیره می‌شود\n• در دسکتاپ/موبایل: مسیر فایل ذخیره می‌شود\n• این تست برای بررسی چالش‌های Blob در STAC است',
                      textDirection: StacTextDirection.rtl,
                      style: StacCustomTextStyle(
                        fontSize: 12,
                        color: '{{appColors.current.text.subtitle}}',
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Action for picking files
class StacFilePickerAction extends StacAction {
  final String fileType;
  final bool allowMultiple;
  final String targetKey;

  const StacFilePickerAction({
    this.fileType = 'image',
    this.allowMultiple = false,
    required this.targetKey,
  });

  @override
  String get actionType => 'pickFile';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': 'pickFile',
    'fileType': fileType,
    'allowMultiple': allowMultiple,
    'targetKey': targetKey,
  };
}

/// Widget that rebuilds when registry changes
class StacRegistryReactive extends StacWidget {
  final StacWidget child;

  StacRegistryReactive({required this.child});

  @override
  Map<String, dynamic> get jsonData => {'child': child.toJson()};

  @override
  String get type => 'registryReactive';

  @override
  Map<String, dynamic> toJson() => {'type': type, ...jsonData};
}

/// ClipRRect widget
class StacClipRRect extends StacWidget {
  final StacBorderRadius borderRadius;
  final StacWidget child;

  StacClipRRect({required this.borderRadius, required this.child});

  @override
  String get type => 'clipRRect';

  @override
  Map<String, dynamic> get jsonData => {
    'borderRadius': borderRadius.toJson(),
    'child': child.toJson(),
  };

  @override
  Map<String, dynamic> toJson() => {'type': type, ...jsonData};
}

/// Custom Image widget to support errorBuilder and registryKey
class StacCustomImage extends StacWidget {
  final String src;
  final String? registryKey;
  final StacBoxFit? fit;
  final double? width;
  final double? height;
  final StacWidget? errorBuilder;

  StacCustomImage({
    required this.src,
    this.registryKey,
    this.fit,
    this.width,
    this.height,
    this.errorBuilder,
  });

  @override
  String get type => 'image';

  @override
  Map<String, dynamic> get jsonData => {
    'src': src,
    if (registryKey != null) 'registryKey': registryKey,
    if (fit != null) 'fit': fit!.name,
    if (width != null) 'width': width,
    if (height != null) 'height': height,
    if (errorBuilder != null) 'errorBuilder': errorBuilder!.toJson(),
  };

  @override
  Map<String, dynamic> toJson() => {'type': type, ...jsonData};
}
