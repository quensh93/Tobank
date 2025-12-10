import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../controller/destination_notebook/iban_notebook_controller.dart';
import '../../../../util/enums_constants.dart';
import '../../../../util/theme/theme_util.dart';
import '../../../../widget/button/continue_button_widget.dart';

class UpdateIbanNotebookBottomSheet extends StatelessWidget {
  const UpdateIbanNotebookBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    //locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<IbanNotebookController>(
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
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
                          decoration:
                              BoxDecoration(color: context.theme.dividerColor, borderRadius: BorderRadius.circular(4))),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(controller.currentOperationType == OperationType.insert ? locale.edit :  locale.edit,
                      style: ThemeUtil.titleStyle),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    locale.title,
                    style: ThemeUtil.titleStyle,
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: controller.titleController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                    decoration: InputDecoration(
                      hintText:
                          '${locale.title} ${controller.notebookDepositData!.type == DestinationType.iban ? locale.shaba : locale.deposit} ${locale.enter_}',
                      filled: false,
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      errorText: controller.isTitleValid
                          ? null
                          : '${locale.title} ${controller.notebookDepositData!.type == DestinationType.iban ? locale.shaba : locale.deposit} ${locale.enter_}',
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
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text('شماره ${controller.notebookDepositData!.type == DestinationType.iban ? locale.shaba : locale.deposit}',
                      style: ThemeUtil.titleStyle),
                  const SizedBox(height: 8.0),
                  TextField(
                    enabled: false,
                    textDirection: TextDirection.ltr,
                    controller: controller.depositNumberController,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'IranYekan',
                      fontSize: 16.0,
                    ),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: false,
                      hintText:
                          '${locale.number} ${controller.notebookDepositData!.type == DestinationType.iban ? locale.shaba : locale.deposit} ${locale.enter_}',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      errorText: controller.depositNumberValid
                          ? null
                          : '${locale.a_number} ${controller.notebookDepositData!.type == DestinationType.iban ? locale.shaba : locale.deposit} ${locale.enter_a_valid}',
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
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  ContinueButtonWidget(
                    callback: () => controller.updateAction(),
                    isLoading: controller.isLoading,
                    buttonTitle:  locale.save,
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
