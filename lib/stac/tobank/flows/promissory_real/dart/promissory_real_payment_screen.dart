import 'package:stac_core/stac_core.dart';
import '../../../../../core/stac/builders/stac_common_builders.dart';
import '../../../../../core/stac/builders/stac_stateful_widget.dart';
import '../../../../../core/stac/builders/stac_custom_actions.dart';

/// Promissory Real Flow - Payment Method Page
///
/// This screen allows users to select payment method:
/// 1. Wallet payment
/// 2. Deposit payment
///
/// Note: Integrating with Real API flow logic.
@StacScreen(screenName: 'promissory_real_payment')
StacWidget promissoryRealPayment() {
  return StacStatefulWidget(
    onInit: StacSequenceAction(
      actions: [
        StacCustomSetValueAction(key: 'isWalletSelected', value: false),
        StacCustomSetValueAction(key: 'isDepositSelected', value: false),
        StacCustomSetValueAction(key: 'selectedPaymentMethod', value: ''),
        StacCustomSetValueAction(key: 'isPayEnabled', value: false),
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.paymentTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        leading: StacIconButton(
          onPressed: StacNavigateAction(navigationStyle: NavigationStyle.pop),
          icon: StacImage(
            src: 'assets/icons/ic_right_arrow.svg',
            imageType: StacImageType.asset,
            width: 24,
            height: 24,
            color: '{{appColors.current.text.title}}',
          ),
        ),
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
                  // Issuance summary and payable amount
                  StacColumn(
                    children: [
                      StacContainer(
                        decoration: StacBoxDecoration(
                          color:
                              '{{appColors.current.background.surfaceContainer}}',
                          borderRadius: StacBorderRadius.all(40),
                          border: StacBorder.all(
                            color: '{{appColors.current.input.borderEnabled}}',
                            width: 0.5,
                          ),
                        ),
                        padding: StacEdgeInsets.all(12),
                        child: StacImage(
                          src: 'assets/icons/ic_promissory_request.svg',
                          imageType: StacImageType.asset,
                          width: 40,
                          height: 40,

                        ),
                      ),
                      StacSizedBox(height: 12),
                      StacText(
                        data: '{{appStrings.promissory.issuanceTitle}}',
                        textDirection: StacTextDirection.rtl,
                        style: StacCustomTextStyle(
                          fontSize: 14,
                          fontWeight: StacFontWeight.w600,
                          color: '{{appColors.current.text.title}}',
                        ),
                      ),
                      StacSizedBox(height: 20),
                      StacRow(
                        textDirection: StacTextDirection.rtl,
                        mainAxisAlignment: StacMainAxisAlignment.spaceAround,
                        children: [
                          StacText(
                            data: '{{appStrings.promissory.payableAmount}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              fontWeight: StacFontWeight.w500,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacRow(
                            textDirection: StacTextDirection.rtl,
                            children: [
                              // Use form.promissory_amount as totalAmount fallback
                              StacText(
                                data: '{{promissory.fees.total}}',
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  fontWeight: StacFontWeight.w900,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                              StacSizedBox(width: 4),
                              StacText(
                                data: '{{appStrings.common.rial}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 16,
                                  color: '{{appColors.current.text.title}}',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  StacSizedBox(height: 16),

                  // Fees - Using appData fallback (might be empty/0 but safer than error)
                  StacContainer(
                    padding: StacEdgeInsets.all(16),
                    decoration: StacBoxDecoration(
                      color:
                          '{{appColors.current.background.surfaceContainer}}',
                      borderRadius: StacBorderRadius.all(8),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 0.5,
                      ),
                    ),
                    child: StacColumn(
                      children: [
                        StacRow(
                          textDirection: StacTextDirection.rtl,
                          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                          children: [
                            StacExpanded(
                              child: StacText(
                                data: '{{appStrings.promissory.stampDuty}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 14,
                                  color: '{{appColors.current.text.subtitle}}',
                                ),
                              ),
                            ),
                            StacSizedBox(width: 8),
                            StacText(
                              data:
                                  '{{promissory.fees.stampFee}} {{appStrings.common.rial}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 14,
                                fontWeight: StacFontWeight.w600,
                                color: '{{appColors.current.text.title}}',
                              ),
                            ),
                          ],
                        ),
                        StacSizedBox(height: 16),
                        StacRow(
                          textDirection: StacTextDirection.rtl,
                          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                          children: [
                            StacExpanded(
                              child: StacText(
                                data: '{{appStrings.promissory.issuanceFee}}',
                                textDirection: StacTextDirection.rtl,
                                style: StacCustomTextStyle(
                                  fontSize: 14,
                                  color: '{{appColors.current.text.subtitle}}',
                                ),
                              ),
                            ),
                            StacSizedBox(width: 8),
                            StacText(
                              data:
                                  '{{promissory.fees.wage}} {{appStrings.common.rial}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 14,
                                fontWeight: StacFontWeight.w600,
                                color: '{{appColors.current.text.title}}',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  StacSizedBox(height: 16),

                  // Payment Methods Title
                  StacText(
                    data: '{{appStrings.promissory.paymentMethod}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w700,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                  StacSizedBox(height: 16),

                  // Wallet Payment Option
                  StacGestureDetector(
                    onTap: StacSequenceAction(
                      actions: [
                        StacCustomSetValueAction(
                          key: 'selectedPaymentMethod',
                          value: 'wallet',
                        ),
                        StacCustomSetValueAction(
                          key: 'isPayEnabled',
                          value: true,
                        ),
                        StacCustomSetValueAction(
                          key: 'isDepositSelected',
                          value: false,
                        ),
                        StacCustomSetValueAction(
                          key: 'isWalletSelected',
                          value: true,
                        ),
                      ],
                    ),
                    child: StacContainer(
                      padding: StacEdgeInsets.all(16),
                      decoration: StacBoxDecoration(
                        color:
                        '{{isWalletSelected ? appColors.current.lightSecondery.color : appColors.current.background.surfaceContainer}}',
                        borderRadius: StacBorderRadius.all(12),
                        border: StacBorder.all(
                          color:
                              '{{isWalletSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
                          width: 1,
                        ),
                      ),
                      child: StacRow(
                        textDirection: StacTextDirection.rtl,
                        children: [
                          // Icon
                          StacContainer(
                            decoration: StacBoxDecoration(
                              color: '{{appColors.current.background.surfaceContainer}}',
                              borderRadius: StacBorderRadius.all(25)
                            ),
                            child: StacImage(
                              src: 'assets/icons/ic_wallet.svg',
                              imageType: StacImageType.asset,
                              width: 32,
                              height: 32,
                            ),
                          ),
                          StacSizedBox(width: 6),
                          StacText(
                            data: '{{appStrings.promissory.walletPayment}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 16,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(width: 12),
                          // Text
                          StacExpanded(
                            child: StacColumn(
                              crossAxisAlignment: StacCrossAxisAlignment.start,
                              children: [
                                StacSizedBox(height: 4),
                                StacText(
                                  data: '2370000 {{appStrings.common.rial}}',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
                                    fontSize: 12,
                                    color:
                                        '{{appColors.current.text.subtitle}}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  StacSizedBox(height: 12),

                  // Deposit Payment Option
                  StacGestureDetector(
                    onTap: StacSequenceAction(
                      actions: [
                        StacCustomSetValueAction(
                          key: 'selectedPaymentMethod',
                          value: 'deposit',
                        ),
                        StacCustomSetValueAction(
                          key: 'isPayEnabled',
                          value: true,
                        ),
                        StacCustomSetValueAction(
                          key: 'isWalletSelected',
                          value: false,
                        ),
                        StacCustomSetValueAction(
                          key: 'isDepositSelected',
                          value: true,
                        ),
                      ],
                    ),
                    child: StacContainer(
                      padding: StacEdgeInsets.all(16),
                      decoration: StacBoxDecoration(
                        color:
                        '{{isDepositSelected ? appColors.current.lightSecondery.color : appColors.current.background.surfaceContainer}}',
                        borderRadius: StacBorderRadius.all(12),
                        border: StacBorder.all(
                          color:
                              '{{isDepositSelected ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
                          width: 1,
                        ),
                      ),
                      child: StacRow(
                        textDirection: StacTextDirection.rtl,
                        children: [
                          // Icon
                          StacContainer(
                            decoration: StacBoxDecoration(
                                color: '{{appColors.current.background.surfaceContainer}}',
                                borderRadius: StacBorderRadius.all(25)
                            ),
                            child: StacImage(
                              src: 'assets/icons/ic_gateway.svg',
                              imageType: StacImageType.asset,
                              width: 32,
                              height: 32,
                            ),
                          ),
                          StacSizedBox(width: 6),
                          StacText(
                            data: '{{appStrings.promissory.depositPayment}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 16,
                              fontWeight: StacFontWeight.w600,
                              color: '{{appColors.current.text.title}}',
                            ),
                          ),
                          StacSizedBox(width: 12),
                          // Text
                          StacExpanded(
                            child: StacColumn(
                              crossAxisAlignment: StacCrossAxisAlignment.start,
                              children: [
                                StacSizedBox(height: 4),
                                StacText(
                                  data: '',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
                                    fontSize: 12,
                                    color:
                                        '{{appColors.current.text.subtitle}}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StacSizedBox(height: 12),
                ],
              ),
            ),
          ),
          // Pay Button (Wallet Action - Default)
          StacRawJsonWidget({
            'type': 'container',
            'height': '{{isDepositSelected ? 0 : 88}}',
            'clipBehavior': 'hardEdge',
            'decoration': StacBoxDecoration(color: 'transparent').toJson(),
            'child': StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isPayEnabled',
                'enabled': false,
                'onPressed': StacRawJsonAction({
                  'actionType': 'showDialog',
                  'widget': StacAlertDialog(
                    title: StacText(
                      data: '{{appStrings.promissory.payConfirmTitle}}',
                      textDirection: StacTextDirection.rtl,
                    ),
                    content: StacText(
                      data: '{{appStrings.promissory.payConfirmMessage}}',
                      textDirection: StacTextDirection.rtl,
                    ),
                    actions: [
                      StacTextButton(
                        onPressed: StacRawJsonAction({
                          'actionType': 'closeDialog',
                        }),
                        child: StacText(
                          data: '{{appStrings.common.cancel}}',
                          textDirection: StacTextDirection.rtl,
                        ),
                      ),
                      StacTextButton(
                        onPressed: StacSequenceAction(
                          actions: [
                            StacRawJsonAction({'actionType': 'closeDialog'}),
                            {
                              'actionType': 'navigate',
                              'widgetType':
                                  'promissory_real_sign', // Updated Navigation
                              'navigationStyle': 'pushReplacement',
                            },
                          ],
                        ),
                        child: StacText(
                          data: '{{appStrings.common.confirm}}',
                          textDirection: StacTextDirection.rtl,
                        ),
                      ),
                    ],
                  ).toJson(),
                }).toJson(),
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.promissory.payAndSign}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ).toJson(),
          }),
          // Pay Button (Deposit Action)
          StacRawJsonWidget({
            'type': 'container',
            'height': '{{isDepositSelected ? 88 : 0}}',
            'clipBehavior': 'hardEdge',
            'decoration': StacBoxDecoration(color: 'transparent').toJson(),
            'child': StacPadding(
              padding: StacEdgeInsets.all(16),
              child: StacRawJsonWidget({
                'type': 'reactiveElevatedButton',
                'enabledKey': 'isPayEnabled',
                'enabled': false,
                'onPressed': {
                  'actionType': 'navigate',
                  'widgetType':
                      'promissory_real_payment_deposits', // Updated Navigation (Assuming this screen exists)
                  'navigationStyle': 'push',
                },
                'style': StacButtonStyle(
                  backgroundColor: '{{appColors.current.primary.color}}',
                  elevation: 0,
                  fixedSize: StacSize(999999, 56),
                  shape: StacRoundedRectangleBorder(
                    borderRadius: StacBorderRadius.all(12),
                  ),
                ).toJson(),
                'child': StacText(
                  data: '{{appStrings.promissory.payAndSign}}',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 18,
                    fontWeight: StacFontWeight.bold,
                    color: '{{appColors.current.primary.onPrimary}}',
                  ),
                ).toJson(),
              }),
            ).toJson(),
          }),
        ],
      ),
    ),
  );
}
