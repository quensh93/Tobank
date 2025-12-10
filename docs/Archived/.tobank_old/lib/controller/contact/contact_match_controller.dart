import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as fc;
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../model/contact_match/custom_match_contact.dart';
import '../../model/contact_match/request/contact_match_data.dart';
import '../../model/contact_match/response/list_contact_match_response_data.dart';
import '../../service/contact_services.dart';
import '../../service/core/api_core.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/permission_handler.dart';
import '../../util/snack_bar_util.dart';
import '../main/main_controller.dart';

class ContactMatchController extends GetxController {
  MainController mainController = Get.find();
  List<CustomMatchContact> allContactsWithPhone = [];
  List<CustomMatchContact> contactsWithPhone = [];
  List<String>? listContactMatchResponse = [];
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  Function(CustomMatchContact contact)? returnDataFunction;

  String errorTitle = '';
  bool hasError = false;

  PageController pageController = PageController();

  @override
  void onInit() {
    Timer(Constants.duration200, () {
      _showConfirm();
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    Get.closeAllSnackbars();
  }

  Future<void> _showConfirm() async {
    final locale = AppLocalizations.of(Get.context!)!;
    final bool isGranted = await PermissionHandler.contacts.isGranted;
    if (isGranted) {
      _refreshContacts();
    } else {
      DialogUtil.showDialogMessage(
        buildContext: Get.context!,
        message: locale.contacts_permission_message,
        description: locale.contacts_permission_description,
        positiveMessage: locale.confirmation,
        negativeMessage: locale.cancel_laghv,
        positiveFunction: () {
          Get.back();
          _refreshContacts();
        },
        negativeFunction: () {
          Get.back();
          Get.back();
        },
      );
    }
  }

  /// Check for read contact permission
  /// if is granted, get list of [fc.Contact]
  /// else request permission from user
  Future<void> _refreshContacts() async {
    if (kIsWeb) {
      return;
    }

    final bool isGranted = await PermissionHandler.contacts.handlePermission();
    if (isGranted) {
      // ← NEW: fetch via flutter_contacts
      final List<fc.Contact> rawContacts = await fc.FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );

      allContactsWithPhone = [];
      for (final fc.Contact contact in rawContacts) {
        if (contact.phones.isNotEmpty) {
          final CustomMatchContact customContact = CustomMatchContact();
          customContact.displayName = contact.displayName;
          // flutter_contacts stores name components in .name
          customContact.familyName = contact.name.last;
          customContact.givenName = contact.name.first;

          // normalize & pick first phone
          final phones = contact.phones
              .map((p) => p.number
              .replaceAll(' ', '')
              .replaceAll(Constants.iranCountryCode, '0'))
              .toList();

          customContact.phone = phones.first;
          allContactsWithPhone.add(customContact);
        }
      }

      // mirror original logic
      contactsWithPhone = allContactsWithPhone;
      getMatchContactsRequest();
    } else {
      final status = await Permission.contacts.request();
      if (status.isPermanentlyDenied) {
        Get.back();
        AppSettings.openAppSettings();
      } else {
        Get.back();
      }
    }
  }

  /// Search for contact with all information that provide
  /// Convert contact class to json string & search for character matching
  /// in it
  void searchContacts() {
    if (allContactsWithPhone.isNotEmpty) {
      contactsWithPhone = allContactsWithPhone
          .where((contact) =>
          contact.toJson().toString().toLowerCase().contains(
            nameController.text.toLowerCase(),
          ))
          .toList();
      update();
    }
  }

  /// Get data of [ListContactMatchResponseData] from server request
  void getMatchContactsRequest() {
    final locale = AppLocalizations.of(Get.context!)!;
    final ContactMatchData contactMatchData = ContactMatchData();
    contactMatchData.contacts = [];
    for (final CustomMatchContact customMatchContact
    in contactsWithPhone) {
      contactMatchData.contacts!.add(customMatchContact.phone);
    }

    hasError = false;
    isLoading = true;
    update();
    ContactServices.matchContactsRequest(
      contactMatchData: contactMatchData,
    ).then(
          (result) {
        isLoading = false;
        update();

        switch (result) {
          case Success(
          value: (final ListContactMatchResponseData response,
          int _)):
            contactsWithPhone = [];
            listContactMatchResponse = response.data!.match;
            for (final String phone in listContactMatchResponse!) {
              final CustomMatchContact? contact =
              allContactsWithPhone.firstWhereOrNull(
                    (element) => element.phone == phone,
              );
              if (contact != null) {
                contactsWithPhone.add(contact);
              }
            }
            contactsWithPhone =
                AppUtil.sortMatchContacts(contactsWithPhone);
            allContactsWithPhone = contactsWithPhone;
            update();
            AppUtil.nextPageController(pageController, isClosed);
          case Failure(exception: final ApiException apiException):
            hasError = true;
            errorTitle = apiException.displayMessage;
            SnackBarUtil.showSnackBar(
              title: locale.show_error(apiException.displayCode),
              message: apiException.displayMessage,
            );
        }
      },
    );
  }

  void selectContact(CustomMatchContact customMatchContact) {
    returnDataFunction!(customMatchContact);
    Get.back();
  }
}
