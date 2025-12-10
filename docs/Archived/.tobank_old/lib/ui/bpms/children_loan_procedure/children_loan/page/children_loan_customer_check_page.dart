import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/children_loan_procedure/children_loan_controller.dart';
import '../../../../../../model/bpms/enum_value_data.dart';
import '../../../../../../util/app_util.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/text_field_clear_icon_widget.dart';

class ChildrenLoanProcedureCustomerCheckPage extends StatelessWidget {
  const ChildrenLoanProcedureCustomerCheckPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ChildrenLoanProcedureController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: Get.isDarkMode ? 1 : 0,
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
                        Text(
                          locale.user_information,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.full_name,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              controller.getCustomerInfo(),
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        const Divider(thickness: 1),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.national_code_title,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              controller.getCustomerNationalCode(),
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  locale.branch_agent,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controller.branchNameController,
                  keyboardType: TextInputType.text,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  readOnly: true,
                  enabled: false,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'IranYekan',
                  ),
                  decoration: const InputDecoration(
                    filled: true,
                    hintText: '',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Text(
                      locale.tracking_code_centeral_bank,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(width: 4.0),
                    InkWell(
                      onTap: () {
                        controller.showTrackingCodeHelperBottomSheet();
                      },
                      borderRadius: BorderRadius.circular(40.0),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.info_outline_rounded),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  children: <Widget>[
                    TextField(
                      controller: controller.trackingCodeBankController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(15),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        fontFamily: 'IranYekan',
                      ),
                      onChanged: (value) {
                        controller.update();
                      },
                      decoration: InputDecoration(
                        filled: false,
                        hintText: locale.tracking_code_centeral_bank_hint,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText: controller.isTrackingCodeValid ? null : locale.tracking_code_error,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        suffixIcon: TextFieldClearIconWidget(
                          isVisible: controller.trackingCodeBankController.text.isNotEmpty,
                          clearFunction: () {
                            controller.trackingCodeBankController.clear();
                            controller.update();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  locale.children,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      value: controller.selectedChildrenCount,
                      hint: Text(
                       locale.select_children,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      items: controller.childrenCountDataList.map((EnumValue item) {
                        return DropdownMenuItem(
                          value: item,
                          alignment: Alignment.centerRight,
                          child: Text(
                            item.title,
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (EnumValue? newValue) {
                        controller.setSelectedChildrenCount(newValue);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                if (controller.selectedChildrenLoanAmountData != null)
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locale.loan_amount,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            locale.amount_format(AppUtil.formatMoney(controller.selectedChildrenLoanAmountData!.title)),
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: ThemeUtil.textTitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateCustomerCheckPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.continue_label,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
