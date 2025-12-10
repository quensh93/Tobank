import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class DocumentPickerWidget extends StatelessWidget {
  const DocumentPickerWidget({
    required this.title,
    required this.subTitle,
    required this.cameraFunction,
    required this.galleryFunction,
    required this.isUploading,
    required this.isUploaded,
    required this.deleteDocumentFunction,
    required this.documentId,
    required this.selectedDocumentId,
    super.key,
    this.description,
    this.selectedImageFile,
  });

  final String title;
  final String subTitle;
  final String? description;
  final Function(int documentId) cameraFunction;
  final Function(int documentId) galleryFunction;
  final bool isUploading;
  final bool isUploaded;
  final Function(int documentId) deleteDocumentFunction;
  final int documentId;
  final int selectedDocumentId;
  final File? selectedImageFile;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: context.theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: Get.isDarkMode ? 1 : 0,
            margin: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.6,
                    ),
                  ),
                  if (subTitle.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          subTitle,
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.6,
                          ),
                        )
                      ],
                    )
                  else
                    Container(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          if (description != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locale.expert_opinion,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    description!,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Divider(thickness: 1),
                ],
              ),
            )
          else
            Container(),
          if (isUploaded)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.file(
                    selectedImageFile!,
                    height: 48.0,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: context.theme.colorScheme.secondary.withOpacity(0.10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              locale.upload_successful,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: context.theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      deleteDocumentFunction(documentId);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SvgIcon(
                            Get.isDarkMode ? SvgIcons.deleteDark : SvgIcons.delete,
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
                  ),
                ],
              ),
            )
          else
            Column(
              children: [
                if (isUploading && documentId == selectedDocumentId)
                  Column(
                    children: [
                      SpinKitFadingCircle(
                        itemBuilder: (_, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ThemeUtil.primaryColor,
                            ),
                          );
                        },
                        size: 32.0,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        locale.uploading_image,
                        style: TextStyle(
                          color: ThemeUtil.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (!isUploading) {
                              cameraFunction(documentId);
                            }
                          },
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgIcon(
                                  Get.isDarkMode ? SvgIcons.cameraDark : SvgIcons.camera,
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
                            if (!isUploading) {
                              galleryFunction(documentId);
                            }
                          },
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgIcon(
                                  Get.isDarkMode ? SvgIcons.galleryDark : SvgIcons.gallery,
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
                const SizedBox(height: 8.0),
              ],
            ),
        ],
      ),
    );
  }
}
