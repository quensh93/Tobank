import 'package:flutter/material.dart';
import '../../../../core/helpers/logger.dart';
import '../../../registry/registry_notifier.dart';
import 'package:stac/stac.dart';

/// A generic reactive list view parser that reads data from a registry key,
/// iterates over it using an item template, and rebuilds when registry changes.
///
/// This parser handles its own template resolution for {{item.*}} and
/// {{isSelected}} placeholders — this is critical because the outer
/// StatefulWidgetParser would otherwise resolve (and destroy) these
/// placeholders before this parser gets a chance to use them.
///
/// To prevent StatefulWidgetParser from touching itemTemplate/onItemTap,
/// this parser stores the RAW template at parse time and resolves it
/// on each rebuild inside ValueListenableBuilder.
///
/// JSON usage:
/// ```json
/// {
///   "type": "reactiveListView",
///   "dataKey": "deposits.rawData",
///   "dataPath": "data",
///   "isLoadedKey": "deposits.isLoaded",
///   "errorKey": "deposits.error",
///   "itemIdField": "depositNumber",
///   "selectedIdKey": "selectedDepositId",
///   "itemTemplate": { ... template with {{item.*}} placeholders ... },
///   "onItemTap": { ... action template with {{item.*}} placeholders ... },
///   "separator": { "type": "sizedBox", "height": 16.0 },
///   "emptyWidget": { "type": "text", "data": "No items" },
///   "loadingWidget": { "type": "circularProgressIndicator" },
///   "errorWidget": { ... error template with {{error}} ... },
///   "padding": { "left": 16, "right": 16, "top": 8, "bottom": 8 }
/// }
/// ```
class ReactiveListViewParser extends StacParser<Map<String, dynamic>> {
  const ReactiveListViewParser();

  @override
  String get type => 'reactiveListView';

  @override
  Map<String, dynamic> getModel(Map<String, dynamic> json) => json;

  @override
  Widget parse(BuildContext context, Map<String, dynamic> model) {
    // IMPORTANT: We capture the raw model here. At this point,
    // StatefulWidgetParser has already resolved {{...}} in the model,
    // but our {{item.*}} / {{isSelected}} placeholders use the same
    // syntax. To solve this, we now handle tap actions PROGRAMMATICALLY
    // instead of relying on Stac's action system for item-level actions.
    return _ReactiveListViewWidget(model: model);
  }
}

class _ReactiveListViewWidget extends StatelessWidget {
  final Map<String, dynamic> model;

  const _ReactiveListViewWidget({required this.model});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: RegistryNotifier.instance.listenable,
      builder: (context, _, _) {
        final registry = StacRegistry.instance;

        // --- State management: loading / error ---
        final isLoadedKey = model['isLoadedKey'] as String?;
        final errorKey = model['errorKey'] as String?;

        // Check loading state
        if (isLoadedKey != null) {
          final isLoaded = registry.getValue(isLoadedKey);
          if (isLoaded != true) {
            final loadingWidget =
                model['loadingWidget'] as Map<String, dynamic>?;
            if (loadingWidget != null) {
              return Stac.fromJson(loadingWidget, context) ??
                  const Center(child: CircularProgressIndicator());
            }
            return const Center(child: CircularProgressIndicator());
          }
        }

        // Check error state
        if (errorKey != null) {
          final error = registry.getValue(errorKey);
          if (error != null && error.toString().isNotEmpty) {
            final errorWidget = model['errorWidget'] as Map<String, dynamic>?;
            if (errorWidget != null) {
              final resolvedError = _resolveErrorPlaceholders(
                _deepCopy(errorWidget),
                error.toString(),
              );
              return Stac.fromJson(resolvedError, context) ??
                  Center(child: Text(error.toString()));
            }
            return Center(child: Text(error.toString()));
          }
        }

        // --- Read raw data from registry ---
        final dataKey = model['dataKey'] as String? ?? '';
        final rawData = registry.getValue(dataKey);

        if (rawData == null) {
          return _buildEmptyWidget(context);
        }

        // Extract list from data using dataPath
        final dataPath = model['dataPath'] as String?;
        dynamic items = rawData;
        if (dataPath != null && dataPath.isNotEmpty && rawData is Map) {
          for (final segment in dataPath.split('.')) {
            if (items is Map && items.containsKey(segment)) {
              items = items[segment];
            } else {
              items = null;
              break;
            }
          }
        }

        if (items is! List || items.isEmpty) {
          return _buildEmptyWidget(context);
        }

        // Read selection state
        final selectedIdKey = model['selectedIdKey'] as String?;
        final selectedId = selectedIdKey != null
            ? registry.getValue(selectedIdKey)?.toString()
            : null;
        final itemIdField = model['itemIdField'] as String? ?? 'id';

        // Item template
        final itemTemplate = model['itemTemplate'] as Map<String, dynamic>?;
        if (itemTemplate == null) return const SizedBox.shrink();

        // On item tap action template
        final onItemTap = model['onItemTap'];

        // Separator
        final separator = model['separator'] as Map<String, dynamic>?;

        // Build children as Flutter widgets directly
        final children = <Widget>[];
        for (int i = 0; i < items.length; i++) {
          final item = items[i];
          if (item is! Map) continue;

          final itemId = item[itemIdField]?.toString() ?? '';
          final isSelected = selectedId != null && selectedId == itemId;

          // Create the resolved template for this item
          final resolvedTemplate = _applyItemData(
            itemTemplate,
            item,
            isSelected,
            i,
            items.length,
          );

          // Build the resolved template into a Flutter widget
          Widget? itemWidget = Stac.fromJson(resolvedTemplate, context);
          if (itemWidget == null) continue;

          // Wrap with GestureDetector for tap handling
          // We handle taps PROGRAMMATICALLY because the StatefulWidgetParser
          // would destroy {{item.*}} placeholders in onItemTap JSON.
          if (onItemTap != null) {
            final resolvedAction = _applyItemData(
              onItemTap is Map<String, dynamic>
                  ? onItemTap
                  : Map<String, dynamic>.from(onItemTap as Map),
              item,
              isSelected,
              i,
              items.length,
            );
            itemWidget = GestureDetector(
              onTap: () {
                AppLogger.dc(
                  LogCategory.stacWidget,
                  '📋 ReactiveListView: Item tapped (id=$itemId)',
                );
                // Debug: log item data for the tapped item
                AppLogger.dc(
                  LogCategory.stacWidget,
                  '📋 ReactiveListView: Item data keys=${(item).keys.toList()}',
                );
                AppLogger.dc(
                  LogCategory.stacWidget,
                  '📋 ReactiveListView: depositNumber=${item['depositNumber']}, depositIban=${item['depositIban']}',
                );
                // Debug: log the resolved action to see if {{item.*}} was replaced
                final actions = resolvedAction['actions'] as List?;
                if (actions != null && actions.isNotEmpty) {
                  for (int a = 0; a < actions.length && a < 3; a++) {
                    AppLogger.dc(
                      LogCategory.stacWidget,
                      '📋 ReactiveListView: resolvedAction[$a]=${actions[a]}',
                    );
                  }
                }
                              try {
                  Stac.onCallFromJson(resolvedAction, context);
                  // Log registry values after tap action completes
                  AppLogger.dc(
                    LogCategory.stacWidget,
                    '📋 ReactiveListView: POST-TAP registry selectedDeposit.depositNumber=${StacRegistry.instance.getValue('selectedDeposit.depositNumber')}, selectedDeposit.depositIban=${StacRegistry.instance.getValue('selectedDeposit.depositIban')}',
                  );
                } catch (e, stackTrace) {
                  AppLogger.e(
                    'ReactiveListView: Error executing onItemTap',
                    e,
                    stackTrace,
                  );
                }
              },
              behavior: HitTestBehavior.opaque,
              child: itemWidget,
            );
          }

          children.add(itemWidget);

          // Add separator between items (not after last)
          if (separator != null && i < items.length - 1) {
            final sepWidget = Stac.fromJson(
              Map<String, dynamic>.from(separator),
              context,
            );
            if (sepWidget != null) children.add(sepWidget);
          }
        }

        // Build the scroll view
        final padding = model['padding'] as Map<String, dynamic>?;
        EdgeInsets? edgeInsets;
        if (padding != null) {
          edgeInsets = EdgeInsets.only(
            left: (padding['left'] as num?)?.toDouble() ?? 0,
            top: (padding['top'] as num?)?.toDouble() ?? 0,
            right: (padding['right'] as num?)?.toDouble() ?? 0,
            bottom: (padding['bottom'] as num?)?.toDouble() ?? 0,
          );
        }

        return SingleChildScrollView(
          padding: edgeInsets,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        );
      },
    );
  }

  Widget _buildEmptyWidget(BuildContext context) {
    final emptyWidget = model['emptyWidget'] as Map<String, dynamic>?;
    if (emptyWidget != null) {
      return Stac.fromJson(emptyWidget, context) ?? const SizedBox.shrink();
    }
    return const SizedBox.shrink();
  }

  /// Resolves {{error}} placeholder in error widget template
  Map<String, dynamic> _resolveErrorPlaceholders(
    Map<String, dynamic> template,
    String errorMessage,
  ) {
    _processErrorRecursively(template, errorMessage);
    return template;
  }

  void _processErrorRecursively(dynamic template, String errorMessage) {
    if (template is Map) {
      for (final key in template.keys.toList()) {
        final value = template[key];
        if (value is String && value.contains('{{error}}')) {
          template[key] = value.replaceAll('{{error}}', errorMessage);
        } else if (value is Map || value is List) {
          _processErrorRecursively(value, errorMessage);
        }
      }
    } else if (template is List) {
      for (int i = 0; i < template.length; i++) {
        final value = template[i];
        if (value is String && value.contains('{{error}}')) {
          template[i] = value.replaceAll('{{error}}', errorMessage);
        } else if (value is Map || value is List) {
          _processErrorRecursively(value, errorMessage);
        }
      }
    }
  }

  /// Deep-resolves {{item.*}} and {{isSelected}} placeholders in a template
  /// using actual item data.
  Map<String, dynamic> _applyItemData(
    Map<String, dynamic> template,
    Map<dynamic, dynamic> item,
    bool isSelected,
    int index,
    int totalCount,
  ) {
    final json = _deepCopy(template);
    _processRecursively(json, item, isSelected, index, totalCount);
    return json;
  }

  Map<String, dynamic> _deepCopy(Map<String, dynamic> source) {
    return source.map((key, value) {
      if (value is Map<String, dynamic>) {
        return MapEntry(key, _deepCopy(value));
      } else if (value is Map) {
        return MapEntry(key, _deepCopy(Map<String, dynamic>.from(value)));
      } else if (value is List) {
        return MapEntry(key, _deepCopyList(value));
      } else {
        return MapEntry(key, value);
      }
    });
  }

  List<dynamic> _deepCopyList(List<dynamic> source) {
    return source.map((item) {
      if (item is Map<String, dynamic>) {
        return _deepCopy(item);
      } else if (item is Map) {
        return _deepCopy(Map<String, dynamic>.from(item));
      } else if (item is List) {
        return _deepCopyList(item);
      } else {
        return item;
      }
    }).toList();
  }

  void _processRecursively(
    dynamic template,
    Map<dynamic, dynamic> item,
    bool isSelected,
    int index,
    int totalCount,
  ) {
    if (template is Map) {
      for (final key in template.keys.toList()) {
        final value = template[key];
        if (value is String) {
          template[key] = _resolvePlaceholders(
            value,
            item,
            isSelected,
            index,
            totalCount,
          );
        } else if (value is Map || value is List) {
          _processRecursively(value, item, isSelected, index, totalCount);
        }
      }
    } else if (template is List) {
      for (int i = 0; i < template.length; i++) {
        final value = template[i];
        if (value is String) {
          template[i] = _resolvePlaceholders(
            value,
            item,
            isSelected,
            index,
            totalCount,
          );
        } else if (value is Map || value is List) {
          _processRecursively(value, item, isSelected, index, totalCount);
        }
      }
    }
  }

  /// Resolves placeholders in the format {{item.fieldName}}, {{isSelected}},
  /// {{index}}, {{totalCount}}, and ternary expressions like
  /// {{isSelected ? value1 : value2}}.
  dynamic _resolvePlaceholders(
    String text,
    Map<dynamic, dynamic> item,
    bool isSelected,
    int index,
    int totalCount,
  ) {
    if (!text.contains('{{') || !text.contains('}}')) return text;

    final regex = RegExp(r'\{\{([^}]+)\}\}');
    final matches = regex.allMatches(text).toList();
    if (matches.isEmpty) return text;

    // If entire string is a single expression, preserve the type
    if (matches.length == 1 && matches.first.group(0) == text) {
      final expr = matches.first.group(1)!.trim();
      return _evalExpr(expr, item, isSelected, index, totalCount);
    }

    // String interpolation for multiple expressions
    return text.replaceAllMapped(regex, (match) {
      final expr = match.group(1)!.trim();
      final value = _evalExpr(expr, item, isSelected, index, totalCount);
      return value?.toString() ?? match.group(0) ?? '';
    });
  }

  dynamic _evalExpr(
    String expr,
    Map<dynamic, dynamic> item,
    bool isSelected,
    int index,
    int totalCount,
  ) {
    // formatNumber(value): formats digits with thousands separators
    final formatNumberMatch = RegExp(r'^formatNumber\((.+)\)$').firstMatch(expr);
    if (formatNumberMatch != null) {
      final innerExpr = formatNumberMatch.group(1)!.trim();
      final rawValue = _lookupValue(innerExpr, item, isSelected, index, totalCount);
      return _formatNumber(rawValue);
    }

    // Handle ternary: "isSelected ? value1 : value2"
    final ternaryMatch = RegExp(
      r'^(.+?)\s*\?\s*(.+?)\s*:\s*(.+)$',
    ).firstMatch(expr);
    if (ternaryMatch != null) {
      final condition = ternaryMatch.group(1)!.trim();
      final trueValue = ternaryMatch.group(2)!.trim();
      final falseValue = ternaryMatch.group(3)!.trim();

      final condResult = _evalCondition(
        condition,
        item,
        isSelected,
        index,
        totalCount,
      );
      final resultExpr = condResult ? trueValue : falseValue;
      return _parseValue(resultExpr, item, isSelected, index, totalCount);
    }

    // Simple value lookup
    return _lookupValue(expr, item, isSelected, index, totalCount);
  }

  bool _evalCondition(
    String condition,
    Map<dynamic, dynamic> item,
    bool isSelected,
    int index,
    int totalCount,
  ) {
    // Handle negation
    if (condition.startsWith('!')) {
      final inner = condition.substring(1).trim();
      final value = _lookupValue(inner, item, isSelected, index, totalCount);
      return !_toBool(value);
    }
    final value = _lookupValue(condition, item, isSelected, index, totalCount);
    return _toBool(value);
  }

  dynamic _lookupValue(
    String expr,
    Map<dynamic, dynamic> item,
    bool isSelected,
    int index,
    int totalCount,
  ) {
    if (expr == 'isSelected') return isSelected;
    if (expr == 'index') return index;
    if (expr == 'totalCount') return totalCount;

    // item.fieldName
    if (expr.startsWith('item.')) {
      final field = expr.substring(5);
      return item[field];
    }

    // Fall through: return the expression as-is wrapped in {{}} so
    // the outer Stac framework can resolve it (e.g. appColors, appStrings)
    return '{{$expr}}';
  }

  String _formatNumber(dynamic value) {
    final input = value?.toString() ?? '';
    final digits = input.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return '';

    final buffer = StringBuffer();
    var count = 0;
    for (int i = digits.length - 1; i >= 0; i--) {
      buffer.write(digits[i]);
      count++;
      if (i > 0 && count % 3 == 0) {
        buffer.write(',');
      }
    }
    return buffer.toString().split('').reversed.join();
  }

  dynamic _parseValue(
    String value,
    Map<dynamic, dynamic> item,
    bool isSelected,
    int index,
    int totalCount,
  ) {
    if (value == 'true') return true;
    if (value == 'false') return false;
    if (value == 'null') return null;

    final intVal = int.tryParse(value);
    if (intVal != null) return intVal;

    final doubleVal = double.tryParse(value);
    if (doubleVal != null) return doubleVal;

    // Strip quotes
    if ((value.startsWith('"') && value.endsWith('"')) ||
        (value.startsWith("'") && value.endsWith("'"))) {
      return value.substring(1, value.length - 1);
    }

    // Try as a variable lookup
    return _lookupValue(value, item, isSelected, index, totalCount);
  }

  bool _toBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is String) {
      final lower = value.toLowerCase();
      return lower == 'true' || lower == '1';
    }
    if (value is num) return value != 0;
    return false;
  }
}
