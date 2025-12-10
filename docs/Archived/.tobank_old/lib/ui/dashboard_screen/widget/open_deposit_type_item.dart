import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/deposit/response/deposit_type_response_data.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class OpenDepositTypeItemWidget extends StatelessWidget {
  const OpenDepositTypeItemWidget({
    required this.depositType,
    required this.returnDataFunction,
    super.key,
  });

  final DepositType depositType;
  final Function(DepositType depositType) returnDataFunction;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    final bool isDisable = depositType.remainingInstances != null && depositType.remainingInstances! <= 0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        border: Border.all(
          color: context.theme.dividerColor,
        ),
      ),
      child: InkWell(
        onTap: () {
          returnDataFunction(depositType);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      isDisable ? '${depositType.localName!} ${locale.deposit_limit_message}' : depositType.localName!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        height: 1.4,
                        color: isDisable ? context.theme.disabledColor : ThemeUtil.textTitleColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SvgIcon(
                      SvgIcons.arrowLeft,
                      colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                      size: 32.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
