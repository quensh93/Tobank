import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_lg_info_controller.dart';
import '../../../../../../util/constants.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../common/text_field_clear_icon_widget.dart';

class MilitaryGuaranteeLGInfoPage extends StatelessWidget {
  const MilitaryGuaranteeLGInfoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeLGInfoController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.guarantee_information,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.guarantee_amount,
                      style: ThemeUtil.titleStyle,
                    ),
                    Text(
                      controller.getAmountDetail(),
                      style: TextStyle(
                          color: context.theme.colorScheme.secondary, fontWeight: FontWeight.w900, fontSize: 11.0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  onChanged: (value) {
                    controller.validateAmountValue(value);
                  },
                  controller: controller.amountController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'IranYekan',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(Constants.amountLength),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  textDirection: TextDirection.ltr,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    filled: false,
                    hintText: locale.enter_guarantee_amount_rial,
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
                    errorText: controller.isAmountValid ? null : locale.invalid_amount_error,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16.0,
                    ),
                    suffixIcon: TextFieldClearIconWidget(
                      isVisible: controller.amountController.text.isNotEmpty,
                      clearFunction: () {
                        controller.clearAmountTextField();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.military_letter_number,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.militaryLetterCodeController,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'IranYekan',
                    fontSize: 16.0,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    controller.update();
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: locale.enter_military_letter_number,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    errorText: controller.isMilitaryLetterCodeValid ? null : locale.please_enter_invalid_amount,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 16.0,
                    ),
                    suffixIcon: TextFieldClearIconWidget(
                      isVisible: controller.militaryLetterCodeController.text.isNotEmpty,
                      clearFunction: () {
                        controller.militaryLetterCodeController.clear();
                        controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.military_letter_issue_date,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () {
                    controller.showSelectFirstDateDialog();
                  },
                  child: IgnorePointer(
                    child: TextField(
                      controller: controller.issueDateController,
                      enabled: true,
                      readOnly: true,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'IranYekan',
                        fontSize: 16.0,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: false,
                        hintText: locale.select_military_letter_issue_date,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        errorText:
                            controller.isIssueDateValid ? null : locale.valid_military_letter_issue_date_error,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 16.0,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgIcon(
                            SvgIcons.calendar,
                            colorFilter: ColorFilter.mode(context.theme.colorScheme.secondary, BlendMode.srcIn),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.military_letter_due_date,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InkWell(
                  onTap: () {
                    controller.showSelectSecondDateDialog();
                  },
                  child: IgnorePointer(
                    child: TextField(
                      controller: controller.dueDateController,
                      enabled: true,
                      readOnly: true,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'IranYekan',
                        fontSize: 16.0,
                      ),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: false,
                        hintText:locale.select_military_letter_due_date,
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                        errorText:
                            controller.isDueDateValid ? null : locale.valid_military_letter_due_date_error,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 16.0,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgIcon(
                            SvgIcons.calendar,
                            colorFilter: ColorFilter.mode(context.theme.colorScheme.secondary, BlendMode.srcIn),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateLGInfoPage();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.confirmation,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
