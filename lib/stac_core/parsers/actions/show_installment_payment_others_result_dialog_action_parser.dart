import 'dart:async';
import 'package:stac/stac.dart';

import 'package:flutter/material.dart';

import '../../registry/custom_component_registry.dart';
import '../../registry/registry_notifier.dart';
import '../../registry/text_form_field_controller_registry.dart';
import 'custom_navigate_action_parser.dart';

class ShowInstallmentPaymentOthersResultDialogActionModel {
  final String nationalCodeFieldId;
  final Map<String, dynamic>? defaultAction;

  const ShowInstallmentPaymentOthersResultDialogActionModel({
    required this.nationalCodeFieldId,
    this.defaultAction,
  });

  factory ShowInstallmentPaymentOthersResultDialogActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ShowInstallmentPaymentOthersResultDialogActionModel(
      nationalCodeFieldId:
          json['nationalCodeFieldId'] as String? ?? 'others_national_code',
      defaultAction: json['defaultAction'] is Map
          ? Map<String, dynamic>.from(json['defaultAction'] as Map)
          : null,
    );
  }
}

class ShowInstallmentPaymentOthersResultDialogActionParser
    extends
        StacActionParser<ShowInstallmentPaymentOthersResultDialogActionModel> {
  const ShowInstallmentPaymentOthersResultDialogActionParser();

  @override
  String get actionType => 'showInstallmentPaymentOthersResultDialog';

  @override
  ShowInstallmentPaymentOthersResultDialogActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowInstallmentPaymentOthersResultDialogActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowInstallmentPaymentOthersResultDialogActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'dialog', 'installment_payment_others_result');
    final rawValue =
        TextFormFieldControllerRegistry.instance
            .get(model.nationalCodeFieldId)
            ?.text
            .trim() ??
        '';
    final nationalCode = _normalizeDigits(rawValue);

    if (nationalCode == '0000000000') {
      await _showResultDialog(
        context: context,
        message: 'تسهیلات مورد نظر تسویه گردیده است',
      );
      return;
    }

    if (nationalCode == '1111111111') {
      await _showResultDialog(
        context: context,
        message: 'اطلاعات مورد نظر یافت نشد',
      );
      return;
    }

    if (model.defaultAction != null) {
      _storeLoanNumberForDetailPage();
      final result = Stac.onCallFromJson(model.defaultAction!, context);
      if (result is Future) {
        await result;
      }
    }
  }

  void _storeLoanNumberForDetailPage() {
    final parts = [
      _readField('others_loan_4'),
      _readField('others_loan_3'),
      _readField('others_loan_2'),
      _readField('others_loan_1'),
    ].where((part) => part.isNotEmpty).toList();

    if (parts.isEmpty) return;

    StacRegistry.instance.setValue('othersPayment.loanNumber', parts.join('-'));
    RegistryNotifier.instance.notify();
  }

  String _readField(String id) {
    return TextFormFieldControllerRegistry.instance.get(id)?.text.trim() ?? '';
  }

  Future<void> _showResultDialog({
    required BuildContext context,
    required String message,
  }) async {
    if (!context.mounted) return;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: const Color(0x99000000),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 34),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.fromLTRB(20, 34, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  height: 62,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFFE11D2E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: const Text(
                      'تایید',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _normalizeDigits(String input) {
    var output = input;
    const fa = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    const ar = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (var i = 0; i < 10; i++) {
      output = output.replaceAll(fa[i], '$i');
      output = output.replaceAll(ar[i], '$i');
    }
    return output;
  }
}

void registerShowInstallmentPaymentOthersResultDialogActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowInstallmentPaymentOthersResultDialogActionParser(),
  );
}
