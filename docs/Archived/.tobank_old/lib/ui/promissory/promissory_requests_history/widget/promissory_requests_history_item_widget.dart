import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../model/promissory/response/promissory_request_history_response_data.dart';
import '../../../../../util/app_util.dart';
import '../../../../../util/persian_date.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/key_value_widget.dart';

class PromissoryRequestsHistoryItemWidget extends StatelessWidget {
  const PromissoryRequestsHistoryItemWidget({
    required this.promissoryRequest,
    required this.cancelRequestFunction,
    required this.continueRequestFunction,
    super.key,
  });

  final PromissoryRequest promissoryRequest;
  final Function() cancelRequestFunction;
  final Function() continueRequestFunction;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.theme.dividerColor,
            ),
          ),
          child: Column(
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        promissoryRequest.faServiceName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          height: 1.6,
                        ),
                      ),
                      if (promissoryRequest is PublishRequest) ...publishColumn(promissoryRequest as PublishRequest),
                      if (promissoryRequest is EndorsementRequest)
                        ...endorsementColumn(promissoryRequest as EndorsementRequest),
                      if (promissoryRequest is GuaranteeRequest)
                        ...guaranteeColumn(promissoryRequest as GuaranteeRequest),
                      if (promissoryRequest is SettlementRequest)
                        ...settlementColumn(promissoryRequest as SettlementRequest),
                      if (promissoryRequest is SettlementGradualRequest)
                        ...settlementGradualColumn(promissoryRequest as SettlementGradualRequest),
                      const SizedBox(
                        height: 16,
                      ),
                      KeyValueWidget(
                        keyString: locale.registration_date,
                        valueString: _getDate(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 56.0,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {
                          continueRequestFunction();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgIcon(
                                SvgIcons.promissoryContinue,
                                colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                                size: 24.0,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                               Flexible(
                                child: Text(
                                  locale.continue_request,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: context.theme.dividerColor,
                      width: 2,
                      height: 32.0,
                    ),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {
                          cancelRequestFunction();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SvgIcon(
                                SvgIcons.promissoryCancel,
                                size: 24.0,
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Flexible(
                                child: Text(
                                  locale.cancel_request_button,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ],
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

  String _getDate() {
    final PersianDate persianDate = PersianDate();
    final String date = promissoryRequest.createdAt!;
    return persianDate.parseToFormat(date, 'd MM yyyy - HH:nn');
  }

  // TODO: Check extra data
  List<Widget> publishColumn(PublishRequest publishRequest) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return <Widget>[
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.recipient_name_,
        valueString: publishRequest.recipientFullName ?? '-',
      ),
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.commitment_amount,
        valueString: locale.amount_format(AppUtil.formatMoney(publishRequest.amount)),
      ),
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.payment_date,
        valueString: publishRequest.dueDate ?? locale.due_on_demand,
      ),
    ];
  }

  // TODO: Check extra data
  List<Widget> endorsementColumn(EndorsementRequest endorsementRequest) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return <Widget>[
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.unique_promissory_id,
        valueString: endorsementRequest.promissoryId ?? '-',
      ),
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.recipient_name_,
        valueString: endorsementRequest.recipientFullName ?? '-',
      ),
    ];
  }

  // TODO: Check extra data
  List<Widget> guaranteeColumn(GuaranteeRequest guaranteeRequest) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return <Widget>[
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.unique_promissory_id,
        valueString: guaranteeRequest.promissoryId ?? '-',
      ),
    ];
  }

  // TODO: Check extra data
  List<Widget> settlementColumn(SettlementRequest settlementRequest) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return <Widget>[
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.unique_promissory_id,
        valueString: settlementRequest.promissoryId ?? '-',
      ),
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.promissory_owner_national_code,
        valueString: settlementRequest.ownerNn ?? '-',
      ),
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.settlement_amount,
        valueString: locale.amount_format(AppUtil.formatMoney(settlementRequest.settlementAmount)),
      ),
    ];
  }

  // TODO: Check extra data
  List<Widget> settlementGradualColumn(SettlementGradualRequest settlementGradualRequest) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return <Widget>[
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.unique_promissory_id,
        valueString: settlementGradualRequest.promissoryId ?? '-',
      ),
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.promissory_owner_national_code,
        valueString: settlementGradualRequest.ownerNn ?? '-',
      ),
      const SizedBox(
        height: 16,
      ),
      KeyValueWidget(
        keyString: locale.settlement_amount,
        valueString: locale.amount_format(AppUtil.formatMoney(settlementGradualRequest.settlementAmount)),
      ),
    ];
  }
}
