import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/process_detail/process_detail_controller.dart';
import '../../../../util/app_util.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../common/key_value_widget.dart';
import '../process_detail_item.dart';

class ProcessDetailPage extends StatelessWidget {
  const ProcessDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<ProcessDetailController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: [
                Text(
                  controller.processDetailResponse!.data!.process!.processDefinitionName ?? '',
                  style: TextStyle(
                    color: ThemeUtil.textTitleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    height: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                KeyValueWidget(
                    keyString: locale.process_start_time,
                    valueString: DateConverterUtil.getJalaliDateTimeFromTimestamp(
                        controller.processDetailResponse!.data!.process!.startTime!)),
                const SizedBox(
                  height: 16.0,
                ),
                KeyValueWidget(keyString: locale.process_status, valueString: controller.getRequestStatusText()),
                if (controller.processDetailResponse!.data!.process!.processDefinitionKey == 'MilitaryLG' &&
                    controller.processDetailResponse!.data!.process!.variables!.requestResult == 'REJECTED')
                  Column(
                    children: [
                      const SizedBox(height: 16.0),
                       KeyValueWidget(
                        keyString: locale.process_result_rejected,
                        valueString: locale.request_rejected,
                      ),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.process_detail,
                        valueString:
                            controller.processDetailResponse!.data!.process!.variables!.requestResultDescription ?? '',
                      ),
                    ],
                  )
                else
                  Container(),
                if (controller.processDetailResponse!.data!.process!.processDefinitionKey == 'DepositClosing')
                  Column(
                    children: [
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.deposit_number,
                        valueString: controller.processDetailResponse!.data!.process!.variables!.sourceDeposit ?? '',
                      ),
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.process_detail,
                        valueString:
                            controller.processDetailResponse!.data!.process!.variables!.depositClosingDescription ?? '',
                      ),
                    ],
                  )
                else
                  Container(),
                if (controller.processDetailResponse!.data!.process!.processDefinitionKey == 'CreditCardReception')
                  Column(
                    children: [
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                          keyString: locale.loan_amount,
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.creditCardAmount()))),
                    ],
                  )
                else
                  Container(),
                if (controller.processDetailResponse!.data!.process!.processDefinitionKey == 'RayanCardRequest')
                  Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      KeyValueWidget(
                          keyString: locale.loan_amount,
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.creditCardAmount()))),
                      if (controller.processDetailResponse!.data!.process!.variables!.promissoryId != null)
                        Column(
                          children: [
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.promissory_id_treasury,
                              valueString: controller.processDetailResponse!.data!.process!.variables!.promissoryId!,
                            ),
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.promissory_amount,
                              valueString:
                                  locale.amount_format(AppUtil.formatMoney(controller.processDetailResponse!.data!.process!.variables!.promissoryAmount!.toInt())),
                            ),
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.promissory_due_date,
                              valueString: controller
                                          .processDetailResponse!.data!.process!.variables!.promissoryDueDate !=
                                      null
                                  ? DateConverterUtil.getDibaliteDateFromMilisecondsTimestamp(
                                      controller.processDetailResponse!.data!.process!.variables!.promissoryDueDate!)
                                  : locale.due_on_demand,
                            ),
                          ],
                        )
                      else
                        Container(),
                    ],
                  )
                else
                  Container(),
                if (controller.processDetailResponse!.data!.process!.processDefinitionKey == 'MarriageLoan')
                  Column(
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ),
                      KeyValueWidget(
                          keyString: locale.marriage_loan_amount,
                          valueString: locale.amount_format(AppUtil.formatMoney(controller.creditCardAmount())),
                      )],
                  )
                else
                  Container(),
                if (controller.processDetailResponse!.data!.process!.processDefinitionKey ==
                    'InternetBankingAccountCreationRequest')
                  Container()
                else
                  Container(),
                if (controller.processDetailResponse!.data!.process!.processDefinitionKey ==
                    'MobileBankingAccountCreationRequest')
                  Container()
                else
                  Container(),
                if (controller.processDetailResponse!.data!.process!.processDefinitionKey == 'CardReissuanceRequest')
                  Column(
                    children: [
                      if (controller.processDetailResponse!.data!.process!.variables!.pan != null)
                        const SizedBox(
                          height: 16.0,
                        )
                      else
                        Container(),
                      if (controller.processDetailResponse!.data!.process!.variables!.pan != null)
                        Column(
                          children: [
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.card_number,
                              valueString: controller.processDetailResponse!.data!.process!.variables!.pan!.toString(),
                            ),
                          ],
                        )
                      else
                        Container(),
                      if (controller.processDetailResponse!.data!.process!.variables!.postBarcode != null)
                        Column(
                          children: [
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.parcel_code,
                              valueString: controller.processDetailResponse!.data!.process!.variables!.postBarcode!,
                            ),
                          ],
                        )
                      else
                        Container(),
                      if (controller.processDetailResponse!.data!.process!.variables!.postParcelStatus != null)
                        Column(
                          children: [
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.parcel_status,
                              valueString: controller.postParcelStatus(),
                            ),
                          ],
                        )
                      else
                        Container(),
                      if (controller.processDetailResponse!.data!.process!.variables!.requestResult == 'REJECTED')
                        Column(
                          children: [
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  locale.process_result_rejected,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    height: 1.6,
                                  ),
                                ),
                                Text(
                                  locale.request_rejected,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      else
                        Container(),
                      if (controller.processDetailResponse!.data!.process!.variables!.customerAddress != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: <Widget>[
                            const SizedBox(height: 16.0),
                            Text(
                              locale.address,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              controller.customerAddress(),
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0,
                                height: 1.6,
                              ),
                            ),
                          ],
                        )
                      else
                        Container(),
                    ],
                  )
                else
                  Container(),
                if (controller.processDetailResponse!.data!.process!.processDefinitionKey == 'CardIssuanceRequest')
                  Column(
                    children: [
                      if (controller.processDetailResponse!.data!.process!.variables!.pan != null)
                        Column(
                          children: [
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.card_number,
                              valueString: controller.processDetailResponse!.data!.process!.variables!.pan!.toString(),
                            ),
                          ],
                        )
                      else
                        Container(),
                      if (controller.processDetailResponse!.data!.process!.variables!.postBarcode != null)
                        Column(
                          children: [
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                                keyString: locale.parcel_code,
                                valueString: controller.processDetailResponse!.data!.process!.variables!.postBarcode!),
                          ],
                        )
                      else
                        Container(),
                      if (controller.processDetailResponse!.data!.process!.variables!.postParcelStatus != null)
                        Column(
                          children: [
                            const SizedBox(height: 16.0),
                            KeyValueWidget(keyString: locale.parcel_status, valueString: controller.postParcelStatus()),
                          ],
                        )
                      else
                        Container(),
                      if (controller.processDetailResponse!.data!.process!.variables!.customerAddress != null)
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.rtl,
                            children: <Widget>[
                              const SizedBox(height: 16.0),
                              Text(
                                locale.address,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                controller.customerAddress(),
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                  height: 1.6,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Container(),
                    ],
                  )
                else
                  Container(),
                if (controller.processDetailResponse!.data!.process!.processDefinitionKey == 'RetailLoan')
                  Column(
                    children: [
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.loan_amount,
                        valueString: locale.amount_format(AppUtil.formatMoney(controller.creditCardAmount())),
                      ),
                      if (controller.processDetailResponse!.data!.process!.variables!.promissoryId != null)
                        Column(
                          children: [
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.promissory_id,
                              valueString: controller.processDetailResponse!.data!.process!.variables!.promissoryId!,
                            ),
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.promissory_amount,
                              valueString:
                                  locale.amount_format(AppUtil.formatMoney(controller.processDetailResponse!.data!.process!.variables!.promissoryAmount!.toInt())),
                            ),
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.promissory_due_date,
                              valueString: controller
                                          .processDetailResponse!.data!.process!.variables!.promissoryDueDate !=
                                      null
                                  ? DateConverterUtil.getDibaliteDateFromMilisecondsTimestamp(
                                      controller.processDetailResponse!.data!.process!.variables!.promissoryDueDate!)
                                  : locale.due_on_demand,
                            ),
                          ],
                        )
                      else
                        Container(),
                    ],
                  )
                else
                  Container(),
                if (controller.processDetailResponse!.data!.process!.processDefinitionKey == 'MicroLendingLoan')
                  Column(
                    children: [
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.loan_amount,
                        valueString: locale.amount_format(AppUtil.formatMoney(controller.creditCardAmount())),
                      ),
                      if (controller.processDetailResponse!.data!.process!.variables!.promissoryId != null)
                        Column(
                          children: [
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.promissory_id_treasury,
                              valueString: controller.processDetailResponse!.data!.process!.variables!.promissoryId!,
                            ),
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.promissory_amount,
                              valueString:
                                  locale.amount_format(AppUtil.formatMoney(controller.processDetailResponse!.data!.process!.variables!.promissoryAmount!.toInt())),
                            ),
                            const SizedBox(height: 16.0),
                            KeyValueWidget(
                              keyString: locale.promissory_due_date,
                              valueString: controller
                                          .processDetailResponse!.data!.process!.variables!.promissoryDueDate !=
                                      null
                                  ? DateConverterUtil.getDibaliteDateFromMilisecondsTimestamp(
                                      controller.processDetailResponse!.data!.process!.variables!.promissoryDueDate!)
                                  : locale.due_on_demand,
                            ),
                          ],
                        )
                      else
                        Container(),
                    ],
                  )
                else
                  Container(),
                if (controller.processDetailResponse!.data?.process?.variables?.applicantAccepted ?? true)
                  Container()
                else
                  Column(
                    children: [
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                        keyString: locale.applicant_reject_reason,
                        valueString: controller.processDetailResponse!.data?.process?.variables?.rejectReason ?? '-',
                      ),
                    ],
                  ),
                if (controller.processDetailResponse!.data?.process?.variables?.finalApprovalStatus == 'REJECTED')
                  Column(
                    children: [
                      const SizedBox(height: 16.0),
                      KeyValueWidget(
                          keyString: locale.final_approval_reject_reason,
                          valueString:
                              controller.processDetailResponse!.data?.process?.variables?.finalApprovalRejectReason ??
                                  '-'),
                    ],
                  )
                else
                  Container(),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
              child: controller.processDetailResponse!.data!.tasks!.isEmpty
                  ? Container()
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                      itemBuilder: (context, index) {
                        return ProcessDetailItem(
                          processTask: controller.processDetailResponse!.data!.tasks![index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16.0,
                        );
                      },
                      itemCount: controller.processDetailResponse!.data!.tasks!.length,
                    )),
        ],
      );
    });
  }
}
