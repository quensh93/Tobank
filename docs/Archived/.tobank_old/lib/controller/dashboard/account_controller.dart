import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart' show Sentry;
import 'package:universal_io/io.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/common/settings_data.dart';
import '../../model/profile/request/update_avatar_by_id_request_data.dart';
import '../../model/profile/request/update_avatar_with_file_request_data.dart';
import '../../model/profile/response/avatar_list_response_data.dart';
import '../../model/profile/response/profile_data.dart';
import '../../service/core/api_core.dart';
import '../../service/profile_services.dart';
import '../../ui/about_us/about_us_screen.dart';
import '../../ui/authentication/register/authentication_register_screen.dart';
import '../../ui/bank_info/bank_info_screen.dart';
import '../../ui/contact_us/contact_us_screen.dart';
import '../../ui/dashboard_screen/widget/select_profile_image_bottom_sheet.dart';
import '../../ui/destination_notebook/destination_notebook_screen.dart';
import '../../ui/invite_customer/invite_customer_screen.dart';
import '../../ui/renew_certificate/renew_certificate_bottom_sheet.dart';
import '../../ui/rule/rules_screen.dart';
import '../../ui/security_screen/security_screen.dart';
import '../../ui/settings/settings_screen.dart';
import '../../util/app_theme.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/data_constants.dart';
import '../../util/image_handler_services/image_picker_service.dart'
    show ImagePickerService, ImageProcessConfig;
import '../../util/image_handler_services/image_validation_service.dart';
import '../../util/snack_bar_util.dart';
import '../../util/storage_util.dart';
import '../main/main_controller.dart';

class AccountController extends GetxController {
  MainController mainController = Get.find();
  final imagePicker = ImagePickerService();

  bool isLoading = false;
  List<AvatarData> avatarDataList = [];
  int? selectedId;

  bool hasError = false;

  String errorTitle = '';

  String getName() {
    if (mainController.authInfoData != null &&
        mainController.authInfoData!.firstName != null &&
        mainController.authInfoData!.lastName != null) {
      return '${mainController.authInfoData!.firstName!} ${mainController.authInfoData!.lastName!}';
    }
    return '';
  }

  String getMobile() {
    if (mainController.authInfoData != null) {
      return mainController.authInfoData!.mobile ?? '';
    } else {
      return '';
    }
  }

  void handleSelectedItem(SettingsItemData settingsDataItem) {
    if (settingsDataItem.event == 1) {
      Get.to(() => const BankInfoScreen());
    } else if (settingsDataItem.event == 2) {
      Get.to(() => const InviteCustomerScreen());
    } else if (settingsDataItem.event == 3) {
      Get.to(() => const DestinationNotebookScreen());
    } else if (settingsDataItem.event == 4) {
      Get.to(() => const SettingsScreen());
    } else if (settingsDataItem.event == 5) {
      Get.to(() => const RulesScreen(isFirst: false));
    } else if (settingsDataItem.event == 6) {
      Get.to(() => const AboutUsScreen());
    } else if (settingsDataItem.event == 7) {
      Get.to(() => const ContactUsScreen());
    } else if (settingsDataItem.event == 8) {
      Get.to(() => const SecurityScreen());
    } else if (settingsDataItem.event == 9) {
      Get.to(() => const AuthenticationRegisterScreen());
    } else if (settingsDataItem.event == 10) {
      _showRenewCertificateBottomSheet();
    }
  }

  void _showRenewCertificateBottomSheet() {
    showModalBottomSheet(
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
        child: const RenewCertificateBottomSheet(remainingDays: 10),
      ),
    );
  }

  String? getProfileImageUrl() {
    if (mainController.authInfoData!.avatar != null) {
      return mainController.authInfoData!.avatar!.avatar;
    } else {
      return mainController.authInfoData!.imageUrl;
    }
  }

  Future<void> showUpdateAccountImage() async {
    if (isClosed) {
      return;
    }
    showModalBottomSheet(
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
        child: const SelectProfileImageBottomSheet(),
      ),
    );
    getListOfAvatarsRequest();
  }

  void updateAvatar(int avatarId) {
    _updateProfileAvatarByIdRequest(avatarId);
  }

  /// Updates the user's profile avatar by sending an API request
  void _updateProfileAvatarByIdRequest(int avatarId) {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final updateAvatarByIdRequest = UpdateAvatarByIdRequest(
      avatarId: avatarId,
    );

    ProfileServices.updateAvatarByIdRequest(
      updateAvatarByIdRequest: updateAvatarByIdRequest,
    ).then(
      (result) {
        switch (result) {
          case Success(value: (final ProfileData response, int _)):
            _updateProfileImageData(response);
            Get.back();
            Timer(Constants.duration200, () {
              SnackBarUtil.showSuccessSnackBar(locale.avatar_editing_completed_successfully);
            });
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  Future<void> _updateProfileImageData(ProfileData profileData) async {
    print("⭕ _updateProfileImageData");
    mainController.authInfoData!.imageUrl = profileData.data!.file;
    print("⭕ image url");
    print(mainController.authInfoData!.imageUrl);
    mainController.authInfoData!.avatar = profileData.data!.avatar;
    print("⭕ avatar");
    print(mainController.authInfoData!.avatar);
    await StorageUtil.setAuthInfoDataSecureStorage(
        mainController.authInfoData!);
    update();
    Get.find<AccountController>().update();
  }

  /// Allows the user to select and crop a profile image from their device's gallery.
  ///
  Future<void> selectProfileImage() async {
    if (kIsWeb) {
      await selectProfileImageWeb();
    } else {
      await selectProfileImageNative();
    }
  }

  Future<void> selectProfileImageNative() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    final picker = ImagePicker();
    final image = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 600.0, maxWidth: 600.0);
    if (image != null) {
      final CroppedFile? croppedImage = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: locale.crop_picture,
                toolbarColor: AppTheme.headerBackground,
                toolbarWidgetColor: Colors.white,
                hideBottomControls: true,
                lockAspectRatio: true),
            IOSUiSettings(
                rectX: 1,
                rectY: 1,
                title: locale.crop_picture,
                cancelButtonTitle: locale.cancel_laghv, doneButtonTitle: locale.confirmation),
          ]);
      if (croppedImage != null) {
        if (AppUtil.checkSizeOfFile(File(croppedImage.path))) {
          SnackBarUtil.showInfoSnackBar(
            locale.file_size_error_more_than_1mb,
          );
        } else {
          final List<int> imageBytes =
              File(croppedImage.path).readAsBytesSync();
          final String base64Image = base64Encode(imageBytes);
          final String? extension = AppUtil.mime(croppedImage.path);
          final String? mimType = DataConstants.mimTypes[extension!];
          final String base64ImageString = 'data:$mimType;base64,$base64Image';
          _updateAvatarWithFileRequest(base64ImageString);
        }
      }
    }
  }

  Future<void> selectProfileImageWeb() async {
    //locale
    final locale = AppLocalizations.of(Get.context!)!;
    final config = ImageProcessConfig(
      ratioY: 1,
      ratioX: 1,
      toolbarTitle: locale.crop_picture,
      maxWidth: 1080.0,
      maxHeight: 1080.0,
      compressQuality: 110,
      lockAspectRatio: false,
      showCropGrid: false,
      maxFileSize: Constants.nationalCardMaxSize,
      aspectRatioPresets: [CropAspectRatioPreset.original],
      beforeProcess: () {
        print('🔴 Executing stopPlayer before process');
      },
      onError: (message) async {
        print('🔴 Error occurred: $message');
        await Sentry.captureException(
          message,
          stackTrace: StackTrace.current,
        );
      },
    );

    print('🔴 Awaiting image processing');
    final processedImage = await imagePicker.selectAndProcessImage(
      source: ImageSource.gallery,
      config: config,
    );

    print('🔴 Process complete, image: ${processedImage?.path}');

    if (processedImage != null) {
      String? base64Image =
      await ImageValidationService().convertToBase64(processedImage);
      if (base64Image != null) {
        final String? extension = AppUtil.mime(processedImage.path);
        final String base64ImageString =
            'data:image/jpeg;base64,$base64Image';
        //
        await _updateAvatarWithFileRequest(base64ImageString);
        update();
      }
    } else {
      print('🔴 No image to process');
    }
  }

  /// Updates the user's profile avatar by sending an API request with the image file.
  Future<void> _updateAvatarWithFileRequest(String base64ImageString) async {
    final updateAvatarWithFileRequest = UpdateAvatarWithFileRequest(
      file: base64ImageString,
    );

    final locale = AppLocalizations.of(Get.context!)!;

    await ProfileServices.updateAvatarWithFileRequest(
      updateAvatarWithFileRequest: updateAvatarWithFileRequest,
    ).then(
      (result) {
        switch (result) {
          case Success(value: (final ProfileData response, int _)):
            _updateProfileImageData(response);
            Get.back();
            Timer(Constants.duration200, () {
              SnackBarUtil.showSuccessSnackBar(locale.avatar_editing_completed_successfully);
            });
          case Failure(exception: final ApiException apiException):
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  /// Retrieves a list of available avatars from the server.
  Future getListOfAvatarsRequest() async {
//locale
    final locale = AppLocalizations.of(Get.context!)!;
    hasError = false;
    isLoading = true;
    update();
    ProfileServices.getAvatarList().then(
      (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(value: (final AvatarListResponseData response, int _)):
            avatarDataList = response.data!.results ?? [];
            update();
          case Failure(exception: final ApiException apiException):
            hasError = true;
            errorTitle = apiException.displayMessage;
            update();
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
