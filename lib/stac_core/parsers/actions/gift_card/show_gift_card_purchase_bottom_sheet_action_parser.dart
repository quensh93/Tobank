import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

import '../../../registry/custom_component_registry.dart';
import '../custom_navigate_action_parser.dart';

class ShowGiftCardPurchaseBottomSheetActionModel {
  final String title;
  final String message;
  final String rulesLabel;
  final String continueText;
  final Map<String, dynamic>? continueAction;

  const ShowGiftCardPurchaseBottomSheetActionModel({
    required this.title,
    required this.message,
    required this.rulesLabel,
    required this.continueText,
    this.continueAction,
  });

  factory ShowGiftCardPurchaseBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawContinueAction = json['continueAction'];
    return ShowGiftCardPurchaseBottomSheetActionModel(
      title: json['title'] as String? ?? 'خرید کارت هدیه',
      message:
          json['message'] as String? ??
          'به مبالغ ۳۶,۰۰۰ ریال بابت کارمزد و ۵۷۰,۰۰۰ ریال بابت ارسال کارت هدیه به تحویل گیرنده اضافه می‌گردد',
      rulesLabel:
          json['rulesLabel'] as String? ??
          'قوانین و مقررات توبانک را خوانده و قبول دارم',
      continueText: json['continueText'] as String? ?? 'ادامه',
      continueAction: rawContinueAction is Map<String, dynamic>
          ? rawContinueAction
          : rawContinueAction is Map
          ? Map<String, dynamic>.from(rawContinueAction)
          : null,
    );
  }
}

class ShowGiftCardPurchaseBottomSheetActionParser
    extends StacActionParser<ShowGiftCardPurchaseBottomSheetActionModel> {
  const ShowGiftCardPurchaseBottomSheetActionParser();

  @override
  String get actionType => 'showGiftCardPurchaseBottomSheet';

  @override
  ShowGiftCardPurchaseBottomSheetActionModel getModel(
    Map<String, dynamic> json,
  ) {
    return ShowGiftCardPurchaseBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowGiftCardPurchaseBottomSheetActionModel model,
  ) async {
    NavLogger.logOverlay('push', 'bottomSheet', 'gift_card_purchase');
    if (!context.mounted) return;

    bool isRulesAccepted = false;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final result = await showModalBottomSheet<_GiftCardPurchaseDecision>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.62),
      builder: (bottomSheetContext) {
        final safeBottom = MediaQuery.of(bottomSheetContext).padding.bottom;

        return SafeArea(
          top: false,
          bottom: false,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: StatefulBuilder(
              builder: (statefulContext, setModalState) {
                return Container(
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 10, 24, safeBottom + 18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            width: 62,
                            height: 6,
                            decoration: BoxDecoration(
                              color: colorScheme.outlineVariant.withValues(
                                alpha: 0.45,
                              ),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Text(
                          model.title,
                          textAlign: TextAlign.right,
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          model.message,
                          textAlign: TextAlign.right,
                          style: textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.onSurfaceVariant,
                            height: 1.9,
                          ),
                        ),
                        const SizedBox(height: 36),
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            setModalState(() {
                              isRulesAccepted = !isRulesAccepted;
                            });
                          },

                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: isRulesAccepted
                                      ? const Color(0xFFD61F2C)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: isRulesAccepted
                                        ? const Color(0xFFD61F2C)
                                        : const Color(0xFF1F2937),
                                    width: 2,
                                  ),
                                ),
                                child: isRulesAccepted
                                    ? const Icon(
                                        Icons.check_rounded,
                                        color: Colors.white,
                                        size: 15,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  model.rulesLabel,
                                  textAlign: TextAlign.right,
                                  style: textTheme.titleMedium?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 34),
                        FilledButton(
                          onPressed: isRulesAccepted
                              ? () {
                                  Navigator.of(
                                    bottomSheetContext,
                                  ).pop(_GiftCardPurchaseDecision.continueFlow);
                                }
                              : null,
                          style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(64),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 0,
                            backgroundColor: const Color(0xFFD61F2C),
                            disabledBackgroundColor: const Color(0xFFADADAD),
                            foregroundColor: Colors.white,
                            disabledForegroundColor: Colors.white,
                          ),
                          child: Text(
                            model.continueText,
                            style: textTheme.titleMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    if (result != _GiftCardPurchaseDecision.continueFlow ||
        model.continueAction == null ||
        !context.mounted) {
      return;
    }

    await Future<void>.delayed(const Duration(milliseconds: 180));
    if (!context.mounted) return;

    await Stac.onCallFromJson(model.continueAction!, context);
  }
}

enum _GiftCardPurchaseDecision { continueFlow }

void registerShowGiftCardPurchaseBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowGiftCardPurchaseBottomSheetActionParser(),
  );
}
