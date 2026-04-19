import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stac/stac.dart';

import '../../registry/custom_component_registry.dart';

class ShowAddDestinationCardBottomSheetActionModel {
  final String title;
  final String scanButtonText;
  final String scanIconAsset;
  final String cardNumberLabel;
  final String cardNumberHint;
  final String cardTitleLabel;
  final String cardTitleHint;
  final String submitText;
  final Map<String, dynamic>? scanAction;
  final Map<String, dynamic>? submitAction;

  const ShowAddDestinationCardBottomSheetActionModel({
    required this.title,
    required this.scanButtonText,
    required this.scanIconAsset,
    required this.cardNumberLabel,
    required this.cardNumberHint,
    required this.cardTitleLabel,
    required this.cardTitleHint,
    required this.submitText,
    this.scanAction,
    this.submitAction,
  });

  factory ShowAddDestinationCardBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawScanAction = json['scanAction'];
    final rawSubmitAction = json['submitAction'];

    return ShowAddDestinationCardBottomSheetActionModel(
      title: json['title'] as String? ?? 'افزودن کارت جدید',
      scanButtonText: json['scanButtonText'] as String? ?? 'اسکن کارت',
      scanIconAsset:
          json['scanIconAsset'] as String? ?? 'assets/icons/ic_scanner.svg',
      cardNumberLabel: json['cardNumberLabel'] as String? ?? 'شماره کارت',
      cardNumberHint:
          json['cardNumberHint'] as String? ?? 'یک شماره کارت معتبر وارد نمایید',
      cardTitleLabel: json['cardTitleLabel'] as String? ?? 'عنوان کارت',
      cardTitleHint: json['cardTitleHint'] as String? ?? 'عنوان کارت را وارد کنید',
      submitText: json['submitText'] as String? ?? 'ثبت',
      scanAction: rawScanAction is Map<String, dynamic>
          ? rawScanAction
          : rawScanAction is Map
              ? Map<String, dynamic>.from(rawScanAction)
              : null,
      submitAction: rawSubmitAction is Map<String, dynamic>
          ? rawSubmitAction
          : rawSubmitAction is Map
              ? Map<String, dynamic>.from(rawSubmitAction)
              : null,
    );
  }
}

class ShowAddDestinationCardBottomSheetActionParser
    extends StacActionParser<ShowAddDestinationCardBottomSheetActionModel> {
  const ShowAddDestinationCardBottomSheetActionParser();

  @override
  String get actionType => 'showAddDestinationCardBottomSheet';

  @override
  ShowAddDestinationCardBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowAddDestinationCardBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowAddDestinationCardBottomSheetActionModel model,
  ) async {
    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cardNumberController = TextEditingController();
    final cardTitleController = TextEditingController();

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.62),
      builder: (bottomSheetContext) {
        final bottomInset = MediaQuery.of(bottomSheetContext).viewInsets.bottom;
        final safeBottom = MediaQuery.of(bottomSheetContext).padding.bottom;

        return SafeArea(
          top: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16, 10, 16, bottomInset + safeBottom + 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 44,
                        height: 5,
                        decoration: BoxDecoration(
                          color: colorScheme.outlineVariant.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: Text(
                            model.title,
                            textAlign: TextAlign.right,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onSurface,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () {
                            if (model.scanAction != null && context.mounted) {
                              Stac.onCallFromJson(model.scanAction!, context);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(128, 44),
                            side: BorderSide(
                              color: colorScheme.outline.withValues(alpha: 0.8),
                              width: 1.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            textDirection: TextDirection.rtl,
                            children: [
                              SvgPicture.asset(
                                model.scanIconAsset,
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  colorScheme.onSurface,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                model.scanButtonText,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      model.cardNumberLabel,
                      textAlign: TextAlign.right,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: cardNumberController,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: model.cardNumberHint,
                        hintStyle: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorScheme.outlineVariant),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorScheme.outlineVariant),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colorScheme.outline.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      model.cardTitleLabel,
                      textAlign: TextAlign.right,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: cardTitleController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: model.cardTitleHint,
                        hintStyle: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorScheme.outlineVariant),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: colorScheme.outlineVariant),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colorScheme.outline.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: () {
                        Navigator.of(bottomSheetContext).pop();
                        if (model.submitAction != null && context.mounted) {
                          Stac.onCallFromJson(model.submitAction!, context);
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
                        model.submitText,
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
        );
      },
    );
  }
}

void registerShowAddDestinationCardBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowAddDestinationCardBottomSheetActionParser(),
  );
}
