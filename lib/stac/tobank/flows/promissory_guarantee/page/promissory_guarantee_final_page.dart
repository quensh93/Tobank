import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/navigation/nav_modes.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory/dart/widgets/promissory_detail_row.dart';
import 'package:tobank_sdui/stac/tobank/flows/promissory/dart/widgets/promissory_divider.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

const String _sampleGuaranteePdfBase64 =
    'JVBERi0xLjQKMSAwIG9iago8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMiAwIFIgPj4KZW5kb2JqCjIgMCBvYmoKPDwgL1R5cGUgL1BhZ2VzIC9LaWRzIFszIDAgUl0gL0NvdW50IDEgPj4KZW5kb2JqCjMgMCBvYmoKPDwgL1R5cGUgL1BhZ2UgL1BhcmVudCAyIDAgUiAvTWVkaWFCb3ggWzAgMCA1OTUgODQyXSAvQ29udGVudHMgNCAwIFIgL1Jlc291cmNlcyA8PCAvRm9udCA8PCAvRjEgNSAwIFIgPj4gPj4gPj4KZW5kb2JqCjQgMCBvYmoKPDwgL0xlbmd0aCAxOTIgPj4Kc3RyZWFtCkJUCi9GMSAyOCBUZgo3MCA3NjAgVGQKKFByb21pc3NvcnkgR3VhcmFudGVlIFJlY2VpcHQpIFRqCi9GMSAxNiBUZgowIC00MCBUZAooQW1vdW50OiA2ODksMDAwLDAwMCBSaWFsKSBUagowIC0yOCBUZAooSXNzdWVyOiBaYWhyYSBIYWppIEVicmFoaW1pKSBUagowIC0yOCBUZAooU3RhdHVzOiBTaWduZWQgc3VjY2Vzc2Z1bGx5KSBUagpFVAplbmRzdHJlYW0KZW5kb2JqCjUgMCBvYmoKPDwgL1R5cGUgL0ZvbnQgL1N1YnR5cGUgL1R5cGUxIC9CYXNlRm9udCAvSGVsdmV0aWNhID4+CmVuZG9iagp4cmVmCjAgNgowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMDAwMDkgMDAwMDAgbiAKMDAwMDAwMDA1OCAwMDAwMCBuIAowMDAwMDAwMTE1IDAwMDAwIG4gCjAwMDAwMDAyNDEgMDAwMDAgbiAKMDAwMDAwMDQ4NCAwMDAwMCBuIAp0cmFpbGVyCjw8IC9TaXplIDYgL1Jvb3QgMSAwIFIgPj4Kc3RhcnR4cmVmCjU1NAolJUVPRgo=';

@StacScreen(screenName: 'promissory_guarantee_final_page')
StacWidget promissoryGuaranteeFinalPage() {
  return StacStatefulWidget(
    onInit: const StacCustomSetValueAction(
      values: [
        {
          'key': 'promissoryGuaranteePdfBase64',
          'value': _sampleGuaranteePdfBase64,
        },
        {
          'key': 'promissoryGuaranteeIssuerName',
          'value':
              '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.sample_person_name}}',
        },
        {
          'key': 'promissoryGuaranteeAmount',
          'value':
              '{{appStrings.generated.promissory_guarantee.promissory_guarantee_confirm_page.rial}}',
        },
        {
          'key': 'promissoryGuaranteeDueDate',
          'value': '{{appStrings.promissory.onDemand}}',
        },
        {
          'key': 'promissoryGuaranteeNationalCode',
          'value': '{{guarantee_promissory_national_code}}',
        },
        {
          'key': 'promissoryGuaranteePromissoryId',
          'value': '{{guarantee_promissory_id}}',
        },
      ],
    ),
    child: StacScaffold(
      appBar: buildTobankFlowAppBar(
        title: '{{appStrings.promissory.guaranteePromissory}}',
        showBack: true,
        showSupport: true,
      ),
      body: StacSafeArea(
        top: false,
        child: StacPadding(
          padding: StacEdgeInsets.all(16),
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacExpanded(
                child: StacCustomWidget.fromJson({
                  'type': 'receiptRepaintBoundary',
                  'boundaryKey': 'promissoryGuaranteeReceiptContent',
                  'child': StacSingleChildScrollView(
                    child: StacColumn(
                      crossAxisAlignment: StacCrossAxisAlignment.stretch,
                      textDirection: StacTextDirection.rtl,
                      children: [
                        StacSizedBox(height: 24),
                        _successMark(),
                        StacSizedBox(height: 16),
                        StacText(
                          data:
                              '{{appStrings.generated.promissory.rules.success_operation}}',
                          textDirection: StacTextDirection.rtl,
                          textAlign: StacTextAlign.center,
                          style: StacTextStyle(
                            fontSize: 18,
                            fontWeight: StacFontWeight.w700,
                            color: '#24B76A',
                          ),
                        ),
                        StacSizedBox(height: 8),
                        StacText(
                          data:
                              '{{appStrings.generated.promissory_guarantee.promissory_guarantee_final_page.guarantee_promissory_successfully_submit}}',
                          textDirection: StacTextDirection.rtl,
                          textAlign: StacTextAlign.center,
                          style: StacTextStyle(
                            fontSize: 14,
                            fontWeight: StacFontWeight.w600,
                            color: '{{appColors.current.text.title}}',
                          ),
                        ),
                        StacSizedBox(height: 24),
                        _buildReceiptCard(),
                        StacSizedBox(height: 16),
                        _buildPdfCard(),
                        StacSizedBox(height: 20),
                      ],
                    ),
                  ).toJson(),
                }),
              ),
              StacRow(
                children: [
                  StacExpanded(
                    child: _actionButton(
                      title:
                          '{{appStrings.generated.card_management.card_management_root.share}}',
                      iconAsset: 'assets/icons/ic_share.svg',
                      mode: 'shareText',
                    ),
                  ),
                  StacSizedBox(width: 10),
                  StacExpanded(
                    child: _actionButton(
                      title:
                          '{{appStrings.generated.charge.charge_payment_success.title}}',
                      iconAsset: 'assets/icons/ic_download.svg',
                      mode: 'shareImage',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

StacWidget _successMark() {
  return StacCenter(
    child: StacContainer(
      width: 80,
      height: 80,
      decoration: StacBoxDecoration(
        color: '#DDF4E8',
        shape: StacBoxShape.circle,
      ),
      child: StacCenter(
        child: StacContainer(
          width: 56,
          height: 56,
          decoration: StacBoxDecoration(
            color: '#24B76A',
            shape: StacBoxShape.circle,
          ),
          child: StacCenter(
            child: StacIcon(icon: 'check', size: 26, color: '#FFFFFF'),
          ),
        ),
      ),
    ),
  );
}

StacWidget _buildReceiptCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      textDirection: StacTextDirection.rtl,
      children: [
        buildPromissoryDetailRow(
          '{{appStrings.promissory.amountLabel}}',
          '{{promissoryGuaranteeAmount}}',
        ),
        StacSizedBox(height: 12),
        buildPromissoryDivider(),
        StacSizedBox(height: 12),
        buildPromissoryDetailRow(
          '{{appStrings.generated.promissory_guarantee.promissory_guarantee_final_page.issuer_name}}',
          '{{promissoryGuaranteeIssuerName}}',
        ),
        StacSizedBox(height: 12),
        buildPromissoryDivider(),
        StacSizedBox(height: 12),
        buildPromissoryDetailRow(
          '{{appStrings.generated.promissory_guarantee.promissory_guarantee_final_page.issuer_national_code}}',
          '{{promissoryGuaranteeNationalCode}}',
        ),
        StacSizedBox(height: 12),
        buildPromissoryDivider(),
        StacSizedBox(height: 12),
        buildPromissoryDetailRow(
          '{{appStrings.promissory.payDate}}',
          '{{promissoryGuaranteeDueDate}}',
        ),
        StacSizedBox(height: 12),
        buildPromissoryDivider(),
        StacSizedBox(height: 12),
        buildPromissoryDetailRow(
          '{{appStrings.generated.promissory_guarantee.promissory_guarantee_final_page.identifier_promissory}}',
          '{{promissoryGuaranteePromissoryId}}',
        ),
      ],
    ),
  );
}

StacWidget _buildPdfCard() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacImage(
                  src: 'assets/icons/ic_pdf_file.svg',
                  imageType: StacImageType.asset,
                  width: 32,
                  height: 32,
                ),
                StacSizedBox(width: 8),
                StacText(
                  data: '{{appStrings.promissory.promissory}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacGestureDetector(
                  onTap: const NavigationAction(
                    fileName: 'promissory_guarantee_preview_page',
                    navMode: NavModes.dart,
                    navigationStyle: NavigationStyle.push,
                  ),
                  child: StacPadding(
                    padding: StacEdgeInsets.all(8),
                    child: StacImage(
                      src: 'assets/icons/ic_show.svg',
                      imageType: StacImageType.asset,
                      width: 24,
                      height: 24,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ),
                StacSizedBox(width: 8),
                StacGestureDetector(
                  onTap: const StacCustomAction.fromJson({
                    'actionType': 'transferReceipt',
                    'mode': 'shareImage',
                    'title':
                        '{{appStrings.generated.promissory_guarantee.promissory_guarantee_final_page.guarantee_promissory_receipt}}',
                    'pixelRatio': 3.0,
                    'boundaryKey': 'promissoryGuaranteeReceiptContent',
                  }),
                  child: StacPadding(
                    padding: StacEdgeInsets.all(8),
                    child: StacImage(
                      src: 'assets/icons/ic_share.svg',
                      imageType: StacImageType.asset,
                      width: 24,
                      height: 24,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        StacSizedBox(height: 8),
        buildPromissoryDivider(),
        StacSizedBox(height: 8),
        StacText(
          data: '{{appStrings.promissory.downloadMessage}}',
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w500,
            height: 1.6,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}

StacWidget _actionButton({
  required String title,
  required String iconAsset,
  required String mode,
}) {
  return StacOutlinedButton(
    onPressed: StacCustomAction.fromJson({
      'actionType': 'transferReceipt',
      'mode': mode,
      'title':
          '{{appStrings.generated.promissory_guarantee.promissory_guarantee_final_page.guarantee_promissory_receipt}}',
      'pixelRatio': 3.0,
      'boundaryKey': 'promissoryGuaranteeReceiptContent',
    }),
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 52),
      side: StacBorderSide(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(10)),
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      textDirection: StacTextDirection.rtl,
      children: [
        StacImage(
          src: iconAsset,
          imageType: StacImageType.asset,
          width: 20,
          height: 20,
          color: '{{appColors.current.text.title}}',
        ),
        StacSizedBox(width: 6),
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ],
    ),
  );
}
