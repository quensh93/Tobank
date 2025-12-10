import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/promissory/promissory_controller.dart';
import '../../../util/custom_expansion_tile.dart';
import '../../../util/data_constants.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';
import 'promissory_item.dart';

class PromissoryServicePage extends StatelessWidget {
  const PromissoryServicePage({super.key});

  @override
  Widget build(BuildContext context) {
//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<PromissoryController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 8.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
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
                    locale.electronic_promissory,
                    style: ThemeUtil.titleStyle,
                  ),
                  children: <Widget>[
                    // TagLine Copy
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.theme.colorScheme.surface,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          locale.electronic_promissory_note_description,
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
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: DataConstants.getPromissoryServiceItemList().length,
                itemBuilder: (BuildContext context, int index) {
                  return PromissoryItemWidget(
                    promissoryItemData: DataConstants.getPromissoryServiceItemList()[index],
                    returnDataFunction: (promissoryItemData) {
                      controller.handleItemClick(promissoryItemData);
                    },
                  );
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
