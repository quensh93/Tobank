import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../controller/main/main_controller.dart';
import '../model/bpms/credit_card_facility/response/credit_card_facility_check_deposit_response_data.dart';
import '../ui/common/credit_card_loan_item_widget.dart';
import '../ui/common/key_value_widget.dart';
import '../ui/common/message_overlay_view.dart';
import '../ui/pichak/cheque_helper_bottom_sheet.dart';
import '../widget/svg/svg_icon.dart';
import '../widget/ui/dotted_line_widget.dart';
import 'app_util.dart';
import 'theme/theme_util.dart';

class DialogUtil {
  DialogUtil._();

  static Future showDialogNotification({
    required BuildContext context,
    String? header,
    String? description,
    String? positiveMessage,
    Function? positiveFunction,
  }) {
    // flutter defined function
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              elevation: 0,
              backgroundColor: context.theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 270),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SvgIcon(
                        SvgIcons.warningRed,
                        size: 48.0,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        header ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'IranYekan',
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        description ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeUtil.textTitleColor,
                          fontSize: 16.0,
                          height: 1.4,
                          fontFamily: 'IranYekan',
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            positiveFunction!();
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
                          child: Padding(
                            padding: const EdgeInsets.all(
                              8.0,
                            ),
                            child: Text(
                              positiveMessage!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showDialogMessage({
    required BuildContext buildContext,
    String? message,
    String? description,
    String? positiveMessage,
    String? negativeMessage,
    Function? positiveFunction,
    Function? negativeFunction,
    Color colorPositive = Colors.white,
    Color? backgroundNegative,
    Color? colorNegative,
  }) {
    // flutter defined function
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              elevation: 0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SvgIcon(
                      SvgIcons.warningRed,
                      size: 48.0,
                    ),
                    if (message == '')
                      const SizedBox(
                        height: 0.0,
                      )
                    else
                      const SizedBox(
                        height: 16.0,
                      ),
                    Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        height: 1.6,
                      ),
                    ),
                    if (description == '')
                      const SizedBox(
                        height: 0.0,
                      )
                    else
                      const SizedBox(
                        height: 16.0,
                      ),
                    Text(
                      description!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeUtil.textSubtitleColor,
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(
                      height: 36.0,
                    ),
                    Row(
                      children: [
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
                                negativeFunction!();
                              },
                              child: Text(
                                negativeMessage!,
                                style: TextStyle(
                                  color: ThemeUtil.textTitleColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
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
                            child: ElevatedButton(
                              onPressed: () {
                                positiveFunction!();
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
                              child: Text(
                                positiveMessage!,
                                style: context.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
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
          ),
        );
      },
    );
  }

  static void showPositiveDialogMessage({
    required BuildContext buildContext,
    required String description,
    required String positiveMessage,
    required Function positiveFunction,
  }) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    // flutter defined function
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              backgroundColor: context.theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: SizedBox(
                  height: 270,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ThemeUtil.primaryColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SvgIcon(
                                SvgIcons.warningRed,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                       Text(
                        locale.attention,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      SizedBox(
                        height: 48.0,
                        child: ElevatedButton(
                          onPressed: () {
                            positiveFunction();
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: ThemeUtil.primaryColor,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: ThemeUtil.primaryColor,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          child: Text(
                            positiveMessage,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showAttentionDialogMessage({
    required BuildContext buildContext,
    required String description,
    required String positiveMessage,
    required Function positiveFunction,
    SvgIcons? icon,
    KeyValueWidget? keyValue,
  }) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    // flutter defined function
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              backgroundColor: context.theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ThemeUtil.warningColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgIcon(
                                  icon ?? SvgIcons.warningOrangeCircle,
                                  size: 40.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        locale.attention,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          color: ThemeUtil.textTitleColor,
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      if (keyValue != null)
                        Column(
                          children: [
                            keyValue,
                            const SizedBox(
                              height: 16.0,
                            ),
                          ],
                        )
                      else
                        Container(),
                      // const SizedBox(
                      //   height: 20.0,
                      // ),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      SizedBox(
                        height: 48.0,
                        child: ElevatedButton(
                          onPressed: () {
                            positiveFunction();
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
                          child: Text(
                            positiveMessage,
                            style: context.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<bool?> showExitMessageDialog(
    BuildContext buildContext,
  ) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return showDialog(
      context: buildContext,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            elevation: 0,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: SizedBox(
                height: 150.0,
                width: 270.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     Text(
                      locale.sure_to_exite,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    MySeparator(
                      color: context.theme.dividerColor,
                      height: 2.0,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: <Widget>[
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
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                locale.no,
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 48.0,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
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
                              child:  Text(
                                locale.yes,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void showForbiddenMessage({Function? actionFunction, BuildContext? buildContext}) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final MainController mainController = Get.find();
    showOverlayNotification((context) {
      mainController.overlayContext = context;
      return MessageNotification(
        message: locale.turn_off_vpn,
        buttonText: locale.try_again,
        onReply: () {
          actionFunction!();
          OverlaySupportEntry.of(context)!.dismiss();
        },
      );
    }, duration: const Duration(days: 365), position: NotificationPosition.bottom);
  }

  static Future<bool?> showSubmitCardDialog(
    BuildContext buildContext,
    Function confirmFunction,
  ) {
    //locale

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return showDialog(
      context: buildContext,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            elevation: 0,
            insetPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 16.0,
                  ),
                  const SvgIcon(
                    SvgIcons.warningRed,
                    size: 48.0,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    locale.to_use_service_must_register_at_least_one_bank_card,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeUtil.textSubtitleColor,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Row(
                    children: <Widget>[
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
                             locale.close,
                              style: TextStyle(
                                color: ThemeUtil.textTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 48.0,
                          child: ElevatedButton(
                            onPressed: () {
                              confirmFunction();
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
                            child: Text(
                              locale.save_card,
                              style: context.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void showCardToCardConfirm({
    required BuildContext buildContext,
    required Function confirmFunction,
    required Function denyFunction,
    required int amount,
    required String destinationCardNumber,
    required String cardOwnerName,
  }) {
    // flutter defined function
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {

//locale
        final locale = AppLocalizations.of(context)!;
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              elevation: 0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                     Text(
                      locale.verify_card_be_card_info,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Card(
                      elevation: 1,
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(locale.destination_card,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(
                                  AppUtil.splitCardNumber(destinationCardNumber, ' - '),
                                  textDirection: TextDirection.ltr,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(locale.name_of_card_owner,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(
                                  cardOwnerName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(locale.transfer_amount,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text(
                                  locale.amount_format(AppUtil.formatMoney(amount)),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
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
                                denyFunction();
                              },
                              child: Text(
                                locale.cancel,
                                style: context.textTheme.bodyLarge,
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
                            child: ElevatedButton(
                              onPressed: () {
                                confirmFunction();
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
                                locale.confirmation,
                                style: context.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
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
          ),
        );
      },
    );
  }

  static Future<bool?> submitShahkarDialog({
    required BuildContext buildContext,
    required Function showShahkarScreenFunction,
  }) {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    return showDialog(
      context: buildContext,
      builder: (context) => Directionality(

        textDirection: TextDirection.rtl,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            elevation: 0,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: SizedBox(
                width: 270.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      height: 16.0,
                    ),
                    const SvgIcon(
                      SvgIcons.warningRed,
                      size: 48.0,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                     Text(
                      locale.to_use_service_national_code_mobile_number_need_match,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                        fontSize: 14.0,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    MySeparator(
                      color: context.theme.iconTheme.color,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: ThemeUtil.primaryColor,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  showShahkarScreenFunction();
                                },
                                child:  Center(
                                  child: Text(
                                    locale.match_information_,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(color: context.theme.iconTheme.color!),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Center(
                                    child: Text(
                                      locale.close,
                                      style: TextStyle(
                                        color: context.theme.iconTheme.color,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static void showLoadingDialog({
    required BuildContext buildContext,
  }) {
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Dialog(
              elevation: 0,
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.black.withOpacity(0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Center(
                    child: SpinKitFadingCircle(
                      itemBuilder: (_, int index) {
                        return const DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        );
                      },
                      size: 48.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showCardConfirmDialogMessage({
    required BuildContext buildContext,
    required Function positiveFunction,
    required Function negativeFunction,
    required String pan,
    required String title,
    required String titleDescription,
    required String confirmMessage,
    required String cancelMessage,
    required Color buttonColor,
    required String symbol,
  }) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              elevation: 0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SvgIcon(
                      SvgIcons.warningRed,
                      size: 48.0,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 28.0,
                    ),
                    Text(
                      titleDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Card(
                      elevation: 1,
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(
                                  locale.card_number,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      AppUtil.splitCardNumber(pan, ' - '),
                                      textDirection: TextDirection.ltr,
                                      style: const TextStyle(
                                        fontFamily: 'IranYekan',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    SvgPicture.network(
                                      AppUtil.baseUrlStatic() + symbol,
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
                                        size: 24.0,
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
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
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
                                negativeFunction();
                              },
                              child: Text(
                                cancelMessage,
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 48.0,
                            child: ElevatedButton(
                              onPressed: () {
                                positiveFunction();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: buttonColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                confirmMessage,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
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
          ),
        );
      },
    );
  }

  static void showChequeHelperBottomSheet() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 5 / 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: const ChequeHelperBottomSheet(),
      ),
    );
  }

  static void showGuaranteeDialog({
    required BuildContext buildContext,
    required Function positiveFunction,
    required Function negativeFunction,
    required String description,
    required String confirmMessage,
    required String cancelMessage,
    required Function copyFunction,
    required Function shareFunction,
  }) {
    // flutter defined function
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {

//locale
        final locale = AppLocalizations.of(context)!;
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SvgIcon(
                      SvgIcons.warningRed,
                      size: 48.0,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                copyFunction();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.copy),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      locale.do_copy,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 1,
                          color: context.textTheme.bodyLarge!.color,
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                shareFunction();
                              },
                              child:  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.share),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      locale.sharing,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
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
                                negativeFunction();
                              },
                              child: Text(
                                cancelMessage,
                                style: context.textTheme.bodyLarge,
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
                            child: ElevatedButton(
                              onPressed: () {
                                positiveFunction();
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
                                confirmMessage,
                                style: context.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
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
          ),
        );
      },
    );
  }

  static void showDeleteDialog({
    required BuildContext buildContext,
    required Function positiveFunction,
    required Function negativeFunction,
    required String title,
    required String confirmMessage,
    required String cancelMessage,
  }) {
    // flutter defined function
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Dialog(
              backgroundColor: context.theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    const SvgIcon(
                      SvgIcons.warningRed,
                      size: 40.0,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48.0,
                            child: ElevatedButton(
                              onPressed: () => positiveFunction(),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: ThemeUtil.primaryColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                confirmMessage,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: ThemeUtil.primaryColor,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () => negativeFunction(),
                                  child: Center(
                                    child: Text(
                                      cancelMessage,
                                      style: TextStyle(
                                        color: ThemeUtil.primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showOpenDepositDialog() {

//locale
    final locale = AppLocalizations.of(Get.context!)!;
    // flutter defined function
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              backgroundColor: context.theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SvgIcon(
                      SvgIcons.warningRed,
                      size: 48.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                     Text(
                      locale.warning,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                     Text(
                      locale.to_use_service_open_deposit,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        height: 1.4,
                      ),
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
                                Get.back();
                                Get.back();
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
                              child:  Text(
                                locale.deposit_button_opening,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: ThemeUtil.primaryColor,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Center(
                                    child: Text(
                                      locale.close,
                                      style: TextStyle(
                                        color: ThemeUtil.primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showConfirmCloseDeposit({
    required BuildContext buildContext,
    required Function positiveFunction,
    required Function negativeFunction,
    required String depositNumber,
    required String title,
    required String confirmMessage,
    required String cancelMessage,
  }) {
    // flutter defined function
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {//locale
        final locale = AppLocalizations.of(Get.context!)!;
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              elevation: 0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SvgIcon(
                      SvgIcons.warningRed,
                      size: 48.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeUtil.textTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Card(
                      margin: EdgeInsets.zero,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: context.theme.dividerColor, width: 0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  locale.deposit_number,
                                  style: TextStyle(
                                    color: ThemeUtil.textSubtitleColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  depositNumber,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    color: ThemeUtil.textTitleColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: ThemeUtil.primaryColor,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    negativeFunction();
                                  },
                                  child: Center(
                                    child: Text(
                                      cancelMessage,
                                      style: TextStyle(
                                        color: ThemeUtil.primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: SizedBox(
                            height: 48.0,
                            child: ElevatedButton(
                              onPressed: () {
                                positiveFunction();
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
                              child: Text(
                                confirmMessage,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
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
          ),
        );
      },
    );
  }

  static void showZaerCardWarningDialog({
    required BuildContext buildContext,
    required String title,
    required String description,
    required String confirmMessage,
    required String cancelMessage,
    required Function positiveFunction,
    required Function negativeFunction,
  }) {
    // flutter defined function
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              backgroundColor: context.theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SvgIcon(
                      SvgIcons.warningRed,
                      size: 48.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: ThemeUtil.primaryColor,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  onTap: () {
                                    negativeFunction();
                                  },
                                  child: Center(
                                    child: Text(
                                      cancelMessage,
                                      style: TextStyle(
                                        color: ThemeUtil.primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: SizedBox(
                            height: 48.0,
                            child: ElevatedButton(
                              onPressed: () {
                                positiveFunction();
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
                              child: Text(
                                confirmMessage,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
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
          ),
        );
      },
    );
  }

  static void showCreditCardLoanAmountDialog({
    required BuildContext buildContext,
    required List<LoanData> loanDataList,
    required int? averageDepositAmount,
    required Function confirmFunction,
    required Function backFunction,
  }) {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    showDialog(
      context: buildContext,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              elevation: 0,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Card(
                      elevation: 1,
                      shadowColor: Colors.transparent,
                      margin: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: ThemeUtil.successColor.withOpacity(0.05),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '${locale.average_account}${AppUtil.formatMillions(averageDepositAmount! ~/ 10)} ${locale.toman}',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: ThemeUtil.successColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            decoration: BoxDecoration(color: context.theme.disabledColor),
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CreditCardLoanItemWidget(
                                  loanData: loanDataList[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: 1,
                                  decoration: BoxDecoration(color: context.theme.disabledColor),
                                );
                              },
                              itemCount: loanDataList.length)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 56.0,
                            child: ElevatedButton(
                              onPressed: () {
                                confirmFunction();
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
                                locale.confirm_continue,
                                style: context.theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: SizedBox(
                            height: 56.0,
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
                                backFunction();
                              },
                              child: Text(
                                locale.return_,
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
          ),
        );
      },
    );
  }
}
