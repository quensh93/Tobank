import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';
import '../../../registry/text_form_field_controller_registry.dart';

class ShowCardExpireSelectBottomSheetActionModel {
  final String formFieldId;
  final String? yearFieldId;
  final String? monthFieldId;
  final String title;
  final String monthTitle;
  final String yearTitle;
  final String confirmText;
  final List<String> monthOptions;
  final List<String> yearOptions;
  final Map<String, dynamic>? onSelectedAction;

  const ShowCardExpireSelectBottomSheetActionModel({
    required this.formFieldId,
    this.yearFieldId,
    this.monthFieldId,
    required this.title,
    required this.monthTitle,
    required this.yearTitle,
    required this.confirmText,
    required this.monthOptions,
    required this.yearOptions,
    this.onSelectedAction,
  });

  factory ShowCardExpireSelectBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    List<String> parseList(dynamic raw) {
      final values = <String>[];
      if (raw is List) {
        for (final item in raw) {
          if (item == null) continue;
          final text = item.toString().trim();
          if (text.isNotEmpty) values.add(text);
        }
      }
      return values;
    }

    final months = parseList(json['monthOptions']);
    final years = parseList(json['yearOptions']);

    return ShowCardExpireSelectBottomSheetActionModel(
      formFieldId: json['formFieldId'] as String? ?? 'cardExpireInput',
      yearFieldId: json['yearFieldId'] as String?,
      monthFieldId: json['monthFieldId'] as String?,
      title: json['title'] as String? ?? 'تاریخ انقضای کارت را انتخاب نمایید',
      monthTitle: json['monthTitle'] as String? ?? 'ماه',
      yearTitle: json['yearTitle'] as String? ?? 'سال',
      confirmText: json['confirmText'] as String? ?? 'تایید',
      monthOptions: months.isEmpty
          ? List<String>.generate(12, (i) => (i + 1).toString().padLeft(2, '0'))
          : months,
      yearOptions: years.isEmpty
          ? List<String>.generate(11, (i) => (1405 + i).toString())
          : years,
      onSelectedAction: json['onSelectedAction'] is Map<String, dynamic>
          ? json['onSelectedAction'] as Map<String, dynamic>
          : json['onSelectedAction'] is Map
          ? Map<String, dynamic>.from(json['onSelectedAction'] as Map)
          : null,
    );
  }
}

class ShowCardExpireSelectBottomSheetActionParser
    extends StacActionParser<ShowCardExpireSelectBottomSheetActionModel> {
  const ShowCardExpireSelectBottomSheetActionParser();

  @override
  String get actionType => 'showCardExpireSelectBottomSheet';

  @override
  ShowCardExpireSelectBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowCardExpireSelectBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowCardExpireSelectBottomSheetActionModel model,
  ) async {
    if (!context.mounted) return;
    final actionContext = context;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final initial = _readInitialValue(actionContext, model.formFieldId);
    String? selectedMonth = initial.$1;
    String? selectedYear = initial.$2;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.62),
      builder: (bottomSheetContext) {
        final safeBottom = MediaQuery.of(bottomSheetContext).padding.bottom;
        final maxHeight = MediaQuery.sizeOf(bottomSheetContext).height * 0.88;

        return SafeArea(
          top: false,
          bottom: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: StatefulBuilder(
              builder: (sheetContext, setState) {
                Widget buildTile({
                  required String value,
                  required bool selected,
                  required VoidCallback onTap,
                }) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: onTap,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: selected
                            ? const Color(0xFF11B9C3).withValues(alpha: 0.18)
                            : colorScheme.surface,
                        border: Border.all(
                          color: selected
                              ? const Color(0xFF11B9C3)
                              : colorScheme.outlineVariant.withValues(
                                  alpha: 0.45,
                                ),
                          width: selected ? 2 : 1.4,
                        ),
                      ),
                      child: Text(
                        _toPersianDigits(value),
                        textDirection: TextDirection.rtl,
                        style: textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  );
                }

                return Container(
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, safeBottom + 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Container(
                            width: 46,
                            height: 6,
                            decoration: BoxDecoration(
                              color: colorScheme.outlineVariant.withValues(
                                alpha: 0.45,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        Text(
                          model.title,
                          textAlign: TextAlign.right,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                  ),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          model.monthTitle,
                                          textAlign: TextAlign.center,
                                          style: textTheme.titleLarge?.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          model.yearTitle,
                                          textAlign: TextAlign.center,
                                          style: textTheme.titleLarge?.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: model.monthOptions.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 12,
                                              crossAxisSpacing: 12,
                                              childAspectRatio: 1.1,
                                            ),
                                        itemBuilder: (context, index) {
                                          final month =
                                              model.monthOptions[index];
                                          return buildTile(
                                            value: month,
                                            selected: selectedMonth == month,
                                            onTap: () {
                                              setState(() {
                                                selectedMonth = month;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: model.yearOptions.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 12,
                                              crossAxisSpacing: 12,
                                              childAspectRatio: 1.1,
                                            ),
                                        itemBuilder: (sheetContext, index) {
                                          final year = model.yearOptions[index];
                                          return buildTile(
                                            value: year,
                                            selected: selectedYear == year,
                                            onTap: () {
                                              setState(() {
                                                selectedYear = year;
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed:
                              (selectedMonth == null || selectedYear == null)
                              ? null
                              : () async {
                                  final month = selectedMonth!;
                                  final year4 = selectedYear!;
                                  final year2 = year4.length >= 2
                                      ? year4.substring(year4.length - 2)
                                      : year4;
                                  final value =
                                      '${_toPersianDigits(year2)}/${_toPersianDigits(month)}';

                                  _updateFormField(
                                    context: actionContext,
                                    fieldId: model.formFieldId,
                                    value: value,
                                  );

                                  // Write to separate year/month fields if provided
                                  if (model.yearFieldId != null) {
                                    _updateFormField(
                                      context: actionContext,
                                      fieldId: model.yearFieldId!,
                                      value: _toPersianDigits(year2),
                                    );
                                  }
                                  if (model.monthFieldId != null) {
                                    _updateFormField(
                                      context: actionContext,
                                      fieldId: model.monthFieldId!,
                                      value: _toPersianDigits(month),
                                    );
                                  }

                                  RegistryNotifier.instance.notify();
                                  if (bottomSheetContext.mounted) {
                                    Navigator.of(bottomSheetContext).pop();
                                  }

                                  if (!actionContext.mounted) return;
                                  if (model.onSelectedAction != null) {
                                    await Stac.onCallFromJson(
                                      model.onSelectedAction!,
                                      actionContext,
                                    );
                                  }
                                },
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(58),
                            backgroundColor: const Color(0xFFD61F2C),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                colorScheme.surfaceContainerHighest,
                            disabledForegroundColor:
                                colorScheme.onSurfaceVariant,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            model.confirmText,
                            style: textTheme.titleMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

(String?, String?) _readInitialValue(BuildContext context, String fieldId) {
  String raw = '';
  final controller = TextFormFieldControllerRegistry.instance.get(fieldId);
  if (controller != null && controller.text.trim().isNotEmpty) {
    raw = controller.text.trim();
  }

  if (raw.isEmpty) {
    try {
      final formScope = StacFormScope.of(context);
      raw = formScope?.formData[fieldId]?.toString().trim() ?? '';
    } catch (_) {
      // Ignore
    }
  }

  final normalized = _toEnglishDigits(raw);
  final parts = normalized.split('/');
  if (parts.length != 2) return (null, null);
  final yy = parts[0].padLeft(2, '0');
  final month = parts[1].padLeft(2, '0');
  if (!RegExp(r'^\d{2}$').hasMatch(month) || !RegExp(r'^\d{2}$').hasMatch(yy)) {
    return (null, null);
  }
  final year = yy == '99' ? '13$yy' : '14$yy';
  return (month, year);
}

void _updateFormField({
  required BuildContext context,
  required String fieldId,
  required String value,
}) {
  TextFormFieldControllerRegistry.instance.updateValue(fieldId, value);
  try {
    final formScope = StacFormScope.of(context);
    formScope?.formData[fieldId] = value;
  } catch (_) {
    // Ignore
  }
  StacRegistry.instance.setValue('form.$fieldId', value);
}

String _toPersianDigits(String input) {
  const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  var output = input;
  for (var i = 0; i < 10; i++) {
    output = output.replaceAll(en[i], fa[i]);
  }
  return output;
}

String _toEnglishDigits(String input) {
  const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  const ar = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  var output = input;
  for (var i = 0; i < 10; i++) {
    output = output.replaceAll(fa[i], '$i');
    output = output.replaceAll(ar[i], '$i');
  }
  return output;
}

void registerShowCardExpireSelectBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowCardExpireSelectBottomSheetActionParser(),
  );
}
