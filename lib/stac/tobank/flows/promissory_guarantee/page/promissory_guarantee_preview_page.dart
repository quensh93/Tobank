import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

const String _sampleGuaranteePdfBase64 =
    'JVBERi0xLjQKMSAwIG9iago8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4KZW5kb2JqCjIgMCBvYmoKPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4KZW5kb2JqCjMgMCBvYmoKPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA1OTUgODQyXSAvQ29udGVudHMgNCAwIFIgL1Jlc291cmNlcyA8PCAvRm9udCA8PCAvRjEgNSAwIFIgPj4gPj4gPj4KZW5kb2JqCjQgMCBvYmoKPDwgL0xlbmd0aCAxOTIgPj4Kc3RyZWFtCkJUCi9GMSAyOCBUZgo3MCA3NjAgVGQKKFByb21pc3NvcnkgR3VhcmFudGVlIFJlY2VpcHQpIFRqCi9GMSAxNiBUZgowIC00MCBUZAooQW1vdW50OiA2ODksMDAwLDAwMCBSaWFsKSBUagowIC0yOCBUZAooSXNzdWVyOiBaYWhyYSBIYWppIEVicmFoaW1pKSBUagowIC0yOCBUZAooU3RhdHVzOiBTaWduZWQgc3VjY2Vzc2Z1bGx5KSBUagpFVAplbmRzdHJlYW0KZW5kb2JqCjUgMCBvYmoKPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+CmVuZG9iagp4cmVmCjAgNgowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMDAwMDkgMDAwMDAgbiAKMDAwMDAwMDA1OCAwMDAwMCBuIAowMDAwMDAwMTE1IDAwMDAwIG4gCjAwMDAwMDAyNDEgMDAwMDAgbiAKMDAwMDAwMDQ4NCAwMDAwMCBuIAp0cmFpbGVyCjw8IC9TaXplIDYgL1Jvb3QgMSAwIFIgPj4Kc3RhcnR4cmVmCjU1NAolJUVPRgo=';

@StacScreen(screenName: 'promissory_guarantee_preview_page')
StacWidget promissoryGuaranteePreviewPage() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      key: 'promissoryGuaranteePdfBase64',
      value: _sampleGuaranteePdfBase64,
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title: '{{appStrings.promissory.previewScreenTitle}}',
        showBack: true,
        showSupport: true,
      ),
      body: StacPadding(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacExpanded(
              child: StacCustomWidget.fromJson({
                'type': 'receiptRepaintBoundary',
                'boundaryKey': 'promissoryGuaranteePreviewContent',
                'child': StacSingleChildScrollView(
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    textDirection: StacTextDirection.rtl,
                    children: [
                      StacSizedBox(height: 18),
                      StacContainer(
                        width: 999999,
                        padding: StacEdgeInsets.all(8),
                        decoration: StacBoxDecoration(color: '#F0EAF7'),
                        child: StacCustomPdfPreview(
                          src: '{{promissoryGuaranteePdfBase64}}',
                          registryKey: 'promissoryGuaranteePdfBase64',
                          width: 999999,
                          height: 500,
                        ),
                      ),
                    ],
                  ),
                ).toJson(),
              }),
            ),
            StacSizedBox(height: 24),
            StacOutlinedButton(
              onPressed: const StacCustomAction.fromJson({
                'actionType': 'transferReceipt',
                'mode': 'shareImage',
                'title':
                    '{{appStrings.generated.promissory_guarantee.promissory_guarantee_preview_page.promissory_guarantee}}',
                'pixelRatio': 3.0,
                'boundaryKey': 'promissoryGuaranteePreviewContent',
              }),
              style: StacButtonStyle(
                fixedSize: StacSize(999999, 56),
                side: const StacBorderSide(color: '#D91F2A', width: 1.3),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(10),
                ),
              ),
              child: StacText(
                data:
                    '{{appStrings.generated.charge.charge_payment_success.title}}',
                textDirection: StacTextDirection.rtl,
                style: StacTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '#D91F2A',
                ),
              ),
            ),
            StacSizedBox(height: 14),
            StacFilledButton(
              onPressed: const StacCustomAction.fromJson({
                'actionType': 'transferReceipt',
                'mode': 'shareImage',
                'title':
                    '{{appStrings.generated.promissory_guarantee.promissory_guarantee_preview_page.promissory_guarantee}}',
                'pixelRatio': 3.0,
                'boundaryKey': 'promissoryGuaranteePreviewContent',
              }),
              style: StacButtonStyle(
                backgroundColor: '#D91F2A',
                foregroundColor: '#FFFFFF',
                fixedSize: StacSize(999999, 56),
                elevation: 0,
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(10),
                ),
              ),
              child: StacText(
                data:
                    '{{appStrings.generated.card_management.card_management_root.share}}',
                textDirection: StacTextDirection.rtl,
                style: StacTextStyle(
                  fontSize: 18,
                  fontWeight: StacFontWeight.w700,
                  color: '#FFFFFF',
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
