import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/gift_card/gift_card_select_design_controller.dart';
import '../../../../util/theme/theme_util.dart';
import '../../common/gift_card_event_item.dart';

class GiftCardSelectDesignPage extends StatelessWidget {
  const GiftCardSelectDesignPage({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<GiftCardSelectDesignController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(locale.select_gift_card_category, style: ThemeUtil.titleStyle),
            const SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.3,
                ),
                children: List<Widget>.generate(controller.eventPlanDataList.length, (index) {
                  return GiftCardEventItemWidget(
                      selectedEvent: controller.selectedEvent,
                      event: controller.eventPlanDataList[index],
                      returnSelectedFunction: (event) {
                        controller.setSelectedEvent(event);
                      },
                      reloadFunction: () {
                        controller.update();
                      });
                }),
              ),
            ),
          ],
        ),
      );
    });
  }
}
