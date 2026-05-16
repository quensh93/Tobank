import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac/tobank/flows/verify_identity/dart/verify_identity_rules.dart'
    as verify_identity_rules_dart;

import '../../registry/custom_component_registry.dart';
import '../../../helpers/logger.dart';

class ShowRulesBottomSheetActionModel {
  final String routeName;
  final String? title;

  const ShowRulesBottomSheetActionModel({
    required this.routeName,
    this.title,
  });

  factory ShowRulesBottomSheetActionModel.fromJson(Map<String, dynamic> json) {
    return ShowRulesBottomSheetActionModel(
      routeName: json['routeName'] as String? ?? '',
      title: json['title'] as String?,
    );
  }
}

class ShowRulesBottomSheetActionParser
    extends StacActionParser<ShowRulesBottomSheetActionModel> {
  const ShowRulesBottomSheetActionParser();

  @override
  String get actionType => 'showRulesBottomSheet';

  @override
  ShowRulesBottomSheetActionModel getModel(Map<String, dynamic> json) {
    return ShowRulesBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowRulesBottomSheetActionModel model,
  ) async {
    final sections = _resolveSections(model.routeName);
    if (sections.isEmpty) {
      AppLogger.w(
        'ShowRulesBottomSheetActionParser: No rules content for ${model.routeName}',
      );
      return;
    }

    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final title = model.title ??
        verify_identity_rules_dart.verifyIdentityRealRulesSheetTitle;
    const actionColor = Color(0xFFD61F2C);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (bottomSheetContext) {
        final bottomInset = MediaQuery.of(bottomSheetContext).padding.bottom;
        final screenHeight = MediaQuery.sizeOf(bottomSheetContext).height;

        return SafeArea(
          top: false,
          bottom: false,
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: SizedBox(
              height: screenHeight * 0.7,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, bottomInset + 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 2),
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: colorScheme.onSurfaceVariant,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                            title,
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onSurface,
                            ),
                          ),

                    const SizedBox(height: 16),
                    Container(
                      height: 0.8,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.separated(
                        itemCount: sections.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 4),
                        itemBuilder: (context, index) {
                          final section = sections[index];
                          return _RulesSection(
                            title: section.title,
                            paragraphs: section.paragraphs,
                            colorScheme: colorScheme,
                            textTheme: textTheme,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () => Navigator.of(bottomSheetContext).pop(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56),
                        side: const BorderSide(color: actionColor, width: 1.5),
                        foregroundColor: actionColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'متوجه شدم',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
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

  List<verify_identity_rules_dart.VerifyIdentityRealRuleSectionData>
      _resolveSections(String routeName) {
    switch (routeName) {
      case 'verify_identity_rules':
        return verify_identity_rules_dart.verifyIdentityRealRulesSections;
      default:
        return const [];
    }
  }
}

class _RulesSection extends StatelessWidget {
  const _RulesSection({
    required this.title,
    required this.paragraphs,
    required this.colorScheme,
    required this.textTheme,
  });

  final String title;
  final List<String> paragraphs;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: colorScheme.onSurface,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 4),
        ...paragraphs.map(
          (paragraph) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              paragraph,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
                height: 1.9,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

void registerShowRulesBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowRulesBottomSheetActionParser(),
  );
}
