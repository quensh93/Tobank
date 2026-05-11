import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';

/// Promissory Real Flow - Confirmation Page
///
/// This screen displays a summary of all entered data for review:
/// 1. Issuer Information
/// 2. Receiver Information
/// 3. Promissory Details (amount, date)
@StacScreen(screenName: 'promissory_real_confirm')
StacWidget promissoryRealConfirm() {
  return StacScaffold(
    appBar: buildTobankFlowAppBar(
      showSupport: false,
      // صدور سفته
      title: '{{appStrings.promissory.issuanceTitle}}',
    ),
    body: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacExpanded(
          child: StacSingleChildScrollView(
            padding: StacEdgeInsets.all(16),
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                // Promissory Details Section
                _buildPromissoryDetails(),

                StacSizedBox(height: 16),

                // Issuer Section
                _buildIssuerSection(),
                StacSizedBox(height: 16),

                // Receiver Section
                _buildReceiverSection(),
              ],
            ),
          ),
        ),
        // Submit Button
        _buildSubmitButton(),
      ],
    ),
  );
}

StacWidget _buildPromissoryDetails() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 0.5,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          // اطلاعات سفته
          data: '{{appStrings.promissory.detailsTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 8),
        StacContainer(
          height: 1,
          decoration: StacBoxDecoration(
            color: '{{appColors.current.input.borderEnabled}}',
          ),
        ),
        StacSizedBox(height: 8),
        StacPadding(
          padding: StacEdgeInsets.only(bottom: 8),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacText(
                // مبلغ سفته
                data: '{{appStrings.promissory.amountLabel}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacText(
                data:
                    // ریال
                    '{{form.promissory_amount_formatted}} {{appStrings.common.rial}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
        ),
        StacSizedBox(height: 4),
        StacPadding(
          padding: StacEdgeInsets.only(bottom: 8),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacText(
                // تاریخ پرداخت
                data: '{{appStrings.promissory.payDate}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacText(
                data: '{{form.promissory_due_date_display}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
        ),
        StacSizedBox(height: 4),
        StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.end,
          children: [
            StacText(
              // توضیحات
              data: '{{appStrings.promissory.descriptionLabel}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
            StacSizedBox(height: 5),
            StacText(
              data: '{{form.description}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
        StacSizedBox(height: 4),
        StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.end,
          children: [
            StacText(
              // محل پرداخت
              data: '{{appStrings.promissory.paymentPlaceLabel}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
            StacSizedBox(height: 5),
            StacText(
              data: '{{form.paymentPlace}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

StacWidget _buildIssuerSection() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 0.5,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          // اطلاعات صادرکننده
          data: '{{appStrings.promissory.issuerInfoTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 8),
        StacContainer(
          height: 1,
          decoration: StacBoxDecoration(
            color: '{{appColors.current.input.borderEnabled}}',
          ),
        ),
        StacSizedBox(height: 8),
        StacPadding(
          padding: StacEdgeInsets.only(bottom: 8),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacText(
                // کد ملی
                data: '{{appStrings.promissory.nationalCode}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacText(
                data: '{{userData.nationalCode}}',
                textDirection: StacTextDirection.ltr,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
        ),
        StacPadding(
          padding: StacEdgeInsets.only(bottom: 8),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacText(
                // شماره موبایل صادرکننده
                data: '{{appStrings.promissory.issuerPhoneNumber}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacText(
                data: '{{userData.mobile}}',
                textDirection: StacTextDirection.ltr,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
            ],
          ),
        ),
        StacPadding(
          padding: StacEdgeInsets.only(bottom: 8),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacText(
                // نام و نام خانوادگی
                data: '{{appStrings.promissory.fullName}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  color: '{{appColors.current.text.subtitle}}',
                ),
              ),
              StacExpanded(
                child: StacText(
                  data: '{{userData.fullName}}',
                  textDirection: StacTextDirection.ltr,
                  textAlign: StacTextAlign.left,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
            ],
          ),
        ),

        StacSizedBox(height: 4),
        StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.end,
          children: [
            StacText(
              // آدرس محل اقامت
              data: '{{appStrings.promissory.addressResidence}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 14,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
            StacSizedBox(height: 5),
            StacText(
              data: '{{userData.address}}',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 15,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

StacWidget _buildReceiverSection() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainer}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 0.5,
      ),
    ),
    padding: StacEdgeInsets.all(16),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacText(
          // دریافت‌کننده
          data: '{{appStrings.promissory.receiverInfoTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 16,
            fontWeight: StacFontWeight.w700,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(height: 8),
        StacContainer(
          height: 1,
          decoration: StacBoxDecoration(
            color: '{{appColors.current.input.borderEnabled}}',
          ),
        ),
        StacSizedBox(height: 8),
        // National Code/ID Row
        StacCustomVisibility(
          visible: '[[recipientType]]',
          child: StacPadding(
            padding: StacEdgeInsets.only(bottom: 8),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
              children: [
                StacText(
                  // کد ملی
                  data: '{{appStrings.promissory.nationalCode}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacText(
                  data: '{{form.receiver_national_code}}',
                  textDirection: StacTextDirection.ltr,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ).toJson(),
        ),
        StacCustomVisibility(
          visible: '[[!recipientType]]',
          child: StacPadding(
            padding: StacEdgeInsets.only(bottom: 8),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
              children: [
                StacText(
                  // شناسه ملی
                  data: '{{appStrings.promissory.nationalId}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacText(
                  data: '{{receiverIdentity.nationalId}}',
                  textDirection: StacTextDirection.ltr,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ).toJson(),
        ),
        // Mobile/Contact Row
        StacCustomVisibility(
          visible: '[[recipientType]]',
          child: StacPadding(
            padding: StacEdgeInsets.only(bottom: 8),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
              children: [
                StacText(
                  // شماره موبایل
                  data: '{{appStrings.promissory.mobileNumber}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacText(
                  data: '{{form.receiver_mobile}}',
                  textDirection: StacTextDirection.ltr,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ).toJson(),
        ),
        StacCustomVisibility(
          visible: '[[!recipientType]]',
          child: StacPadding(
            padding: StacEdgeInsets.only(bottom: 8),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
              children: [
                StacText(
                  // شماره تماس
                  data: '{{appStrings.promissory.contactNumber}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacText(
                  data: '{{receiverIdentity.phone}}',
                  textDirection: StacTextDirection.ltr,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
          ).toJson(),
        ),
        StacPadding(
          padding: StacEdgeInsets.only(bottom: 8),
          child: StacRow(
            textDirection: StacTextDirection.rtl,
            mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
            children: [
              StacCustomVisibility(
                visible: '[[recipientType]]',
                child: StacText(
                  // نام و نام خانوادگی
                  data: '{{appStrings.promissory.fullName}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ).toJson(),
              ),
              StacCustomVisibility(
                visible: '[[!recipientType]]',
                child: StacText(
                  // نام
                  data: 'نام',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ).toJson(),
              ),
              StacExpanded(
                child: StacText(
                  data: '{{receiverIdentity.fullName}}',
                  textDirection: StacTextDirection.ltr,
                  textAlign: StacTextAlign.left,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

StacWidget _buildSubmitButton() {
  return StacPadding(
    padding: StacEdgeInsets.all(16),
    child: StacFilledButton(
      style: StacButtonStyle(
        backgroundColor: '{{appColors.current.primary.color}}',
        elevation: 0,
        fixedSize: StacSize(999999, 56),
        shape: StacRoundedRectangleBorder(
          borderRadius: StacBorderRadius.all(12),
        ),
      ),
      onPressed: StacNavigateAction(
        routeName: 'promissory_real_payment',
        navigationStyle: NavigationStyle.push,
      ),
      child: StacText(
        // تایید و پرداخت
        data: '{{appStrings.promissory.confirmAndPay}}',
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.bold,
          color: '{{appColors.current.primary.onPrimary}}',
        ),
      ),
    ),
  );
}
