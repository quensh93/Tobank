import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../utils/registry_notifier.dart';
import '../../builders/stac_stateful_widget.dart';
import '../../builders/stac_custom_actions.dart';

class PromissoryRealDepositsListParser
    extends StacParser<PromissoryRealDepositsListModel> {
  const PromissoryRealDepositsListParser();

  @override
  String get type => 'promissory_real_deposits_list';

  @override
  PromissoryRealDepositsListModel getModel(Map<String, dynamic> json) {
    return PromissoryRealDepositsListModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, PromissoryRealDepositsListModel model) {
    return _PromissoryRealDepositsListWidget(model: model);
  }
}

class PromissoryRealDepositsListModel {
  final Map<String, dynamic>? onContinue;
  final Map<String, dynamic>? onRetry;

  const PromissoryRealDepositsListModel({this.onContinue, this.onRetry});

  factory PromissoryRealDepositsListModel.fromJson(Map<String, dynamic> json) {
    return PromissoryRealDepositsListModel(
      onContinue: json['onContinue'] as Map<String, dynamic>?,
      onRetry: json['onRetry'] as Map<String, dynamic>?,
    );
  }
}

class _PromissoryRealDepositsListWidget extends StatelessWidget {
  final PromissoryRealDepositsListModel model;

  const _PromissoryRealDepositsListWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: RegistryNotifier.instance.listenable,
      builder: (context, _, __) {
        final registry = StacRegistry.instance;
        final isLoaded = registry.getValue('deposits.isLoaded') == true;
        final rawData = registry.getValue('deposits.rawData');
        final errorMessage = registry.getValue('deposits.error')?.toString();

        final StacWidget stacWidget;
        if (!isLoaded) {
          stacWidget = _buildLoadingScreen();
        } else {
          final deposits = _tryTransformDeposits(rawData);
          if (deposits == null) {
            stacWidget = _buildErrorScreen(
              message: errorMessage ?? 'خطا در بارگذاری اطلاعات سپرده‌ها',
              onRetry: model.onRetry,
            );
          } else {
            stacWidget = _buildDepositPageWithData(deposits, model.onContinue);
          }
        }

        return Stac.fromJson(stacWidget.toJson(), context) ??
            const SizedBox.shrink();
      },
    );
  }

  List<Map<String, String>>? _tryTransformDeposits(dynamic rawData) {
    try {
      if (rawData == null) return null;

      dynamic items = rawData;
      if (rawData is Map && rawData['data'] is List) {
        items = rawData['data'];
      }

      if (items is! List) return null;

      return items.map<Map<String, String>>((item) {
        if (item is Map) {
          final depositNumber = item['depositNumber']?.toString() ?? '';
          final depositTitle = item['depositTitle']?.toString() ?? 'سپرده';
          final depositIban = item['depositIban']?.toString() ?? '';

          return {
            'id': depositNumber,
            'title': depositTitle,
            'depositNumber': depositNumber,
            'shabaNumber': depositIban,
          };
        }
        return {
          'id': '',
          'title': 'سپرده',
          'depositNumber': '',
          'shabaNumber': '',
        };
      }).toList();
    } catch (_) {
      return null;
    }
  }

  StacWidget _buildLoadingScreen() {
    return StacScaffold(
      appBar: StacAppBar(
        title: StacText(
          data: 'انتخاب سپرده',
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
      body: StacCenter(
        child: StacColumn(
          mainAxisSize: StacMainAxisSize.min,
          children: [
            StacCircularProgressIndicator(),
            StacSizedBox(height: 16),
            StacText(
              data: 'در حال دریافت لیست سپرده‌ها...',
              textDirection: StacTextDirection.rtl,
              style: StacCustomTextStyle(
                fontSize: 16,
                color: '{{appColors.current.text.subtitle}}',
              ),
            ),
          ],
        ),
      ),
    );
  }

  StacWidget _buildErrorScreen({
    required String message,
    Map<String, dynamic>? onRetry,
  }) {
    return StacRawJsonWidget({
      'type': 'scaffold',
      'appBar': {
        'type': 'appBar',
        'centerTitle': true,
        'title': {
          'type': 'text',
          'data': 'انتخاب سپرده',
          'textDirection': 'rtl',
          'style': {'type': 'alias', 'value': '{{appStyles.appbarStyle}}'},
        },
        'leading': {
          'type': 'iconButton',
          'onPressed': {'actionType': 'navigate', 'navigationStyle': 'pop'},
          'icon': {
            'type': 'image',
            'src': 'assets/icons/ic_right_arrow.svg',
            'imageType': 'asset',
            'width': 24.0,
            'height': 24.0,
            'color': '{{appColors.current.text.title}}',
          },
        },
      },
      'body': {
        'type': 'center',
        'child': {
          'type': 'column',
          'mainAxisAlignment': 'center',
          'children': [
            {
              'type': 'padding',
              'padding': {
                'left': 16.0,
                'top': 16.0,
                'right': 16.0,
                'bottom': 16.0,
              },
              'child': {
                'type': 'text',
                'data': message,
                'textDirection': 'rtl',
                'textAlign': 'center',
                'style': {
                  'type': 'custom',
                  'fontSize': 14.0,
                  'color': '{{appColors.current.text.subtitle}}',
                },
              },
            },
            if (onRetry != null) ...[
              {'type': 'sizedBox', 'height': 16.0},
              {
                'type': 'elevatedButton',
                'onPressed': onRetry,
                'style': {
                  'type': 'buttonStyle',
                  'backgroundColor': '{{appColors.current.primary.color}}',
                  'shape': {
                    'type': 'roundedRectangleBorder',
                    'borderRadius': {'type': 'all', 'value': 12.0},
                  },
                },
                'child': {
                  'type': 'text',
                  'data': 'تلاش مجدد',
                  'style': {
                    'type': 'custom',
                    'color': 'white',
                    'fontWeight': 'bold',
                  },
                },
              },
            ],
          ],
        },
      },
    });
  }

  StacWidget _buildDepositPageWithData(
    List<Map<String, String>> deposits,
    Map<String, dynamic>? onContinueAction,
  ) {
    if (deposits.isEmpty) {
      return _buildLoadingScreen();
    }

    return StacStatefulWidget(
      onInit: StacRawJsonAction({
        'actionType': 'sequence',
        'actions': [
          ...deposits.asMap().entries.map((entry) {
            final index = entry.key;
            final id = entry.value['id'];
            return {
              'actionType': 'setValue',
              'key': 'isDeposit${index}Selected',
              'value': '{{form.selected_deposit_id == "$id"}}',
            };
          }),
          {
            'actionType': 'setValue',
            'key': 'hasSelection',
            'value': '{{form.selected_deposit_id ? true : false}}',
          },
        ],
      }),
      child: StacScaffold(
        appBar: StacAppBar(
          title: StacText(
            data: 'انتخاب سپرده',
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
        body: StacForm(
          autovalidateMode: StacAutovalidateMode.disabled,
          child: StacColumn(
            crossAxisAlignment: StacCrossAxisAlignment.stretch,
            children: [
              StacSizedBox(height: 24),
              StacPadding(
                padding: StacEdgeInsets.symmetric(horizontal: 16),
                child: StacText(
                  data: 'سپرده خود را جهت پرداخت انتخاب کنید',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 16,
                    fontWeight: StacFontWeight.w600,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ),
              StacSizedBox(height: 16),
              StacExpanded(
                child: StacSingleChildScrollView(
                  padding: StacEdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: StacColumn(
                    crossAxisAlignment: StacCrossAxisAlignment.stretch,
                    children: [
                      ...deposits.asMap().entries.map(
                        (entry) => StacColumn(
                          crossAxisAlignment: StacCrossAxisAlignment.stretch,
                          children: [
                            _buildDepositCard(
                              index: entry.key,
                              deposit: entry.value,
                              totalCount: deposits.length,
                            ),
                            if (entry.key < deposits.length - 1)
                              StacSizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              StacPadding(
                padding: StacEdgeInsets.all(16),
                child: StacRawJsonWidget({
                  'type': 'reactiveElevatedButton',
                  'enabledKey': 'hasSelection',
                  'onPressed': onContinueAction,
                  'style': StacButtonStyle(
                    backgroundColor: '{{appColors.current.primary.color}}',
                    elevation: 0,
                    fixedSize: StacSize(999999, 56),
                    shape: StacRoundedRectangleBorder(
                      borderRadius: StacBorderRadius.all(12),
                    ),
                  ).toJson(),
                  'child': StacText(
                    data: '{{appStrings.common.continue}}',
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 18,
                      fontWeight: StacFontWeight.bold,
                      color: '{{appColors.current.primary.onPrimary}}',
                    ),
                  ).toJson(),
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StacWidget _buildDepositCard({
    required int index,
    required Map<String, String> deposit,
    required int totalCount,
  }) {
    final String id = deposit['id'] ?? '';
    final String title = deposit['title'] ?? '';
    final String depositNumber = deposit['depositNumber'] ?? '';
    final String shabaNumber = deposit['shabaNumber'] ?? '';
    final String selectedKey = 'isDeposit${index}Selected';

    return StacGestureDetector(
      onTap: StacSequenceAction(
        actions: [
          ...List.generate(
            totalCount,
            (i) => StacCustomSetValueAction(
              key: 'isDeposit${i}Selected',
              value: false,
            ),
          ),
          StacCustomSetValueAction(key: selectedKey, value: true),
          StacCustomSetValueAction(key: 'hasSelection', value: true),
          StacCustomSetValueAction(key: 'form.selected_deposit_id', value: id),
          StacCustomSetValueAction(
            key: 'form.selected_deposit_title',
            value: title,
          ),
          StacCustomSetValueAction(
            key: 'form.selected_deposit_number',
            value: depositNumber,
          ),
          StacCustomSetValueAction(
            key: 'form.selected_shaba_number',
            value: shabaNumber,
          ),
        ],
      ),
      child: StacContainer(
        decoration: StacBoxDecoration(
          color: '{{appColors.current.background.surfaceContainer}}',
          borderRadius: StacBorderRadius.all(8),
          border: StacBorder.all(
            color:
                '{{$selectedKey ? appColors.current.secondary.color : appColors.current.input.borderEnabled}}',
            width: 1,
          ),
        ),
        padding: StacEdgeInsets.all(16),
        child: StacColumn(
          crossAxisAlignment: StacCrossAxisAlignment.stretch,
          children: [
            StacRow(
              textDirection: StacTextDirection.rtl,
              mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
              crossAxisAlignment: StacCrossAxisAlignment.center,
              children: [
                StacExpanded(
                  child: StacText(
                    data: title,
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 16,
                      fontWeight: StacFontWeight.w600,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ),
                StacContainer(
                  width: 24,
                  height: 24,
                  decoration: StacBoxDecoration(
                    shape: StacBoxShape.circle,
                    border: StacBorder.all(
                      color:
                          '{{$selectedKey ? appColors.current.secondary.color : appColors.current.text.subtitle}}',
                      width: 2,
                    ),
                  ),
                  child: StacCenter(
                    child: StacRawJsonWidget({
                      'type': 'opacity',
                      'opacity': '{{$selectedKey ? 1.0 : 0.0}}',
                      'child': StacContainer(
                        width: 12,
                        height: 12,
                        decoration: StacBoxDecoration(
                          shape: StacBoxShape.circle,
                          color: '{{appColors.current.secondary.color}}',
                        ),
                      ).toJson(),
                    }),
                  ),
                ),
              ],
            ),
            StacSizedBox(height: 12),
            StacContainer(
              height: 1,
              color: '{{appColors.current.input.borderEnabled}}',
            ),
            StacSizedBox(height: 12),
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacText(
                  data: 'شماره سپرده: ',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacText(
                  data: depositNumber,
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w500,
                    color: '{{appColors.current.text.title}}',
                  ),
                ),
              ],
            ),
            StacSizedBox(height: 8),
            StacRow(
              textDirection: StacTextDirection.rtl,
              children: [
                StacText(
                  data: 'شماره شبا: ',
                  textDirection: StacTextDirection.rtl,
                  style: StacCustomTextStyle(
                    fontSize: 14,
                    fontWeight: StacFontWeight.w400,
                    color: '{{appColors.current.text.subtitle}}',
                  ),
                ),
                StacExpanded(
                  child: StacText(
                    data: shabaNumber,
                    textDirection: StacTextDirection.rtl,
                    style: StacCustomTextStyle(
                      fontSize: 14,
                      fontWeight: StacFontWeight.w500,
                      color: '{{appColors.current.text.title}}',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);
  @override
  StacTextStyleType get type => StacTextStyleType.custom;
  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}

class StacRawJsonWidget implements StacWidget {
  final Map<String, dynamic> json;
  StacRawJsonWidget(this.json);

  @override
  Map<String, dynamic> get jsonData => json;

  @override
  Map<String, dynamic> toJson() => json;

  @override
  String get type => json['type'] as String;
}

class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}
