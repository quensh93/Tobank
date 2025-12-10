import 'package:universal_io/io.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/bpms/contract_preview_controller.dart';
import '../../../../widget/button/button_with_icon.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../custom_app_bar.dart';

class ContractPreviewScreen extends StatelessWidget {
  const ContractPreviewScreen({
    required this.pdfData,
    required this.templateName,
    super.key,
    this.showStore = true,
    this.showShare = true,
  });

  final bool showStore;
  final bool showShare;
  final Uint8List pdfData;
  final String templateName;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<ContractPreviewController>(
        init: ContractPreviewController(pdfData: pdfData, templateName: templateName),
        builder: (controller) {
          return Scaffold(
            appBar: CustomAppBar(
              titleString: locale.show_contract,
              context: context,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: PDFView(
                        pdfData: pdfData,
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    if (showShare)
                      Row(
                        children: [
                          Expanded(
                            child: ButtonWithIcon(
                              buttonTitle:locale.sharing,
                              buttonIcon: SvgIcons.share,
                              onPressed: controller.sharePdf,
                            ),
                          ),
                          if (Platform.isAndroid && showStore)
                            const SizedBox(
                              width: 8.0,
                            )
                          else
                            Container(),
                          if (Platform.isAndroid && showStore)
                            Expanded(
                              child: ButtonWithIcon(
                                buttonTitle: locale.save_contract,
                                buttonIcon: SvgIcons.download,
                                onPressed: controller.storePdf,
                              ),
                            )
                          else
                            Container(),
                        ],
                      )
                    else
                      Container(),
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
