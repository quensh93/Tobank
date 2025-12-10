import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/deposit/transfer/deposit_transfer_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/button_with_icon.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../../widget/ui/dotted_separator_widget.dart';
import '../../../common/key_value_widget.dart';

class DepositTransferResultPage extends StatelessWidget {
  const DepositTransferResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DepositTransferController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16.0),
                    RepaintBoundary(
                      key: controller.globalKey,
                      child: Container(
                        color: Get.isDarkMode ? const Color(0xff1c222e) : const Color(0xffffffff),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Column(
                                children: <Widget>[
                                  SvgIcon(
                                    controller.getStatusIcon(),
                                    size: 56.0,
                                  ),
                                  const SizedBox(height: 16.0),
                                  Column(
                                    children: [
                                      Text(
                                        controller.transferResponseData!.data!.transferMessage ??
                                            controller.getTransferStatus(),
                                        style: TextStyle(
                                          color: ThemeUtil.textTitleColor,
                                          height: 1.6,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (controller.transferResponseData!.data!.message != null &&
                                          controller.transferResponseData!.data!.message!.isNotEmpty)
                                        const SizedBox(
                                          height: 16.0,
                                        )
                                      else
                                        Container(),
                                      if (controller.transferResponseData!.data!.message != null &&
                                          controller.transferResponseData!.data!.message!.isNotEmpty)
                                        Text(
                                          controller.transferResponseData!.data!.message ?? '',
                                          style: TextStyle(
                                            color: ThemeUtil.textSubtitleColor,
                                            height: 1.6,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      else
                                        Container(),
                                      if (controller.transferResponseData!.data!.errors != null &&
                                          controller.transferResponseData!.data!.errors!.isNotEmpty)
                                        Column(
                                          children: [
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Text(
                                              controller.transferResponseData!.data!.errors![0].errorDescription ?? '',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: ThemeUtil.textSubtitleColor,
                                                height: 1.6,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        )
                                      else
                                        Container(),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                              Card(
                                elevation: 0,
                                margin: EdgeInsets.zero,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      KeyValueWidget(
                                        keyString: locale.transfer_type,
                                        valueString: controller.selectedTransferMethodData!.title,
                                      ),
                                      const DottedSeparatorWidget(),
                                      KeyValueWidget(
                                        keyString: locale.transfer_amount,
                                        valueString: locale.amount_format(AppUtil.formatMoney(controller.amount)),
                                      ),
                                      const DottedSeparatorWidget(),
                                      if (controller.transferResponseData!.data!.registrationDate != null)
                                        Column(
                                          children: [
                                            KeyValueWidget(
                                              keyString: locale.transfer_time,
                                              valueString: DateConverterUtil.getJalaliDateTimeFromTimestamp(
                                                  controller.transferResponseData!.data!.registrationDate!),
                                            ),
                                            const DottedSeparatorWidget(),
                                          ],
                                        )
                                      else
                                        Container(),
                                      KeyValueWidget(
                                        keyString: locale.destination_deposit_number,
                                        valueString: controller.deposit!.depositNumber,
                                      ),
                                      const DottedSeparatorWidget(),
                                      KeyValueWidget(
                                        keyString: controller.isIBAN ? locale.destination_deposit_number : locale.destination_shaba,
                                        valueString: controller.destinationDeposit,
                                      ),
                                      const DottedSeparatorWidget(),
                                      KeyValueWidget(
                                        keyString: locale.destination_account_owner,
                                        valueString: controller.getDestinationCustomer(),
                                      ),
                                      const DottedSeparatorWidget(),
                                      if(controller.referenceNumberController.text != '')
                                        KeyValueWidget(
                                          keyString: locale.pay_id,
                                          valueString: controller.referenceNumberController.text,
                                        ),
                                      if(controller.referenceNumberController.text != '')
                                        const DottedSeparatorWidget(),
                                      KeyValueWidget(
                                        keyString: controller.showExternalTransactionId()
                                            ? locale.bank_tracking_number
                                            : locale.system_tracking_number,
                                        valueString: controller.getTrackingCode(),
                                      ),
                                      if (controller.localDescriptionController.text.isNotEmpty)
                                        Column(
                                          children: [
                                            const DottedSeparatorWidget(),
                                            KeyValueWidget(
                                              keyString: '${locale.from_description}:',
                                              valueString: controller.localDescriptionController.text,
                                            ),
                                          ],
                                        )
                                      else
                                        Container(),
                                      if (controller.transactionDescriptionController.text.isNotEmpty)
                                        Column(
                                          children: [
                                            const DottedSeparatorWidget(),
                                            KeyValueWidget(
                                              keyString: locale.transaction_description,
                                              valueString: controller.transactionDescriptionController.text,
                                            ),
                                          ],
                                        )
                                      else
                                        Container(),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SvgIcon(
                                    SvgIcons.tobank,
                                    size: 48.0,
                                  ),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  Container(
                                      width: 1,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: context.theme.dividerColor,
                                      )),
                                  const SizedBox(
                                    width: 12.0,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        locale.virtual_branch_with_you,
                                        style: TextStyle(
                                          color: ThemeUtil.textTitleColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8.0),
                                      Text(locale.website,
                                          style: TextStyle(
                                            color: ThemeUtil.textSubtitleColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: (kIsWeb || Platform.isIOS)
                          ? Row(
                        children: [
                          Expanded(
                            child: ButtonWithIcon(
                              buttonTitle: locale.sharing,
                              buttonIcon: SvgIcons.shareImage,
                              onPressed: controller.captureAndShareTransactionImage,
                              isLoading: controller.shareLoading,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: ButtonWithIcon(
                              buttonTitle: locale.save_to_gallery,
                              buttonIcon: SvgIcons.shareText,
                              onPressed: controller.shareTransactionText,
                              isLoading: controller.storeLoading,
                            ),
                          ),
                        ],
                      )
                          : Row(
                        children: [
                          Expanded(
                            child: ButtonWithIcon(
                              buttonTitle: locale.receipt_image,
                              buttonIcon: SvgIcons.share,
                              onPressed: controller.showShareTransactionBottomSheet,
                              isLoading: controller.shareLoading,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: ButtonWithIcon(
                              buttonTitle: locale.receipt_text,
                              buttonIcon: SvgIcons.download,
                              onPressed: controller.captureAndSaveTransactionImage,
                              isLoading: controller.storeLoading,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
