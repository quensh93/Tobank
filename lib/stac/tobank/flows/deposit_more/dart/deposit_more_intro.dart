import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';
import 'package:tobank_sdui/stac_core/builders/stac_stateful_widget.dart';

const bool _showCardIssueByFlag = true;

@StacScreen(screenName: 'deposit_more_intro')
StacWidget depositMoreIntro() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        const StacCustomSetValueAction(
          values: [
            {'key': 'deposit_more_show_card_issue', 'value': _showCardIssueByFlag},
          ],
        ),
        StacShowBottomSheetAction(
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: '{{appColors.current.background.surface}}',
          barrierColor: '#8B000000',
          sheet: _buildDepositServicesBottomSheet().toJson(),
        ),
      ],
    ),
    child: StacScaffold(
      backgroundColor: '{{appColors.current.background.surface}}',
      body: StacCenter(
        child: StacPadding(
          padding: StacEdgeInsets.symmetric(horizontal: 16),
          child: StacFilledButton(
            onPressed: StacShowBottomSheetAction(
              isScrollControlled: true,
              useSafeArea: true,
              backgroundColor: '{{appColors.current.background.surface}}',
              barrierColor: '#8B000000',
              sheet: _buildDepositServicesBottomSheet().toJson(),
            ),
            style: StacButtonStyle(
              fixedSize: const StacSize(999999, 48),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(10),
              ),
            ),
            child: StacText(
              data: 'نمایش بیشتر (سپرده)',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

StacWidget _buildDepositServicesBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 20, topRight: 20),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 36,
              height: 4,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(4),
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data: 'خدمات سپرده',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 18,
              fontWeight: StacFontWeight.w800,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 16),
          StacCustomVisibility(
            visible: '[[deposit_more_show_card_issue]]',
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                _buildDepositServiceTile(
                  title: 'صدور کارت',
                  iconPath: '{{appAssets.icons.requestCardCurrent}}',
                  onTap: const StacCloseDialogAction(
                    result: {
                      'actionType': 'navigate',
                      'fileName': 'deposit_card_issue_address',
                      'navMode': 'dart',
                      'navigationStyle': 'push',
                    },
                  ),
                ),
                StacSizedBox(height: 10),
              ],
            ).toJson(),
          ),
          _buildDepositServiceTile(
            title: 'بستن سپرده',
            iconPath: '{{appAssets.icons.closeDepositCurrent}}',
            onTap: const StacCloseDialogAction(
              result: {
                'actionType': 'navigate',
                'fileName': 'deposit_close_confirm',
                'navMode': 'dart',
                'navigationStyle': 'push',
              },
            ),
          ),
          StacSizedBox(height: 10),
          _buildDepositServiceTile(
            title: 'جزئیات سپرده',
            iconPath: '{{appAssets.icons.depositDetailCurrent}}',
            onTap: _openDepositDetailsBottomSheetAction(),
          ),
          StacSizedBox(height: 4),
        ],
      ),
    ),
  );
}

StacWidget _buildDepositServiceTile({
  required String title,
  required String iconPath,
  StacAction? onTap,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surfaceContainerLowest}}',
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacInkWell(
      onTap: onTap ?? const StacCloseDialogAction(),
      borderRadius: StacBorderRadius.all(8),
      child: StacPadding(
        padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: StacRow(
          textDirection: StacTextDirection.rtl,
          mainAxisAlignment: StacMainAxisAlignment.start,
          crossAxisAlignment: StacCrossAxisAlignment.center,
          children: [
            StacContainer(
              width: 40,
              height: 40,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.background.surfaceContainer}}',
                borderRadius: StacBorderRadius.all(40),
              ),
              child: StacCenter(
                child: StacImage(
                  src: iconPath,
                  imageType: StacImageType.asset,
                  width: 31,
                  height: 31,
                ),
              ),
            ),
            StacSizedBox(width: 8),
            StacText(
              data: title,
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w500,
                color: '{{appColors.current.text.title}}',
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

StacAction _openDepositDetailsBottomSheetAction() {
  return StacCloseDialogAction(
    result: StacSequenceAction(
      actions: [
        const StacCustomSetValueAction(
          values: [
            {
              'key': 'depositMore.details.depositNumber',
              'value': '۱۱۹.۹۲۹۰.۱۶۱۲۹۸۸.۱',
            },
            {
              'key': 'depositMore.details.iban',
              'value': 'IR۶۲۰۶۴۰۰۱۱۹۹۲۹۰۱۶۱۲۹۸۸۰۰۱',
            },
          ],
        ),
        StacShowBottomSheetAction(
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: '{{appColors.current.background.surface}}',
          barrierColor: '#8B000000',
          sheet: _buildDepositDetailsBottomSheet().toJson(),
        ),
      ],
    ).toJson(),
  );
}

StacWidget _buildDepositDetailsBottomSheet() {
  return StacContainer(
    decoration: StacBoxDecoration(
      color: '{{appColors.current.background.surface}}',
      borderRadius: const StacBorderRadius.only(topLeft: 20, topRight: 20),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.all(16),
      child: StacColumn(
        mainAxisSize: StacMainAxisSize.min,
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          StacCenter(
            child: StacContainer(
              width: 36,
              height: 4,
              decoration: StacBoxDecoration(
                color: '{{appColors.current.input.borderEnabled}}',
                borderRadius: StacBorderRadius.all(4),
              ),
            ),
          ),
          StacSizedBox(height: 16),
          StacText(
            data: 'جزئیات سپرده',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w700,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 24),
          _depositDetailsItem(
            title: 'شماره سپرده',
            valueKey: 'depositMore.details.depositNumber',
            rightIconAsset: '{{appAssets.icons.shareDepositCurrent}}',
            ltrValue: false,
          ),
          StacSizedBox(height: 16),
          _depositDetailsItem(
            title: 'شماره شبا',
            valueKey: 'depositMore.details.iban',
            rightIconAsset: '{{appAssets.icons.shareIbanCurrent}}',
            ltrValue: true,
          ),
        ],
      ),
    ),
  );
}

StacWidget _depositDetailsItem({
  required String title,
  required String valueKey,
  required String rightIconAsset,
  required bool ltrValue,
}) {
  return StacContainer(
    decoration: StacBoxDecoration(
      borderRadius: StacBorderRadius.all(8),
      border: StacBorder.all(
        color: '{{appColors.current.input.borderEnabled}}',
        width: 1,
      ),
    ),
    child: StacPadding(
      padding: StacEdgeInsets.only(left: 8, top: 16, right: 16, bottom: 16),
      child: StacRow(
        textDirection: StacTextDirection.rtl,
        crossAxisAlignment: StacCrossAxisAlignment.center,
        children: [
          StacContainer(
            width: 40,
            height: 40,
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.surfaceContainer}}',
              borderRadius: StacBorderRadius.all(40),
            ),
            child: StacCenter(
              child: StacImage(
                src: rightIconAsset,
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
              ),
            ),
          ),
          StacSizedBox(width: 8),
          StacExpanded(
            child: StacColumn(
              crossAxisAlignment: StacCrossAxisAlignment.stretch,
              children: [
                StacText(
                  data: title,
                  textDirection: StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    color: '{{appColors.current.text.subtitle}}',
                    fontSize: 16,
                    fontWeight: StacFontWeight.w400,
                  ),
                ),
                StacSizedBox(height: 8),
                StacText(
                  data: '{{$valueKey}}',
                  textDirection: ltrValue
                      ? StacTextDirection.ltr
                      : StacTextDirection.rtl,
                  textAlign: StacTextAlign.right,
                  style: StacCustomTextStyle(
                    color: '{{appColors.current.text.title}}',
                    fontSize: 14,
                    fontWeight: StacFontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          StacGestureDetector(
            onTap: StacCopyToClipboardAction(valueKey: valueKey),
            child: StacPadding(
              padding: StacEdgeInsets.all(8),
              child: StacImage(
                src: '{{appAssets.icons.copyCurrent}}',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.icon.main}}',
              ),
            ),
          ),
          StacGestureDetector(
            onTap: StacShareTextAction(valueKey: valueKey),
            child: StacPadding(
              padding: StacEdgeInsets.all(8),
              child: StacImage(
                src: '{{appAssets.icons.shareCurrent}}',
                imageType: StacImageType.asset,
                width: 24,
                height: 24,
                color: '{{appColors.current.icon.main}}',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

