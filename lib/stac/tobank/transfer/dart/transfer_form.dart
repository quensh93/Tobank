import 'package:stac_core/stac_core.dart';
import 'package:stac_core/actions/network_request/stac_network_request.dart';

/// Tobank Transfer Form Screen - Transfer money between accounts
/// 
/// This screen provides a form to transfer money with:
/// - From account selector
/// - To account input
/// - Amount input
/// - Description/Note input
/// 
/// Uses data binding to load all text strings from mock API.
/// Uses Persian text from app_fa.arb.
/// Uses STAC theme colors which automatically adapt to light/dark mode.
/// 
/// Reference: `.tobank_old/lib/ui/deposit/card_transfer/page/card_transfer_select_destination_page.dart` and `card_transfer_amount_page.dart`
@StacScreen(screenName: 'tobank_transfer_form')
StacWidget tobankTransferForm() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacDynamicView(
        request: StacNetworkRequest(
          url: 'https://api.tobank.com/transfer-form-labels',
          method: Method.get,
        ),
        targetPath: 'data',
        template: StacText(
          data: '{{appBarTitle}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        loaderWidget: StacText(
          data: '{{appStrings.transfer.title}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        errorWidget: StacText(
          data: '{{appStrings.transfer.title}}',
          style: StacCustomTextStyle(
            fontSize: 20,
            fontWeight: StacFontWeight.bold,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
      centerTitle: true,
    ),
    body: StacDynamicView(
      request: StacNetworkRequest(
        url: 'https://api.tobank.com/transfer-form-labels',
        method: Method.get,
      ),
      targetPath: 'data',
      loaderWidget: StacCenter(
        child: StacCircularProgressIndicator(),
      ),
      errorWidget: StacCenter(
        child: StacText(
          data: '{{appStrings.transfer.errorLoading}}',
          style: StacCustomTextStyle(
            color: '{{appColors.current.error.color}}',
          ),
        ),
      ),
      template: StacSingleChildScrollView(
        padding: StacEdgeInsets.all(16),
        child: StacForm(
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              // From Account Field
              StacText(
                data: '{{fromAccountLabel}}',
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 8),
              
              // TODO: Add dropdown for account selection when STAC supports it
              // For now, using text field
              StacTextFormField(
                id: 'from_account',
                readOnly: true,
                decoration: StacInputDecoration(
                  hintText: 'انتخاب حساب مبدا',
                  hintStyle: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  filled: true,
                  fillColor: 'surface',
                ),
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 16),
              
              // To Account Field
              StacText(
                data: '{{toAccountLabel}}',
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 8),
              
              StacTextFormField(
                id: 'to_account',
                decoration: StacInputDecoration(
                  hintText: '{{appStrings.transfer.toAccountPlaceholder}}',
                  hintStyle: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  filled: true,
                  fillColor: 'surface',
                ),
                keyboardType: StacTextInputType.number,
                textInputAction: StacTextInputAction.next,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 16),
              
              // Amount Field
              StacText(
                data: '{{amountLabel}}',
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 8),
              
              StacTextFormField(
                id: 'amount',
                decoration: StacInputDecoration(
                  hintText: '{{amountPlaceholder}}',
                  hintStyle: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  filled: true,
                  fillColor: 'surface',
                ),
                keyboardType: StacTextInputType.number,
                textInputAction: StacTextInputAction.next,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 16),
              
              // Description Field (Optional)
              StacText(
                data: '{{descriptionLabel}}',
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 8),
              
              StacTextFormField(
                id: 'description',
                decoration: StacInputDecoration(
                  hintText: '{{descriptionPlaceholder}}',
                  hintStyle: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                  filled: true,
                  fillColor: 'surface',
                ),
                keyboardType: StacTextInputType.text,
                textInputAction: StacTextInputAction.done,
                maxLines: 3,
                style: StacCustomTextStyle(
                  fontSize: 16,
                  fontWeight: StacFontWeight.w600,
                  color: '{{appColors.current.text.title}}',
                ),
              ),
              
              StacSizedBox(height: 24),
              
              // Review Transfer Button
              StacElevatedButton(
                onPressed: StacNavigateAction(
                  assetPath: 'stac/.build/tobank_transfer_confirmation.json',
                  navigationStyle: NavigationStyle.push,
                ),
                style: StacButtonStyle(
                  backgroundColor: 'primary',
                  padding: StacEdgeInsets.symmetric(vertical: 16),
                ),
                child: StacText(
                  data: '{{reviewButtonText}}',
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.bold,
                    color: 'onPrimary',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
