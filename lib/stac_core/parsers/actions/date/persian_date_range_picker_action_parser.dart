import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../registry/custom_component_registry.dart';

class PersianDateRangePickerActionModel {
  final String startDateKey;
  final String endDateKey;
  final String? firstDate;
  final String? lastDate;
  final String? helpText;
  final String? confirmText;
  final String? cancelText;
  final Map<String, dynamic>? onDateSelected;

  const PersianDateRangePickerActionModel({
    required this.startDateKey,
    required this.endDateKey,
    this.firstDate,
    this.lastDate,
    this.helpText,
    this.confirmText,
    this.cancelText,
    this.onDateSelected,
  });

  factory PersianDateRangePickerActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return PersianDateRangePickerActionModel(
      startDateKey: json['startDateKey'] as String,
      endDateKey: json['endDateKey'] as String,
      firstDate: json['firstDate'] as String?,
      lastDate: json['lastDate'] as String?,
      helpText: json['helpText'] as String?,
      confirmText: json['confirmText'] as String?,
      cancelText: json['cancelText'] as String?,
      onDateSelected: json['onDateSelected'] as Map<String, dynamic>?,
    );
  }
}

class PersianDateRangePickerActionParser
    extends StacActionParser<PersianDateRangePickerActionModel> {
  const PersianDateRangePickerActionParser();

  @override
  String get actionType => 'persianDateRangePicker';

  @override
  PersianDateRangePickerActionModel getModel(Map<String, dynamic> json) =>
      PersianDateRangePickerActionModel.fromJson(json);

  @override
  FutureOr<void> onCall(
    BuildContext context,
    PersianDateRangePickerActionModel model,
  ) async {
    if (!context.mounted) return;

    final now = Jalali.now();
    final firstDate = _parseJalali(model.firstDate) ?? Jalali(now.year - 10, 1);
    final lastDate =
        _parseJalali(model.lastDate) ?? Jalali(now.year + 10, 12, 29);

    final currentStartRaw = StacRegistry.instance
        .getValue(model.startDateKey)
        ?.toString();
    final currentEndRaw = StacRegistry.instance
        .getValue(model.endDateKey)
        ?.toString();

    var selectedStart = _parseJalali(currentStartRaw) ?? Jalali(1405, 1, 29);
    var selectedEnd = _parseJalali(currentEndRaw) ?? Jalali(1405, 1, 31);
    if (_dateKey(selectedEnd) < _dateKey(selectedStart)) {
      final oldStart = selectedStart;
      selectedStart = selectedEnd;
      selectedEnd = oldStart;
    }
    var isSelectingRangeEnd = false;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (stateContext, setState) {
            final theme = Theme.of(stateContext);
            final colorScheme = theme.colorScheme;
            final textTheme = theme.textTheme;
            final surface = colorScheme.surface;
            final onSurface = colorScheme.onSurface;
            final outline = colorScheme.outlineVariant;
            final primary = colorScheme.primary;
            final primaryContainer = colorScheme.primaryContainer;
            final onPrimaryContainer = colorScheme.onPrimaryContainer;
            final firstVisibleMonth = Jalali(
              selectedStart.year,
              selectedStart.month,
            );
            final secondVisibleMonth = _nextMonth(firstVisibleMonth);
            final sheetHeight = MediaQuery.sizeOf(stateContext).height * 0.92;

            Future<void> confirmRange() async {
              final startText = _toPersianDateString(selectedStart);
              final endText = _toPersianDateString(selectedEnd);

              await Stac.onCallFromJson({
                'actionType': 'setValue',
                'values': [
                  {'key': model.startDateKey, 'value': startText},
                  {'key': model.endDateKey, 'value': endText},
                ],
              }, bottomSheetContext);

              if (model.onDateSelected != null && bottomSheetContext.mounted) {
                await Stac.onCallFromJson(
                  model.onDateSelected!,
                  bottomSheetContext,
                );
              }

              if (bottomSheetContext.mounted) {
                Navigator.of(bottomSheetContext).pop();
              }
            }

            void selectDate(Jalali date) {
              if (_dateKey(date) < _dateKey(firstDate) ||
                  _dateKey(date) > _dateKey(lastDate)) {
                return;
              }

              setState(() {
                if (!isSelectingRangeEnd) {
                  selectedStart = date;
                  selectedEnd = date;
                  isSelectingRangeEnd = true;
                  return;
                }

                if (_dateKey(date) < _dateKey(selectedStart)) {
                  selectedEnd = selectedStart;
                  selectedStart = date;
                } else {
                  selectedEnd = date;
                }
                isSelectingRangeEnd = false;
              });
            }

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: Material(
                    color: surface,
                    child: SizedBox(
                      height: sheetHeight,
                      width: double.infinity,
                      child: Column(
                        children: [
                          _PickerHeader(
                            title: model.helpText ?? 'انتخاب بازه زمانی',
                            onClose: () =>
                                Navigator.of(bottomSheetContext).pop(),
                          ),
                          _WeekdayHeader(
                            outline: outline,
                            textStyle: textTheme.titleSmall?.copyWith(
                              color: onSurface,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.fromLTRB(
                                16,
                                18,
                                16,
                                10,
                              ),
                              child: Column(
                                children: [
                                  _MonthCalendar(
                                    month: firstVisibleMonth,
                                    selectedStart: selectedStart,
                                    selectedEnd: selectedEnd,
                                    firstDate: firstDate,
                                    lastDate: lastDate,
                                    onDateSelected: selectDate,
                                    textTheme: textTheme,
                                    onSurface: onSurface,
                                    primaryContainer: primaryContainer,
                                    onPrimaryContainer: onPrimaryContainer,
                                    rangeColor: primaryContainer.withValues(
                                      alpha: 0.42,
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  _MonthCalendar(
                                    month: secondVisibleMonth,
                                    selectedStart: selectedStart,
                                    selectedEnd: selectedEnd,
                                    firstDate: firstDate,
                                    lastDate: lastDate,
                                    onDateSelected: selectDate,
                                    textTheme: textTheme,
                                    onSurface: onSurface,
                                    primaryContainer: primaryContainer,
                                    onPrimaryContainer: onPrimaryContainer,
                                    rangeColor: primaryContainer.withValues(
                                      alpha: 0.42,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          _SelectedRangeFooter(
                            startDate: _toPersianDateString(selectedStart),
                            endDate: _toPersianDateString(selectedEnd),
                            outline: outline,
                            textTheme: textTheme,
                            onSurface: onSurface,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                            child: SizedBox(
                              width: double.infinity,
                              height: 58,
                              child: FilledButton(
                                onPressed: confirmRange,
                                style: FilledButton.styleFrom(
                                  backgroundColor: primary,
                                  foregroundColor: colorScheme.onPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                                child: Text(
                                  model.confirmText ?? 'تایید',
                                  style: textTheme.titleMedium?.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Jalali? _parseJalali(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final normalized = _normalizePersianDigits(value.trim());
    final parts = normalized.split('/');
    if (parts.length != 3) return null;
    final y = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    final d = int.tryParse(parts[2]);
    if (y == null || m == null || d == null) return null;
    try {
      return Jalali(y, m, d);
    } catch (_) {
      return null;
    }
  }

  static String _toPersianDateString(Jalali date) {
    final en =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    return _toPersianDigits(en);
  }

  static String _normalizePersianDigits(String input) {
    const fa = '۰۱۲۳۴۵۶۷۸۹';
    var out = input;
    for (var i = 0; i < 10; i++) {
      out = out.replaceAll(fa[i], '$i');
    }
    return out;
  }

  static String _toPersianDigits(String input) {
    const fa = '۰۱۲۳۴۵۶۷۸۹';
    var out = input;
    for (var i = 0; i < 10; i++) {
      out = out.replaceAll('$i', fa[i]);
    }
    return out;
  }
}

class _PickerHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const _PickerHeader({required this.title, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
          PositionedDirectional(
            end: 10,
            child: IconButton(
              onPressed: onClose,
              icon: Icon(Icons.close, color: colorScheme.onSurface, size: 28),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekdayHeader extends StatelessWidget {
  final Color outline;
  final TextStyle? textStyle;

  const _WeekdayHeader({required this.outline, this.textStyle});

  @override
  Widget build(BuildContext context) {
    const days = ['ش', 'ی', 'د', 'س', 'چ', 'پ', 'ج'];

    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: outline, width: 1)),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          for (final day in days)
            Expanded(
              child: Center(child: Text(day, style: textStyle)),
            ),
        ],
      ),
    );
  }
}

class _MonthCalendar extends StatelessWidget {
  final Jalali month;
  final Jalali selectedStart;
  final Jalali selectedEnd;
  final Jalali firstDate;
  final Jalali lastDate;
  final ValueChanged<Jalali> onDateSelected;
  final TextTheme textTheme;
  final Color onSurface;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color rangeColor;

  const _MonthCalendar({
    required this.month,
    required this.selectedStart,
    required this.selectedEnd,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
    required this.textTheme,
    required this.onSurface,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.rangeColor,
  });

  @override
  Widget build(BuildContext context) {
    final cells = <Widget>[];
    final firstWeekDayOffset = month.weekDay - 1;

    for (var i = 0; i < firstWeekDayOffset; i++) {
      cells.add(const SizedBox.shrink());
    }

    for (var day = 1; day <= month.monthLength; day++) {
      final date = Jalali(month.year, month.month, day);
      cells.add(
        _DateCell(
          date: date,
          selectedStart: selectedStart,
          selectedEnd: selectedEnd,
          firstDate: firstDate,
          lastDate: lastDate,
          onTap: () => onDateSelected(date),
          textTheme: textTheme,
          onSurface: onSurface,
          primaryContainer: primaryContainer,
          onPrimaryContainer: onPrimaryContainer,
          rangeColor: rangeColor,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${_persianMonthName(month.month)} ${PersianDateRangePickerActionParser._toPersianDigits('${month.year}')}',
            style: textTheme.titleMedium?.copyWith(
              color: onSurface,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 7,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.28,
          children: cells,
        ),
      ],
    );
  }
}

class _DateCell extends StatelessWidget {
  final Jalali date;
  final Jalali selectedStart;
  final Jalali selectedEnd;
  final Jalali firstDate;
  final Jalali lastDate;
  final VoidCallback onTap;
  final TextTheme textTheme;
  final Color onSurface;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color rangeColor;

  const _DateCell({
    required this.date,
    required this.selectedStart,
    required this.selectedEnd,
    required this.firstDate,
    required this.lastDate,
    required this.onTap,
    required this.textTheme,
    required this.onSurface,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.rangeColor,
  });

  @override
  Widget build(BuildContext context) {
    final dateKey = _dateKey(date);
    final startKey = _dateKey(selectedStart);
    final endKey = _dateKey(selectedEnd);
    final isEndpoint = dateKey == startKey || dateKey == endKey;
    final isInRange = dateKey > startKey && dateKey < endKey;
    final isDisabled =
        dateKey < _dateKey(firstDate) || dateKey > _dateKey(lastDate);
    final textColor = isEndpoint
        ? onPrimaryContainer
        : onSurface.withValues(alpha: isDisabled ? 0.32 : 0.82);

    return IgnorePointer(
      ignoring: isDisabled,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isInRange)
                Container(
                  height: 34,
                  width: double.infinity,
                  color: rangeColor,
                ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 140),
                width: isEndpoint ? 48 : 34,
                height: isEndpoint ? 48 : 34,
                decoration: BoxDecoration(
                  color: isEndpoint ? primaryContainer : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  PersianDateRangePickerActionParser._toPersianDigits(
                    '${date.day}',
                  ),
                  style: textTheme.bodyMedium?.copyWith(
                    color: textColor,
                    fontWeight: isEndpoint ? FontWeight.w800 : FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectedRangeFooter extends StatelessWidget {
  final String startDate;
  final String endDate;
  final Color outline;
  final TextTheme textTheme;
  final Color onSurface;

  const _SelectedRangeFooter({
    required this.startDate,
    required this.endDate,
    required this.outline,
    required this.textTheme,
    required this.onSurface,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: outline, width: 1)),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: _FooterDate(title: 'تاریخ شروع', value: startDate),
          ),
          Container(width: 1, height: 48, color: outline),
          Expanded(
            child: _FooterDate(title: 'تاریخ پایان', value: endDate),
          ),
        ],
      ),
    );
  }
}

class _FooterDate extends StatelessWidget {
  final String title;
  final String value;

  const _FooterDate({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.78),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

int _dateKey(Jalali date) => date.year * 10000 + date.month * 100 + date.day;

Jalali _nextMonth(Jalali month) {
  if (month.month == 12) return Jalali(month.year + 1, 1);
  return Jalali(month.year, month.month + 1);
}

String _persianMonthName(int month) {
  const names = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];
  return names[month - 1];
}

void registerPersianDateRangePickerActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const PersianDateRangePickerActionParser(),
  );
}
