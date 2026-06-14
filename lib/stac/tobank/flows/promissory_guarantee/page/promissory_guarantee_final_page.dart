import 'package:stac/stac.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
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
          'value': 'زهرا حاجی ابراهیمی',
        },
        {
          'key': 'promissoryGuaranteeAmount',
          'value': '۶۸۹,۰۰۰,۰۰۰ ریال',
        },
        {
          'key': 'promissoryGuaranteeDueDate',
          'value': 'عندالمطالبه',
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
        title: 'ضمانت سفته',
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
                          data: 'عملیات موفق',
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
                          data: 'ضمانت سفته شما با موفقیت ثبت شد!',
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
                    title: 'اشتراک‌گذاری',
                      iconAsset: 'assets/icons/ic_share.svg',
                      mode: 'shareText',
                  ),
                ),
                StacSizedBox(width: 10),
                StacExpanded(
                  child: _actionButton(
                    title: 'ذخیره در گالری',
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
          'مبلغ سفته',
          '{{promissoryGuaranteeAmount}}',
        ),
        StacSizedBox(height: 12),
        buildPromissoryDivider(),
        StacSizedBox(height: 12),
        buildPromissoryDetailRow(
          'نام صادرکننده',
          '{{promissoryGuaranteeIssuerName}}',
        ),
        StacSizedBox(height: 12),
        buildPromissoryDivider(),
        StacSizedBox(height: 12),
        buildPromissoryDetailRow(
          'کد ملی صادرکننده',
          '{{promissoryGuaranteeNationalCode}}',
        ),
        StacSizedBox(height: 12),
        buildPromissoryDivider(),
        StacSizedBox(height: 12),
        buildPromissoryDetailRow(
          'تاریخ پرداخت',
          '{{promissoryGuaranteeDueDate}}',
        ),
        StacSizedBox(height: 12),
        buildPromissoryDivider(),
        StacSizedBox(height: 12),
        buildPromissoryDetailRow(
          'شناسه یکتای سفته',
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
                  data: 'سفته',
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
                onTap: const StacNavigateAction(
                  routeName: 'promissory_guarantee_preview_page',
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
                  'title': 'رسید ضمانت سفته',
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
          data: 'کاربر گرامی سفته شما در بخش سفته‌های من نیز قابل دانلود است',
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
      'title': 'رسید ضمانت سفته',
      'pixelRatio': 3.0,
      'boundaryKey': 'promissoryGuaranteeReceiptContent',
    }),
    style: StacButtonStyle(
      fixedSize: StacSize(999999, 52),
      side: StacBorderSide(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      shape: StacRoundedRectangleBorder(
        borderRadius: StacBorderRadius.all(10),
      ),
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
