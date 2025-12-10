import 'package:universal_html/html.dart' as html;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Mobile PDF viewer import
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/cbs/cbs_preview/cbs_preview_controller.dart';
import '../../../../widget/button/button_with_icon.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../common/custom_app_bar.dart';

class CBSPreviewScreen extends StatelessWidget {
  const CBSPreviewScreen({
    required this.pdfData,
    super.key,
    this.nationalCode,
  });

  final Uint8List pdfData;
  final String? nationalCode;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<CBSPreviewController>(
        init: CBSPreviewController(pdfData: pdfData, nationalCode: nationalCode),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              titleString: locale.show_credit_evaluation,
              context: context,
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: kIsWeb
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.picture_as_pdf,
                            size: 80,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            icon: const Icon(Icons.open_in_new),
                            label:  Text(locale.view_pdf_in_new_tab),
                            onPressed: () => _openPdfInNewTab(pdfData),
                          ),
                        ],
                      ),
                    )
                        : PDFView(
                      filePath: null,
                      pdfData: pdfData,
                      // Other parameters as needed
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ButtonWithIcon(
                            buttonTitle: locale.sharing,
                            buttonIcon: SvgIcons.share,
                            onPressed: controller.shareCBSPdf,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: ButtonWithIcon(
                            buttonTitle:locale.save,
                            buttonIcon: SvgIcons.download,
                            onPressed: controller.storePdf,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _openPdfInNewTab(Uint8List pdfData) {
    if (kIsWeb) {
      // Create a Blob with the correct MIME type
      final blob = html.Blob([pdfData], 'application/pdf');

      // Create a URL for the Blob
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Open a new tab with the PDF
      html.window.open(url, '_blank');

      // Optional: You can set up a timer to revoke the URL later to free memory
      // html.Timer(const Duration(seconds: 5), () {
      //   html.Url.revokeObjectUrl(url);
      // });
    }
  }
}