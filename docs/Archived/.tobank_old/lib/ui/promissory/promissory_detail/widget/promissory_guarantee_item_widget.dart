import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../model/promissory/promissory_single_info.dart';
import '../../../../../util/theme/theme_util.dart';
import '../../../../../widget/svg/svg_icon.dart';
import '../../../common/key_value_widget.dart';

class PromissoryGuaranteeItemWidget extends StatelessWidget {
  const PromissoryGuaranteeItemWidget({
    required this.guarantor,
    required this.isLoading,
    required this.showFilePdfCallback,
    super.key,
  });

  final Guarantor guarantor;
  final bool isLoading;
  final Function(Guarantor guarantor) showFilePdfCallback;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
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
                        locale.guarantor_info,
                        style: ThemeUtil.titleStyle,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showFilePdfCallback(guarantor);
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
                  valueString: guarantor.creationDate ?? '',
                ),
                const SizedBox(
                  height: 16.0,
                ),
                KeyValueWidget(
                  keyString: locale.national_code_title,
                  valueString: guarantor.guaranteeNn ?? '',
                ),
                const SizedBox(
                  height: 16,
                ),
                KeyValueWidget(
                  keyString: locale.guarantor_mobile_number,
                  valueString: '0${guarantor.guaranteeCellphone}',
                ),
                const SizedBox(
                  height: 16,
                ),
                KeyValueWidget(
                  keyString: locale.full_name,
                  valueString: guarantor.guaranteeFullName ?? '',
                ),
                const SizedBox(
                  height: 16,
                ),
                KeyValueWidget(
                  keyString: locale.deposit_info,
                  valueString: guarantor.guaranteeAccountNumber ?? '-',
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.address_of_residence,
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
                  guarantor.guaranteeAddress ?? '',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    height: 1.4,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  locale.description,
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
                  guarantor.description ?? '-',
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
