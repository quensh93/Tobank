import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universal_io/io.dart';

import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/destination_card_selector/destination_card_selector_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/button_with_icon.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/text_field_clear_icon_widget.dart';
import '../destination_card_item.dart';

class DestinationCardSelectorPage extends StatelessWidget {
  const DestinationCardSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<DestinationCardSelectorController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          locale.search_destination_card,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          onChanged: (value) {
                            controller.search(value);
                          },
                          controller: controller.cardDestinationController,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.ltr,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (term) {},
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.hint_card_number,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isDestinationCardNumberValid
                                ? null
                                : locale.invalid_card_number,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 16.0,
                            ),
                            suffixIcon: TextFieldClearIconWidget(
                              isVisible: controller.cardDestinationController.text.isNotEmpty,
                              clearFunction: () {
                                controller.cleanTextField();
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (controller.destinationCustomerCardList.isEmpty)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          Get.isDarkMode ? 'assets/images/empty_list_dark.png' : 'assets/images/empty_list.png',
                          height: 140,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          locale.card_not_found,
                          style: TextStyle(
                              color: ThemeUtil.textSubtitleColor, fontWeight: FontWeight.w600, fontSize: 14.0),
                        ),
                      ],
                    )
                  else
                    ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: controller.destinationCustomerCardList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return DestinationCardItemWidget(
                          customerCard: controller.destinationCustomerCardList[index],
                          bankInfoList: controller.bankInfoList,
                          selectCardDataFunction: (cardData) {
                            controller.setSelectedCardData(cardData);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 12.0,
                        );
                      },
                    ),
                  const SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          ),
          if (controller.cardDestinationController.text.isEmpty)
            ///Need test on IOS
            if (!kIsWeb)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonWithIcon(
                buttonTitle: locale.scan_card,
                buttonIcon: SvgIcons.scanner,
                onPressed: controller.showScannerScreen,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ContinueButtonWidget(
                callback: () {
                  controller.validate();
                },
                isLoading: controller.isLoading,
                buttonTitle: locale.confirmation,
              ),
            ),
        ],
      );
    });
  }
}
