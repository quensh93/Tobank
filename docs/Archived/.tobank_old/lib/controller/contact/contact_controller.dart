import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as fc;
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';

import '../../model/contact_match/custom_contact.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/dialog_util.dart';
import '../../util/permission_handler.dart';

class ContactController extends GetxController {
  List<CustomContact> _allContactsWithPhone = [];
  List<CustomContact>? contactsWithPhone;
  TextEditingController nameController = TextEditingController();
  Function(CustomContact contact)? returnDataFunction;

  @override
  void onInit() {
    super.onInit();
    Timer(Constants.duration200, _showConfirm);
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

  /// Check permission, then fetch contacts via flutter_contacts,
  /// map to [CustomContact], sort them, and expose via [contactsWithPhone].
  Future<void> _refreshContacts() async {
    // Web has no contacts API
    if (kIsWeb) {
      _allContactsWithPhone = [];
      contactsWithPhone = [];
      update();
      return;
    }

    final bool isGranted = await PermissionHandler.contacts.handlePermission();
    if (!isGranted) {
      // User denied; just close the dialog
      Get.back();
      return;
    }

    // Fetch raw device contacts (with phone/property data)
    final List<fc.Contact> rawContacts = await fc.FlutterContacts.getContacts(
      withProperties: true,
      withPhoto: false,
    );

    final List<CustomContact> mapped = [];
    for (final c in rawContacts) {
      if (c.phones.isNotEmpty) {
        final custom = CustomContact();
        custom.displayName = c.displayName;
        custom.givenName = c.name.first;
        custom.familyName = c.name.last;

        // Normalize phone numbers, pick first
        final phones = c.phones
            .map((p) => p.number
            .replaceAll(' ', '')
            .replaceAll(Constants.iranCountryCode, '0'))
            .toList();
        custom.phones = phones;

        mapped.add(custom);
      }
    }

    // Sort & publish
    _allContactsWithPhone = AppUtil.sortContacts(mapped);
    contactsWithPhone = List.from(_allContactsWithPhone);
    update();
  }

  /// In‐memory search over the JSON representation
  void searchContacts() {
    final q = nameController.text.trim().toLowerCase();
    if (_allContactsWithPhone.isNotEmpty) {
      contactsWithPhone = _allContactsWithPhone
          .where((contact) =>
          contact.toJson().toString().toLowerCase().contains(q))
          .toList();
      update();
    }
  }

  /// Return the tapped contact and close
  void selectContact(CustomContact contact) {
    returnDataFunction?.call(contact);
    Get.back();
  }
}
