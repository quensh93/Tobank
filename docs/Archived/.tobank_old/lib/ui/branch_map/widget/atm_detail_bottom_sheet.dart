import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/branch_map/branch_map_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class AtmDetailBottomSheet extends StatelessWidget {
  const AtmDetailBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<BranchMapController>(
        builder: (controller) {
          return Padding(
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
                        decoration:
                            BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  children: [
                    const SvgIcon(SvgIcons.atm),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(locale.central_branch_1, style: ThemeUtil.titleStyle),
                  ],
                ),
                const SizedBox(height: 24.0),
                Row(
                  children: [
                    SvgIcon(
                      SvgIcons.location,
                      colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      locale.central_branch_1,
                      style: TextStyle(color: ThemeUtil.textSubtitleColor),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Divider(thickness: 1),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgIcon(
                          SvgIcons.share,
                          colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          locale.sharing,
                          style: TextStyle(color: ThemeUtil.textTitleColor),
                        ),
                      ],
                    )),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgIcon(
                          SvgIcons.direction,
                          colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          locale.routing,
                          style: TextStyle(color: ThemeUtil.textTitleColor),
                        ),
                      ],
                    )),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
