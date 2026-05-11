import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/core/stac/builders/stac_stateful_widget.dart';

@StacScreen(screenName: 'transfer_real_in_bank_confirm')
StacWidget transferRealInBankConfirm() {
  return StacStatefulWidget(
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      appBar: buildTobankFlowAppBar(
        showSupport: true,
        title: 'انتقال وجه',
      ),
      body: StacPadding(
        padding: StacEdgeInsets.only(left: 16, top: 16, right: 16, bottom: 21),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            _summaryCard(),
            StacExpanded(child: StacSizedBox()),
            StacFilledButton(
              onPressed: const StacNavigateAction(
                routeName: 'transfer_real_in_bank_result',
                navigationStyle: NavigationStyle.push,
              ),
              style: StacButtonStyle(
                fixedSize: const StacSize(999999, 57),
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(10),
                ),
                backgroundColor: '#E31B2F',
                foregroundColor: '#FFFFFF',
              ),
              child: StacText(
                data: 'انتقال وجه',
                style: StacCustomTextStyle(
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

StacWidget _summaryCard() {
  return StacContainer(
    padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(14),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
      color: '{{appColors.current.background.surface}}',
    ),
    child: StacColumn(
      crossAxisAlignment: StacCrossAxisAlignment.stretch,
      children: [
        StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
          children: [
            StacCustomRegistryReactive(
              registryKey: 'transferApiTransferTypeTitle',
              child: StacRow(
                mainAxisSize: StacMainAxisSize.min,
                textDirection: StacTextDirection.rtl,
                children: [
                  StacText(
                    data: 'مبلغ انتقال',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(width: 4),

                  StacRawJsonWidget({
                    'type': 'text',
                    'data': '{{transferApiTransferTypeTitle}}',
                    'textDirection': 'rtl',
                    'style': {
                      'type': 'custom',
                      'fontSize': 18,
                      'fontWeight': 'w700',
                      'color': '{{appColors.current.text.title}}',
                    },
                  }),
                ],
              ).toJson(),
            ),
            StacCustomRegistryReactive(
              registryKey: 'transferApiAmountRaw',
              child: StacRow(
                mainAxisSize: StacMainAxisSize.min,
                textDirection: StacTextDirection.ltr,
                children: [
                  StacText(
                    data: 'ریال',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 15,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(width: 4),

                  StacRawJsonWidget({
                    'type': 'text',
                    'data': '{{transferApiAmountRaw}}',
                    'textDirection': 'ltr',
                    'textAlign': 'left',
                    'style': {
                      'type': 'custom',
                      'fontSize': 18,
                      'fontWeight': 'w700',
                      'color': '{{appColors.current.text.title}}',
                    },
                  }),
                ],
              ).toJson(),
            ),
          ],
        ),
        StacSizedBox(height: 14),
        StacDivider(
          color: '{{appColors.current.input.borderEnabled}}',
          height: 1,
          thickness: 1,
        ),
        StacSizedBox(height: 14),
        _accountSection(
          sectionTitle: 'مبدا',
          accountHolder: 'سجاد رحمانی پور',
          accountValue: '۱۱۰.۹۹۲۲.۱۷۹۳۸۵۸.۱',
          iconAsset: 'assets/icons/ic_gardeshgari.svg',
          accountDirection: StacTextDirection.ltr,
        ),
        StacSizedBox(height: 14),
        StacDivider(
          color: '{{appColors.current.input.borderEnabled}}',
          height: 1,
          thickness: 1,
        ),
        StacSizedBox(height: 14),
        _destinationSection(),
      ],
    ),
  );
}

StacWidget _destinationSection() {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      _sectionLabel('مقصد'),
      StacSizedBox(width: 10),
      StacContainer(
        width: 38,
        height: 38,
        decoration: StacBoxDecoration(
          shape: StacBoxShape.circle,
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
          color: '{{appColors.current.background.surfaceContainer}}',
        ),
        child: StacCenter(
          child: StacImage(
            src: 'assets/icons/ic_gardeshgari.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
          ),
        ),
      ),
      StacSizedBox(width: 10),
      StacExpanded(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacCustomRegistryReactive(
              registryKey: 'transferApiDestinationName',
              child: {
                'type': 'text',
                'data': '{{transferApiDestinationName}}',
                'textDirection': 'rtl',
                'textAlign': 'right',
                'style': {
                  'type': 'custom',
                  'fontSize': 18,
                  'fontWeight': 'w600',
                  'color': '{{appColors.current.text.title}}',
                },
              },
            ),
            StacSizedBox(height: 8),
            StacCustomRegistryReactive(
              registryKey: 'transferApiDestinationIban',
              child: {
                'type': 'text',
                'data': '{{transferApiDestinationIban}}',
                'textDirection': 'ltr',
                'textAlign': 'right',
                'style': {
                  'type': 'custom',
                  'fontSize': 17,
                  'fontWeight': 'w700',
                  'color': '{{appColors.current.text.title}}',
                },
              },
            ),
          ],
        ),
      ),
    ],
  );
}

StacWidget _accountSection({
  required String sectionTitle,
  required String accountHolder,
  required String accountValue,
  required String iconAsset,
  required StacTextDirection accountDirection,
}) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    crossAxisAlignment: StacCrossAxisAlignment.center,
    children: [
      _sectionLabel(sectionTitle),
      StacSizedBox(width: 10),
      StacContainer(
        width: 38,
        height: 38,
        decoration: StacBoxDecoration(
          shape: StacBoxShape.circle,
          border: StacBorder.all(
            color: '{{appColors.current.input.borderEnabled}}',
            width: 1,
          ),
          color: '{{appColors.current.background.surfaceContainer}}',
        ),
        child: StacCenter(
          child: StacImage(
            src: iconAsset,
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
          ),
        ),
      ),
      StacSizedBox(width: 10),
      StacExpanded(
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacText(
              data: accountHolder,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacText(
              data: accountValue,
              textDirection: accountDirection,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 17,
                fontWeight: StacFontWeight.w700,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

StacWidget _sectionLabel(String title) {
  return StacContainer(
    width: 42,
    child: StacText(
      data: title,
      textDirection: StacTextDirection.rtl,
      style: StacCustomTextStyle(
        fontSize: 16,
        fontWeight: StacFontWeight.w600,
        color: '{{appColors.current.text.subtitle}}',
      ),
    ),
  );
}
