import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/source_card_selector/source_card_selector_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/svg/svg_icon.dart';
import '../../common/text_field_clear_icon_widget.dart';
import '../source_card_item.dart';

class SourceCardSelectorPage extends StatelessWidget {
  const SourceCardSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<SourceCardSelectorController>(builder: (controller) {
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
                          locale.search_source_card,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          onChanged: (value) {
                            controller.searchCards();
                          },
                          controller: controller.cardSearchController,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            fontFamily: 'IranYekan',
                          ),
                          textAlign: TextAlign.right,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (term) {
                            controller.searchCards();
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.card_title_or_number,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
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
                              isVisible: controller.cardSearchController.text.isNotEmpty,
                              clearFunction: () {
                                controller.clearSourceCardTextField();
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      controller.description!,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  if (controller.sourceCustomerCardList.isEmpty)
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
                      itemCount: controller.sourceCustomerCardList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return SourceCardItemWidget(
                          customerCard: controller.sourceCustomerCardList[index],
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  controller.showAddCardScreen();
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
                  children: <Widget>[
                    const SvgIcon(
                      SvgIcons.add,
                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      size: 24,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      locale.add_new_card,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      );
    });
  }
}
