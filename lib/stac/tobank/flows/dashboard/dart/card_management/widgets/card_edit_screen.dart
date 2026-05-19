import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/core/stac/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/stac/builders/stac_custom_actions.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';

const String _cardExpireFieldId = 'cardEditExpireInput';

@StacScreen(screenName: 'dashboard_card_edit')
StacWidget dashboardCardEdit() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: StacAppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: StacText(
        data: 'ویرایش کارت',
        textDirection: StacTextDirection.rtl,
        style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
      ),
      actions: [
        StacPadding(
          padding: StacEdgeInsets.only(right: 12),
          child: StacIconButton(
            onPressed:
                const StacNavigateAction(navigationStyle: NavigationStyle.pop),
            icon: StacImage(
              src: '{{appAssets.icons.arrowBack}}',
              imageType: StacImageType.asset,
              width: 31,
              height: 31,
              color: '{{appColors.current.text.title}}',
            ),
          ),
        ),
      ],
    ),
    body: StacForm(
      autovalidateMode: StacAutovalidateMode.onUserInteraction,
      child: StacSingleChildScrollView(
      padding: StacEdgeInsets.only(left: 16, right: 16, top: 24, bottom: 32),
      child: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        children: [
          // ── Card number info row ─────────────────────────────────────
          StacContainer(
            padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: StacBoxDecoration(
              color: '{{appColors.current.background.card}}',
              borderRadius: StacBorderRadius.all(12),
              border: StacBorder.all(
                color: '{{appColors.current.input.borderEnabled}}',
                width: 1,
              ),
            ),
            child: StacRow(
              textDirection: StacTextDirection.rtl,
              mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
              children: [
                StacText(
                  data: 'شماره کارت',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 13,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.hint}}',
                  ),
                ),
                StacRow(
                  textDirection: StacTextDirection.ltr,
                  mainAxisSize: StacMainAxisSize.min,
                  children: [
                    StacCustomVisibility(
                      visible: '[[cardsManagement.selectedIsGardeshgary]]',
                      child: StacImage(
                        src: '{{appAssets.current.icons.tobankLogo}}',
                        imageType: StacImageType.asset,
                        width: 32,
                        height: 32,
                      ).toJson(),
                      replacement: StacImage(
                        src: '{{appAssets.current.icons.bank}}',
                        imageType: StacImageType.asset,
                        width: 32,
                        height: 32,
                        color: '{{appColors.current.text.hint}}',
                      ).toJson(),
                    ),
                    StacSizedBox(width: 10),
                    StacCustomRegistryReactive(
                      registryKey: 'cardsManagement.sheet.cardNumber',
                      child: {
                        'type': 'text',
                        'data': '{{cardsManagement.sheet.cardNumber}}',
                        'textDirection': 'ltr',
                        'style': {
                          'type': 'custom',
                          'fontSize': 15,
                          'fontWeight': 'w600',
                          'color': '{{appColors.current.text.title}}',
                        },
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          StacSizedBox(height: 24),

          // ── Expiry date (read-only, picker on tap) ───────────────────
          StacText(
            data: 'تاریخ انقضاء',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 8),
          StacCustomTextFormField(
            id: _cardExpireFieldId,
            textDirection: 'ltr',
            textAlign: 'right',
            initialValue: '{{cardsManagement.sheet.expDate}}',
            keyboardType: 'number',
            maxLength: 5,
            readOnly: true,
            onTap: _showCardExpireBottomSheetAction(),
            style: StacCustomTextStyle(
              fontSize: 16,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ).toJson(),
            decoration: {
              'hintText': '۰۶/۱۰',
              'hintStyle': {
                'type': 'custom',
                'fontSize': 16,
                'fontWeight': 'w500',
                'color': '{{appColors.current.text.hint}}',
              },
              'enabledBorder': {
                'type': 'outline',
                'borderSide': {
                  'color': '{{appColors.current.input.borderEnabled}}',
                  'width': 1,
                },
                'borderRadius': {'all': 12},
              },
              'focusedBorder': {
                'type': 'outline',
                'borderSide': {
                  'color':
                      '{{appColors.current.button.primary.backgroundColor}}',
                  'width': 1.5,
                },
                'borderRadius': {'all': 12},
              },
              'contentPadding': {
                'left': 16,
                'top': 14,
                'right': 16,
                'bottom': 14,
              },
            },
          ),

          StacSizedBox(height: 24),

          // ── Card title (editable) ────────────────────────────────────
          StacText(
            data: 'عنوان کارت',
            textDirection: StacTextDirection.rtl,
            textAlign: StacTextAlign.right,
            style: StacCustomTextStyle(
              fontSize: 14,
              fontWeight: StacFontWeight.w600,
              color: '{{appColors.current.text.title}}',
            ),
          ),
          StacSizedBox(height: 8),
          StacCustomRegistryReactive(
            registryKey: 'cardsManagement.sheet.title',
            child: StacCustomTextFormField(
              id: 'card_edit_title',
              textDirection: 'rtl',
              textAlign: 'right',
              initialValue: '{{cardsManagement.sheet.title}}',
              decoration: {
                'enabledBorder': {
                  'type': 'outline',
                  'borderSide': {
                    'color': '{{appColors.current.input.borderEnabled}}',
                    'width': 1,
                  },
                  'borderRadius': {'all': 12},
                },
                'focusedBorder': {
                  'type': 'outline',
                  'borderSide': {
                    'color':
                        '{{appColors.current.button.primary.backgroundColor}}',
                    'width': 1.5,
                  },
                  'borderRadius': {'all': 12},
                },
                'contentPadding': {
                  'left': 16,
                  'top': 14,
                  'right': 16,
                  'bottom': 14,
                },
              },
            ).toJson(),
          ),

          StacSizedBox(height: 32),

          // ── Save button ──────────────────────────────────────────────
          StacFilledButton(
            onPressed: StacSequenceAction(
              actions: [
                StacCustomSnackBarAction(
                  title: 'ذخیره شد',
                  detail: 'عنوان کارت با موفقیت به‌روزرسانی شد.',
                  duration: 3000,
                ),
                StacNavigateAction(navigationStyle: NavigationStyle.pop),
              ],
            ),
            style: StacButtonStyle(
              padding: StacEdgeInsets.symmetric(vertical: 16),
              backgroundColor:
                  '{{appColors.current.button.primary.backgroundColor}}',
              foregroundColor:
                  '{{appColors.current.button.primary.foregroundColor}}',
              shape: StacRoundedRectangleBorder(
                borderRadius: StacBorderRadius.all(16),
              ),
            ),
            child: StacText(
              data: 'ذخیره تغییرات',
              textDirection: StacTextDirection.rtl,
              style: StacTextStyle(
                fontSize: 16,
                fontWeight: StacFontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  ),
  );
}

StacAction _showCardExpireBottomSheetAction() {
  return StacRawJsonAction({
    'actionType': 'showCardExpireSelectBottomSheet',
    'formFieldId': _cardExpireFieldId,
    'title': 'تاریخ انقضای کارت را انتخاب نمایید',
    'monthTitle': 'ماه',
    'yearTitle': 'سال',
    'confirmText': 'تایید',
  });
}
