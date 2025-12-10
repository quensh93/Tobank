import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/check_submit_controller.dart';
import '../../../../model/pichak/response/pichak_reason_type_list_response.dart';
import '../../../../util/constants.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../common/text_field_clear_icon_widget.dart';
import '../../../common/text_field_error_widget.dart';
import '../widget/receiver_item_widget.dart';

class CheckSubmitReceiverPage extends StatelessWidget {
  const CheckSubmitReceiverPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<CheckSubmitController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    locale.amount,
                    style: ThemeUtil.titleStyle,
                  ),
                  Text(
                    controller.getAmountDetail(),
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  controller.validateAmountValue(value);
                },
                controller: controller.amountController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  fontFamily: 'IranYekan',
                ),
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(Constants.amountLength),
                  FilteringTextInputFormatter.digitsOnly
                ],
                textDirection: TextDirection.ltr,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  filled: false,
                  hintText: locale.enter_cheque_amount_in_rials,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isAmountValid ? null :locale.valid_amount_error,
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
                    isVisible: controller.amountController.text.isNotEmpty,
                    clearFunction: () {
                      controller.clearAmountTextField();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.due_date,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    controller.showSelectDateDialog(context);
                  },
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      IgnorePointer(
                        child: TextField(
                          controller: controller.dateController,
                          enabled: true,
                          readOnly: true,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.select_cheque_date,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isDateValid ? null : locale.valid_cheque_date_error,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgIcon(
                          SvgIcons.calendar,
                          colorFilter: ColorFilter.mode(context.theme.colorScheme.secondary, BlendMode.srcIn),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                locale.reason_type_note,
                textAlign: TextAlign.right,
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
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    value: controller.selectedReasonType,
                    hint: Text(
                      locale.select_reason_type,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    items: controller.reasonTypeListResponse.data!.map((ReasonType item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item.faTitle ?? '',
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (ReasonType? newValue) {
                      controller.setSelectedReasonType(newValue!);
                    },
                  ),
                ),
              ),
              TextFieldErrorWidget(
                isValid: controller.isReasonTypeValid,
                errorText: locale.select_reason_type,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                locale.cheque_description,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: controller.descriptionController,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
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
                  hintText:locale.enter_cheque_description,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                  errorText: controller.isDescriptionValid ? null : locale.cheque_description_error,
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
                    isVisible: controller.descriptionController.text.isNotEmpty,
                    clearFunction: () {
                      controller.descriptionController.clear();
                      controller.update();
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ReceiverItemWidget(
                      receiverInquiryResponse: controller.registrationRequest.receiverInquiryResponseList![index],
                      deleteFunction: (receiverData) {
                        controller.deleteReceiverData(receiverData);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 16.0,
                    );
                  },
                  itemCount: controller.registrationRequest.receiverInquiryResponseList!.length),
              const SizedBox(
                height: 24.0,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () {
                  controller.showAddReceiverBottomSheet();
                },
                child: Row(
                  children: [
                    SvgIcon(
                      SvgIcons.addPlus,
                      colorFilter: ColorFilter.mode(ThemeUtil.textTitleColor, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 8.0),
                    Text(locale.add_cheque_receiver,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ContinueButtonWidget(
                callback: () {
                  controller.validateFourthPage();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.continue_label,
              ),
            ],
          ),
        ),
      );
    });
  }
}
