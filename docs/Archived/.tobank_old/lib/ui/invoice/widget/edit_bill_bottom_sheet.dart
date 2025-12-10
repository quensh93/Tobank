import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../controller/invoice/invoice_controller.dart';
import '../../../util/theme/theme_util.dart';
import '../../../widget/button/continue_button_widget.dart';
import '../../common/text_field_clear_icon_widget.dart';

class EditBillWidgetBottomSheet extends StatelessWidget {
  const EditBillWidgetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {

//locale
    final locale = AppLocalizations.of(context)!;
    return GetBuilder<InvoiceController>(builder: (controller) {
      return SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        locale.title_bill,
                        style: TextStyle(color: ThemeUtil.textTitleColor, fontWeight: FontWeight.w600, fontSize: 18.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    locale.bill_title_label,
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
                      hintText: locale.enter_bill_title_hint,
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
                        isVisible: controller.titleController.text.isNotEmpty,
                        clearFunction: () {
                          controller.titleController.clear();
                          controller.update();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  ContinueButtonWidget(
                    callback: () {
                      controller.validateEditInvoiceName();
                    },
                    isLoading: controller.isLoading,
                    buttonTitle:locale.edit_bill,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
