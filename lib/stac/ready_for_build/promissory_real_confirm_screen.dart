import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'promissory_real_confirm')
StacWidget promissoryRealConfirm() {
  return StacScaffold(
    appBar: StacAppBar(
      title: StacText(
        data: '{{appStrings.promissory.issuanceTitle}}',
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
                StacContainer(
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
                              data: '{{appStrings.promissory.amountLabel}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 14,
                                color: '{{appColors.current.text.subtitle}}',
                              ),
                            ),
                            StacText(
                              data:
                                  '{{form.promissory_amount}} {{appStrings.common.rial}}',
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
                      StacSizedBox(height: 4),
                      StacPadding(
                        padding: StacEdgeInsets.only(bottom: 8),
                        child: StacRow(
                          textDirection: StacTextDirection.rtl,
                          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                          children: [
                            StacText(
                              data: '{{appStrings.promissory.payDate}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 14,
                                color: '{{appColors.current.text.subtitle}}',
                              ),
                            ),
                            StacText(
                              data: '{{form.promissory_due_date}}',
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
                      StacSizedBox(height: 4),
                      StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.end,
                        children: [
                          StacText(
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
                            data: '{{appStrings.promissory.paymentPlaceLabel}}',
                            textDirection: StacTextDirection.rtl,
                            style: StacCustomTextStyle(
                              fontSize: 14,
                              color: '{{appColors.current.text.subtitle}}',
                            ),
                          ),
                          StacSizedBox(height: 5),
                          StacText(
                            data: '{{form.promissory_payment_place}}',
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
                ),
                StacSizedBox(height: 16),
                StacContainer(
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
                              data: '{{appStrings.promissory.fullName}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 14,
                                color: '{{appColors.current.text.subtitle}}',
                              ),
                            ),
                            StacText(
                              data: '{{userData.fullName}}',
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
                      StacSizedBox(height: 4),
                      StacColumn(
                        crossAxisAlignment: StacCrossAxisAlignment.end,
                        children: [
                          StacText(
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
                ),
                StacSizedBox(height: 16),
                StacContainer(
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
                      StacPadding(
                        padding: StacEdgeInsets.only(bottom: 8),
                        child: StacRow(
                          textDirection: StacTextDirection.rtl,
                          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                          children: [
                            StacText(
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
                      ),
                      StacPadding(
                        padding: StacEdgeInsets.only(bottom: 8),
                        child: StacRow(
                          textDirection: StacTextDirection.rtl,
                          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                          children: [
                            StacText(
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
                      ),
                      StacPadding(
                        padding: StacEdgeInsets.only(bottom: 8),
                        child: StacRow(
                          textDirection: StacTextDirection.rtl,
                          mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
                          children: [
                            StacText(
                              data: '{{appStrings.promissory.fullName}}',
                              textDirection: StacTextDirection.rtl,
                              style: StacCustomTextStyle(
                                fontSize: 14,
                                color: '{{appColors.current.text.subtitle}}',
                              ),
                            ),
                            StacText(
                              data: '{{receiverIdentity.fullName}}',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        StacPadding(
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
            onPressed: StacRawJsonAction({
              'actionType': 'navigate',
              'widgetType': 'promissory_real_payment',
              'navigationStyle': 'push',
            }),
            child: StacText(
              data: '{{appStrings.promissory.confirmAndPay}}',
              style: StacCustomTextStyle(
                fontSize: 18,
                fontWeight: StacFontWeight.bold,
                color: '{{appColors.current.primary.onPrimary}}',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);
  @override
  String get actionType => json['actionType'] as String;
  @override
  Map<String, dynamic> toJson() => json;
}
