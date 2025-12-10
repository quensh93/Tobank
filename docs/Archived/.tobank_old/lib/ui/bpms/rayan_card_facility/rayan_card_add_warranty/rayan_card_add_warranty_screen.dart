import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/rayan_card_facility/rayan_card_add_warranty_controller.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/custom_app_bar.dart';

class RayanCardAddWarrantyScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const RayanCardAddWarrantyScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<RayanCardAddWarrantyController>(
      init: RayanCardAddWarrantyController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.rayan_card_facility,
                context: context,
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        elevation: 1,
                        margin: EdgeInsets.zero,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(locale.promissory_note_info, style: ThemeUtil.titleStyle),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    locale.promissory_amount,
                                    style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0),
                                  ),
                                  Text(
                                    locale.amount_format(AppUtil.formatMoney(controller.collateralPromissoryRequestData!.amount)),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    locale.due_date,
                                    style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0),
                                  ),
                                  Text(
                                    controller.collateralPromissoryRequestData!.dueDate ?? locale.due_on_demand,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: context.theme.dividerColor),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(locale.select_electronic_promissory_note, style: ThemeUtil.titleStyle),
                              const SizedBox(
                                height: 8.0,
                              ),
                              const Divider(
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              SizedBox(
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: () {
                                    controller.collateralPromissoryPublishResultData != null
                                        ? controller.showPreviewScreen()
                                        : controller.showSelectCollateralPromissoryBottomSheet();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: context.theme.colorScheme.surface,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: ThemeUtil.primaryColor,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        controller.collateralPromissoryPublishResultData != null
                                            ? locale.show_promissory_note
                                            : locale.complete,
                                        style: TextStyle(
                                          color: ThemeUtil.primaryColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      ContinueButtonWidget(
                        callback: () {
                          controller.validateCollateralPromissory();
                        },
                        isLoading: controller.isLoading,
                        buttonTitle: locale.register_guarantee,
                        isEnabled: controller.collateralPromissoryPublishResultData != null,
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
