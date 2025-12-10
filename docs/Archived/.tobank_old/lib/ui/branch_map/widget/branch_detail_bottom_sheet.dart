import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/branch_map/branch_map_controller.dart';
import '../../../model/bank_branch_list_data.dart';
import '../../../util/app_util.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class BranchDetailBottomSheet extends StatelessWidget {
  const BranchDetailBottomSheet({required this.bankBranch, super.key});

  final BankBranchListData bankBranch;

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
                    const SvgIcon(SvgIcons.branch),
                    const SizedBox(width: 8.0),
                    Text('${bankBranch.faTitle!} - ${bankBranch.code!}', style: ThemeUtil.titleStyle),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgIcon(
                      SvgIcons.location,
                      colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Flexible(
                      child: Text(bankBranch.address ?? '',
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    SvgIcon(
                      SvgIcons.phone,
                      colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: Wrap(
                        children: List.generate(
                          bankBranch.phones!.length,
                          (index) => InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: () {
                              AppUtil.launchInBrowser(url: 'tel://${bankBranch.phones![index]}');
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                bankBranch.phones![index],
                                style: TextStyle(
                                  color: ThemeUtil.textSubtitleColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    SvgIcon(
                      SvgIcons.clock,
                      colorFilter: ColorFilter.mode(ThemeUtil.textSubtitleColor, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 8.0),
                    Flexible(
                      child: Text(bankBranch.workingTime ?? '',
                          style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Divider(thickness: 1),
                Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 48.0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {
                          controller.share(bankBranch);
                        },
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
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        controller.direction(bankBranch);
                      },
                      child: SizedBox(
                        height: 48.0,
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
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
