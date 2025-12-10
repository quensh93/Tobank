import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../../../../util/theme/theme_util.dart';
import '../../../../../core/entities/loan_details_entity.dart';
import '../../../../../core/theme/main_theme.dart';
import '../../../../../core/widgets/bottom_sheets/bottom_sheet_handler.dart';
import 'loan_payment_more_detail_bottom_sheet.dart';

class LoanPaymentMoreBottomSheet extends StatelessWidget {
  final LoanDetailsEntity data;
  final String title;

  const LoanPaymentMoreBottomSheet({
    required this.title,
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color:  MainTheme.of(context).onSurfaceVariant,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            locale.more_options,
            style: ThemeUtil.titleStyle,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: MainTheme.of(context).textTheme.bodyMedium
                .copyWith(color: MainTheme.of(context).surfaceContainer),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: ShapeDecoration(
                        color: MainTheme.of(context).surfaceContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          locale.soon,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode? Colors.black: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        locale.send_direct_link_pay_to_others,
                        textAlign: TextAlign.right,
                        style: MainTheme.of(context).textTheme.titleSmall
                            .copyWith(color:Get.isDarkMode?MainTheme.of(context).surfaceContainer.withOpacity(0.7) : MainTheme.of(context).surfaceContainer),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 16,
                thickness: 1,
                color: MainTheme.of(context).onSurface,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  showMainBottomSheet(
                      context: Get.context!,
                      bottomSheetWidget:
                           LoanPaymentMoreDetailBottomSheet(
                            data: data,
                          ));
                },
                splashColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          locale.loan_details_,
                          textAlign: TextAlign.right,
                          style: MainTheme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 16,
                thickness: 1,
                color:MainTheme.of(context).onSurface,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: ShapeDecoration(
                        color: MainTheme.of(context).surfaceContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          locale.soon,
                          textAlign: TextAlign.center,
                          style: MainTheme.of(context).textTheme.bodyLarge.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode? Colors.black: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        locale.loan_auto_payment,
                        textAlign: TextAlign.right,
                        style: MainTheme.of(context).textTheme.titleSmall
                            .copyWith(color:Get.isDarkMode?MainTheme.of(context).surfaceContainer.withOpacity(0.7): MainTheme.of(context).surfaceContainer),

                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
