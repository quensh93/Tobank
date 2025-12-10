import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/pichak/owner_credit_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';
import '../../../../widget/ui/dotted_line_widget.dart';
import '../../../common/key_value_widget.dart';
import '../widget/owner_item_widget.dart';

class OwnerCreditInquiryResultPage extends StatelessWidget {
  const OwnerCreditInquiryResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<OwnerCreditController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          locale.inquiry_details,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        MySeparator(color: context.theme.dividerColor),
                        const SizedBox(height: 16.0),
                        KeyValueWidget(
                          keyString: locale.shaba_number ,
                          valueString: controller.creditInquiryResponse.iban,
                        ),
                        const SizedBox(height: 16.0),
                        MySeparator(color: context.theme.dividerColor),
                        const SizedBox(height: 16.0),
                        KeyValueWidget(
                          keyString: locale.bank_code_title,
                          valueString: controller.creditInquiryResponse.bankCode.toString(),
                        ),
                        const SizedBox(height: 16.0),
                        MySeparator(color: context.theme.dividerColor),
                        const SizedBox(height: 16.0),
                        KeyValueWidget(
                          keyString:locale.bank_name_title,
                          valueString: controller.creditInquiryResponse.bankName!,
                        ),
                        const SizedBox(height: 16.0),
                        MySeparator(color: context.theme.dividerColor),
                        const SizedBox(height: 16.0),
                        KeyValueWidget(
                          keyString: locale.branch_code_title,
                          valueString: controller.creditInquiryResponse.branchCode,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      locale.cheque_owner_title,
                      style: ThemeUtil.titleStyle,
                    ),
                    InkWell(
                      onTap: () {
                        controller.showCheckStatusBottomSheet();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgIcon(
                            SvgIcons.info,
                            colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                           locale.check_status_guide,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.creditInquiryResponse.accountOwners!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OwnerItemWidget(
                      accountOwner: controller.creditInquiryResponse.accountOwners![index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 16);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
