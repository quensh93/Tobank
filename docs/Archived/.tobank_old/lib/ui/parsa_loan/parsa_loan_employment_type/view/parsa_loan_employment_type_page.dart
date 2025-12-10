import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../../util/theme/theme_util.dart';
import '../../../../../../../widget/button/continue_button_widget.dart';
import '../../../../../controller/parsa_loan/parsa_loan_employment_type_controller.dart';
import '../../../common/document_picker_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';

class ParsaLoanEmploymentTypePage extends StatelessWidget {
  const ParsaLoanEmploymentTypePage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ParsaLoanEmploymentTypeController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SingleChildScrollView(
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
                InkWell(
                  onTap: () {
                    controller.showSelectEmploymentTypeBottomSheet();
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      textDirection: TextDirection.ltr,
                      enabled: true,
                      enableInteractiveSelection: false,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        controller.update();
                      },
                      controller: controller.employmentTypeController,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: false,
                        hintText: locale.select_employment_type_,
                        hintStyle: ThemeUtil.hintStyle,
                        errorText: controller.isSelectedEmploymentValid ? null : locale.employment_type_error,
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
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                if (controller.selectedEmploymentData != null)
                  if (controller.selectedEmploymentData!.jobType == '1')
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
                                        locale.workplace_address_info,
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
                                      Text(locale.postal_code_label, style: ThemeUtil.titleStyle),
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
                                                  controller: controller.jobPostalCodeController,
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
                                                    hintText: locale.enter_postal_code_hint,
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
                                                      isVisible: controller.jobPostalCodeController.text.isNotEmpty,
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
                                          hintText: locale.verify_postal_code_hint,
                                          hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                          ),
                                          errorText:
                                              controller.isProvinceValid ? null : locale.please_verify_postal_code_hint,
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
                                          hintText: locale.verify_postal_code_hint,
                                          hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                          ),
                                          errorText: controller.isCityValid ? null : locale.please_verify_postal_code_hint,
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
                                      Text(locale.employee_workplace_address, style: ThemeUtil.titleStyle),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      TextField(
                                        controller: controller.jobAddressController,
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
                                            isVisible: controller.jobAddressController.text.isNotEmpty,
                                            clearFunction: () {
                                              controller.jobAddressController.clear();
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
                        Text(
                          locale.occupation_documents,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          locale.mandatory_documents,
                          style: ThemeUtil.hintStyle,
                        ),
                        const SizedBox(height: 24.0),
                        DocumentPickerWidget(
                          title: locale.salary_slip_or_employment_certificate,
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
                        const SizedBox(height: 12.0),
                        DocumentPickerWidget(
                          title: locale.salary_deduction_certificate,
                          subTitle: '',
                          cameraFunction: (documentId) {
                            controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.camera);
                          },
                          galleryFunction: (documentId) {
                            controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.gallery);
                          },
                          isUploading: controller.isUploading,
                          isUploaded: controller.isUploaded(2),
                          deleteDocumentFunction: (documentId) {
                            controller.deleteDocument(documentId);
                          },
                          documentId: 2,
                          selectedDocumentId: controller.selectedDocumentId,
                          selectedImageFile: controller.documentFile_2,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          controller.getCertificateSalaryDeductionAmount(),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: ThemeUtil.errorLightColor,
                          ),
                        ),
                      ],
                    )
                  else if (controller.selectedEmploymentData!.jobType == '3')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          locale.occupation_documents,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(height: 24.0),
                        DocumentPickerWidget(
                          title: locale.image_of_retirement,
                          subTitle: '',
                          cameraFunction: (documentId) {
                            controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.camera);
                          },
                          galleryFunction: (documentId) {
                            controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.gallery);
                          },
                          isUploading: controller.isUploading,
                          isUploaded: controller.isUploaded(3),
                          deleteDocumentFunction: (documentId) {
                            controller.deleteDocument(documentId);
                          },
                          documentId: 3,
                          selectedDocumentId: controller.selectedDocumentId,
                          selectedImageFile: controller.documentFile_3,
                        ),
                      ],
                    )
                  else if (controller.selectedEmploymentData!.jobType == '26')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          locale.occupation_documents,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(height: 24.0),
                        DocumentPickerWidget(
                          title: locale.business_license_image,
                          subTitle: '',
                          cameraFunction: (documentId) {
                            controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.camera);
                          },
                          galleryFunction: (documentId) {
                            controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.gallery);
                          },
                          isUploading: controller.isUploading,
                          isUploaded: controller.isUploaded(4),
                          deleteDocumentFunction: (documentId) {
                            controller.deleteDocument(documentId);
                          },
                          documentId: 4,
                          selectedDocumentId: controller.selectedDocumentId,
                          selectedImageFile: controller.documentFile_4,
                        ),
                      ],
                    )
                  else
                    Container(),
                const SizedBox(height: 32.0),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateEmploymentTypeScreen();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.continue_label,
                  isEnabled: controller.selectedEmploymentData != null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
