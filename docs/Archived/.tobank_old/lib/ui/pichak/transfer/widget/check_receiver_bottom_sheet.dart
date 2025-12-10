import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/check_transfer_controller.dart';
import '../../../../model/pichak/customer_type_data.dart';
import '../../../../util/data_constants.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class CheckReceiverBottomSheetWidget extends StatelessWidget {
  const CheckReceiverBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CheckTransferController>(builder: (controller) {
      String hint = '';
      String title = '';
      if (controller.selectedCustomerTypeData == DataConstants.getCustomerTypeDataList()[0]) {
        hint = locale.recipient_national_code_hint;
        title = locale.national_code_title;
      } else if (controller.selectedCustomerTypeData == DataConstants.getCustomerTypeDataList()[1]) {
        hint = locale.recipient_national_id_hint;
        title = locale.recipient_national_id_title;
      } else {
        hint = locale.recipient_foreigner_code_hint;
        title = locale.recipient_foreigner_code_title;
      }
      return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
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
                  height: 16.0,
                ),
                Text(
                  locale.recipient_type,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: DataConstants.getCustomerTypeDataList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: DataConstants.getCustomerTypeDataList()[index].id ==
                                    controller.selectedCustomerTypeData.id
                                ? context.theme.colorScheme.secondary
                                : context.theme.dividerColor),
                        color:
                            DataConstants.getCustomerTypeDataList()[index].id == controller.selectedCustomerTypeData.id
                                ? context.theme.colorScheme.secondary.withOpacity(0.15)
                                : Colors.transparent,
                      ),
                      child: RadioListTile<CustomerTypeData>(
                        title: Text(
                          DataConstants.getCustomerTypeDataList()[index].title!,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                        activeColor: context.theme.colorScheme.secondary,
                        value: DataConstants.getCustomerTypeDataList()[index],
                        groupValue: controller.selectedCustomerTypeData,
                        onChanged: (CustomerTypeData? value) {
                          controller.setSelectedCustomerTypeData(value);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 12);
                  },
                ),
                const SizedBox(height: 16.0),
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.codeController,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'IranYekan',
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: false,
                    hintText: hint,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    suffixIcon: TextFieldClearIconWidget(
                      isVisible: controller.codeController.text.isNotEmpty,
                      clearFunction: () {
                        controller.codeController.clear();
                        // controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.addReceiver();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.add_reciver,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
