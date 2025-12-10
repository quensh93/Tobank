import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/pichak/response/dynamic_info_inquiry_response.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../common/key_value_widget.dart';

class StaticReceiverItemWidget extends StatelessWidget {
  const StaticReceiverItemWidget({
    required this.checkReceiver,
    super.key,
  });

  final ChequeReceiver checkReceiver;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          checkReceiver.fullName!,
          style: TextStyle(
            color: ThemeUtil.textTitleColor,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        KeyValueWidget(keyString: locale.national_code_title, valueString: '${checkReceiver.nationalId}'),
      ],
    );
  }
}
