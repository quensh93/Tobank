import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/dashboard/account_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../common/minify_loading_page.dart';
import 'avatar_item_widget.dart';

class SelectProfileImageBottomSheet extends StatelessWidget {
  const SelectProfileImageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GetBuilder<AccountController>(
        builder: (controller) {
          return Container(
            constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
            child: SingleChildScrollView(
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
                                color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(locale.select_profile_image, style: ThemeUtil.titleStyle),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(locale.default_images,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
                    const SizedBox(
                      height: 24.0,
                    ),
                    if (controller.isLoading || controller.hasError)
                      MinifyLoadingPage(
                        controller.errorTitle,
                        hasError: controller.hasError,
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        isLoading: controller.isLoading,
                        retryFunction: () {
                          controller.getListOfAvatarsRequest();
                        },
                      )
                    else
                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 12.0,
                          crossAxisSpacing: 12.0,
                        ),
                        children: List<Widget>.generate(controller.avatarDataList.length, (index) {
                          return AvatarItemWidget(
                            avatarData: controller.avatarDataList[index],
                            selectedId: controller.selectedId,
                            returnDataFunction: (avatarData) {
                              controller.updateAvatar(avatarData.id!);
                            },
                            reloadFunction: () {
                              controller.update();
                            },
                          );
                        }),
                      ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48.0,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.selectProfileImage();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 1,
                                backgroundColor: ThemeUtil.primaryColor,
                                shadowColor: context.isDarkMode ? Colors.transparent : context.theme.shadowColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                locale.select_from_gallery,
                                style: context.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 48.0,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                locale.cancel,
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
