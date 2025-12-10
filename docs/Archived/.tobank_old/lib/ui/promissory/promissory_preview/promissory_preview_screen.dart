import 'package:universal_io/io.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../../../../controller/promissory/promissory_preview_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../common/custom_app_bar.dart';

class PromissoryPreviewScreen extends StatelessWidget {
  const PromissoryPreviewScreen({
    required this.pdfData,
    super.key,
    this.promissoryId,
  });

  final Uint8List pdfData;
  final String? promissoryId;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<PromissoryPreviewController>(
        init: PromissoryPreviewController(pdfData: pdfData, promissoryId: promissoryId),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              titleString: locale.show_promissory_note,
              context: context,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: Get.height / 2,
                            child: PDFView(
                              pdfData: pdfData,
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          if (Platform.isAndroid)
                            SizedBox(
                              height: 56,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.storePdf();
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: context.theme.colorScheme.surface,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: ThemeUtil.primaryColor,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                    8.0,
                                  ),
                                  child: Text(
                                    locale.save_promissory_note,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0,
                                      color: ThemeUtil.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            Container(),
                          if (Platform.isAndroid)
                            const SizedBox(
                              height: 16.0,
                            )
                          else
                            Container(),
                          ContinueButtonWidget(
                            callback: () {
                              controller.sharePromissoryPdf();
                            },
                            isLoading: false,
                            buttonTitle: locale.share_promissory_note,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
