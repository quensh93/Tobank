import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../registry/custom_component_registry.dart';

class ShowTransferCardConfirmDialogActionModel {
  final String title;
  final String cardLabel;
  final String ownerNameLabel;
  final String amountLabel;
  final String destinationCardKey;
  final String destinationNameKey;
  final String amountKey;
  final String cancelText;
  final String confirmText;
  final Map<String, dynamic>? cancelAction;
  final Map<String, dynamic>? confirmAction;

  const ShowTransferCardConfirmDialogActionModel({
    required this.title,
    required this.cardLabel,
    required this.ownerNameLabel,
    required this.amountLabel,
    required this.destinationCardKey,
    required this.destinationNameKey,
    required this.amountKey,
    required this.cancelText,
    required this.confirmText,
    this.cancelAction,
    this.confirmAction,
  });

  factory ShowTransferCardConfirmDialogActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawCancelAction = json['cancelAction'];
    final rawConfirmAction = json['confirmAction'];
    return ShowTransferCardConfirmDialogActionModel(
      title: json['title'] as String? ?? 'تایید اطلاعات کارت به کارت',
      cardLabel: json['cardLabel'] as String? ?? 'کارت مقصد',
      ownerNameLabel: json['ownerNameLabel'] as String? ?? 'نام صاحب کارت',
      amountLabel: json['amountLabel'] as String? ?? 'مبلغ انتقال',
      destinationCardKey:
          json['destinationCardKey'] as String? ??
          'transferApiCardDestinationNumber',
      destinationNameKey:
          json['destinationNameKey'] as String? ??
          'transferApiCardDestinationName',
      amountKey: json['amountKey'] as String? ?? 'transferApiCardAmountRaw',
      cancelText: json['cancelText'] as String? ?? 'انصراف',
      confirmText: json['confirmText'] as String? ?? 'تایید',
      cancelAction: rawCancelAction is Map<String, dynamic>
          ? rawCancelAction
          : rawCancelAction is Map
          ? Map<String, dynamic>.from(rawCancelAction)
          : null,
      confirmAction: rawConfirmAction is Map<String, dynamic>
          ? rawConfirmAction
          : rawConfirmAction is Map
          ? Map<String, dynamic>.from(rawConfirmAction)
          : null,
    );
  }
}

class ShowTransferCardConfirmDialogActionParser
    extends StacActionParser<ShowTransferCardConfirmDialogActionModel> {
  const ShowTransferCardConfirmDialogActionParser();

  @override
  String get actionType => 'showTransferCardConfirmDialog';

  @override
  ShowTransferCardConfirmDialogActionModel getModel(Map<String, dynamic> json) {
    return ShowTransferCardConfirmDialogActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowTransferCardConfirmDialogActionModel model,
  ) async {
    if (!context.mounted) return;
    final actionContext = context;
    final registry = StacRegistry.instance;
    final cardNumberRaw = _readRegistryValue(
      registry,
      model.destinationCardKey,
    );
    final ownerNameRaw = _readRegistryValue(registry, model.destinationNameKey);
    final amountRaw = _readRegistryValue(registry, model.amountKey);

    final cardNumber = _formatCardNumber(cardNumberRaw);
    final ownerName = _toPersianDigits(ownerNameRaw.trim());
    final amountText = _formatAmount(amountRaw);

    final colorScheme = Theme.of(context).colorScheme;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.70),
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 0,
              backgroundColor: colorScheme.surfaceContainerHigh,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      model.title,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 34 / 2,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildInfoRow(
                            label: model.cardLabel,
                            value: cardNumber,
                            colorScheme: colorScheme,
                          ),
                          _buildDivider(colorScheme),
                          _buildInfoRow(
                            label: model.ownerNameLabel,
                            value: ownerName,
                            colorScheme: colorScheme,
                          ),
                          _buildDivider(colorScheme),
                          _buildInfoRow(
                            label: model.amountLabel,
                            value: amountText,
                            colorScheme: colorScheme,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      textDirection: TextDirection.ltr,
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                              if (model.confirmAction != null &&
                                  actionContext.mounted) {
                                Stac.onCallFromJson(
                                  model.confirmAction!,
                                  actionContext,
                                );
                              }
                            },
                            style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                              backgroundColor: const Color(0xFFE31B2F),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              model.confirmText,
                              style: const TextStyle(
                                fontSize: 34 / 2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                              if (model.cancelAction != null &&
                                  actionContext.mounted) {
                                Stac.onCallFromJson(
                                  model.cancelAction!,
                                  actionContext,
                                );
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                              side: BorderSide(
                                color: colorScheme.outline.withValues(
                                  alpha: 0.9,
                                ),
                                width: 1.3,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              model.cancelText,
                              style: TextStyle(
                                fontSize: 34 / 2,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required String label,
    required String value,
    required ColorScheme colorScheme,
  }) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Text(
          label,
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Divider(
        color: colorScheme.outlineVariant.withValues(alpha: 0.45),
        height: 1,
        thickness: 1,
      ),
    );
  }

  String _readRegistryValue(StacRegistry registry, String key) {
    final value = registry.getValue(key);
    if (value == null) return '';
    return value.toString().trim();
  }

  String _formatCardNumber(String raw) {
    final englishDigits = _toEnglishDigits(raw);
    final digitsOnly = englishDigits.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length < 16) {
      return _toPersianDigits(raw);
    }
    final groups = <String>[];
    for (var i = 0; i < 16; i += 4) {
      groups.add(digitsOnly.substring(i, i + 4));
    }
    return _toPersianDigits(groups.join(' - '));
  }

  String _formatAmount(String raw) {
    if (raw.trim().isEmpty) return '-';
    final normalized = raw.trim();
    if (normalized.contains('ریال')) {
      return _toPersianDigits(normalized);
    }
    final display = _toPersianDigits(normalized);
    return '$display ریال';
  }

  String _toEnglishDigits(String input) {
    const persian = '۰۱۲۳۴۵۶۷۸۹';
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    var output = input;
    for (var i = 0; i < 10; i++) {
      output = output.replaceAll(persian[i], '$i');
      output = output.replaceAll(arabic[i], '$i');
    }
    return output;
  }

  String _toPersianDigits(String input) {
    const persian = '۰۱۲۳۴۵۶۷۸۹';
    var output = input;
    for (var i = 0; i < 10; i++) {
      output = output.replaceAll('$i', persian[i]);
    }
    return output;
  }
}

void registerShowTransferCardConfirmDialogActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowTransferCardConfirmDialogActionParser(),
  );
}
