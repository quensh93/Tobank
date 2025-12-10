import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_employment_type_controller.dart';
import '../../../../../../model/bpms/enum_value_data.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/text_field_error_widget.dart';

class MilitaryGuaranteeEmploymentTypePage extends StatelessWidget {
  const MilitaryGuaranteeEmploymentTypePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteeEmploymentTypeController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                locale.select_employment_type,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.employment_type,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField2(
                    isExpanded: true,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    value: controller.selectedMilitaryGuaranteeEmploymentData,
                    hint: Text(
                      locale.select_employment_type_hint,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    items: controller.employmentTypeDataList.map((EnumValue item) {
                      return DropdownMenuItem(
                        value: item,
                        alignment: Alignment.centerRight,
                        child: Text(
                          item.title,
                          textAlign: TextAlign.start,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontFamily: 'IranYekan',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (EnumValue? newValue) {
                      controller.setSelectedEmploymentType(newValue);
                    },
                  ),
                ),
              ),
              TextFieldErrorWidget(
                isValid: controller.isSelectedEmploymentValid,
                errorText: locale.select_employment_type_error,
              ),
              Expanded(child: Container()),
              ContinueButtonWidget(
                callback: () {
                  controller.validateEmploymentTypePage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.continue_label,
              ),
            ],
          ),
        );
      },
    );
  }
}
