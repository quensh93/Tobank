import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/card_management/edit_card_controller.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../util/app_util.dart';
import '../../util/theme/theme_util.dart';
import '../../widget/button/continue_button_widget.dart';
import '../common/custom_app_bar.dart';
import '../common/text_field_clear_icon_widget.dart';

class EditCardScreen extends StatelessWidget {
  const EditCardScreen({
    required this.customerCard,
    required this.bankInfo,
    super.key,
  });

  final CustomerCard customerCard;
  final BankInfo bankInfo;

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<EditCardController>(
        init: EditCardController(customerCard: customerCard),
        builder: (controller) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: CustomAppBar(
                titleString: locale.edit_card,
                context: context,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 64.0,
                          child: Card(
                            elevation: 8,
                            margin: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        locale.card_number,
                                        style: TextStyle(
                                          color: ThemeUtil.textSubtitleColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            AppUtil.splitCardNumber(customerCard.cardNumber!, ' - '),
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              color: ThemeUtil.textTitleColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          SvgPicture.network(
                                            AppUtil.baseUrlStatic() + bankInfo.symbol!,
                                            semanticsLabel: '',
                                            height: 24.0,
                                            width: 24.0,
                                            placeholderBuilder: (BuildContext context) => SpinKitFadingCircle(
                                              itemBuilder: (_, int index) {
                                                return DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: context.theme.iconTheme.color,
                                                  ),
                                                );
                                              },
                                              size: 32.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Text(
                         locale.expiration_date,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        InkWell(
                          onTap: () {
                            controller.showExpireDateBottomSheet();
                          },
                          child: IgnorePointer(
                            child: TextField(
                              controller: controller.expireDateController,
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              textInputAction: TextInputAction.done,
                              enabled: true,
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: false,
                                hintText:'${locale.month}/${locale.year}',
                                hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0,
                                ),
                                errorText: controller.isExpValid ? null : locale.enter_expiration_card,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 28.0,
                        ),
                        Text(
                          locale.card_title,
                          style: ThemeUtil.titleStyle,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                          controller: controller.titleController,
                          onChanged: (value) {
                            controller.update();
                          },
                          decoration: InputDecoration(
                            filled: false,
                            hintText: locale.enter_card_title,
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                            ),
                            errorText: controller.isTitleValid ? null : locale.enter_card_title,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 16.0,
                            ),
                            suffixIcon: TextFieldClearIconWidget(
                              isVisible: controller.titleController.text.isNotEmpty,
                              clearFunction: () {
                                controller.titleController.clear();
                                controller.update();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        ContinueButtonWidget(
                          callback: () {
                            controller.validate();
                          },
                          isLoading: controller.isLoading,
                          buttonTitle:locale.save_changes,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
