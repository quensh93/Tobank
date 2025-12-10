import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/military_guarantee/military_guarantee_person_address_controller.dart';
import '../../../../../../model/bpms/bpms_ownership_data.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/document_picker_widget.dart';
import '../../../../common/text_field_clear_icon_widget.dart';
import '../../../../common/text_field_error_widget.dart';

class MilitaryGuaranteePersonAddressPage extends StatelessWidget {
  const MilitaryGuaranteePersonAddressPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MilitaryGuaranteePersonAddressController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                 locale.applicant_residence_ownership_info,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.user_message_residence_ownership,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.ownership_type,
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
                      value: controller.selectedCustomerOwnershipData,
                      hint: Text(
                        locale.ownership_type_hint,
                        style: TextStyle(
                          color: ThemeUtil.textSubtitleColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      items: controller.ownershipData.map((BPMSOwnershipData item) {
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
                      onChanged: (BPMSOwnershipData? newValue) {
                        controller.setCustomerOwnershipData(newValue!);
                      },
                    ),
                  ),
                ),
                TextFieldErrorWidget(
                  isValid: controller.isSelectedCustomerOwnershipValid,
                  errorText: locale.ownership_type_error,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                if (controller.selectedCustomerOwnershipData != null &&
                    controller.selectedCustomerOwnershipData!.id == 2)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        locale.ownership_description,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.descriptionOwnershipController,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                          height: 1.6,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 4,
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.ownership_description_hint,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                          errorText:
                              controller.isDescriptionOwnershipValid ? null : locale.ownership_description_error,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 8.0,
                          ),
                          suffixIcon: TextFieldClearIconWidget(
                            isVisible: controller.descriptionOwnershipController.text.isNotEmpty,
                            clearFunction: () {
                              controller.descriptionOwnershipController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  )
                else
                  Container(),
                if (controller.selectedCustomerOwnershipData != null &&
                    controller.selectedCustomerOwnershipData!.id == 1)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        locale.hint_text_property_document,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: controller.trackingCodeCustomerOwnershipController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(20),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.tracking_number_label,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isTrackingCodeCustomerOwnershipValid
                              ? null
                              : locale.tracking_code_error,
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
                            isVisible: controller.trackingCodeCustomerOwnershipController.text.isNotEmpty,
                            clearFunction: () {
                              controller.trackingCodeCustomerOwnershipController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )
                else
                  Container(),
                DocumentPickerWidget(
                  title: locale.copy_guarantor_residence_document_or_lease,
                  subTitle: '',
                  cameraFunction: (documentId) {
                    controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.camera);
                  },
                  galleryFunction: (documentId) {
                    controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.gallery);
                  },
                  isUploading: controller.isUploading,
                  isUploaded: controller.isUploaded(1),
                  deleteDocumentFunction: (documentId) {
                    controller.deleteDocument(documentId);
                  },
                  documentId: 1,
                  selectedDocumentId: controller.selectedDocumentId,
                  selectedImageFile: controller.documentFile_1,
                ),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateCustomerAddress();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.submit_button ,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
