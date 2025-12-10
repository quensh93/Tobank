import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/safe_box/add_safe_box_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import 'refer_date_item_widget.dart';
import 'refer_time_item_widget.dart';

class AddSafeBoxSelectDateBottomSheet extends StatelessWidget {
  const AddSafeBoxSelectDateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<AddSafeBoxController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 36,
                      height: 4,
                      decoration:
                          BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(locale.select_bank_visit_date_and_time, style: ThemeUtil.titleStyle),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(locale.visit_date, style: ThemeUtil.titleStyle),
                      const SizedBox(
                        height: 8.0,
                      ),
                      GridView(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12.0,
                          crossAxisSpacing: 12.0,
                          childAspectRatio: 3.0,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        children:
                            List<Widget>.generate(controller.referDateTimeListResponseData!.data!.length, (index) {
                          return ReferDateItemWidget(
                            referDateTime: controller.referDateTimeListResponseData!.data![index],
                            selectedDate: controller.selectedDate,
                            index: index,
                            returnSelectedFunction: (index) {
                              controller.selectDate(index);
                            },
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(locale.visit_time_period, style: ThemeUtil.titleStyle),
                      const SizedBox(
                        height: 16.0,
                      ),
                      if (controller.selectedDate == null && controller.times.isEmpty)
                        Center(
                          child: Text(
                            locale.no_date_selected,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      else
                        controller.selectedDate != null && controller.times.isEmpty
                            ? Center(
                                child: Text(
                                  locale.no_time_available_for_date,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : Wrap(
                                spacing: 12,
                                children: List.generate(controller.times.length, (index) {
                                  return ReferTimeItemWidget(
                                    referTime: controller.times[index],
                                    value: controller.times[index].id!,
                                    selectedTime: controller.selectedTime,
                                    onChanged: (int? newValue) {
                                      controller.selectTime(newValue!);
                                    },
                                  );
                                }),
                              ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      ContinueButtonWidget(
                        callback: () {
                          controller.validateSelectedDate();
                        },
                        isLoading: controller.isLoading,
                        buttonTitle: locale.confirm_continue,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
