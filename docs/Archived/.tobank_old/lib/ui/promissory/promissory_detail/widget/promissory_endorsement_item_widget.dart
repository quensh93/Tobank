import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../model/promissory/promissory_single_info.dart';
import '../../../../../util/enums_constants.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/key_value_widget.dart';

class PromissoryEndorsementItemWidget extends StatelessWidget {
  const PromissoryEndorsementItemWidget({
    required this.endorsement,
    required this.isLoading,
    required this.showFilePdfCallback,
    super.key,
  });

  final Endorsement endorsement;
  final bool isLoading;
  final Function(Endorsement endorsement) showFilePdfCallback;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    final isIndividual = endorsement.ownerType! == PromissoryCustomerType.individual;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            border: Border.all(
              color: context.theme.dividerColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        locale.transfer_information,
                        style: ThemeUtil.titleStyle,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showFilePdfCallback(endorsement);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: isLoading
                            ? SpinKitFadingCircle(
                                itemBuilder: (_, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: context.theme.iconTheme.color,
                                    ),
                                  );
                                },
                                size: 24.0,
                              )
                            :  Row(
                                children: [
                                  const SvgIcon(
                                    SvgIcons.promissoryShow,
                                    size: 24.0,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    locale.view_promissory_note,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                const Divider(thickness: 1),
                const SizedBox(height: 8.0),
                KeyValueWidget(
                  keyString: locale.registration_date,
                  valueString: endorsement.creationDate ?? '',
                ),
                const SizedBox(
                  height: 16.0,
                ),
                KeyValueWidget(
                  keyString: locale.registrant_name,
                  valueString: endorsement.ownerFullName ?? '',
                ),
                const SizedBox(
                  height: 16,
                ),
                KeyValueWidget(
                  keyString: isIndividual ?  locale.recipient_mobile_number : locale.recipient_phone_number,
                  valueString: isIndividual ? '0${endorsement.ownerCellphone}' : endorsement.ownerCellphone,
                ),
                const SizedBox(
                  height: 16,
                ),
                KeyValueWidget(
                  keyString: locale.recipient_name_,
                  valueString: endorsement.recipientFullName ?? '',
                ),
                const SizedBox(
                  height: 16,
                ),
                KeyValueWidget(
                  keyString: isIndividual ? locale.recipient_mobile_number : locale.recipient_phone_number,
                  valueString: isIndividual ? '0${endorsement.recipientCellphone}' : endorsement.recipientCellphone,
                ),
                const SizedBox(
                  height: 16,
                ),
                KeyValueWidget(
                  keyString: locale.issuer_deposit_info,
                  valueString: endorsement.ownerAccountNumber ?? '-',
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.residence_address,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  endorsement.ownerAddress ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.payment_address,
                  style: TextStyle(
                    color: ThemeUtil.textSubtitleColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    height: 1.4,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  endorsement.paymentPlace ?? '',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                 Text(
                  locale.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  endorsement.description ?? '-',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
