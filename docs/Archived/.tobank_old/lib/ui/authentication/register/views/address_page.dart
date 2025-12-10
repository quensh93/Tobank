import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../controller/authentication/authentication_extension/address_verification_flow_methods.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/authentication/authentication_register_controller.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AuthenticationRegisterController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                     locale.postal_code_and_address,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      locale.postal_code,
                      style: ThemeUtil.titleStyle,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              fontFamily: 'IranYekan',
                            ),
                            controller: controller.postalCodeEditingController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            textInputAction: TextInputAction.done,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              controller.addressTextEditingController.text = '';
                              controller.update();
                            },
                            decoration: InputDecoration(
                              filled: false,
                              hintText: locale.postal_code_hint,
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                              errorText: controller.isPostalCodeValidate ? null :locale.postal_code_error,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                              suffixIcon: TextFieldClearIconWidget(
                                isVisible: controller.postalCodeEditingController.text.isNotEmpty,
                                clearFunction: () {
                                  controller.addressTextEditingController.text = '';
                                  controller.postalCodeEditingController.clear();
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            constraints: const BoxConstraints(minWidth: 100.0),
                            child: ContinueButtonWidget(
                              callback: () {
                                controller.getAddressInfo(postOnly: true);
                              },
                              isLoading: controller.isPostInquiryLoading,
                              buttonTitle: locale.inquiry,
                            ),
                          ),
                        )
                      ],
                    ),
                    if (controller.isPostInquired)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 24.0,
                          ),
                          Text(
                           locale.address,
                            style: ThemeUtil.titleStyle,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          TextField(
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                              fontFamily: 'IranYekan',
                            ),
                            controller: controller.addressTextEditingController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.right,
                            textInputAction: TextInputAction.done,
                            maxLines: 3,
                            onChanged: (value) {
                              controller.update();
                            },
                            decoration: InputDecoration(
                              filled: false,
                              hintText: locale.address_hint,
                              hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                              errorText: controller.isAddressValidate ? null : locale.address_error,
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                              suffixIcon: TextFieldClearIconWidget(
                                isVisible: controller.addressTextEditingController.text.isNotEmpty,
                                clearFunction: () {
                                  controller.addressTextEditingController.clear();
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            if (controller.isPostInquired)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ContinueButtonWidget(
                  callback: () {
                    controller.getAddressInfo(postOnly: !controller.isPostInquired);
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.confirm_continue,
                ),
              ),
          ],
        );
      },
    );
  }
}
