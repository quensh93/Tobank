import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/safe_box/request_visit_safe_box_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../visit_date_item_widget.dart';
import '../visit_time_item_widget.dart';

class RequestVisitSelectDatePage extends StatelessWidget {
  const RequestVisitSelectDatePage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RequestVisitSafeBoxController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(locale.select_date_time_fund_visit, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(locale.visit_date_, style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 8.0,
                  ),
                  GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 12.0,
                      childAspectRatio: 3.0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    children:
                        List<Widget>.generate(controller.visitDateTimeListResponseData!.data!.results!.length, (index) {
                      return VisitDateItemWidget(
                        visitDateTime: controller.visitDateTimeListResponseData!.data!.results![index],
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
                  Text(locale.visit_time_range, style: ThemeUtil.titleStyle),
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
                            spacing: 8,
                            children: List.generate(
                                controller.times.length,
                                (index) => VisitTimeItemWidget(
                                      referTime: controller.times[index],
                                      value: controller.times[index].id!,
                                      selectedTime: controller.selectedTime,
                                      onChanged: (int? newValue) {
                                        controller.selectTIme(newValue!);
                                      },
                                    )),
                          ),
                ],
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validateRequestVisitSelectedDate();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.final_confirmation_button,
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      );
    });
  }
}
