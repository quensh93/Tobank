import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/util/theme/theme_util.dart';
import '/widget/button/continue_button_widget.dart';
import '../../../../../controller/parsa_loan/parsa_loan_customer_address_controller.dart';
import '../../../../../model/bpms/parsa_loan/response/residency_type_list_response_data.dart';
import '../../../common/document_picker_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../../../common/text_field_error_widget.dart';

class ParsaLoanAddressPage extends StatelessWidget {
  const ParsaLoanAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanCustomerAddressController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.applicant_address_information,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.dear_user_message_living_place_Lease,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: context.theme.dividerColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            elevation: Get.isDarkMode ? 1 : 0,
                            margin: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: const Radius.circular(8),
                                  bottom: controller.isShowAddress ? Radius.zero : const Radius.circular(8)),
                              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    locale.residence_address_information,
                                    style: ThemeUtil.titleStyle,
                                  ),
                                  InkWell(
                                    onTap: controller.toggleIsShowAddress,
                                    child: controller.isShowAddress
                                        ? const Icon(Icons.keyboard_arrow_up)
                                        : const Icon(Icons.keyboard_arrow_down),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (controller.isShowAddress)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(locale.applicant_postal_code, style: ThemeUtil.titleStyle),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    crossAxisAlignment: controller.isPostalCodeValid
                                        ? CrossAxisAlignment.center
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            TextField(
                                              controller: controller.customerPostalCodeController,
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
                                                controller.resetCustomerAddressInputs();
                                              },
                                              decoration: InputDecoration(
                                                filled: false,
                                                hintText: locale.enter_your_postal_code,
                                                hintStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.0,
                                                ),
                                                errorText: controller.isPostalCodeValid
                                                    ? null
                                                    : controller.customerPostalCodeErrorMessage,
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
                                                  isVisible: controller.customerPostalCodeController.text.isNotEmpty,
                                                  clearFunction: () {
                                                    controller.clearPostalCodeTextField();
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
                                                controller.validateCustomerAddressInquiry();
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
                                  Text(locale.province, style: ThemeUtil.titleStyle),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  TextField(
                                    controller: controller.provinceController,
                                    enabled: false,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      fontFamily: 'IranYekan',
                                    ),
                                    minLines: 1,
                                    maxLines: 3,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      filled: false,
                                      hintText: locale.inquire_about_postal_code,
                                      hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                      ),
                                      errorText:
                                          controller.isProvinceValid ? null : locale.inquire_about_postal_code,
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
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(locale.city, style: ThemeUtil.titleStyle),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  TextField(
                                    controller: controller.cityController,
                                    textAlign: TextAlign.right,
                                    enabled: false,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                      fontFamily: 'IranYekan',
                                    ),
                                    minLines: 1,
                                    maxLines: 3,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      filled: false,
                                      hintText: locale.inquire_about_postal_code,
                                      hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                      ),
                                      errorText: controller.isCityValid ? null : locale.inquire_about_postal_code,
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
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(locale.applicant_residential_address, style: ThemeUtil.titleStyle),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  TextField(
                                    controller: controller.customerAddressController,
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
                                      hintText: locale.address_hint_text,
                                      hintStyle: ThemeUtil.hintStyle,
                                      errorText: controller.isAddressValid
                                          ? null
                                          : locale.postal_address_error_text,
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
                                        isVisible: controller.customerAddressController.text.isNotEmpty,
                                        clearFunction: () {
                                          controller.customerAddressController.clear();
                                          controller.update();
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                ],
                              ),
                            )
                          else
                            Container(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: context.theme.dividerColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            elevation: Get.isDarkMode ? 1 : 0,
                            margin: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: const Radius.circular(8),
                                  bottom: controller.isShowOwnership ? Radius.zero : const Radius.circular(8)),
                              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    locale.residence_ownership_information,
                                    style: ThemeUtil.titleStyle,
                                  ),
                                  InkWell(
                                    onTap: controller.toggleIsShowOwnership,
                                    child: controller.isShowOwnership
                                        ? const Icon(Icons.keyboard_arrow_up)
                                        : const Icon(Icons.keyboard_arrow_down),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (controller.isShowOwnership)
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(locale.ownership_type, style: ThemeUtil.titleStyle),
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
                                        items: controller.ownershipData.map((ResidencyType item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              item.faTitle!,
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
                                        onChanged: (ResidencyType? newValue) {
                                          controller.setCustomerOwnershipData(newValue!);
                                        },
                                      ),
                                    ),
                                  ),
                                  TextFieldErrorWidget(
                                    isValid: controller.isSelectedCustomerOwnershipValid,
                                    errorText: locale.ownership_type_error,
                                  ),
                                  if (controller.selectedCustomerOwnershipData == null)
                                    Container()
                                  else if (controller.selectedCustomerOwnershipData!.type == 'RENTAL')
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(
                                          height: 16.0,
                                        ),
                                        Text(
                                          locale.tracking_code_rent,
                                          style: ThemeUtil.titleStyle,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        TextField(
                                          controller: controller.trackingCodeCustomerOwnershipController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
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
                                              isVisible:
                                                  controller.trackingCodeCustomerOwnershipController.text.isNotEmpty,
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
                                  else if (controller.selectedCustomerOwnershipData!.type == 'OTHERS')
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        const SizedBox(
                                          height: 16.0,
                                        ),
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
                                            errorText: controller.isDescriptionOwnershipValid
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
                                    ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    locale.address_match_warning,
                                    style: TextStyle(
                                        color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w500, fontSize: 16.0),
                                  ),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  DocumentPickerWidget(
                                    title: locale.document_picker_title,
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
                            )
                          else
                            Container()
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ContinueButtonWidget(
                      callback: () {
                        controller.validateCustomerAddress();
                      },
                      isLoading: controller.isLoading,
                      buttonTitle: locale.submit_button,
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
