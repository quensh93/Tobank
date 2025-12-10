import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../../model/promissory/promissory_list_info_detailed.dart';
import '../../../../../../util/theme/theme_util.dart';

class SelectFinalizedPublishedPromissoryItemWidget extends StatelessWidget {
  const SelectFinalizedPublishedPromissoryItemWidget({
    required this.promissory,
    required this.selectedPromissory,
    required this.setSelectedPromissoryFunction,
    super.key,
  });

  final PromissoryListInfoDetail promissory;
  final PromissoryListInfoDetail? selectedPromissory;
  final Function(PromissoryListInfoDetail promissoryListInfoDetail) setSelectedPromissoryFunction;

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selectedPromissory != null && promissory.promissoryId == selectedPromissory!.promissoryId
                  ? context.theme.colorScheme.secondary
                  : context.theme.dividerColor,
            ),
          ),
          child: InkWell(
            onTap: () {
              setSelectedPromissoryFunction(promissory);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Row(
                children: [
                  Radio(
                    activeColor: context.theme.colorScheme.secondary,
                    value: promissory,
                    groupValue: selectedPromissory,
                    onChanged: (PromissoryListInfoDetail? promissoryListInfoDetail) {
                      setSelectedPromissoryFunction(promissory);
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                locale.treasury_identifier,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                promissory.promissoryId!,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${locale.registration_date}:',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                promissory.creationDate!,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
