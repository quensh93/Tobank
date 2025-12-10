import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/charity/charity_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../widget/charity_item_widget.dart';

class CharitySelectorPage extends StatelessWidget {
  const CharitySelectorPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return GetBuilder<CharityController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    color: context.theme.colorScheme.surface),
                child: Image.asset(
                  'assets/images/charity_logo.png',
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
               locale.select_charity_plan,
                style: ThemeUtil.titleStyle,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.charityDataList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return CharityItemWidget(
                    charityData: controller.charityDataList![index],
                    returnDataFunction: (charityData) {
                      controller.setSelectedCharityData(charityData);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16.0,
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
