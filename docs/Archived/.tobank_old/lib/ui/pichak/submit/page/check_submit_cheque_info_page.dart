import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/check_submit_controller.dart';
import '../../../../util/data_constants.dart';
import '../../../../util/dialog_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../widget/check_type_item_widget.dart';

class CheckSubmitChequeInfoPage extends StatelessWidget {
  const CheckSubmitChequeInfoPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CheckSubmitController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: [
                  Text(
                    locale.saayad_id_title,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {
                      DialogUtil.showChequeHelperBottomSheet();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SvgIcon(SvgIcons.info),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                crossAxisAlignment: controller.isChequeIdValid ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        fontFamily: 'IranYekan',
                      ),
                      controller: controller.chequeIdController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                      ],
                      textDirection: TextDirection.ltr,
                      onChanged: (value) {
                        controller.update();
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText:locale.saayad_cheque_id_hint,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText: controller.isChequeIdValid ? null :locale.saayad_id_error,
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
                          isVisible: controller.chequeIdController.text.isNotEmpty,
                          clearFunction: () {
                            controller.chequeIdController.clear();
                            controller.update();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  InkWell(
                    onTap: () {
                      controller.permissionMessageDialog();
                    },
                    child: Card(
                      elevation: Get.isDarkMode ? 1 : 0,
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                      ),
                      child: SizedBox(
                        height: 56.0,
                        width: 56.0,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgIcon(
                            Get.isDarkMode ? SvgIcons.scannerDark : SvgIcons.scanner,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.physical_cheque_type,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 56.0,
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: context.theme.dividerColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          locale.paper_cheque,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.cheque_type,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 48,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return CheckTypeItemWidget(
                        checkTypeData: DataConstants.getCheckTypeDataList()[index],
                        selectedCheckTypeData: controller.selectedCheckTypeData,
                        returnDataFunction: (checkTypeData) {
                          controller.setCheckType(checkTypeData);
                        },
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: DataConstants.getCheckTypeDataList().length),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validate();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.cheque_inquiry,
              ),
            ],
          ),
        ),
      );
    });
  }
}
