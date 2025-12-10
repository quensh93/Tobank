import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../util/date_picker/flutter_datepicker.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';

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

//locale
    final locale = AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
      ),
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
                  decoration: BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
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
              style: ThemeUtil.titleStyle,
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
            child: ContinueButtonWidget(
              isLoading: false,
              callback: () {
                callback();
              },
              buttonTitle: locale.confirmation,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }
}
