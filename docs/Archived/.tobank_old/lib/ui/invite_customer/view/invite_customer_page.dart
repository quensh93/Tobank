import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/invite_customer/invite_customer_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';

class InviteCustomerPage extends StatelessWidget {
  const InviteCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<InviteCustomerController>(builder: (controller) {
      return SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0), border: Border.all(color: context.theme.dividerColor)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SvgIcon(SvgIcons.inviteHeader),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(locale.invite_friends, style: ThemeUtil.titleStyle),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(locale.copy_invitation_code_or_share_with_friends,
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CouponCard(
                          height: 64.0,
                          curvePosition: 80,
                          curveAxis: Axis.vertical,
                          backgroundColor: context.theme.colorScheme.surfaceContainerHighest,
                          firstChild: SizedBox(
                            height: 64.0,
                            child: Center(
                              child: Container(
                                height: 48.0,
                                width: 48.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: const Color(0x33d61f2c),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8.0),
                                    onTap: () {
                                      controller.copyToClipboard();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgIcon(
                                        SvgIcons.copy,
                                        colorFilter: ColorFilter.mode(ThemeUtil.primaryColor, BlendMode.srcIn),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          secondChild: SizedBox(
                            height: 64.0,
                            child: Stack(
                              children: [
                                const Positioned(
                                  right: 24,
                                  child: SvgIcon(SvgIcons.inviteCode),
                                ),
                                Center(
                                  child: Text(
                                    controller.getLoyaltyCode() ?? '-',
                                    style: TextStyle(
                                      color: ThemeUtil.textTitleColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          height: 56.0,
                          child: ElevatedButton(
                              onPressed: () {
                                controller.shareLoyaltyCode();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: ThemeUtil.primaryColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SvgIcon(
                                    SvgIcons.share,
                                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text( locale.sharing_invitation_code,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ))
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    controller.showCustomerReferralsScreen();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: context.theme.dividerColor),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          SvgIcon(
                            SvgIcons.person,
                            colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Text(locale.invited_list, style: ThemeUtil.titleStyle),
                          ),
                          Container(
                            height: 16.0,
                            width: 2.0,
                            decoration: BoxDecoration(color: context.theme.dividerColor),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          SvgIcon(
                            SvgIcons.arrowLeft,
                            colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
    });
  }
}
