import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/pichak/pichak_controller.dart';
import '../../util/custom_expansion_tile.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/svg/svg_icon.dart';
import 'pichak_item.dart';

class PichakListServicePage extends StatelessWidget {
  const PichakListServicePage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PichakController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: context.theme.colorScheme.surface,
                ),
                child: CustomExpansionTile(
                  trailing: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SvgIcon(
                      SvgIcons.cardDown,
                      colorFilter: ColorFilter.mode(context.theme.iconTheme.color!, BlendMode.srcIn),
                      size: 24.0,
                    ),
                  ),
                  headerBackgroundColor: context.theme.colorScheme.surface,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    locale.central_bank_notice_title,
                    style: ThemeUtil.titleStyle,
                  ),
                  children: <Widget>[
                    // TagLine Copy
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: context.theme.colorScheme.surface,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(locale.central_bank_notice_content,
                           style: TextStyle(
                            color: ThemeUtil.textSubtitleColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              if (controller.isPichakItemsEnable)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                     locale.services_of_issuer_title,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                )
              else
                Container(),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.pichakItems.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 2 && controller.isPichakItemsEnable) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                         locale.services_of_receiver_title,
                          style: TextStyle(
                            color: ThemeUtil.textTitleColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        PichakItemWidget(
                          pichakItemData: controller.pichakItems[index],
                          returnDataFunction: (pichakData) {
                            controller.handleItemClick(pichakData);
                          },
                        ),
                      ],
                    );
                  } else {
                    return PichakItemWidget(
                      pichakItemData: controller.pichakItems[index],
                      returnDataFunction: (pichakData) {
                        controller.handleItemClick(pichakData);
                      },
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16.0,
                  );
                },
              ),
              const SizedBox(
                height: 24.0,
              ),
            ],
          ),
        ),
      );
    });
  }
}
