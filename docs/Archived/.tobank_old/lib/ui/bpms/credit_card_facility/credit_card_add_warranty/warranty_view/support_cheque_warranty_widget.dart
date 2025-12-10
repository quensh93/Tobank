import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../controller/bpms/credit_card_facility/credit_card_add_warranty_controller.dart';
import '../../../../../../util/theme/theme_util.dart';
import '../../../../common/document_picker_widget.dart';
import '../../../../common/text_field_clear_icon_widget.dart';

class SupportChequeWarrantyWidget extends StatelessWidget {
  const SupportChequeWarrantyWidget({required this.pageIndex, super.key});

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;

    return GetBuilder<CreditCardAddWarrantyController>(builder: (controller) {
      return Column(
        children: [
          Text(
            locale.guarantee_cheque_upload_message,
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
          Text(
            locale.cheque_id_title,
            style: ThemeUtil.titleStyle,
          ),
          const SizedBox(
            height: 8.0,
          ),
          TextField(
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              fontFamily: 'IranYekan',
            ),
            controller: controller.chequeIdController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
            textDirection: TextDirection.ltr,
            onChanged: (value) {
              controller.update();
            },
            decoration: InputDecoration(
              filled: false,
              hintText: locale.saayad_cheque_id_hint,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
              errorText: controller.isChequeIdValid ? null : locale.saayad_id_error,
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
                isVisible: controller.chequeIdController.text.isNotEmpty,
                clearFunction: () {
                  controller.chequeIdController.clear();
                  controller.update();
                },
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          DocumentPickerWidget(
            title: locale.guarantee_cheque_upload_title,
            subTitle: '',
            cameraFunction: (documentId) {
              controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.camera);
            },
            galleryFunction: (documentId) {
              controller.selectDocumentImage(documentId: documentId, imageSource: ImageSource.gallery);
            },
            isUploading: controller.isUploading,
            isUploaded: controller.isUploaded(pageIndex),
            deleteDocumentFunction: (documentId) {
              controller.deleteDocument(documentId);
            },
            documentId: pageIndex,
            selectedDocumentId: controller.selectedDocumentId,
            selectedImageFile: controller.collateralsImages[pageIndex],
          ),
        ],
      );
    });
  }
}
