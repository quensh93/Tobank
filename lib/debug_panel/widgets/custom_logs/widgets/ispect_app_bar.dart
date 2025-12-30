// ignore_for_file: implementation_imports, inference_failure_on_function_return_type, avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/group_button.dart';
import '../controllers/ispect_view_controller.dart';
import '../extensions/context.dart';
import 'gap.dart';

class ISpectAppBar extends StatefulWidget {
  const ISpectAppBar({
    required this.title,
    required this.titlesController,
    required this.controller,
    required this.titles,
    required this.uniqTitles,
    required this.onToggleTitle,
    required this.focusNode,
    this.onSettingsTap,
    this.onInfoTap,
    this.onClearTap,
    this.backgroundColor,
    this.searchController,
    this.onSearchChanged,
    super.key,
  });

  final String? title;

  final GroupButtonController titlesController;
  final ISpectViewController controller;

  final List<String?> titles;
  final List<String?> uniqTitles;

  final VoidCallback? onSettingsTap;
  final VoidCallback? onInfoTap;
  final VoidCallback? onClearTap;

  final FocusNode focusNode;

  final Function(String title, bool selected) onToggleTitle;

  final Color? backgroundColor;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;

  @override
  State<ISpectAppBar> createState() => _ISpectAppBarState();
}

class _ISpectAppBarState extends State<ISpectAppBar> {
  final _isFilterEnabled = ValueNotifier(false);
  final _keyboardListenerNode = FocusNode();

  @override
  void dispose() {
    _keyboardListenerNode.dispose();
    super.dispose();
    _isFilterEnabled.dispose();
  }

  KeyEventResult _handleKeyboardEvent(KeyEvent event) {
    // Only handle when TextField has focus
    if (!widget.focusNode.hasFocus || widget.searchController == null) {
      return KeyEventResult.ignored;
    }

    if (event is KeyDownEvent) {
      // Handle backspace manually
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        final controller = widget.searchController!;
        final selection = controller.selection;

        if (controller.text.isNotEmpty && selection.isValid) {
          final text = controller.text;
          final start = selection.start;

          if (selection.isCollapsed) {
            // Normal backspace - delete character before cursor
            if (start > 0) {
              final newText =
                  text.substring(0, start - 1) + text.substring(start);
              final newOffset = start - 1;
              controller.value = TextEditingValue(
                text: newText,
                selection: TextSelection.collapsed(offset: newOffset),
              );
            }
          } else {
            // Selection exists - delete selected text
            final newText = text.substring(0, selection.start) +
                text.substring(selection.end);
            controller.value = TextEditingValue(
              text: newText,
              selection: TextSelection.collapsed(offset: selection.start),
            );
          }
          return KeyEventResult.handled;
        }
      }

      // Handle Ctrl+A (Select All)
      if (event.logicalKey == LogicalKeyboardKey.keyA &&
          (HardwareKeyboard.instance.isControlPressed ||
              HardwareKeyboard.instance.isMetaPressed)) {
        final controller = widget.searchController!;
        controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: controller.text.length,
        );
        return KeyEventResult.handled;
      }
    }

    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _isFilterEnabled,
        builder: (context, value, _) => SliverAppBar(
          elevation: 0,
          pinned: true,
          floating: true,
          expandedHeight: !value ? 110 : 160,
          collapsedHeight: 60,
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          leading: null,
          scrolledUnderElevation: 0,
          backgroundColor: widget.backgroundColor ??
              context.ispectTheme.scaffoldBackgroundColor,
          actions: [
            if (widget.onClearTap != null)
              UnconstrainedBox(
                child: IconButton(
                  onPressed: widget.onClearTap,
                  tooltip: 'Clear logs',
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                  ),
                ),
              ),
            if (widget.onInfoTap != null)
              UnconstrainedBox(
                child: IconButton(
                  onPressed: widget.onInfoTap,
                  icon: const Icon(
                    Icons.info_outline_rounded,
                  ),
                ),
              ),
            if (widget.onSettingsTap != null)
              UnconstrainedBox(
                child: IconButton(
                  onPressed: widget.onSettingsTap,
                  icon: const Icon(
                    Icons.settings_rounded,
                  ),
                ),
              ),
            const Gap(10),
          ],
          title: Text(
            widget.title ?? '',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: KeyboardListener(
                        focusNode: _keyboardListenerNode,
                        onKeyEvent: _handleKeyboardEvent,
                        child: TextField(
                          focusNode: widget.focusNode,
                          controller: widget.searchController,
                          decoration: InputDecoration(
                            hintText: context.ispectL10n.search,
                            prefixIcon: const Icon(Icons.search_rounded),
                            suffixIcon: Badge(
                              smallSize: 8,
                              alignment: const Alignment(0.8, -0.8),
                              isLabelVisible: widget
                                  .titlesController.selectedIndexes.isNotEmpty,
                              child: IconButton(
                                iconSize: 24,
                                onPressed: () {
                                  _isFilterEnabled.value =
                                      !_isFilterEnabled.value;
                                },
                                icon: const Icon(Icons.tune_rounded),
                              ),
                            ),
                            filled: true,
                            fillColor: Theme.of(context).colorScheme.surface,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            constraints: const BoxConstraints(
                              minHeight: 45,
                            ),
                          ),
                          style: Theme.of(context).textTheme.bodyMedium,
                          enableInteractiveSelection: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          // Use onChanged callback to update filter (debounced in LogsScreen)
                          // This allows TextField to handle all text editing (backspace, select all, etc.)
                          // without interference from controller listeners
                          onChanged: widget.onSearchChanged,
                        ),
                      ),
                    ),
                    Flexible(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: !value
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: SizedBox(
                                  key: const ValueKey('filter'),
                                  height: 40,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (_, __) => const Gap(8),
                                    itemCount: widget.uniqTitles.length,
                                    itemBuilder: (context, index) {
                                      final title = widget.uniqTitles[index];
                                      final count = widget.titles
                                          .where((e) => e == title)
                                          .length;
                                      return FilterChip(
                                        selectedColor: context.ispectTheme
                                            .colorScheme.primaryContainer,
                                        label: Text(
                                          '$count  $title',
                                          style: context
                                              .ispectTheme.textTheme.bodyMedium,
                                        ),
                                        selected: widget
                                            .titlesController.selectedIndexes
                                            .contains(index),
                                        onSelected: (selected) {
                                          if (selected) {
                                            widget.titlesController
                                                .selectIndex(index);
                                          } else {
                                            widget.titlesController
                                                .unselectIndex(index);
                                          }
                                          _onToggle(
                                            title,
                                            widget.titlesController
                                                    .selectedIndex ==
                                                index,
                                          );
                                        },
                                        backgroundColor: widget.titlesController
                                                .selectedIndexes
                                                .contains(index)
                                            ? context.isDarkMode
                                                ? context
                                                    .ispectTheme
                                                    .colorScheme
                                                    .primaryContainer
                                                : context.ispectTheme
                                                    .colorScheme.primary
                                            : context.ispectTheme.cardColor,
                                      );
                                    },
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void _onToggle(String? title, bool selected) {
    if (title == null) return;
    widget.onToggleTitle(title, selected);
  }
}
