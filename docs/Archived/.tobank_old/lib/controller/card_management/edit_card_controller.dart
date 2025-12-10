import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/card/expire_data.dart';
import '../../model/card/request/edit_card_data_request.dart';
import '../../model/card/response/customer_card_response_data.dart';
import '../../service/card_services.dart';
import '../../service/core/api_core.dart';
import '../../ui/common/card_expire_select_view.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class EditCardController extends GetxController {
  EditCardController({this.customerCard});

  CustomerCard? customerCard;
  MainController mainController = Get.find();
  bool isDeleteLoading = false;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expireDateController = TextEditingController();

  // TextEditingController monthExpireController = TextEditingController();
  // bool cardExpMonthValid = true;
  // TextEditingController yearExpireController = TextEditingController();
  // bool cardExpYearValid = true;

  TextEditingController titleController = TextEditingController();

  bool isTitleValid = true;
  bool isExpValid = true;

  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    if (customerCard != null) {
      titleController.text = customerCard!.title!;
      cardNumberController.text = AppUtil.splitCardNumber(customerCard!.cardNumber!, ' - ');
      expireDateController.text = "${customerCard!.cardExpYear ?? "--"}/${customerCard!.cardExpMonth ?? "--"}";
    }
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  void showExpireDateBottomSheet() {
    AppUtil.hideKeyboard(Get.context!);
    if (isClosed) {
      return;
    }
    final ExpireData expireData = ExpireData();
    if (expireDateController.text.isNotEmpty) {
      expireData.expireMonth = expireDateController.text.split('/')[1];
      expireData.expireYear = expireDateController.text.split('/')[0];
    }
    showModalBottomSheet(
      elevation: 0,
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Get.isDarkMode ? const Color(0xFF1c222e) : Colors.white,
      constraints: BoxConstraints(maxHeight: Get.height * 9 / 10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: CardExpireSelectWidget(
          expireData: expireData,
          returnData: (selectedExpireData) {
            expireDateController.text = '${selectedExpireData.expireYear}/${selectedExpireData.expireMonth}';
            selectedExpireData = selectedExpireData;
          },
        ),
      ),
    );
  }

  void validate() {
    bool isValid = true;
    if (titleController.text.isNotEmpty) {
      isTitleValid = true;
    } else {
      isValid = false;
      isTitleValid = false;
    }
    if (expireDateController.text.isNotEmpty && expireDateController.text != '--/--') {
      isExpValid = true;
    } else {
      isValid = false;
      isExpValid = false;
    }
    update();

    if (isValid) {
      _editCardRequest();
    }
  }

  /// Sends a request to edit a user card and handles the response.
  Future<void> _editCardRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final EditUserCardDataRequest editCardDataRequest = EditUserCardDataRequest();
    editCardDataRequest.title = titleController.text;
    editCardDataRequest.cardExpMonth = expireDateController.text.split('/')[1];
    editCardDataRequest.cardExpYear = expireDateController.text.split('/')[0];
    editCardDataRequest.id = customerCard!.id;
    editCardDataRequest.isDefault = customerCard!.isDefault;

    isLoading = true;
    update();
    await CardServices.updateUserCardRequest(
      editCardDataRequest: editCardDataRequest,
    ).then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: _):
          Get.back(result: true);
          Future.delayed(Constants.duration200, () {
            SnackBarUtil.showSuccessSnackBar(locale.card_edit_success);
          });
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }
}
