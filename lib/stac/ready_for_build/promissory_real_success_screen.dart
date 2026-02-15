import 'package:stac_core/stac_core.dart';

@StacScreen(screenName: 'promissory_real_success')
StacWidget promissoryRealSuccess() {
  return StacStatefulWidget(
    onInit: StacCustomSetValueAction(
      values: [
        {
          'key': 'transactionType',
          'value': '{{appStrings.promissory.issuanceTitle}}',
        },
        {'key': 'paymentMethod', 'value': '{{selectedPaymentMethod}}'},
      ],
    ),
    child: StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: '{{appStrings.promissory.successTitle}}',
          textDirection: StacTextDirection.rtl,
          style: StacAliasTextStyle('{{appStyles.appbarStyle}}'),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: StacColumn(
        crossAxisAlignment: StacCrossAxisAlignment.stretch,
        textDirection: StacTextDirection.rtl,
        children: [
          StacExpanded(
            child: StacSingleChildScrollView(
              padding: StacEdgeInsets.all(16),
              child: StacColumn(
                crossAxisAlignment: StacCrossAxisAlignment.center,
                textDirection: StacTextDirection.rtl,
                children: [
                  StacSizedBox(height: 24),
                  StacContainer(
                    width: 80,
                    height: 80,
                    decoration: StacBoxDecoration(
                      color: '{{appColors.current.success.color}}20',
                      borderRadius: StacBorderRadius.all(40),
                    ),
                    child: StacCenter(
                      child: StacImage(
                        src: 'assets/icons/ic_check_circle.svg',
                        imageType: StacImageType.asset,
                        width: 56,
                        height: 56,
                        color: '{{appColors.current.success.color}}',
                      ),
                    ),
                  ),
                  StacSizedBox(height: 16),
                  StacText(
                    data: '{{appStrings.promissory.paymentSuccessful}}',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.bold,
                      color: '{{appColors.current.success.color}}',
                    ),
                  ),
                  StacSizedBox(height: 8),
                  StacText(
                    data: '{{appStrings.promissory.successMessage}}',
                    textDirection: StacTextDirection.rtl,
                    textAlign: StacTextAlign.center,
                    style: StacCustomTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.subtitle}}',
                    ),
                  ),
                  StacSizedBox(height: 24),
                  StacContainer(
                    width: 999999,
                    decoration: StacBoxDecoration(
                      color: '{{appColors.current.background.surfaceContainer}}',
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
                        _buildDetailRow(
                          '{{appStrings.promissory.paidAmount}}',
                          '{{transactionAmount}} {{appStrings.common.rial}}',
                        ),
                        StacSizedBox(height: 16),
                        _buildDivider(),
                        StacSizedBox(height: 16),
                        _buildDetailRow(
                          '{{appStrings.promissory.transactionType}}',
                          '{{transactionType}}',
                        ),
                        StacSizedBox(height: 16),
                        _buildDivider(),
                        StacSizedBox(height: 16),
                        _buildDetailRow(
                          '{{appStrings.promissory.transactionTime}}',
                          '{{transactionTime}}',
                        ),
                        StacSizedBox(height: 16),
                        _buildDivider(),
                        StacSizedBox(height: 16),
                        _buildDetailRow(
                          '{{appStrings.promissory.paidVia}}',
                          'حساب بانکی',
                        ),
                        StacSizedBox(height: 16),
                        _buildDivider(),
                        StacSizedBox(height: 16),
                        _buildDetailRow(
                          '{{appStrings.promissory.trackingNumber}}',
                          '{{requestId}}',
                        ),
                      ],
                    ),
                  ),
                  StacSizedBox(height: 16),
                  StacContainer(
                    width: 999999,
                    margin: StacEdgeInsets.symmetric(horizontal: 0),
                    decoration: StacBoxDecoration(
                      borderRadius: StacBorderRadius.all(8),
                      border: StacBorder.all(
                        color: '{{appColors.current.input.borderEnabled}}',
                        width: 1,
                      ),
                    ),
                    padding: StacEdgeInsets.all(16),
                    child: StacColumn(
                      crossAxisAlignment: StacCrossAxisAlignment.start,
                      textDirection: StacTextDirection.rtl,
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
                                  data: '{{appStrings.promissory.promissory}}',
                                  textDirection: StacTextDirection.rtl,
                                  style: StacCustomTextStyle(
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
                                  onTap: StacRawJsonAction({
                                    'actionType': 'log',
                                    'message': 'Preview PDF',
                                  }),
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
                                  onTap: StacRawJsonAction({
                                    'actionType': 'log',
                                    'message': 'Share PDF',
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
                        _buildDivider(),
                        StacSizedBox(height: 8),
                        StacText(
                          data: '{{appStrings.promissory.downloadMessage}}',
                          textDirection: StacTextDirection.rtl,
                          style: StacCustomTextStyle(
                            fontSize: 14,
                            fontWeight: StacFontWeight.w500,
                            color: '{{appColors.current.text.subtitle}}',
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

StacWidget _buildDetailRow(String label, String value) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacExpanded(
        child: StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ),
      StacSizedBox(width: 16),
      StacExpanded(
        child: StacText(
          data: value,
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
  );
}

StacWidget _buildDivider() {
  return StacContainer(
    height: 1,
    decoration: StacBoxDecoration(
      color: '{{appColors.current.input.borderEnabled}}',
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

class StacStatefulWidget extends StacWidget {
  final dynamic onInit;
  final dynamic onBuild;
  final dynamic onDependenciesChanged;
  final dynamic onWidgetUpdated;
  final dynamic onReassemble;
  final dynamic onDeactivate;
  final dynamic onDispose;
  final dynamic onResume;
  final dynamic onPause;
  final dynamic onInactive;
  final dynamic onHidden;
  final dynamic onDetached;
  final StacWidget child;
  const StacStatefulWidget({
    this.onInit,
    this.onBuild,
    this.onDependenciesChanged,
    this.onWidgetUpdated,
    this.onReassemble,
    this.onDeactivate,
    this.onDispose,
    this.onResume,
    this.onPause,
    this.onInactive,
    this.onHidden,
    this.onDetached,
    required this.child,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': 'stateFull',
      if (onInit != null) 'onInit': _actionToJson(onInit),
      if (onBuild != null) 'onBuild': _actionToJson(onBuild),
      if (onDependenciesChanged != null)
        'onDependenciesChanged': _actionToJson(onDependenciesChanged),
      if (onWidgetUpdated != null)
        'onWidgetUpdated': _actionToJson(onWidgetUpdated),
      if (onReassemble != null) 'onReassemble': _actionToJson(onReassemble),
      if (onDeactivate != null) 'onDeactivate': _actionToJson(onDeactivate),
      if (onDispose != null) 'onDispose': _actionToJson(onDispose),
      if (onResume != null) 'onResume': _actionToJson(onResume),
      if (onPause != null) 'onPause': _actionToJson(onPause),
      if (onInactive != null) 'onInactive': _actionToJson(onInactive),
      if (onHidden != null) 'onHidden': _actionToJson(onHidden),
      if (onDetached != null) 'onDetached': _actionToJson(onDetached),
      'child': child.toJson(),
    };
  }
  dynamic _actionToJson(dynamic action) {
    if (action == null) return null;
    if (action is Map) return action;
    try {
      return action.toJson();
    } catch (e) {
      return action;
    }
  }
}

class StacCustomSetValueAction extends StacAction {
  final String? key;
  final dynamic value;
  final List<Map<String, dynamic>>? values;
  const StacCustomSetValueAction({this.key, this.value, this.values});
  @override
  String get actionType => 'setValue';
  @override
  Map<String, dynamic> toJson() {
    if (values != null) {
      return {'actionType': 'setValue', 'values': values};
    }
    dynamic processedValue = value;
    if (value is StacAction) {
      processedValue = value.toJson();
    }
    return {'actionType': 'setValue', 'key': key, 'value': processedValue};
  }
}
