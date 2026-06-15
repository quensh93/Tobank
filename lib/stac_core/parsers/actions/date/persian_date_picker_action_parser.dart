import 'dart:async';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../registry/custom_component_registry.dart';
import '../../../registry/text_form_field_controller_registry.dart';
import '../../../../core/helpers/logger.dart';
import '../../../../core/widgets/date_picker/date_selector_bottom_sheet.dart';
import 'package:stac/stac.dart';

/// Persian Date Picker Action Model
///
/// A custom STAC action that shows a Persian (Jalali) date picker dialog.
///
/// Example JSON:
/// ```json
/// {
///   "actionType": "persianDatePicker",
///   "formFieldId": "birthdate",
///   "initialDate": "1400/01/01",
///   "firstDate": "1350/01/01",
///   "lastDate": "1450/12/29"
/// }
/// ```
class PersianDatePickerActionModel {
  /// The form field ID to update with the selected date
  final String formFieldId;

  /// Initial date to show in picker (format: YYYY/MM/DD)
  final String? initialDate;

  /// First selectable date (format: YYYY/MM/DD)
  final String? firstDate;

  /// Last selectable date (format: YYYY/MM/DD)
  final String? lastDate;

  /// Optional action to execute after date is selected
  final Map<String, dynamic>? onDateSelected;

  /// Extra spacing added below the date picker bottom sheet (in logical pixels).
  final double bottomSheetBottomPadding;

  const PersianDatePickerActionModel({
    required this.formFieldId,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.bottomSheetBottomPadding = 0,
  });

  factory PersianDatePickerActionModel.fromJson(Map<String, dynamic> json) {
    return PersianDatePickerActionModel(
      formFieldId: json['formFieldId'] as String,
      initialDate: json['initialDate'] as String?,
      firstDate: json['firstDate'] as String?,
      lastDate: json['lastDate'] as String?,
      onDateSelected: json['onDateSelected'] as Map<String, dynamic>?,
      bottomSheetBottomPadding:
          (json['bottomSheetBottomPadding'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actionType': 'persianDatePicker',
      'formFieldId': formFieldId,
      if (initialDate != null) 'initialDate': initialDate,
      if (firstDate != null) 'firstDate': firstDate,
      if (lastDate != null) 'lastDate': lastDate,
      if (onDateSelected != null) 'onDateSelected': onDateSelected,
      if (bottomSheetBottomPadding > 0)
        'bottomSheetBottomPadding': bottomSheetBottomPadding,
    };
  }
}

/// Persian Date Picker Action Parser
///
/// Shows a Persian (Jalali) date picker dialog and updates the form field
/// with the selected date in YYYY/MM/DD format.
class PersianDatePickerActionParser
    extends StacActionParser<PersianDatePickerActionModel> {
  const PersianDatePickerActionParser();

  @override
  String get actionType => 'persianDatePicker';

  @override
  PersianDatePickerActionModel getModel(Map<String, dynamic> json) =>
      PersianDatePickerActionModel.fromJson(json);

  @override
  FutureOr onCall(
    BuildContext context,
    PersianDatePickerActionModel model,
  ) async {
    try {
      AppLogger.i(
        '🗓️ Persian date picker action triggered for field: ${model.formFieldId}',
      );
      AppLogger.d(
        '📋 onDateSelected is: ${model.onDateSelected != null ? 'PRESENT' : 'NULL'}',
      );
      if (model.onDateSelected != null) {
        AppLogger.d('📋 onDateSelected content: ${model.onDateSelected}');
      }

      // Format initial date string (YYYY/MM/DD format)
      String initDateString = '';
      if (model.initialDate != null && model.initialDate!.isNotEmpty) {
        initDateString = model.initialDate!;
        AppLogger.d('Using provided initial date: $initDateString');
      } else {
        final now = Jalali.now();
        initDateString =
            '${now.year}/${now.month.toString().padLeft(2, '0')}/${now.day.toString().padLeft(2, '0')}';
        AppLogger.d('Using current date as initial: $initDateString');
      }

      // Format start date string (YYYY/MM/DD format)
      String? startDateString;
      if (model.firstDate != null && model.firstDate!.isNotEmpty) {
        startDateString = model.firstDate!;
        AppLogger.d('Using provided first date: $startDateString');
      } else {
        // Default: 100 years ago
        final firstJalali = Jalali(Jalali.now().year - 100, 1, 1);
        startDateString =
            '${firstJalali.year}/${firstJalali.month.toString().padLeft(2, '0')}/${firstJalali.day.toString().padLeft(2, '0')}';
        AppLogger.d('Using default first date: $startDateString');
      }

      // Format end date string (YYYY/MM/DD format)
      String? endDateString;
      if (model.lastDate != null && model.lastDate!.isNotEmpty) {
        endDateString = model.lastDate!;
        AppLogger.d('Using provided last date: $endDateString');
      } else {
        // Default: today
        final lastJalali = Jalali.now();
        endDateString =
            '${lastJalali.year}/${lastJalali.month.toString().padLeft(2, '0')}/${lastJalali.day.toString().padLeft(2, '0')}';
        AppLogger.d('Using default last date: $endDateString');
      }

      // Get title from registry
      final title =
          StacRegistry.instance
              .getValue('appStrings.datePicker.selectBirthDate')
              ?.toString() ??
          StacRegistry.instance
              .getValue('appStrings.common.selectDate')
              ?.toString() ??
          'انتخاب تاریخ';
      AppLogger.d('Date picker title: $title');

      // Track selected date
      String selectedDateString = initDateString;
      AppLogger.d('Initial selected date: $selectedDateString');

      // Check if context has a Navigator
      if (!context.mounted) {
        AppLogger.e('Context is not mounted, cannot show date picker');
        return null;
      }

      final isDarkMode = Theme.of(context).brightness == Brightness.dark;
      final screenHeight = MediaQuery.of(context).size.height;

      AppLogger.d(
        'Showing date picker bottom sheet - isDarkMode: $isDarkMode, height: $screenHeight',
      );

      // Check if Navigator is available
      try {
        Navigator.of(context, rootNavigator: false);
        AppLogger.d('Navigator found in context');
      } catch (e) {
        AppLogger.e('No Navigator found in context: $e');
        // Try root navigator
        try {
          Navigator.of(context, rootNavigator: true);
          AppLogger.d('Root Navigator found in context');
        } catch (e2) {
          AppLogger.e('No root Navigator found either: $e2');
          return null;
        }
      }

      // Show bottom sheet with date picker
      AppLogger.d('Calling showModalBottomSheet...');
      AppLogger.d('Context type: ${context.runtimeType}');
      AppLogger.d('Context mounted: ${context.mounted}');

      // Add a small delay to ensure the context is ready
      await Future.delayed(const Duration(milliseconds: 100));

      if (!context.mounted) {
        AppLogger.e('Context no longer mounted after delay');
        return null;
      }

      final result = await showModalBottomSheet<String>(
        elevation: 0,
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors
            .transparent, // Make background transparent so we can see the rounded corners
        constraints: BoxConstraints(maxHeight: screenHeight * 5 / 6),
        isDismissible: true, // Allow dismissing by tapping outside
        enableDrag: true, // Allow dragging to dismiss
        useSafeArea: false,
        barrierColor: Colors.black54, // Semi-transparent barrier
        builder: (bottomSheetContext) {
          AppLogger.d(
            'Bottom sheet builder called - building DateSelectorBottomSheet',
          );
          AppLogger.d(
            'Bottom sheet context: ${bottomSheetContext.runtimeType}',
          );
          AppLogger.d(
            'Bottom sheet context mounted: ${bottomSheetContext.mounted}',
          );
          try {
            final safeBottom = MediaQuery.of(bottomSheetContext).padding.bottom;
            final extraBottomPadding = model.bottomSheetBottomPadding;

            // Wrap in GestureDetector to prevent taps from propagating
            final bottomSheetWidget = Padding(
              padding: EdgeInsets.only(bottom: safeBottom + extraBottomPadding),
              child: GestureDetector(
                onTap: () {
                  // Prevent tap from dismissing the bottom sheet
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode ? const Color(0xFF1c222e) : Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8.0),
                    ),
                  ),
                  child: DateSelectorBottomSheet(
                    initDateString: initDateString,
                    startDateString: startDateString,
                    endDateString: endDateString,
                    title: title,
                    onDateSelected: (selectedDate) {
                      selectedDateString = selectedDate;
                    },
                    callback: () async {
                      // Format date as YYYY/MM/DD (ensure consistent format)
                      final parts = selectedDateString.split('/');
                      if (parts.length == 3) {
                        final year = parts[0];
                        final month = parts[1].padLeft(2, '0');
                        final day = parts[2].padLeft(2, '0');
                        selectedDateString = '$year/$month/$day';
                      }

                      AppLogger.d(
                        'Persian date picker selected: $selectedDateString',
                      );

                      // Get form scope to update form field directly
                      final formScope = StacFormScope.of(context);
                      if (formScope != null) {
                        // Update formData directly (the map should be mutable)
                        formScope.formData[model.formFieldId] =
                            selectedDateString;
                        AppLogger.d(
                          'Updated formData[${model.formFieldId}] = $selectedDateString',
                        );
                      }

                      // Also update registry for use in other places (e.g., API calls)
                      StacRegistry.instance.setValue(
                        'form.${model.formFieldId}',
                        selectedDateString,
                      );

                      // Update the TextFormField controller to display the selected date
                      _updateTextFormFieldValue(
                        context,
                        model.formFieldId,
                        selectedDateString,
                      );

                      // Use setValue action to ensure the form field updates
                      // This will trigger any necessary rebuilds
                      final setValueActionJson = {
                        'actionType': 'setValue',
                        'values': [
                          {
                            'key': 'form.${model.formFieldId}',
                            'value': selectedDateString,
                          },
                        ],
                      };
                      await Stac.onCallFromJson(setValueActionJson, context);

                      // Execute optional onDateSelected action if provided
                      if (model.onDateSelected != null) {
                        AppLogger.i(
                          '🎯 Executing onDateSelected callback: ${model.onDateSelected}',
                        );
                        if (context.mounted) {
                          await Stac.onCallFromJson(
                            model.onDateSelected!,
                            context,
                          );
                          AppLogger.i(
                            '✅ onDateSelected callback executed successfully',
                          );
                        }
                      } else {
                        AppLogger.w(
                          '⚠️ onDateSelected is null, skipping callback',
                        );
                      }

                      // Close bottom sheet
                      AppLogger.d(
                        'Closing bottom sheet with date: $selectedDateString',
                      );
                      if (bottomSheetContext.mounted) {
                        Navigator.of(
                          bottomSheetContext,
                        ).pop(selectedDateString);
                      }
                    },
                  ),
                ),
              ),
            );
            AppLogger.d('DateSelectorBottomSheet widget created successfully');
            return bottomSheetWidget;
          } catch (e, stackTrace) {
            AppLogger.e(
              'Error building DateSelectorBottomSheet: $e',
              e,
              stackTrace,
            );
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1c222e) : Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
              ),
              child: Text('Error: $e'),
            );
          }
        },
      );

      AppLogger.d('showModalBottomSheet completed, result: $result');

      // If user cancelled (result is null), return null
      if (result != null) {
        selectedDateString = result;
        AppLogger.d('Date selected: $selectedDateString');
      } else {
        AppLogger.d('Date picker was cancelled or dismissed');
      }

      return selectedDateString;
    } catch (e, stackTrace) {
      AppLogger.e('Error showing Persian date picker: $e', e, stackTrace);
      return null;
    }
  }

  /// Update the TextFormField controller to display the selected date
  /// Uses the TextFormFieldControllerRegistry to update the controller
  void _updateTextFormFieldValue(
    BuildContext context,
    String fieldId,
    String value,
  ) {
    try {
      // Use post-frame callback to ensure update happens after dialog closes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          // Try to update using the registry first (if controller was registered)
          final registry = TextFormFieldControllerRegistry.instance;
          final updated = registry.updateValue(fieldId, value);

          if (updated) {
            AppLogger.d(
              '✅ Updated TextFormField via registry for: $fieldId = $value',
            );
          } else {
            // Fallback: Try to find and update manually
            AppLogger.w(
              'Controller not found in registry for: $fieldId, trying manual update',
            );
            _findAndUpdateControllerManually(context, fieldId, value);
          }
        } catch (e) {
          AppLogger.w('Error in post-frame callback: $e');
        }
      });
    } catch (e) {
      AppLogger.w('Error updating TextFormField value: $e');
    }
  }

  /// Fallback method to manually find and update TextFormField
  /// This tries to trigger a rebuild by calling setState on the form
  void _findAndUpdateControllerManually(
    BuildContext context,
    String fieldId,
    String value,
  ) {
    try {
      // Get form scope and trigger a rebuild
      final formScope = StacFormScope.of(context);
      if (formScope != null) {
        // Mark the form as needing a rebuild
        final element = context as Element;
        element.markNeedsBuild();
        AppLogger.d('Triggered rebuild for form to update: $fieldId = $value');
      }
    } catch (e) {
      AppLogger.w('Error in manual update: $e');
    }
  }
}

/// Register the Persian date picker action parser
void registerPersianDatePickerActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const PersianDatePickerActionParser(),
  );
}
