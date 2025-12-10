import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class SignedContractWidget extends StatelessWidget {
  const SignedContractWidget({
    required this.pdfTitle,
    required this.previewFunction,
    required this.shareFunction,
    super.key,
    this.showShare = true,
  });

  final String pdfTitle;
  final Function() previewFunction;
  final bool showShare;
  final Function() shareFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color: context.theme.dividerColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Column(children: [
              Row(
                children: [
                  const SvgIcon(
                    SvgIcons.pdfFile,
                    size: 40,
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Text(
                      pdfTitle,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24.0),
                      onTap: () {
                        previewFunction();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgIcon(
                          SvgIcons.showPassword,
                          colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24.0),
                      onTap: () {
                        shareFunction();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgIcon(
                          SvgIcons.share,
                          colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
