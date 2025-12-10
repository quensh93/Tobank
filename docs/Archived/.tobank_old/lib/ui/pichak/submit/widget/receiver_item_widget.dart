import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/pichak/response/receiver_inquiry_response.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/svg/svg_icon.dart';

class ReceiverItemWidget extends StatelessWidget {
  const ReceiverItemWidget({
    required this.receiverInquiryResponse,
    required this.deleteFunction,
    super.key,
  });

  final Function(ReceiverInquiryResponse receiverInquiryResponse) deleteFunction;
  final ReceiverInquiryResponse receiverInquiryResponse;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Card(
      elevation: 1,
      shadowColor: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: context.theme.dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receiverInquiryResponse.fullName!,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    receiverInquiryResponse.nationalId!,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(8.0),
              onTap: () {
                deleteFunction(receiverInquiryResponse);
              },
              child: Row(
                children: <Widget>[
                  SvgIcon(
                    Get.isDarkMode ? SvgIcons.deleteDark : SvgIcons.delete,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                   locale.delete,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: context.theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
