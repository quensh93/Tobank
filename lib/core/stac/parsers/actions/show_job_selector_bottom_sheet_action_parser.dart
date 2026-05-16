import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import 'package:tobank_sdui/stac/tobank/flows/verify_identity/dart/verify_identity_job_selector.dart'
    as verify_identity_job_selector_dart;

import '../../utils/registry_notifier.dart';
import '../../registry/custom_component_registry.dart';

class ShowJobSelectorBottomSheetActionModel {
  final double heightFactor;

  const ShowJobSelectorBottomSheetActionModel({required this.heightFactor});

  factory ShowJobSelectorBottomSheetActionModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ShowJobSelectorBottomSheetActionModel(
      heightFactor: (json['heightFactor'] as num?)?.toDouble() ?? 0.75,
    );
  }
}

class ShowJobSelectorBottomSheetActionParser
    extends StacActionParser<ShowJobSelectorBottomSheetActionModel> {
  const ShowJobSelectorBottomSheetActionParser();

  @override
  String get actionType => 'showJobSelectorBottomSheet';

  @override
  ShowJobSelectorBottomSheetActionModel getModel(Map<String, dynamic> json) {
    return ShowJobSelectorBottomSheetActionModel.fromJson(json);
  }

  @override
  FutureOr<void> onCall(
    BuildContext context,
    ShowJobSelectorBottomSheetActionModel model,
  ) async {
    if (!context.mounted) return;

    final colorScheme = Theme.of(context).colorScheme;

    final selectedJob = await showModalBottomSheet<String>(
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
                top: Radius.circular(16),
              ),
            ),
            child: SizedBox(
              height: screenHeight * model.heightFactor,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, bottomInset + 8),
                child: _JobSelectorBottomSheet(
                  jobTitles: verify_identity_job_selector_dart
                      .verifyIdentityRealJobTitles,
                ),
              ),
            ),
          ),
        );
      },
    );

    if (!context.mounted || selectedJob == null || selectedJob.isEmpty) {
      return;
    }

    StacRegistry.instance.setValue(
      'verifyIdentitySelectedJobTitle',
      selectedJob,
    );
    StacRegistry.instance.setValue('verifyIdentityHasSelectedJob', true);
    RegistryNotifier.instance.notify();
  }
}

class _JobSelectorBottomSheet extends StatefulWidget {
  const _JobSelectorBottomSheet({required this.jobTitles});

  final List<String> jobTitles;

  @override
  State<_JobSelectorBottomSheet> createState() =>
      _JobSelectorBottomSheetState();
}

class _JobSelectorBottomSheetState extends State<_JobSelectorBottomSheet> {
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final filteredJobs = widget.jobTitles.where(_matchesQuery).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 18),
        Center(
          child: Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.outlineVariant.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'حوزه فعالیت خود را انتخاب کنید',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: colorScheme.onSurface,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            controller: _searchController,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
            cursorColor: colorScheme.primary,
            onChanged: (value) {
              setState(() {
                _query = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'جستجو در لیست مشاغل...',
              hintTextDirection: TextDirection.rtl,
              prefixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _query = '';
                        });
                      },
                      icon: const Icon(Icons.close_rounded),
                    ),
              suffixIcon: const Icon(Icons.search_rounded),
              filled: true,
              fillColor: colorScheme.surfaceContainerHigh,
              hintStyle: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              prefixIconColor: colorScheme.onSurfaceVariant,
              suffixIconColor: colorScheme.onSurfaceVariant,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
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
                borderSide: BorderSide(color: colorScheme.primary),
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Expanded(
          child: filteredJobs.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'شغلی با این عبارت پیدا نشد.',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: filteredJobs.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 1,
                    thickness: 1,
                    color: colorScheme.outlineVariant.withValues(alpha: 0.18),
                    endIndent: 8,
                    indent: 8,
                  ),
                  itemBuilder: (context, index) {
                    final title = filteredJobs[index];
                    return InkWell(
                      onTap: () => _selectJob(context, title),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        child: Text(
                          title,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  bool _matchesQuery(String title) {
    final normalizedQuery = _normalize(_query);
    if (normalizedQuery.isEmpty) return true;
    return _normalize(title).contains(normalizedQuery);
  }

  String _normalize(String value) {
    return value.trim().toLowerCase();
  }

  void _selectJob(BuildContext context, String title) {
    Navigator.of(context).pop(title);
  }
}

void registerShowJobSelectorBottomSheetActionParser() {
  CustomComponentRegistry.instance.registerAction(
    const ShowJobSelectorBottomSheetActionParser(),
  );
}
