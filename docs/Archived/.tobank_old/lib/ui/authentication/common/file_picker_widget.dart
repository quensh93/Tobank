import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class FilePickerWidget extends StatelessWidget {
  const FilePickerWidget({
    required this.title,
    required this.cameraFunction,
    required this.galleryFunction,
    required this.deleteDocumentFunction,
    required this.documentId,
    required this.isSelected,
    super.key,
    this.selectedImageFile,
  });

  final String title;
  final Function(int documentId) cameraFunction;
  final Function(int documentId) galleryFunction;
  final Function(int documentId) deleteDocumentFunction;
  final int documentId;
  final File? selectedImageFile;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        border: Border.all(
          color: Get.isDarkMode
              ? context.theme.colorScheme.surface
              : ThemeUtil.borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: Get.isDarkMode ? 1 : 0,
            margin: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          if (isSelected)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// todo: add later to pwa (cropper web)
                  if (kIsWeb) Image.network(
                          selectedImageFile!.path,
                          height: 48.0,
                        ) else Image.file(
                          selectedImageFile!,
                          height: 48.0,
                        ),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      deleteDocumentFunction(documentId);
                    },
                    child: Row(
                      children: [
                        SvgIcon(
                          Get.isDarkMode
                              ? SvgIcons.deleteDark
                              : SvgIcons.delete,
                          size: 24.0,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                          locale.delete,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      cameraFunction(documentId);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgIcon(
                            Get.isDarkMode
                                ? SvgIcons.cameraDark
                                : SvgIcons.camera,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Flexible(
                            child: Text(
                             locale.camera,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: context.theme.dividerColor,
                  height: 32.0,
                  width: 2.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      galleryFunction(documentId);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgIcon(
                            Get.isDarkMode
                                ? SvgIcons.galleryDark
                                : SvgIcons.gallery,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Flexible(
                            child: Text(
                             locale.gallery,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
