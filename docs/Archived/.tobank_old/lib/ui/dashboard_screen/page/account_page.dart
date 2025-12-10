import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/account_controller.dart';
import '../../../new_structure/core/app_config/app_config.dart';
import '../../../new_structure/core/injection/injection.dart';
import '../../../util/app_util.dart';
import '../../../util/application_info_util.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';
import '../widget/account_item_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<AccountController>(
        init: AccountController(),
        builder: (controller) {
          return Stack(
            children: [
              SvgIcon(
                context.isDarkMode ? SvgIcons.accountHeaderDark : SvgIcons.accountHeader,
                size: Get.width,
              ),
              Column(
                children: [
                  const SizedBox(height: 32.0),
                  Text(
                   locale.user_account,
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  if (controller.getProfileImageUrl() == null)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Get.isDarkMode
                            ? context.theme.colorScheme.surfaceContainerHighest
                            : context.theme.colorScheme.surface.withOpacity(0.5),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8.0),
                        onTap: () {
                          controller.showUpdateAccountImage();
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SvgIcon(
                              SvgIcons.editProfile,
                              colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                              size: 40.0,
                            ),),
                      ),
                    )
                  else
                    InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        controller.showUpdateAccountImage();
                      },
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Get.isDarkMode ? Colors.white : const Color(0xfff2f4f7),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipOval(
                                child: SizedBox(
                                  height: 72.0,
                                  width: 72.0,
                                  child: FastCachedImage(
                                    key: UniqueKey(),
                                    fit: BoxFit.fitHeight,
                                    url: AppUtil.baseUrlStatic() + controller.getProfileImageUrl()!,
                                    loadingBuilder: (context, progress) => Image.asset(
                                      'assets/images/profile.png',
                                    ),
                                    errorBuilder: (context, url, error) => Image.asset(
                                      'assets/images/profile.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 24.0,
                            height: 24.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(color: const Color(0xFFd0d5dd))),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: SvgIcon(
                                SvgIcons.editAccountImage,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16.0),
                  Text(
                    controller.getName(),
                    style: TextStyle(
                      color: ThemeUtil.textTitleColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    controller.getMobile(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: DataConstants.getOtherPageItems(
                                    controller.mainController.walletDetailData!.data!.availableTransactionGift!)
                                .length,
                            itemBuilder: (BuildContext context, int index) {
                              return AccountItemWidget(
                                settingsItemData: DataConstants.getOtherPageItems(
                                    controller.mainController.walletDetailData!.data!.availableTransactionGift!)[index],
                                returnDataFunction: (settingsDataItem) {
                                  controller.handleSelectedItem(settingsDataItem);
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 16.0);
                            },
                          ),
                          Text(
                            locale.app_version(kIsWeb ? getIt<AppConfigService>().config.webVersion : ApplicationInfoUtil().appVersion),
                            style: TextStyle(
                              color: ThemeUtil.textSubtitleColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
