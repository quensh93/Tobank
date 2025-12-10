import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/promissory/promissory_guarantee_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class PromissoryGuaranteeInfoPage extends StatelessWidget {
  const PromissoryGuaranteeInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryGuaranteeController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.unique_promissory_id,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.promissoryIdController,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.enter_unique_promissory_id,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isPromissoryIdValid ? null : locale.invalid_promissory_id_error,
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
                            isVisible: controller.promissoryIdController.text.isNotEmpty,
                            clearFunction: () {
                              controller.promissoryIdController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        locale.issuer_national_code,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.nationalCodeController,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontFamily: 'IranYekan',
                          fontSize: 16.0,
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.issuer_national_code_hint,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isNationalCodeValid ? null : locale.enter_national_code_error,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 16.0,
                          ),
                          suffixIcon: TextFieldClearIconWidget(
                            isVisible: controller.nationalCodeController.text.isNotEmpty,
                            clearFunction: () {
                              controller.nationalCodeController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButtonWidget(
                callback: () {
                  controller.validateGuaranteeInfoPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.inquiry,
              ),
            ),
          ],
        );
      },
    );
  }
}
