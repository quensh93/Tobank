import 'package:get/get.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/promissory/request/promissory_delete_request_data.dart';
import '../../model/promissory/response/promissory_request_history_response_data.dart';
import '../../service/core/api_core.dart';
import '../../service/promissory_services.dart';
import '../../util/dialog_util.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class PromissoryCancelRequestController extends GetxController {
  MainController mainController = Get.find();
  final PromissoryRequest promissoryRequest;

  bool isLoading = false;

  PromissoryCancelRequestController({required this.promissoryRequest});

  void cancelRequest() {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.sure_to_cancel_request,
        description: '',
        positiveMessage: locale.confirmation,
        negativeMessage: locale.return_,
        positiveFunction: () async {
          Get.back();
          _promissoryDeleteRequest();
        },
        negativeFunction: () {
          Get.back();
        });
  }

  /// Sends a request to delete the promissory note.
  Future<void> _promissoryDeleteRequest() async {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final PromissoryDeleteRequestData promissoryDeleteRequestData = PromissoryDeleteRequestData(
      id: promissoryRequest.id!,
      docType: promissoryRequest.docType!.jsonValue,
    );

    isLoading = true;
    update();
    PromissoryServices.promissoryDeleteRequest(
      promissoryDeleteRequestData: promissoryDeleteRequestData,
    ).then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: _):
            Get.back();
            SnackBarUtil.showSuccessSnackBar(locale.request_delete_successfully);
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }
}
