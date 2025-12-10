import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class ContractWidget extends StatelessWidget {
  const ContractWidget({
    required this.rejectReason,
    required this.pdfData,
    required this.previewFunction,
    required this.shareFunction,
    super.key,
    this.showShare = true,
  });

  final String? rejectReason;
  final Uint8List pdfData;
  final Function() previewFunction;
  final bool showShare;
  final Function() shareFunction;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
            border: Border.all(
              color: context.theme.dividerColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              if (rejectReason != null)
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          locale.expert_opinion,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            rejectReason!,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                  ],
                )
              else
                Container(),
              SizedBox(
                height: Get.height / 3,
                child: PDFView(
                  pdfData: pdfData,
                  pageFling: false,
                  enableSwipe: false,
                  pageSnap: false,
                ),
              ),
            ]),
          ),
        ),
        Container(
          height: 48.0,
          decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? context.theme.colorScheme.surfaceContainerHighest
                  : context.theme.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8))),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                    onTap: () {
                      previewFunction();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgIcon(
                            SvgIcons.showPassword,
                            colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                            size: 24.0,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            locale.view,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (showShare)
                Container(
                  color: context.theme.dividerColor,
                  width: 1,
                  height: 32.0,
                )
              else
                Container(),
              if (showShare)
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8.0)),
                      onTap: () {
                        shareFunction();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgIcon(
                              Get.isDarkMode ? SvgIcons.shareDark : SvgIcons.share,
                              size: 24.0,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              locale.sharing,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              else
                Container(),
            ],
          ),
        ),
      ],
    );
  }
}
