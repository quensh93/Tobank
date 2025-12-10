import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/bpms/response/applicant_task_list_response_data.dart';
import '../../../../util/date_converter_util.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class ProcessItemWidget extends StatelessWidget {
  const ProcessItemWidget({
    required this.sampleTask,
    required this.onTapContinue,
    required this.onTapDetail,
    super.key,
  });

  final Task sampleTask;
  final Function onTapContinue;
  final Function onTapDetail;

  String getRequestTypeText() {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final String processKey = sampleTask.processDefinitionId!.split(':')[0];
    switch (processKey) {
      case 'CreditCardReception':
        return locale.rayan_card_request;
      case 'MarriageLoan':
        return locale.marriage_loan_gharz_hassane;
      case 'InternetBankingAccountCreationRequest':
        return locale.internet_banking_account_creation_request;
      case 'MobileBankingAccountCreationRequest':
        return locale.mobile_banking_account_creation_request;
      case 'CardIssuanceRequest':
        return locale.card_issuance_request;
      case 'CardReissuanceRequest':
        return locale.card_reissuance_request;
      case 'RayanCardRequest':
        return locale.rayan_card_request;
      case 'ChildrenLoan':
        return locale.children_loan;
      case 'DepositClosing':
        return locale.close_deposit;
      case 'DocumentsCompletion':
        return locale.documents_completion;
      case 'MilitaryLG':
        return locale.military_lg;
      case 'RetailLoan':
        return locale.retail_loan;
      case 'MicroLendingLoan':
        return locale.micro_lending_loan;
      default:
        return locale.default_unknown;
    }
  }

  bool hasDetail() {
    final String processKey = sampleTask.processDefinitionId!.split(':')[0];
    switch (processKey) {
      case 'DocumentsCompletion':
        return false;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: context.theme.dividerColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: Get.isDarkMode ? 1 : 0,
                margin: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${locale.request_type}${getRequestTypeText()}',
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            locale.next_step,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              sampleTask.name ?? '',
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (sampleTask.createTime != null) const SizedBox(height: 8) else Container(),
                      if (sampleTask.createTime != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              locale.registration_date,
                              style: TextStyle(
                                color: ThemeUtil.textSubtitleColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                DateConverterUtil.getJalaliFromTimestamp(sampleTask.createTime!),
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      else
                        Container(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    if (hasDetail())
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                            onTap: () => onTapDetail(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgIcon(
                                    Get.isDarkMode ? SvgIcons.detailDark : SvgIcons.detail,
                                    size: 24.0,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    locale.detail,
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Container(),
                    if (hasDetail())
                      Container(
                        color: context.theme.dividerColor,
                        width: 1,
                        height: 32.0,
                      )
                    else
                      Container(),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
                          onTap: () => onTapContinue(),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgIcon(
                                  Get.isDarkMode ? SvgIcons.continueProcessDark : SvgIcons.continueProcess,
                                  size: 24.0,
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  locale.continue_process,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
