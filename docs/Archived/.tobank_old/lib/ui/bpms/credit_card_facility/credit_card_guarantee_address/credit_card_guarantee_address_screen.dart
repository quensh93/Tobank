import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/credit_card_facility/credit_card_guarantee_address_controller.dart';
import '../../../../../model/bpms/bpms_ownership_data.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/document_picker_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../../../common/text_field_error_widget.dart';

class CreditCardGuaranteeAddressScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const CreditCardGuaranteeAddressScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CreditCardGuaranteeAddressController>(
      init: CreditCardGuaranteeAddressController(task: task, taskData: taskData),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.guarantee_request,
                context: context,
              ),
              body: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                locale.guarantor_address_info,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Text(locale.guarantee_residence_info,
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
                                locale.guarantor_residence_postal_code,
                                style: ThemeUtil.titleStyle,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                crossAxisAlignment: controller.isGuaranteePostalCodeValid
                                    ? CrossAxisAlignment.center
                                    : CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        TextField(
                                          controller: controller.guaranteePostalCodeController,
                                          textDirection: TextDirection.ltr,
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16.0,
                                            fontFamily: 'IranYekan',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            LengthLimitingTextInputFormatter(10),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          textInputAction: TextInputAction.next,
                                          onChanged: (value) {
                                            controller.isAddressInquirySuccessful = false;
                                            controller.update();
                                          },
                                          decoration: InputDecoration(
                                            filled: false,
                                            hintText: locale.enter_your_postal_code,
                                            hintStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                            ),
                                            errorText: controller.isGuaranteePostalCodeValid
                                                ? null
                                                : controller.guaranteePostalCodeErrorMessage,
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
                                              isVisible: controller.guaranteePostalCodeController.text.isNotEmpty,
                                              clearFunction: () {
                                                controller.guaranteePostalCodeController.clear();
                                                controller.isAddressInquirySuccessful = false;
                                                controller.update();
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 16.0,
                                  ),
                                  Container(
                                    constraints: const BoxConstraints(minWidth: 120.0),
                                    height: 56,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (!controller.isPostalCodeLoading) {
                                            controller.validateGuaranteeAddressInquiry();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor: ThemeUtil.primaryColor,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                            8.0,
                                          ),
                                          child: controller.isPostalCodeLoading
                                              ? SpinKitFadingCircle(
                                                  itemBuilder: (_, int index) {
                                                    return const DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                      ),
                                                    );
                                                  },
                                                  size: 24.0,
                                                )
                                              :  Text(
                                            locale.inquiry,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              if (controller.isAddressInquirySuccessful)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: ThemeUtil.borderColor,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              locale.province,
                                              style: ThemeUtil.titleStyle,
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Container(
                                              height: 56.0,
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                                color: context.theme.colorScheme.surface,
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    controller.getGuaranteeProvince(),
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: ThemeUtil.textTitleColor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            Text(
                                              locale.city,
                                              style: ThemeUtil.titleStyle,
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Container(
                                              height: 56.0,
                                              decoration: BoxDecoration(
                                                color: context.theme.colorScheme.surface,
                                                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    controller.getGuaranteeCity(),
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: ThemeUtil.textTitleColor,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            Text(
                                              locale.guarantor_residence_address,
                                              style: ThemeUtil.titleStyle,
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            TextField(
                                              controller: controller.guaranteeAddressController,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.0,
                                              ),
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              minLines: 3,
                                              onChanged: (value) {
                                                controller.update();
                                              },
                                              decoration: InputDecoration(
                                                filled: false,
                                                hintText: locale.address_hint_text,
                                                hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                ),
                                                errorText: controller.isGuaranteeAddressValid
                                                    ? null
                                                    :locale.postal_address_error_text,
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
                                                  isVisible: controller.guaranteeAddressController.text.isNotEmpty,
                                                  clearFunction: () {
                                                    controller.guaranteeAddressController.clear();
                                                    controller.update();
                                                  },
                                                ),
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
                                                    contentPadding:
                                                        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  value: controller.selectedGuaranteeOwnershipData,
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
                                                    controller.setOwnershipData(newValue!);
                                                  },
                                                ),
                                              ),
                                            ),
                                            TextFieldErrorWidget(
                                                isValid: controller.isSelectedGuaranteeOwnershipValid,
                                                errorText: locale.ownership_type_error),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            if (controller.isOtherOwnershipSelected())
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
                                                    controller: controller.guaranteeDescriptionOwnershipController,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 16.0,
                                                      fontFamily: 'IranYekan',
                                                      height: 1.6,
                                                    ),
                                                    keyboardType: TextInputType.multiline,
                                                    maxLines: null,
                                                    minLines: 3,
                                                    onChanged: (value) {
                                                      controller.update();
                                                    },
                                                    decoration: InputDecoration(
                                                      filled: false,
                                                      hintText: locale.ownership_type_explanation,
                                                      hintStyle: const TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14.0,
                                                      ),
                                                      errorText: controller.isGuaranteeDescriptionOwnershipValid
                                                          ? null
                                                          : locale.valid_explanation_required,
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
                                                        isVisible: controller
                                                            .guaranteeDescriptionOwnershipController.text.isNotEmpty,
                                                        clearFunction: () {
                                                          controller.guaranteeDescriptionOwnershipController.clear();
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
                                            if (controller.selectedGuaranteeOwnershipData != null &&
                                                controller.selectedGuaranteeOwnershipData!.id == 1)
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                   locale.hint_text_property_document,
                                                    style: ThemeUtil.titleStyle,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  TextField(
                                                    controller: controller.trackingCodeGuaranteeOwnershipController,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      LengthLimitingTextInputFormatter(20),
                                                      FilteringTextInputFormatter.digitsOnly
                                                    ],
                                                    textDirection: TextDirection.ltr,
                                                    textAlign: TextAlign.center,
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
                                                      errorText: controller.isTrackingCodeGuaranteeOwnershipValid
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
                                                        isVisible: controller
                                                            .trackingCodeGuaranteeOwnershipController.text.isNotEmpty,
                                                        clearFunction: () {
                                                          controller.trackingCodeGuaranteeOwnershipController.clear();
                                                          controller.update();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16.0),
                                                ],
                                              )
                                            else
                                              Container(),
                                            DocumentPickerWidget(
                                              title: locale.copy_guarantor_residence_document_or_lease,
                                              subTitle: '',
                                              cameraFunction: (documentId) {
                                                controller.selectDocumentImage(
                                                    documentId: documentId, imageSource: ImageSource.camera);
                                              },
                                              galleryFunction: (documentId) {
                                                controller.selectDocumentImage(
                                                    documentId: documentId, imageSource: ImageSource.gallery);
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
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    ContinueButtonWidget(
                                      callback: () {
                                        controller.validateGuaranteeAddress();
                                      },
                                      isLoading: controller.isLoading,
                                      buttonTitle: locale.submit_button,
                                    ),
                                  ],
                                )
                              else
                                Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
