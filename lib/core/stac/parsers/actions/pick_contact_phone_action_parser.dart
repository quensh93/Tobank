import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';
import '../../utils/text_form_field_controller_registry.dart';
import '../../../helpers/logger.dart';

class PickContactPhoneActionModel {
  final String formFieldId;
  final String? targetKey;
  final Map<String, dynamic>? onContactSelected;
  final String permissionDeniedMessage;
  final String invalidMobileMessage;
  final String unsupportedMessage;

  const PickContactPhoneActionModel({
    required this.formFieldId,
    this.targetKey,
    this.onContactSelected,
    this.permissionDeniedMessage = 'دسترسی مخاطبین مجاز نیست',
    this.invalidMobileMessage = 'شماره همراه معتبر در مخاطب یافت نشد',
    this.unsupportedMessage = 'انتخاب مخاطب در این پلتفرم پشتیبانی نمی‌شود',
  });

  factory PickContactPhoneActionModel.fromJson(Map<String, dynamic> json) {
    return PickContactPhoneActionModel(
      formFieldId: json['formFieldId'] as String? ?? '',
      targetKey: json['targetKey'] as String?,
      onContactSelected: json['onContactSelected'] as Map<String, dynamic>?,
      permissionDeniedMessage:
          json['permissionDeniedMessage'] as String? ??
          'دسترسی مخاطبین مجاز نیست',
      invalidMobileMessage:
          json['invalidMobileMessage'] as String? ??
          'شماره همراه معتبر در مخاطب یافت نشد',
      unsupportedMessage:
          json['unsupportedMessage'] as String? ??
          'انتخاب مخاطب در این پلتفرم پشتیبانی نمی‌شود',
    );
  }
}

class PickContactPhoneActionParser
    extends StacActionParser<PickContactPhoneActionModel> {
  const PickContactPhoneActionParser();

  @override
  String get actionType => 'pickContactPhone';

  @override
  PickContactPhoneActionModel getModel(Map<String, dynamic> json) {
    return PickContactPhoneActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    PickContactPhoneActionModel model,
  ) async {
    if (model.formFieldId.isEmpty) {
      AppLogger.w('pickContactPhone: formFieldId is empty');
      return;
    }

    if (kIsWeb) {
      _showMessage(context, model.unsupportedMessage);
      return;
    }

    try {
      var status = await Permission.contacts.status;
      if (!status.isGranted) {
        status = await Permission.contacts.request();
      }
      if (!context.mounted) return;

      if (!status.isGranted) {
        _showMessage(context, model.permissionDeniedMessage);
        return;
      }

      final picker = FlutterNativeContactPicker();
      final contact = await picker.selectContact();
      if (!context.mounted) return;
      if (contact == null) {
        return;
      }

      final mobile = _extractIranMobile(contact.phoneNumbers);
      if (mobile == null) {
        _showMessage(context, model.invalidMobileMessage);
        return;
      }

      final controller = TextFormFieldControllerRegistry.instance.get(
        model.formFieldId,
      );
      if (controller != null) {
        controller.value = TextEditingValue(
          text: mobile,
          selection: TextSelection.collapsed(offset: mobile.length),
        );
      }

      final formScope = StacFormScope.of(context);
      formScope?.formData[model.formFieldId] = mobile;

      final registry = StacRegistry.instance;
      registry.setValue('form.${model.formFieldId}', mobile);
      if (model.targetKey != null && model.targetKey!.isNotEmpty) {
        registry.setValue(model.targetKey!, mobile);
      }

      if (model.onContactSelected != null && context.mounted) {
        await Stac.onCallFromJson(model.onContactSelected!, context);
      }
    } catch (e, stackTrace) {
      AppLogger.e('pickContactPhone: failed to select contact', e, stackTrace);
      if (context.mounted) {
        _showMessage(context, model.invalidMobileMessage);
      }
    }
  }

  String? _extractIranMobile(List<String>? phoneNumbers) {
    if (phoneNumbers == null || phoneNumbers.isEmpty) return null;

    for (final phone in phoneNumbers) {
      final normalized = _normalizeIranMobile(phone);
      if (normalized != null) return normalized;
    }
    return null;
  }

  String? _normalizeIranMobile(String rawPhone) {
    var raw = rawPhone
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll('-', '')
        .replaceAll('(', '')
        .replaceAll(')', '');

    if (raw.startsWith('+')) {
      raw = raw.substring(1);
    }

    if (raw.startsWith('0098')) {
      raw = '0${raw.substring(4)}';
    } else if (raw.startsWith('98')) {
      raw = '0${raw.substring(2)}';
    } else if (raw.startsWith('9') && raw.length == 10) {
      raw = '0$raw';
    }

    final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
    if (RegExp(r'^09\d{9}$').hasMatch(digits)) {
      return digits;
    }

    return null;
  }

  void _showMessage(BuildContext context, String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message, textDirection: TextDirection.rtl)),
    );
  }
}

void registerPickContactPhoneActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const PickContactPhoneActionParser(),
  );
}
