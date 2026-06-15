import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

@StacScreen(screenName: 'transfer_in_bank_result')
StacWidget transferRealInBankResult() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      showSupport: true,
      title: 'انتقال وجه',
    ),
    body: StacPadding(
      padding: StacEdgeInsets.only(left: 16, top: 14, right: 16, bottom: 35),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacExpanded(
            child: StacCustomWidget.fromJson({
              'type': 'receiptRepaintBoundary',
              'boundaryKey': 'transferInBankReceiptContent',
              'child': StacSingleChildScrollView(
                child: StacColumn(
                  crossAxisAlignment: StacCrossAxisAlignment.stretch,
                  children: [
                    _successHeader(),
                    StacSizedBox(height: 14),
                    _resultCard(),
                    StacSizedBox(height: 20),
                    _brandSection(),
                  ],
                ),
              ).toJson(),
            }),
          ),
          StacSizedBox(height: 12),
          StacRow(
            children: [
              StacExpanded(
                child: _bottomActionButton(
                  title: 'متن رسید',
                  iconAsset: 'assets/icons/ic_download.svg',
                  mode: 'shareText',
                ),
              ),
              StacSizedBox(width: 10),
              StacExpanded(
                child: _bottomActionButton(
                  title: 'تصویر رسید',
                  iconAsset: 'assets/icons/ic_share.svg',
                  mode: 'shareImage',
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

StacWidget _successHeader() {
  return StacColumn(
    children: [
      StacSizedBox(height: 8),
      StacImage(
        src: 'assets/icons/ic_transaction_success.svg',
        imageType: StacImageType.asset,
        width: 88,
        height: 88,
      ),
      StacSizedBox(height: 18),
      StacText(
        data: 'درخواست انتقال شما با موفقیت ثبت شد.',
        textDirection: StacTextDirection.rtl,
        textAlign: StacTextAlign.center,
        style: StacCustomTextStyle(
          fontSize: 18,
          fontWeight: StacFontWeight.w600,
          color: '{{appColors.current.text.title}}',
        ),
      ),
    ],
  );
}

StacWidget _resultCard() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(11),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surface}}',
    ),
    child: StacColumn(
      children: [
        _resultRow(
          title: 'نوع انتقال',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiTransferTypeTitle',
            child: {
              'type': 'text',
              'data': '{{transferApiTransferTypeTitle}}',
              'textDirection': 'rtl',
              'textAlign': 'left',
              'style': {
                'type': 'custom',
                'fontSize': 17,
                'fontWeight': 'w700',
                'color': '{{appColors.current.text.title}}',
              },
            },
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: 'مبلغ انتقال',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiAmountRaw',
            child: StacRow(
              mainAxisSize: StacMainAxisSize.min,
              textDirection: StacTextDirection.ltr,
              children: [
                StacRawJsonWidget({
                  'type': 'text',
                  'data': '{{transferApiAmountRaw}}',
                  'textDirection': 'ltr',
                  'style': {
                    'type': 'custom',
                    'fontSize': 17,
                    'fontWeight': 'w700',
                    'color': '{{appColors.current.text.title}}',
                  },
                }),
                StacSizedBox(width: 4),
                StacText(
                  data: 'ریال',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 17,
                    fontWeight: StacFontWeight.w700,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ).toJson(),
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: 'زمان انتقال وجه',
          valueWidget: StacText(
            data: '۱۴۰۵/۰۲/۰۵ - ۱۲:۲۶',
            textDirection: StacTextDirection.ltr,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: 'شماره سپرده مبدا',
          valueWidget: StacText(
            data: '۱۱۰.۹۹۲۲.۱۷۹۳۸۵۸.۱',
            textDirection: StacTextDirection.ltr,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: 'شماره سپرده مقصد',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiDestinationIban',
            child: {
              'type': 'text',
              'data': '{{transferApiDestinationIban}}',
              'textDirection': 'ltr',
              'textAlign': 'left',
              'style': {
                'type': 'custom',
                'fontSize': 17,
                'fontWeight': 'w700',
                'color': '{{appColors.current.text.title}}',
              },
            },
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: 'صاحب سپرده مقصد',
          valueWidget: StacCustomRegistryReactive(
            registryKey: 'transferApiDestinationName',
            child: {
              'type': 'text',
              'data': '{{transferApiDestinationName}}',
              'textDirection': 'rtl',
              'textAlign': 'left',
              'style': {
                'type': 'custom',
                'fontSize': 17,
                'fontWeight': 'w700',
                'color': '{{appColors.current.text.title}}',
              },
            },
          ),
        ),
        _dashedLikeDivider(),
        _resultRow(
          title: 'شماره پیگیری بانکی',
          valueWidget: StacText(
            data: '۱۴۰۵۰۲۰۵۰۶۴۳۰۰۳۸۵۲۱۷۱',
            textDirection: StacTextDirection.ltr,
            textAlign: StacTextAlign.left,
            style: StacCustomTextStyle(
              fontSize: 17,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
      ],
    ),
  );
}

StacWidget _resultRow({
  required String title,
  required StacWidget valueWidget,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      StacExpanded(
        child: StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.right,
          style: StacCustomTextStyle(
            fontSize: 17,
            fontWeight: StacFontWeight.w500,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ),
      StacSizedBox(width: 8),
      StacExpanded(
        child: StacAlign(
          alignment: StacAlignmentDirectional.centerStart,
          child: valueWidget,
        ),
      ),
    ],
  );
}

StacWidget _dashedLikeDivider() {
  return StacPadding(
    padding: StacEdgeInsets.symmetric(vertical: 11),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
      children: List.generate(
        44,
        (_) => StacContainer(
          width: 3,
          height: 1,
          color: '{{appColors.current.input.borderEnabled}}',
        ),
      ),
    ),
  );
}

StacWidget _brandSection() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.center,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      StacImage(
        src: 'assets/icons/ic_tobank.svg',
        imageType: StacImageType.asset,
        width: 56,
        height: 56,
      ),
      StacSizedBox(width: 16),
      StacContainer(
        height: 45,
        width: 0.7,
        color: '{{appColors.current.text.subtitle}}',
      ),
      StacSizedBox(width: 16),
      StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.end,
        children: [
          StacText(
            data: 'یک شعبه مجازی همراه شماست!',
            textDirection: StacTextDirection.rtl,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 8),
          StacText(
            data: 'www.tobank.ir',
            textDirection: StacTextDirection.ltr,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w500,
              color: '{{appColors.current.text.subtitle}}',
            ),
          ),
        ],
      ),
    ],
  );
}

StacWidget _bottomActionButton({
  required String title,
  required String iconAsset,
  required String mode,
}) {
  return StacOutlinedButton(
    onPressed: StacCustomAction.fromJson({
      'actionType': 'transferReceipt',
      'mode': mode,
      'title': 'رسید تراکنش',
      'pixelRatio': 3.0,
      'boundaryKey': 'transferInBankReceiptContent',
    }),
    style: StacButtonStyle(
      fixedSize: const StacSize(999999, 57),
      side: StacBorderSide(color: '{{appColors.current.input.borderEnabled}}'),
      shape: StacRoundedRectangleBorder(borderRadius: StacBorderRadius.all(12)),
      foregroundColor: '{{appColors.current.text.title}}',
    ),
    child: StacRow(
      mainAxisAlignment: StacMainAxisAlignment.center,
      children: [
        StacText(
          data: title,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 18,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
        StacSizedBox(width: 8),

        StacImage(
          src: iconAsset,
          imageType: StacImageType.asset,
          width: 26,
          height: 26,
          color: '{{appColors.current.text.title}}',
        ),
      ],
    ),
  );
}
