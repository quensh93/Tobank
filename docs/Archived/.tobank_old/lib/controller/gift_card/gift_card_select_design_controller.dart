import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/gift_card/gift_card_selected_design_data.dart';
import '../../model/gift_card/response/list_event_plan_data.dart';
import '../../model/gift_card/response/list_message_gift_card_data.dart';
import '../../service/core/api_core.dart';
import '../../service/gift_card_services.dart';
import '../../ui/common/help_bottom_sheet.dart';
import '../../ui/gift_card/gift_card_select_custom_design/widget/gift_card_plan_selector_bottom_sheet.dart';
import '../../util/app_theme.dart';
import '../../util/app_util.dart';
import '../../util/data_constants.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class GiftCardSelectDesignController extends GetxController {
  MainController mainController = Get.find();
  bool isLoading = false;

  List<Event> eventPlanDataList = [];

  PageController pageController = PageController();

  String? errorTitle = '';

  bool hasError = false;

  Plan? selectedPlan;

  bool isLoadingMessages = false;

  List<MessageData> messageGiftCardList = [];

  Event? selectedEvent;

  TextEditingController cardTitleController = TextEditingController();

  MessageData? selectedMessageData;

  bool isTitleValid = true;

  File? selectedCustomImage;

  int openBottomSheets = 0;

  @override
  void onInit() {
    getEventPlansRequest();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  /// Retrieves a list of available event plans for gift cards and navigates to the next page.
  void getEventPlansRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoading = true;
    update();

    GiftCardServices.getListEventPlanRequest().then((result) {
      isLoading = false;
      update();

      switch (result) {
        case Success(value: (final ListEventPlanData response, int _)):
          eventPlanDataList = response.data ?? [];
          update();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void setSelectedEvent(Event event) {
    selectedEvent = event;
    update();
    _showSelectPlanBottomSheet();
  }

  Future<void> onBackPress(bool didPop) async {
    if (didPop) {
      return;
    }
    if (!isLoading) {
      if (pageController.page == 0 || pageController.page == 1) {
        final NavigatorState navigator = Navigator.of(Get.context!);
        navigator.pop();
      } else {
        AppUtil.previousPageController(pageController, isClosed);
      }
    }
  }

  void selectPlan(Plan? plan) {
    selectedPlan = plan;
    update();
    _getGiftCardMessagesRequest();
  }

  /// Retrieves a list of gift card messages for a selected event and navigates to the next page.
  void _getGiftCardMessagesRequest() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    isLoadingMessages = true;
    update();

    GiftCardServices.getListMessageGiftCardRequest(eventId: selectedEvent!.id!).then((result) {
      isLoadingMessages = false;
      update();

      switch (result) {
        case Success(value: (final ListMessageGiftCardData response, int _)):
          messageGiftCardList = response.results ?? [];
          update();
          _closeBottomSheets();
          AppUtil.nextPageController(pageController, isClosed);
        case Failure(exception: final ApiException apiException):
          SnackBarUtil.showSnackBar(
            title: locale.show_error(apiException.displayCode),
            message: apiException.displayMessage,
          );
      }
    });
  }

  void setSelectedMessageData(MessageData messageData) {
    selectedMessageData = messageData;
    update();
  }

  /// Validate values of form before request
  void validateAlternative() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    AppUtil.hideKeyboard(Get.context!);
    bool isValid = true;
    if (selectedMessageData == null) {
      isValid = false;
      SnackBarUtil.showInfoSnackBar(
        locale.default_text_required,
      );
    }
    if (cardTitleController.text.trim().isNotEmpty) {
      if (cardTitleController.text.length >= 3 && cardTitleController.text.length <= 40) {
        isTitleValid = true;
      } else {
        SnackBarUtil.showInfoSnackBar(
          locale.custom_text_length,
        );
        isValid = false;
        isTitleValid = false;
      }
    }
    update();

    if (isValid) {
      _returnSelectedData();
    }
  }

  /// Collects and returns selected gift card data, including title,custom image, message, event, and plan.
  void _returnSelectedData() {
    final GiftCardSelectedDesignData giftCardSelectedDesignData = GiftCardSelectedDesignData();
    if (cardTitleController.text.trim().isNotEmpty &&
        cardTitleController.text.trim().length >= 3 &&
        cardTitleController.text.trim().length <= 40) {
      giftCardSelectedDesignData.cardTitle = cardTitleController.text.trim();
    }
    if (selectedCustomImage != null) {
      final List<int> imageBytes = File(selectedCustomImage!.path).readAsBytesSync();
      final String base64Image = base64Encode(imageBytes);
      final String? extension = AppUtil.mime(selectedCustomImage!.path);
      final String? mimType = DataConstants.mimTypes[extension!];
      final String customImageBase64 = 'data:$mimType;base64,$base64Image';
      giftCardSelectedDesignData.customImageBase64 = customImageBase64;
      giftCardSelectedDesignData.customImageFile = selectedCustomImage;
    }
    giftCardSelectedDesignData.selectedMessageData = selectedMessageData;
    giftCardSelectedDesignData.selectedEvent = selectedEvent;
    giftCardSelectedDesignData.selectedPlan = selectedPlan;
    Get.back(result: giftCardSelectedDesignData);
  }

  Future selectAndSendImage() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    XFile? image;

    if (Platform.isAndroid) {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
      );
      if (result != null && result.files.length == 1) {
        image = XFile(result.files[0].path!);
      }
    } else {
      final picker = ImagePicker();
      image = await picker.pickImage(
        source: ImageSource.gallery,
      );
    }

    if (image != null) {
      final CroppedFile? croppedImage = await ImageCropper()
          .cropImage(sourcePath: image.path, aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 1), uiSettings: [
        AndroidUiSettings(
            toolbarTitle: locale.crop_picture,
            toolbarColor: AppTheme.headerBackground,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: true,
            lockAspectRatio: true),
        IOSUiSettings(rectX: 3, rectY: 1, title: locale.crop_picture, cancelButtonTitle: locale.cancel_laghv, doneButtonTitle: locale.confirmation),
      ]);
      if (croppedImage != null) {
        if (AppUtil.checkSizeOfFile(File(croppedImage.path))) {
          SnackBarUtil.showInfoSnackBar(
            locale.file_size_error_more_than_1mb,
          );
        } else {
          selectedCustomImage = File(croppedImage.path);
        }
      }
    }
    update();
  }

  Future<void> _showSelectPlanBottomSheet() async {
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
      elevation: 0,
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
        child: const GiftCardPlanSelectorBottomSheet(),
      ),
    );
    openBottomSheets--;
  }

  void validateImageSelectorPage() {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    bool isValid = true;
    if (selectedCustomImage == null) {
      SnackBarUtil.showInfoSnackBar(
        locale.select_card_image,
      );
    } else {
      if (cardTitleController.text.length >= 3 && cardTitleController.text.length <= 40) {
        isTitleValid = true;
      } else {
        isValid = false;
        isTitleValid = false;
      }
      update();
      if (isValid) {
        AppUtil.nextPageController(pageController, isClosed);
      }
    }
  }

  Future<void> showHelpBottomSheet() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    if (isClosed) {
      return;
    }
    openBottomSheets++;
    await showModalBottomSheet(
      elevation: 0,
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
        child: HelpBottomSheet(
          title: locale.guide,
          description:
              locale.help_description,
        ),
      ),
    );
    openBottomSheets--;
  }

  void _closeBottomSheets() {
    List.generate(openBottomSheets, (index) => Get.back());
  }
}
