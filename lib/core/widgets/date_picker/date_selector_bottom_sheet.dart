import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../extensions/context_extensions.dart';
import 'linear_date_picker.dart';

class DateSelectorBottomSheet extends StatelessWidget {
  const DateSelectorBottomSheet({
    required this.initDateString,
    required this.title,
    required this.onDateSelected,
    required this.callback,
    super.key,
    this.startDateString,
    this.endDateString,
  });

  final String initDateString;
  final String? startDateString;
  final String? endDateString;
  final String title;
  final Function(String text) onDateSelected;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    try {
      debugPrint('DateSelectorBottomSheet.build() called');
      debugPrint('initDateString: $initDateString');
      debugPrint('startDateString: $startDateString');
      debugPrint('endDateString: $endDateString');
      debugPrint('title: $title');
      
      // Get confirmation text from registry
      final confirmationText = StacRegistry.instance.getValue('appStrings.common.confirmation')?.toString() ?? 'تایید';
      debugPrint('confirmationText: $confirmationText');
      
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
          const SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                      color: context.theme.dividerColor,
                      borderRadius: BorderRadius.circular(4))),
            ],
          ),
          const SizedBox(
            height: 24.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              title,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: context.isDarkMode ? const Color(0xFFf9fafb) : const Color(0xFF101828),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          LinearDatePicker(
            initialDate: initDateString,
            startDate: startDateString ?? '',
            endDate: endDateString ?? '',
            onDateSelected: (String selectedDate) {
              onDateSelected(selectedDate);
            },
            fontFamily: 'IranYekan',
            textColor: context.theme.textTheme.bodyLarge!.color,
            selectedColor: context.theme.textTheme.bodyLarge!.color,
            unselectedColor: context.theme.textTheme.bodyLarge!.color,
            columnWidth: 120,
            showMonthName: true,
            isJalaali: true,
          ),
          const SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  callback();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFFd61f2c),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: Text(
                    confirmationText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ],
        ),
      );
    } catch (e, stackTrace) {
      // Log error and return error widget
      debugPrint('Error building DateSelectorBottomSheet: $e');
      debugPrint('Stack trace: $stackTrace');
      return Container(
        padding: const EdgeInsets.all(16),
        child: Text('Error: $e'),
      );
    }
  }
}

