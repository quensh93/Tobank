import 'package:stac_core/stac_core.dart';
import 'package:tobank_sdui/stac_core/builders/stac_common_builders.dart';
import 'package:tobank_sdui/core/widgets/tobank_flow_app_bar.dart';
import 'package:tobank_sdui/stac_core/parsers/actions/stac_custom_actions.dart';

const _cardNumberFieldId = 'addNewCard.cardNumber';
const _expireDateFieldId = 'addNewCard.expireDate';
const _cardTitleFieldId = 'addNewCard.title';
const _submitEnabledKey = 'addNewCard.submitEnabled';

@StacScreen(screenName: 'card_management_add_card')
StacWidget dashboardAddNewCard() {
  return StacScaffold(
    backgroundColor: '{{appColors.current.background.surface}}',
    appBar: buildTobankFlowAppBar(
      title: '{{appStrings.profile.real.destinations.addCardTitle}}',
      showSupport: true,
      showBack: true,
    ),
    body: StacForm(
      autovalidateMode: StacAutovalidateMode.always,
      child: StacSingleChildScrollView(
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            // ── Bank logos info section ─────────────────────────────────
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
              child: StacColumn(
                children: [
                  StacText(
                    data:
                        '{{appStrings.generated.card_management.add_new_card.bank_u200c_bank_u200c}}',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 12,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                  ),
                  StacSizedBox(height: 12),
                  StacRow(
                    mainAxisAlignment: StacMainAxisAlignment.spaceEvenly,
                    children: [
                      StacImage(
                        src: '{{appAssets.current.icons.gardeshgari}}',
                        imageType: StacImageType.asset,
                        width: 32,
                        height: 32,
                      ),
                      StacImage(
                        src: '{{appAssets.current.icons.melli}}',
                        imageType: StacImageType.asset,
                        width: 32,
                        height: 32,
                      ),
                      StacImage(
                        src: '{{appAssets.current.icons.sepah}}',
                        imageType: StacImageType.asset,
                        width: 32,
                        height: 32,
                      ),
                      StacImage(
                        src: '{{appAssets.current.icons.keshavarzi}}',
                        imageType: StacImageType.asset,
                        width: 32,
                        height: 32,
                      ),
                      StacImage(
                        src: '{{appAssets.current.icons.maskan}}',
                        imageType: StacImageType.asset,
                        width: 32,
                        height: 32,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            StacSizedBox(height: 20),

            // ── Scan card button ───────────────────────────────────────
            StacGestureDetector(
              onTap: StacRawJsonAction({
                'actionType': 'showTransferCardScanner',
                'fieldId': _cardNumberFieldId,
              }),
              child: StacContainer(
                padding: StacEdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: StacBoxDecoration(
                  borderRadius: StacBorderRadius.all(12),
                  border: StacBorder.all(
                    color: '{{appColors.current.input.borderEnabled}}',
                    width: 1,
                  ),
                ),
                child: StacRow(
                  textDirection: StacTextDirection.rtl,
                  mainAxisAlignment: StacMainAxisAlignment.center,
                  children: [
                    StacImage(
                      src: 'assets/icons/ic_scanner.svg',
                      imageType: StacImageType.asset,
                      width: 22,
                      height: 22,
                      color: '{{appColors.current.text.title}}',
                    ),
                    StacSizedBox(width: 8),
                    StacText(
                      data: '{{appStrings.profile.real.destinations.scanCard}}',
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
            ),

            StacSizedBox(height: 24),

            // ── Card number field ──────────────────────────────────────
            StacText(
              data: '{{appStrings.profile.real.destinations.cardNumberLabel}}',
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
              id: _cardNumberFieldId,
              textDirection: 'ltr',
              textAlign: 'left',
              supportTextDirection: 'rtl',
              autovalidateMode: 'always',
              keyboardType: 'number',
              maxLength: 16,
              validatorRules: const [
                {
                  'rule': 'matches',
                  'options': {'pattern': r'^\d{16}$'},
                  'message':
                      '{{appStrings.generated.card_management.card_management_add_card.card_number}}',
                },
              ],
              onChanged: _validateAddNewCardAction(),
              decoration: {
                'hintText':
                    '{{appStrings.generated.card_management.card_management_add_card.card_number_enter}}',
                'hintStyle': {
                  'type': 'custom',
                  'fontSize': 14,
                  'color': '{{appColors.current.text.hint}}',
                },
                'enabledBorder': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color': '{{appColors.current.input.borderEnabled}}',
                    'width': 1,
                  },
                  'borderRadius': {'all': 12},
                },
                'focusedBorder': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color':
                        '{{appColors.current.button.primary.backgroundColor}}',
                    'width': 1.5,
                  },
                  'borderRadius': {'all': 12},
                },
                'contentPadding': {
                  'left': 16,
                  'top': 16,
                  'right': 16,
                  'bottom': 16,
                },
              },
            ),

            StacSizedBox(height: 20),

            // ── Expire date field (two fields: سال + ماه) ───────────────
            StacText(
              data:
                  '{{appStrings.generated.card_management.card_management_add_card.date_card}}',
              textDirection: StacTextDirection.rtl,
              textAlign: StacTextAlign.right,
              style: StacCustomTextStyle(
                fontSize: 14,
                fontWeight: StacFontWeight.w600,
                color: '{{appColors.current.text.title}}',
              ),
            ),
            StacSizedBox(height: 8),
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacExpanded(
                  child: StacCustomTextFormField(
                    id: 'addNewCard.expireYear',
                    textDirection: 'rtl',
                    textAlign: 'center',
                    readOnly: true,
                    onTap: _showExpirePickerAction(),
                    decoration: {
                      'hintText':
                          '{{appStrings.generated.transfer.transfer_confirm.year}}',
                      'hintStyle': {
                        'type': 'custom',
                        'fontSize': 14,
                        'fontWeight': 'w500',
                        'color': '{{appColors.current.text.hint}}',
                      },
                      'enabledBorder': {
                        'type': 'outlineInputBorder',
                        'borderSide': {
                          'color': '{{appColors.current.input.borderEnabled}}',
                          'width': 1,
                        },
                        'borderRadius': {'all': 12},
                      },
                      'focusedBorder': {
                        'type': 'outlineInputBorder',
                        'borderSide': {
                          'color': '{{appColors.current.input.borderEnabled}}',
                          'width': 1,
                        },
                        'borderRadius': {'all': 12},
                      },
                      'contentPadding': {
                        'left': 16,
                        'top': 16,
                        'right': 16,
                        'bottom': 16,
                      },
                    },
                  ),
                ),
                StacSizedBox(width: 12),
                StacExpanded(
                  child: StacCustomTextFormField(
                    id: 'addNewCard.expireMonth',
                    textDirection: 'rtl',
                    textAlign: 'center',
                    readOnly: true,
                    onTap: _showExpirePickerAction(),
                    decoration: {
                      'hintText':
                          '{{appStrings.generated.transfer.transfer_confirm.month}}',
                      'hintStyle': {
                        'type': 'custom',
                        'fontSize': 14,
                        'fontWeight': 'w500',
                        'color': '{{appColors.current.text.hint}}',
                      },
                      'enabledBorder': {
                        'type': 'outlineInputBorder',
                        'borderSide': {
                          'color': '{{appColors.current.input.borderEnabled}}',
                          'width': 1,
                        },
                        'borderRadius': {'all': 12},
                      },
                      'focusedBorder': {
                        'type': 'outlineInputBorder',
                        'borderSide': {
                          'color': '{{appColors.current.input.borderEnabled}}',
                          'width': 1,
                        },
                        'borderRadius': {'all': 12},
                      },
                      'contentPadding': {
                        'left': 16,
                        'top': 16,
                        'right': 16,
                        'bottom': 16,
                      },
                    },
                  ),
                ),
              ],
            ),
            // Hidden field for combined expire value (used for validation)
            StacVisibility(
              visible: false,
              child: StacCustomTextFormField(
                id: _expireDateFieldId,
                textDirection: 'ltr',
                textAlign: 'center',
                readOnly: true,
                onChanged: _validateAddNewCardAction(),
              ),
            ),

            StacSizedBox(height: 20),

            // ── Card title field ───────────────────────────────────────
            StacText(
              data: '{{appStrings.profile.real.destinations.cardTitleLabel}}',
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
              id: _cardTitleFieldId,
              textDirection: 'rtl',
              textAlign: 'right',
              supportTextDirection: 'rtl',
              autovalidateMode: 'always',
              validatorRules: const [
                {
                  'rule': 'matches',
                  'options': {'pattern': r'.+'},
                  'message':
                      '{{appStrings.generated.card_management.add_new_card.title_card_not_u200c_can}}',
                },
              ],
              onChanged: _validateAddNewCardAction(),
              decoration: {
                'hintText':
                    '{{appStrings.generated.card_management.card_management_add_card.title_card_enter}}',
                'hintStyle': {
                  'type': 'custom',
                  'fontSize': 14,
                  'color': '{{appColors.current.text.hint}}',
                },
                'enabledBorder': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color': '{{appColors.current.input.borderEnabled}}',
                    'width': 1,
                  },
                  'borderRadius': {'all': 12},
                },
                'focusedBorder': {
                  'type': 'outlineInputBorder',
                  'borderSide': {
                    'color':
                        '{{appColors.current.button.primary.backgroundColor}}',
                    'width': 1.5,
                  },
                  'borderRadius': {'all': 12},
                },
                'contentPadding': {
                  'left': 16,
                  'top': 16,
                  'right': 16,
                  'bottom': 16,
                },
              },
            ),

            StacSizedBox(height: 24),

            // ── Submit button (reactive) ───────────────────────────────
            StacCustomReactiveElevatedButton(
              enabledKey: _submitEnabledKey,
              onPressed: StacSequenceAction(
                actions: [
                  StacCustomSnackBarAction(
                    title:
                        '{{appStrings.generated.card_management.card_management_add_card.submit}}',
                    detail:
                        '{{appStrings.generated.card_management.card_management_add_card.successfully_new_card}}',
                    duration: 3000,
                  ),
                  const StacNavigateAction(
                    navigationStyle: NavigationStyle.pop,
                  ),
                ],
              ).toJson(),
              style: StacButtonStyle(
                padding: StacEdgeInsets.symmetric(vertical: 8),
                minimumSize: const StacSize(0, 56),
                backgroundColor:
                    '{{appColors.current.button.primary.backgroundColor}}',
                foregroundColor:
                    '{{appColors.current.button.primary.foregroundColor}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(8),
                ),
              ).toJson(),
              disabledStyle: StacButtonStyle(
                padding: StacEdgeInsets.symmetric(vertical: 8),
                minimumSize: const StacSize(0, 56),
                backgroundColor: '{{appColors.current.input.borderEnabled}}',
                foregroundColor: '{{appColors.current.text.subtitle}}',
                shape: StacRoundedRectangleBorder(
                  borderRadius: StacBorderRadius.all(8),
                ),
              ).toJson(),
              child: StacText(
                data:
                    '{{appStrings.generated.card_management.card_management_add_card.submit_card}}',
                textDirection: StacTextDirection.rtl,
                style: StacCustomTextStyle(
                  fontSize: 14,
                  fontWeight: StacFontWeight.w700,
                ),
              ).toJson(),
            ),
          ],
        ),
      ),
    ),
  );
}

StacValidateFieldsAction _validateAddNewCardAction() {
  return const StacValidateFieldsAction(
    resultKey: _submitEnabledKey,
    fields: [
      {'id': _cardNumberFieldId, 'rule': r'^\d{16}$'},
      {'id': _expireDateFieldId, 'rule': r'.+'},
      {'id': _cardTitleFieldId, 'rule': r'.+'},
    ],
  );
}

StacAction _showExpirePickerAction() {
  return StacRawJsonAction({
    'actionType': 'showCardExpireSelectBottomSheet',
    'formFieldId': _expireDateFieldId,
    'yearFieldId': 'addNewCard.expireYear',
    'monthFieldId': 'addNewCard.expireMonth',
    'title':
        '{{appStrings.generated.transfer.transfer_confirm.select_date_card}}',
    'monthTitle': '{{appStrings.generated.transfer.transfer_confirm.month}}',
    'yearTitle': '{{appStrings.generated.transfer.transfer_confirm.year}}',
    'confirmText': '{{appStrings.common.confirm}}',
    'onSelectedAction': {
      'actionType': 'validateFields',
      'resultKey': _submitEnabledKey,
      'fields': [
        {'id': _cardNumberFieldId, 'rule': r'^\d{16}$'},
        {'id': _expireDateFieldId, 'rule': r'.+'},
        {'id': _cardTitleFieldId, 'rule': r'.+'},
      ],
    },
  });
}
