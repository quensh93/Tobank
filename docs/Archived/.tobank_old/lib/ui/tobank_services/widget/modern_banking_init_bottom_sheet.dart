import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '/controller/tobank_services/tobank_services_controller.dart';
import '/util/app_state.dart';
import '/util/theme/theme_util.dart';
import '/widget/button/custom_continue_button.dart';
import '../../../util/enums_constants.dart';
import '../../../widget/svg/svg_icon.dart';

class ModernBankingInitBottomSheet extends GetView<TobankServicesController> {
  const ModernBankingInitBottomSheet({
    required this.modernBankingActivationType,
    super.key,
  });

  final ModernBankingActivationType modernBankingActivationType;

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: context.theme.dividerColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            Row(
              children: [
                SvgIcon(
                  SvgIcons.info,
                  colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                ),
                const SizedBox(width: 8.0),
                Text(
                  locale.attention,
                  style: ThemeUtil.titleStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
             locale.activation_notice,
              style: TextStyle(
                color: ThemeUtil.textSubtitleColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 40),
            Obx(() {
              final AppState state = controller.modernBankingState;
              return CustomContinueButton(
                callback: () {
                  controller.activeModernBanking(modernBankingActivationType);
                },
                buttonTitle: locale.activation_button,
                state: state,
              );
            }),
          ],
        ),
      ),
    );
  }
}
