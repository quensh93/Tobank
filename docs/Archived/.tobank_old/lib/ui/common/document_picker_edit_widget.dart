import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/bpms/document_state_data.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';

class DocumentPickerEditWidget extends StatelessWidget {
  const DocumentPickerEditWidget({
    required this.documentStateData,
    required this.cameraFunction,
    required this.galleryFunction,
    required this.deleteDocumentFunction,
    super.key,
  });

  final DocumentStateData documentStateData;
  final Function(DocumentStateData documentStateData) cameraFunction;
  final Function(DocumentStateData documentStateData) galleryFunction;
  final Function(DocumentStateData documentStateData) deleteDocumentFunction;

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
          color: context.theme.dividerColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 1,
            margin: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                documentStateData.id.label ?? '',
                style: TextStyle(
                  color: ThemeUtil.textTitleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (documentStateData.isRejected())
                  documentStateData.documentId != null
                      ? Row(
                          children: [
                            Image.file(
                              documentStateData.documentFile!,
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
                                deleteDocumentFunction(documentStateData);
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
                        )
                      : Column(
                          children: [
                            if (documentStateData.isUploading)
                              Column(
                                children: [
                                  SpinKitFadingCircle(
                                    itemBuilder: (_, int index) {
                                      return DecoratedBox(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: context.theme.colorScheme.primary,
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 1.6,
                                      color: ThemeUtil.primaryColor,
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
                                        if (!documentStateData.isUploading) {
                                          cameraFunction(documentStateData);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgIcon(
                                              Get.isDarkMode ? SvgIcons.cameraDark : SvgIcons.camera,
                                            ),
                                            const SizedBox(
                                              width: 4.0,
                                            ),
                                            Flexible(
                                              child: Text(
                                                locale.camera,
                                                style: TextStyle(
                                                  color: ThemeUtil.textSubtitleColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
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
                                        if (!documentStateData.isUploading) {
                                          galleryFunction(documentStateData);
                                        }
                                      },
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
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ],
                        )
                else
                  Container(),
                const SizedBox(height: 16.0),
                const Divider(thickness: 1),
                const SizedBox(height: 16.0),
                if (documentStateData.isRejected())
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        locale.expert_opinion,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        documentStateData.description.value!.subValue ?? '',
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.6,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Text(
                        locale.document_verified,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
