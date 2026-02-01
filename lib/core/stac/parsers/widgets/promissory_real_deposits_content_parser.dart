import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../helpers/logger.dart';
import '../../utils/registry_notifier.dart';
import '../../../../stac/tobank/flows/promissory/dart/request_promissory_deposit_page.dart';

class PromissoryRealDepositsContentParser extends StacParser<Map<String, dynamic>> {
  const PromissoryRealDepositsContentParser();

  @override
  String get type => 'promissory_real_deposits_content';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  Widget parse(BuildContext context, Map<String, dynamic> model) {
    return ValueListenableBuilder<int>(
      valueListenable: RegistryNotifier.instance.listenable,
      builder: (context, version, child) {
        final isLoaded = StacRegistry.instance.getValue('deposits.isLoaded') == true;
        final rawData = StacRegistry.instance.getValue('deposits.rawData');
        final errorMessage = StacRegistry.instance.getValue('deposits.error')?.toString();

        if (!isLoaded) {
          final stacWidget = requestPromissoryDepositPage(deposits: const []);
          return Stac.fromJson(stacWidget.toJson(), context) ?? const SizedBox.shrink();
        }

        final deposits = _tryTransformDeposits(rawData);
        if (deposits == null) {
          final stacWidget = _buildErrorScreen(
            message: errorMessage ?? 'خطا در بارگذاری اطلاعات سپرده‌ها',
          );
          return Stac.fromJson(stacWidget, context) ?? const SizedBox.shrink();
        }

        final stacWidget = requestPromissoryDepositPage(deposits: deposits);
        return Stac.fromJson(stacWidget.toJson(), context) ?? const SizedBox.shrink();
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
    } catch (e, st) {
      AppLogger.e('Failed to transform deposits.rawData: $e\n$st');
      return null;
    }
  }

  Map<String, dynamic> _buildErrorScreen({required String message}) {
    return {
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
          'type': 'padding',
          'padding': {'left': 16.0, 'top': 16.0, 'right': 16.0, 'bottom': 16.0},
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
      },
    };
  }
}
