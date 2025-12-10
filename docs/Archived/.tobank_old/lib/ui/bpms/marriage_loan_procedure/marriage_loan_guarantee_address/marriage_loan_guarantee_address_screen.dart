import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../controller/bpms/marriage_loan_procedure/marriage_loan_guarantee_address_controller.dart';
import '../../../../../model/bpms/bpms_ownership_data.dart';
import '../../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../../model/bpms/response/get_task_data_response_data.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/button/continue_button_widget.dart';
import '../../../common/custom_app_bar.dart';
import '../../../common/document_picker_widget.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../../../common/text_field_error_widget.dart';

class MarriageLoanProcedureGuaranteeAddressScreen extends StatelessWidget {
  final Task task;
  final List<TaskDataFormField> taskData;

  const MarriageLoanProcedureGuaranteeAddressScreen({required this.task, required this.taskData, super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<MarriageLoanProcedureGuaranteeAddressController>(
      init: MarriageLoanProcedureGuaranteeAddressController(task: task, taskData: taskData),
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      locale.dear_user_message_living_place_Lease,
                                      style: TextStyle(
                                        color: ThemeUtil.textSubtitleColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
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
                                crossAxisAlignment:
                                    controller.isPostalCodeValid ? CrossAxisAlignment.center : CrossAxisAlignment.start,
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
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            LengthLimitingTextInputFormatter(10),
                                            FilteringTextInputFormatter.digitsOnly
                                          ],
                                          textInputAction: TextInputAction.next,
                                          onChanged: (value) {
                                            controller.isGuaranteeAddressInquirySuccessful = false;
                                            controller.update();
                                          },
                                          decoration: InputDecoration(
                                            filled: false,
                                            hintText:locale.enter_your_postal_code,
                                            hintStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                            ),
                                            errorText: controller.isPostalCodeValid
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
                                                controller.isGuaranteeAddressInquirySuccessful = false;
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
                              if (controller.isGuaranteeAddressInquirySuccessful)
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
                                              textAlign: TextAlign.right,
                                              style: ThemeUtil.titleStyle,
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: controller.guaranteeProvinceController,
                                                  enabled: false,
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                  ),
                                                  minLines: 1,
                                                  maxLines: 3,
                                                  textInputAction: TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    filled: false,
                                                    hintText: locale.guarantee_postcode_hint,
                                                    hintStyle: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                    errorText: controller.isGuaranteeProvinceValid
                                                        ? null
                                                        : locale.check_guarantor_postal_code,
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
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            Text(
                                              locale.city,
                                              textAlign: TextAlign.right,
                                              style: ThemeUtil.titleStyle,
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: controller.guaranteeCityController,
                                                  textAlign: TextAlign.right,
                                                  enabled: false,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                  ),
                                                  minLines: 1,
                                                  maxLines: 3,
                                                  textInputAction: TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    filled: false,
                                                    hintText: locale.guarantee_postcode_hint,
                                                    hintStyle: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                    errorText: controller.isGuaranteeCityValid
                                                        ? null
                                                        : locale.guarantee_postcode_hint,
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
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            Text(
                                              locale.county,
                                              textAlign: TextAlign.right,
                                              style: ThemeUtil.titleStyle,
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: controller.guaranteeTownshipController,
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                  ),
                                                  minLines: 1,
                                                  maxLines: 3,
                                                  textInputAction: TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    filled: false,
                                                    hintText: locale.please_enter_county_value,
                                                    hintStyle: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                    errorText: controller.isGuaranteeTownshipValid
                                                        ? null
                                                        : locale.please_enter_county_value,
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
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            Text(
                                              locale.main_street_label,
                                              textAlign: TextAlign.right,
                                              style: ThemeUtil.titleStyle,
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: controller.guaranteeLastStreetController,
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                  ),
                                                  minLines: 1,
                                                  maxLines: 3,
                                                  textInputAction: TextInputAction.next,
                                                  onChanged: (value) {
                                                    controller.update();
                                                  },
                                                  decoration: InputDecoration(
                                                    filled: false,
                                                    hintText: locale.guarantee_main_street_hint,
                                                    hintStyle: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                    errorText: controller.isGuaranteeLastStreetValid
                                                        ? null
                                                        : locale.main_street_error,
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
                                                          controller.guaranteeLastStreetController.text.isNotEmpty,
                                                      clearFunction: () {
                                                        controller.guaranteeLastStreetController.clear();
                                                        controller.update();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            Text(
                                              locale.secondary_street_label,
                                              textAlign: TextAlign.right,
                                              style: ThemeUtil.titleStyle,
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: controller.guaranteeSecondLastStreetController,
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                  ),
                                                  minLines: 1,
                                                  maxLines: 3,
                                                  textInputAction: TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    filled: false,
                                                    hintText: locale.enter_guarantor_secondary_street,
                                                    hintStyle: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                    errorText: controller.isGuaranteeSecondLastStreetValid
                                                        ? null
                                                        : locale.enter_side_street_value,
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
                                                          .guaranteeSecondLastStreetController.text.isNotEmpty,
                                                      clearFunction: () {
                                                        controller.guaranteeSecondLastStreetController.clear();
                                                        controller.update();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            Text(
                                              locale.plaque_label,
                                              textAlign: TextAlign.right,
                                              style: ThemeUtil.titleStyle,
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: controller.guaranteePlaqueController,
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                  ),
                                                  minLines: 1,
                                                  maxLines: 3,
                                                  textInputAction: TextInputAction.next,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  onChanged: (value) {
                                                    controller.update();
                                                  },
                                                  decoration: InputDecoration(
                                                    filled: false,
                                                      hintText: locale.enter_guarantor_plate,
                                                    hintStyle: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                    errorText: controller.isGuaranteePlaqueValid
                                                        ? null
                                                        : locale.plaque_error,
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
                                                      isVisible: controller.guaranteePlaqueController.text.isNotEmpty,
                                                      clearFunction: () {
                                                        controller.guaranteePlaqueController.clear();
                                                        controller.update();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            Text(
                                              locale.unit_label,
                                              textAlign: TextAlign.right,
                                              style: ThemeUtil.titleStyle,
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: controller.guaranteeUnitController,
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                  ),
                                                  minLines: 1,
                                                  maxLines: 3,
                                                  textInputAction: TextInputAction.next,
                                                  keyboardType: TextInputType.number,
                                                  inputFormatters: <TextInputFormatter>[
                                                    FilteringTextInputFormatter.digitsOnly
                                                  ],
                                                  decoration: InputDecoration(
                                                    filled: false,
                                                    hintText: locale.guarantee_unit_hint,
                                                    hintStyle: const TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14.0,
                                                    ),
                                                    errorText: controller.isGuaranteeUnitValid
                                                        ? null
                                                        : locale.unit_error,
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
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                             Text(
                                              locale.ownership_type,
                                              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
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
                                                    controller.setGuaranteeOwnershipData(newValue!);
                                                  },
                                                ),
                                              ),
                                            ),
                                            TextFieldErrorWidget(
                                              isValid: controller.isSelectedGuaranteeOwnershipValid,
                                              errorText:  locale.ownership_type_error,
                                            ),
                                            const SizedBox(
                                              height: 16.0,
                                            ),
                                            if (controller.selectedGuaranteeOwnershipData != null &&
                                                controller.selectedGuaranteeOwnershipData!.id == 2)
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                   Text(
                                                    locale.ownership_description,
                                                    style: const TextStyle(
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  TextField(
                                                    controller: controller.descriptionOwnershipController,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 16.0,
                                                      height: 1.4,
                                                    ),
                                                    keyboardType: TextInputType.multiline,
                                                    maxLines: null,
                                                    minLines: 4,
                                                    decoration: InputDecoration(
                                                      filled: false,
                                                      hintText: locale.ownership_description_hint,
                                                      hintStyle: const TextStyle(
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14.0,
                                                      ),
                                                      errorText: controller.isDescriptionOwnershipValid
                                                          ? null
                                                          : locale.ownership_description_error,
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
                                                    locale.tracking_code_rent,
                                                    style: const TextStyle(
                                                      height: 1.4,
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  TextField(
                                                    controller: controller.trackingCodeGuaranteeOwnershipController,
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
                                                    ),
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
                                                        horizontal: 20.0,
                                                        vertical: 16.0,
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
                                              title: locale.document_picker_title,
                                              subTitle: '',
                                              description: controller.documentFileDescription_1,
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
