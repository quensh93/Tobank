import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/children_loan_procedure/children_loan_child_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../../widget/svg/svg_icon.dart';
import '../../../../common/text_field_clear_icon_widget.dart';

class ChildrenLoanProcedureChildCheckPage extends StatelessWidget {
  const ChildrenLoanProcedureChildCheckPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ChildrenLoanProcedureChildController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(locale.child_info_title, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 16.0,
                ),
                Text(locale.child_national_code_label, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: controller.nationalCodeChildController,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    fontFamily: 'IranYekan',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    controller.update();
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: locale.child_national_code_hint,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                    errorText: controller.isChildNationalCodeValid ? null : locale.national_code_error_,
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
                      isVisible: controller.nationalCodeChildController.text.isNotEmpty,
                      clearFunction: () {
                        controller.nationalCodeChildController.clear();
                        controller.update();
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(locale.child_birth_date_label, style: ThemeUtil.titleStyle),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.showSelectDateDialog(birthDayId: 1);
                        },
                        child: IgnorePointer(
                          child: TextField(
                            controller: controller.birthdayDateChildController,
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
                              hintText: locale.child_birth_date_hint,
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              errorText:
                                  controller.isChildDateValid ? null : locale.child_birth_date_error,
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateChildCheck();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.next_step,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
