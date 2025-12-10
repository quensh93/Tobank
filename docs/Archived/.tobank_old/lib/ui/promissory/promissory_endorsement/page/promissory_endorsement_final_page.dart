import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_endorsement_controller.dart';
import '../../../../../util/app_theme.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';

class PromissoryEndorsementFinalPage extends StatelessWidget {
  const PromissoryEndorsementFinalPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryEndorsementController>(builder: (controller) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const SvgIcon(
                  SvgIcons.transactionSuccess,
                  size: 56,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                 Text(
                  locale.operation_successful_,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: AppTheme.successColor,
                  ),
                ),
                const SizedBox(height: 8.0),
                 Text(
                  locale.promissory_success_message,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16.0),

                const SizedBox(
                  height: 16.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: context.theme.dividerColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SvgIcon(
                              SvgIcons.pdfFile,
                              size: 32,
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                locale.promissory_title,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(8.0),
                              onTap: () {
                                controller.showPreviewScreen();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgIcon(
                                  SvgIcons.showPassword,
                                  size: 24,
                                  colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            InkWell(
                              borderRadius: BorderRadius.circular(8.0),
                              onTap: () {
                                controller.sharePromissoryPdf();
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
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(
                          thickness: 1,
                        ),
                        const SizedBox(height: 8.0),
                         Text(
                          locale.promissory_download_message,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
