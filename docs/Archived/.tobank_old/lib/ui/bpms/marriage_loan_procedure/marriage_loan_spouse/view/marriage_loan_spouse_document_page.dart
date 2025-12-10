import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../controller/bpms/marriage_loan_procedure/marriage_loan_spouse_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../../../widget/button/continue_button_widget.dart';
import '../../../../common/document_picker_widget.dart';
import '../../../../common/text_field_clear_icon_widget.dart';

class MarriageLoanProcedureSpouseDocumentPage extends StatelessWidget {
  const MarriageLoanProcedureSpouseDocumentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MarriageLoanProcedureSpouseController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  locale.spouse_identity_documents_upload,
                  style: ThemeUtil.titleStyle,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.spouse_documents_info,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.no_spouse_national_card,
                      style: ThemeUtil.titleStyle,
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 36.0,
                      height: 24.0,
                      child: Transform.scale(
                        scale: 0.7,
                        transformHitTests: false,
                        child: CupertinoSwitch(
                          activeColor: context.theme.colorScheme.secondary,
                          onChanged: (bool value) {
                            controller.setNoSpouseNationalCard(value);
                          },
                          value: controller.noSpouseNationalCard,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                if (controller.noSpouseNationalCard)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        locale.spouse_national_card_tracking_number,
                        style: ThemeUtil.titleStyle,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        controller: controller.spouseNationalCodeTrackingNumberController,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          fontFamily: 'IranYekan',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: false,
                          hintText: locale.spouse_national_card_tracking_number_hint,
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                          ),
                          errorText: controller.isSpouseNationalCodeTrackingNumberValid
                              ? null
                              : locale.spouse_national_card_tracking_number_error,
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
                            isVisible: controller.spouseNationalCodeTrackingNumberController.text.isNotEmpty,
                            clearFunction: () {
                              controller.spouseNationalCodeTrackingNumberController.clear();
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                    ],
                  )
                else
                  Container(),
                DocumentPickerWidget(
                  title: locale.birth_certificate_page_one_two,
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
                  height: 16.0,
                ),
                DocumentPickerWidget(
                  title: locale.birth_certificate_page_three_four,
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
                const SizedBox(
                  height: 16.0,
                ),
                DocumentPickerWidget(
                  title: locale.birth_certificate_page_five_six,
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
                const SizedBox(
                  height: 16.0,
                ),
                if (controller.noSpouseNationalCard)
                  Container()
                else
                  Column(
                    children: [
                      DocumentPickerWidget(
                        title: locale.front_national_card_image,
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
                      const SizedBox(
                        height: 16.0,
                      ),
                      DocumentPickerWidget(
                        title: locale.back_national_card_image,
                        subTitle: '',
                        cameraFunction: (documentId) {
                          controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.camera);
                        },
                        galleryFunction: (documentId) {
                          controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.gallery);
                        },
                        isUploading: controller.isUploading,
                        isUploaded: controller.isUploaded(5),
                        deleteDocumentFunction: (documentId) {
                          controller.deleteDocument(documentId);
                        },
                        documentId: 5,
                        selectedDocumentId: controller.selectedDocumentId,
                        selectedImageFile: controller.documentFile_5,
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 40,
                ),
                ContinueButtonWidget(
                  callback: () {
                    controller.validateSpouseBirthCertificate();
                  },
                  isLoading: controller.isLoading,
                  buttonTitle: locale.submit_button,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
