import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/pichak/response/transfer_status_inquiry_response.dart';
import '../../../model/pichak/transfer_action_data.dart';
import '../../../util/app_util.dart';
import '../../../util/date_converter_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/ui/dotted_line_widget.dart';
import '../../common/key_value_widget.dart';

class OwnerItemWidget extends StatelessWidget {
  const OwnerItemWidget({
    required this.chequeHolder,
    super.key,
  });

  final ChequeHolder chequeHolder;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    final TransferActionData? transferActionData = AppUtil.getTransferActionData(chequeHolder.transferAction);
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: Get.isDarkMode ? context.theme.colorScheme.surface : Colors.white,
            border: Border.all(
              color: Get.isDarkMode ? context.theme.colorScheme.surface : ThemeUtil.borderColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chequeHolder.fullName!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                MySeparator(color: context.theme.iconTheme.color),
                const SizedBox(
                  height: 16.0,
                ),
                KeyValueWidget(
                  keyString: locale.transfer_status,
                  valueString: transferActionData != null
                      ? transferActionData.title ?? ''
                      : chequeHolder.transferAction.toString(),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                KeyValueWidget(
                  keyString:locale.last_change_status,
                  valueString: DateConverterUtil.getJalaliFromTimestamp(chequeHolder.lastActionDate!),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
