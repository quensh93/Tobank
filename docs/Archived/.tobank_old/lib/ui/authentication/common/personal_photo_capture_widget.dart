import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class PersonalPhotoCaptureWidget extends StatelessWidget {
  const PersonalPhotoCaptureWidget({
    required this.title,
    required this.buttonText,
    required this.cameraFunction,
    required this.deleteDocumentFunction,
    required this.documentId,
    required this.isSelected,
    super.key,
    this.selectedImageFile,
  });

  final String title;
  final String buttonText;
  final Function(int documentId) cameraFunction;
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
          color: context.theme.dividerColor,
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!kIsWeb)
                      Image.file(
                        selectedImageFile!,
                        height: 48.0,
                      )else
                        Image.network(
                          selectedImageFile!.path,
                          height: 48.0,
                        )
                      ,
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
              ],
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
                              buttonText,
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
