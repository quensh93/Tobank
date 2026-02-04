import 'package:stac_core/stac_core.dart';

/// Promissory Flow - Success Page
///
/// This screen displays the successful promissory issuance result:
/// 1. Success icon and message
/// 2. Promissory ID
/// 3. Transaction details (amount, type, time, payment method, tracking number)
/// 4. PDF section with preview and share options
/// 5. Return to home button
///
/// Reference: docs/promissory_docs/promissory_transaction_detail_page.dart
@StacScreen(screenName: 'promissory_success')
StacWidget promissorySuccess() {
  return StacStatefulWidget(
    // Load transaction details on init
    onInit: StacNetworkRequestAction(
      url: 'https://api.tobank.com/promissory_finalize',
      method: 'post',
      results: [
        {
          'statusCode': 200,
          'action': StacCustomSetValueAction(
            values: [
              {'key': 'promissoryId', 'value': '{{data.data.promissoryId}}'},
              {'key': 'transactionAmount', 'value': '{{data.data.amount}}'},
              {
                'key': 'transactionType',
                'value': '{{appStrings.promissory.issuanceTitle}}',
              },
              {
                'key': 'transactionTime',
                'value': '{{data.data.transactionTime}}',
              },
              {'key': 'paymentMethod', 'value': '{{form.payment_method}}'},
              {
                'key': 'trackingNumber',
                'value': '{{data.data.trackingNumber}}',
              },
            ],
          ).toJson(),
        },
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
                  // Success Icon
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

                  // Success Message
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
                  StacSizedBox(height: 8),
                  // Promissory ID
                  // StacText(
                  //   data:
                  //       '{{appStrings.promissory.promissoryIdLabel}}: {{promissoryId}}',
                  //   textDirection: StacTextDirection.rtl,
                  //   textAlign: StacTextAlign.center,
                  //   style: StacCustomTextStyle(
                  //     fontSize: 16,
                  //     color: '{{appColors.current.text.title}}',
                  //   ),
                  // ),
                  StacSizedBox(height: 24),

                  // Transaction Details Card
                  StacContainer(
                    width: 999999,
                    decoration: StacBoxDecoration(
                      color:
                          '{{appColors.current.background.surfaceContainer}}',
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
                          '{{paymentMethod}}',
                        ),
                        StacSizedBox(height: 16),
                        _buildDivider(),
                        StacSizedBox(height: 16),
                        _buildDetailRow(
                          '{{appStrings.promissory.trackingNumber}}',
                          '{{trackingNumber}}',
                        ),
                      ],
                    ),
                  ),
                  StacSizedBox(height: 16),

                  // PDF Section
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
                        // PDF Header Row
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
                                // Preview Button
                                StacGestureDetector(
                                  onTap: StacRawJsonAction({
                                    'actionType': 'log',
                                    'message':
                                        '{{appStrings.promissory.previewPdf}}',
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
                                // Share Button
                                StacGestureDetector(
                                  onTap: StacRawJsonAction({
                                    'actionType': 'log',
                                    'message':
                                        '{{appStrings.promissory.sharePdf}}',
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

/// Helper: Detail row
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

/// Helper: Divider
StacWidget _buildDivider() {
  return StacContainer(
    height: 1,
    color: '{{appColors.current.input.borderEnabled}}',
  );
}






// ==========================================
// Local Helper Classes (Inlined to avoid import issues)
// ==========================================

/// Dart builder for 'stateFull' STAC widgets.
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

/// Raw JSON widget helper
class StacRawJsonWidget implements StacWidget {
  final Map<String, dynamic> json;
  StacRawJsonWidget(this.json);

  @override
  Map<String, dynamic> get jsonData => json;

  @override
  Map<String, dynamic> toJson() => json;

  @override
  String get type => json['type'] as String;
  String? get id => json['id'] as String?;
}

/// Raw JSON action helper
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}

/// Builder for 'sequence' action.
class StacSequenceAction extends StacAction {
  final List<dynamic> actions;

  const StacSequenceAction({required this.actions});

  @override
  String get actionType => 'sequence';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'sequence',
      'actions': actions.map((a) {
        if (a is StacAction) return a.toJson();
        if (a is Map) return a;
        try {
          return a.toJson();
        } catch (_) {
          return a;
        }
      }).toList(),
    };
  }
}

/// Alias for StacSequenceAction as some files use StacMultiAction
typedef StacMultiAction = StacSequenceAction;

/// Builder for 'networkRequest' action.
class StacNetworkRequestAction extends StacAction {
  final String url;
  final String method;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? headers;
  final List<dynamic>? results;

  const StacNetworkRequestAction({
    required this.url,
    this.method = 'get',
    this.data,
    this.headers,
    this.results,
  });

  @override
  String get actionType => 'networkRequest';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'networkRequest',
      'url': url,
      'method': method,
      if (data != null) 'data': data,
      if (headers != null) 'headers': headers,
      if (results != null)
        'results': results!.map((r) {
          if (r is Map) {
            // Check if any values inside the map are StacAction objects and serialize them
            return r.map((key, value) {
              if (value is StacAction) {
                return MapEntry(key, value.toJson());
              }
              return MapEntry(key, value);
            }).cast<String, dynamic>();
          }
          try {
            return (r as dynamic).toJson();
          } catch (_) {
            return r;
          }
        }).toList(),
    };
  }
}

/// Builder for 'setValue' action.
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
    if (value is StacGetFormValueAction) {
      processedValue = value.toJson();
    } else if (value is StacAction) {
      processedValue = value.toJson();
    }
    return {'actionType': 'setValue', 'key': key, 'value': processedValue};
  }
}

/// Helper for 'getFormValue' action used inside setValue
class StacGetFormValueAction {
  final String id;

  const StacGetFormValueAction({required this.id});

  Map<String, dynamic> toJson() {
    return {'actionType': 'getFormValue', 'id': id};
  }
}

/// Custom class to support alias text styles
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

/// Builder for 'validateFields' action.
class StacValidateFieldsAction extends StacAction {
  final String resultKey;
  final List<Map<String, dynamic>> fields;

  const StacValidateFieldsAction({
    required this.resultKey,
    required this.fields,
  });

  @override
  String get actionType => 'validateFields';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'validateFields',
      'resultKey': resultKey,
      'fields': fields,
    };
  }
}

/// StacAction wrapper for Persian Date Picker
class StacPersianDatePickerAction extends StacAction {
  const StacPersianDatePickerAction({
    required this.formFieldId,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
  });

  final String formFieldId;
  final String? initialDate;
  final String? firstDate;
  final String? lastDate;
  final dynamic onDateSelected;

  @override
  String get actionType => 'persianDatePicker';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'persianDatePicker',
      'formFieldId': formFieldId,
      if (initialDate != null) 'initialDate': initialDate,
      if (firstDate != null) 'firstDate': firstDate,
      if (lastDate != null) 'lastDate': lastDate,
      if (onDateSelected != null) 'onDateSelected': onDateSelected is StacAction ? onDateSelected.toJson() : onDateSelected,
    };
  }
}

/// Builder for 'log' action.
class StacLogAction extends StacAction {
  final String message;
  final String? level;

  const StacLogAction({required this.message, this.level});

  @override
  String get actionType => 'log';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'log',
      'message': message,
      if (level != null) 'level': level,
    };
  }
}