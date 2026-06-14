import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stac/stac.dart';

import '../../../../core/helpers/logger.dart';
import '../../../registry/custom_component_registry.dart';
import '../../../registry/registry_notifier.dart';
import '../custom_navigate_action_parser.dart';

class ShowBankAddressBottomSheetActionModel {
  final String title;
  final String addressLabel;
  final String address;
  final String postalCodeLabel;
  final String postalCode;
  final String editButtonText;
  final String editTitle;
  final String postalCodeHint;
  final String inquiryButtonText;
  final String postalCodeValueKey;
  final Map<String, dynamic>? inquiryAction;

  const ShowBankAddressBottomSheetActionModel({
    required this.title,
    required this.addressLabel,
    required this.address,
    required this.postalCodeLabel,
    required this.postalCode,
    required this.editButtonText,
    required this.editTitle,
    required this.postalCodeHint,
    required this.inquiryButtonText,
    required this.postalCodeValueKey,
    this.inquiryAction,
  });

  factory ShowBankAddressBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawInquiryAction = json['inquiryAction'];
    return ShowBankAddressBottomSheetActionModel(
      title: json['title'] as String? ?? 'آدرس ثبت‌شده در بانک',
      addressLabel: json['addressLabel'] as String? ?? 'آدرس',
      address: json['address'] as String? ?? '-',
      postalCodeLabel: json['postalCodeLabel'] as String? ?? 'کد پستی',
      postalCode: json['postalCode'] as String? ?? '-',
      editButtonText: json['editButtonText'] as String? ?? 'ویرایش',
      editTitle: json['editTitle'] as String? ?? 'ویرایش آدرس ثبت‌شده در بانک',
      postalCodeHint:
          json['postalCodeHint'] as String? ?? 'کد پستی محل سکونت را وارد کنید',
      inquiryButtonText: json['inquiryButtonText'] as String? ?? 'استعلام',
      postalCodeValueKey:
          json['postalCodeValueKey'] as String? ?? 'profileRealPostalCode',
      inquiryAction: rawInquiryAction is Map<String, dynamic>
          ? rawInquiryAction
          : rawInquiryAction is Map
          ? Map<String, dynamic>.from(rawInquiryAction)
          : null,
    );
  }
}

enum _AddressBottomSheetResult { edit }

class ShowBankAddressBottomSheetActionParser
    extends StacActionParser<ShowBankAddressBottomSheetActionModel> {
  const ShowBankAddressBottomSheetActionParser();

  @override
  String get actionType => 'showBankAddressBottomSheet';

  @override
  ShowBankAddressBottomSheetActionModel getModel(Map<String, dynamic> json) {
    return ShowBankAddressBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowBankAddressBottomSheetActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'bottomSheet', 'bank_address');
    if (!context.mounted) return;

    final shouldOpenEdit = await _showCustomerAddressBottomSheet(
      context,
      model,
    );
    if (!shouldOpenEdit || !context.mounted) return;

    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (!context.mounted) return;

    await _showPostalCodeBottomSheet(context, model);
  }

  Future<bool> _showCustomerAddressBottomSheet(
    BuildContext context,
    ShowBankAddressBottomSheetActionModel model,
  ) async {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final result = await showModalBottomSheet<_AddressBottomSheetResult>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (bottomSheetContext) {
        final mediaQuery = MediaQuery.of(bottomSheetContext);
        final bottomInset = MediaQuery.of(bottomSheetContext).padding.bottom;

        return SafeArea(
          top: false,
          bottom: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: mediaQuery.size.height * 0.85,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, bottomInset + 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            width: 44,
                            height: 5,
                            decoration: BoxDecoration(
                              color: colorScheme.outlineVariant.withValues(
                                alpha: 0.35,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          model.title,
                          textAlign: TextAlign.right,
                          style: textTheme.titleMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withValues(alpha: 0.03),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.deepPurple.withValues(alpha: 0.05),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                model.addressLabel,
                                textAlign: TextAlign.right,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                model.address,
                                textAlign: TextAlign.right,
                                style: textTheme.bodyMedium?.copyWith(
                                  height: 1.7,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface.withValues(
                                    alpha: 0.9,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              _DashedDivider(
                                color: colorScheme.outlineVariant.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    model.postalCodeLabel,
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                  Text(
                                    model.postalCode,
                                    textDirection: TextDirection.ltr,
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 36),
                        FilledButton(
                          onPressed: () => Navigator.of(
                            bottomSheetContext,
                          ).pop(_AddressBottomSheetResult.edit),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(52),
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            model.editButtonText,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    return result == _AddressBottomSheetResult.edit;
  }

  Future<void> _showPostalCodeBottomSheet(
    BuildContext context,
    ShowBankAddressBottomSheetActionModel model,
  ) async {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final inputBorderColor = _resolveInputBorderColor(context, colorScheme);
    var postalCodeInput = '';
    var showValidationError = false;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (bottomSheetContext) {
        final mediaQuery = MediaQuery.of(bottomSheetContext);
        final bottomInset = mediaQuery.viewInsets.bottom;
        final bottomSafeArea = mediaQuery.padding.bottom;

        return SafeArea(
          top: false,
          bottom: false,
          child: StatefulBuilder(
            builder: (statefulContext, setModalState) {
              return AnimatedPadding(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                padding: EdgeInsets.only(bottom: bottomInset),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: mediaQuery.size.height * 0.9,
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            16,
                            10,
                            16,
                            bottomSafeArea + 16,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Container(
                                  width: 44,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: colorScheme.outlineVariant
                                        .withValues(alpha: 0.35),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                model.editTitle,
                                textAlign: TextAlign.right,
                                style: textTheme.titleMedium?.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                model.postalCodeLabel,
                                textAlign: TextAlign.right,
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.right,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  postalCodeInput = value;
                                  if (!showValidationError) return;
                                  setModalState(
                                    () => showValidationError = false,
                                  );
                                },
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                                decoration: InputDecoration(
                                  hintText: model.postalCodeHint,
                                  hintTextDirection: TextDirection.rtl,
                                  hintStyle: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                  errorText: showValidationError
                                      ? 'کد پستی صحیح را وارد کنید'
                                      : null,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: inputBorderColor,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: inputBorderColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 36),
                              FilledButton(
                                onPressed: () async {
                                  final postalCode = _normalizePostalCode(
                                    postalCodeInput,
                                  );
                                  if (!_isValidPostalCode(postalCode)) {
                                    setModalState(
                                      () => showValidationError = true,
                                    );
                                    return;
                                  }

                                  StacRegistry.instance.setValue(
                                    model.postalCodeValueKey,
                                    postalCode,
                                  );
                                  RegistryNotifier.instance.notify();

                                  Navigator.of(bottomSheetContext).pop();

                                  if (model.inquiryAction == null ||
                                      !context.mounted) {
                                    return;
                                  }

                                  await Future<void>.delayed(
                                    const Duration(milliseconds: 120),
                                  );
                                  if (!context.mounted) return;

                                  try {
                                    await Stac.onCallFromJson(
                                      model.inquiryAction!,
                                      context,
                                    );
                                  } catch (e, stackTrace) {
                                    AppLogger.e(
                                      'Error executing bank address inquiry action',
                                      e,
                                      stackTrace,
                                    );
                                  }
                                },
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size.fromHeight(52),
                                  backgroundColor: colorScheme.primary,
                                  foregroundColor: colorScheme.onPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  model.inquiryButtonText,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  String _normalizePostalCode(String input) {
    const persianDigits = '۰۱۲۳۴۵۶۷۸۹';
    const arabicDigits = '٠١٢٣٤٥٦٧٨٩';
    final buffer = StringBuffer();

    for (final char in input.trim().split('')) {
      final persianIndex = persianDigits.indexOf(char);
      if (persianIndex >= 0) {
        buffer.write(persianIndex);
        continue;
      }

      final arabicIndex = arabicDigits.indexOf(char);
      if (arabicIndex >= 0) {
        buffer.write(arabicIndex);
        continue;
      }

      buffer.write(char);
    }

    return buffer.toString();
  }

  bool _isValidPostalCode(String postalCode) {
    return RegExp(r'^\d{10}$').hasMatch(postalCode);
  }

  Color _resolveInputBorderColor(
    BuildContext context,
    ColorScheme colorScheme,
  ) {
    final enabledBorder = Theme.of(context).inputDecorationTheme.enabledBorder;
    if (enabledBorder is OutlineInputBorder) {
      return enabledBorder.borderSide.color;
    }
    return colorScheme.outlineVariant.withValues(alpha: 0.45);
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 6.0;
        const dashSpace = 4.0;
        final dashCount = (constraints.maxWidth / (dashWidth + dashSpace))
            .floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            dashCount,
            (_) => SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            ),
          ),
        );
      },
    );
  }
}

void registerShowBankAddressBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowBankAddressBottomSheetActionParser(),
  );
}
