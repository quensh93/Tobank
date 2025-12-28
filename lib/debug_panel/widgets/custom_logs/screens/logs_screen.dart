import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ispect/ispect.dart';
import '../controllers/group_button.dart';
import '../controllers/ispect_view_controller.dart';
import '../extensions/context.dart';
import '../utils/copy_clipboard.dart';
import '../utils/screen_size.dart';
import '../widgets/ispect_app_bar.dart';
import '../widgets/log_card.dart';
import '../widgets/gap.dart';
import '../widgets/sliver_gap.dart';
import '../widgets/info_bottom_sheet.dart';
import '../widgets/settings_bottom_sheet.dart';
import '../screens/navigation_flow.dart';
import '../screens/daily_sessions.dart';
import '../widgets/share_all_logs_sheet.dart';
import '../widgets/widget_builder.dart';
import '../extensions/string.dart';

/// Main screen for displaying ISpect logs.
/// Matches the original ISpect LogsScreen structure exactly.
class LogsScreen extends StatefulWidget {
  const LogsScreen({
    required this.options,
    this.appBarTitle,
    super.key,
  });

  final ISpectOptions options;
  final String? appBarTitle;

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final _titleFiltersController = GroupButtonController();
  final _searchFocusNode = FocusNode();
  final _logsScrollController = ScrollController();
  final _searchController = TextEditingController();
  late final ISpectViewController _logsViewController;
  Timer? _filterDebounceTimer;

  @override
  void initState() {
    super.initState();
    _logsViewController = ISpectViewController(
      onShare: widget.options.onShare,
    );
    _logsViewController.toggleExpandedLogs();

    // Initialize controller with current search query
    // Extract search query from filter (it's stored in SearchFilter within filters list)
    final searchFilters =
        _logsViewController.filter.filters.whereType<SearchFilter>().toList();
    final currentQuery =
        searchFilters.isNotEmpty ? searchFilters.first.query : '';
    _searchController.text = currentQuery;

    // Listen to TextEditingController changes to sync filter immediately
    // This ensures the filter updates even when text is modified programmatically
    // (e.g., via keyboard handler or programmatic clear)
    _searchController.addListener(_onSearchControllerChanged);
  }

  void _onSearchControllerChanged() {
    // Sync filter with controller text value
    // This handles both manual typing and programmatic changes (like keyboard handler)
    final value = _searchController.text;
    _onSearchTextChanged(value);
  }

  void _onSearchTextChanged(String value) {
    // Cancel previous timer
    _filterDebounceTimer?.cancel();

    // For empty search, update immediately without debounce to show logs right away
    if (value.isEmpty) {
      _logsViewController.updateFilterSearchQuery('');
      return;
    }

    // Debounce filter updates to prevent interfering with text editing
    // Update filter after user stops typing for 300ms
    _filterDebounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;

      final searchFilters =
          _logsViewController.filter.filters.whereType<SearchFilter>().toList();
      final filterQuery =
          searchFilters.isNotEmpty ? searchFilters.first.query : '';

      // Only update if different (avoid unnecessary updates)
      if (value != filterQuery) {
        _logsViewController.updateFilterSearchQuery(value);
      }
    });
  }

  @override
  void dispose() {
    _filterDebounceTimer?.cancel();
    _searchController.removeListener(_onSearchControllerChanged);
    _searchFocusNode.dispose();
    _searchController.dispose();
    _titleFiltersController.dispose();
    _logsViewController.dispose();
    _logsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iSpect = ISpect.read(context);
    return Scaffold(
      backgroundColor: context.ispectTheme.scaffoldBackgroundColor,
      body: ListenableBuilder(
        listenable: _logsViewController,
        builder: (_, __) => Row(
          children: [
            Expanded(
              child: ISpectifyBuilder(
                iSpectLogger: ISpect.logger,
                builder: (context, data) => ListenableBuilder(
                  listenable: _logsViewController,
                  builder: (_, __) => _MainLogsView(
                    logsData: data,
                    iSpectTheme: iSpect,
                    titleFiltersController: _titleFiltersController,
                    searchFocusNode: _searchFocusNode,
                    logsScrollController: _logsScrollController,
                    logsViewController: _logsViewController,
                    appBarTitle: widget.appBarTitle,
                    searchController: _searchController,
                    onSearchChanged: _onSearchTextChanged,
                    onSettingsTap: () => _openLogsSettings(context),
                    onInfoTap: () => _showInfoBottomSheet(context),
                  ),
                ),
              ),
            ),
            if (_logsViewController.activeData != null) ...[
              VerticalDivider(
                color: _getDividerColor(iSpect, context),
                width: 1,
                thickness: 1,
              ),
              context.screenSizeMaybeWhen(
                phone: () => const SizedBox.shrink(),
                orElse: () => _DetailView(
                  activeData: _logsViewController.activeData!,
                  onClose: () => _logsViewController.activeData = null,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getDividerColor(ISpectScopeModel iSpect, BuildContext context) =>
      context.ispectTheme.dividerColor;

  Future<void> _showInfoBottomSheet(BuildContext context) async {
    if (!mounted) return;
    await const InfoBottomSheet().show(context);
  }

  void _openLogsSettings(BuildContext context) {
    ISpectSettingsBottomSheet(
      iSpectLogger: ValueNotifier(ISpect.logger),
      options: widget.options,
      controller: _logsViewController,
      actions: _buildSettingsActions(context),
    ).show(context);
  }

  List<ISpectActionItem> _buildSettingsActions(BuildContext context) => [
        _buildReverseLogsAction(context),
        _buildCopyAllLogsAction(context),
        _buildExpandLogsAction(context),
        _buildClearHistoryAction(context),
        if (widget.options.onShare != null) _buildShareLogsAction(context),
        if (widget.options.observer != null &&
            widget.options.observer is ISpectNavigatorObserver)
          _buildNavigationFlowAction(context),
        if (ISpect.logger.fileLogHistory != null)
          _buildDailySessionsAction(context),
        _buildLogViewerAction(context),
        ...widget.options.actionItems,
      ];

  ISpectActionItem _buildReverseLogsAction(BuildContext context) =>
      ISpectActionItem(
        onTap: (_) => _logsViewController.toggleLogOrder(),
        title: context.ispectL10n.reverseLogs,
        icon: Icons.swap_vert,
      );

  ISpectActionItem _buildCopyAllLogsAction(BuildContext context) {
    // Capture the LogsScreen's context which has access to ScaffoldMessenger
    final logsScreenContext = context;
    return ISpectActionItem(
      onTap: (_) => _logsViewController.copyAllLogsToClipboard(
        logsScreenContext,
        ISpect.logger.history,
        (bottomSheetContext, {required value, showValue, title}) {
          // Use the LogsScreen's context (which has ScaffoldMessenger) instead of bottom sheet context
          copyClipboard(
            logsScreenContext,
            value: value,
            title: title ?? logsScreenContext.ispectL10n.allLogsCopied,
            showValue: showValue ?? false,
          );
        },
        '✅ ${context.ispectL10n.allLogsCopied}',
      ),
      title: context.ispectL10n.copyAllLogs,
      icon: Icons.copy,
    );
  }

  ISpectActionItem _buildExpandLogsAction(BuildContext context) =>
      ISpectActionItem(
        onTap: (_) => _logsViewController.toggleExpandedLogs(),
        title: _logsViewController.expandedLogs
            ? context.ispectL10n.collapseLogs
            : context.ispectL10n.expandLogs,
        icon: _logsViewController.expandedLogs
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
      );

  ISpectActionItem _buildClearHistoryAction(BuildContext context) =>
      ISpectActionItem(
        onTap: (_) =>
            _logsViewController.clearLogsHistory(ISpect.logger.clearHistory),
        title: context.ispectL10n.clearHistory,
        icon: Icons.delete_outline,
      );

  ISpectActionItem _buildShareLogsAction(BuildContext context) =>
      ISpectActionItem(
        onTap: (_) => ShareAllLogsSheet(
          controller: _logsViewController,
          logs: ISpect.logger.history,
        ).show(context),
        title: context.ispectL10n.shareLogsFile,
        icon: Icons.ios_share_outlined,
      );

  ISpectActionItem _buildNavigationFlowAction(BuildContext context) {
    // Capture the LogsScreen's context which has access to Navigator
    final logsScreenContext = context;
    return ISpectActionItem(
      title: context.ispectL10n.navigationFlow,
      icon: Icons.route_rounded,
      onTap: (_) => ISpectNavigationFlowScreen(
        observer: widget.options.observer! as ISpectNavigatorObserver,
      ).push(logsScreenContext),
    );
  }

  ISpectActionItem _buildDailySessionsAction(BuildContext context) {
    // Capture the LogsScreen's context which has access to Navigator
    final logsScreenContext = context;
    return ISpectActionItem(
      title: context.ispectL10n.dailySessions,
      icon: Icons.history_rounded,
      onTap: (_) => Navigator.of(logsScreenContext).push(
        MaterialPageRoute(
          builder: (_) => DailySessionsScreen(
            controller: _logsViewController,
            logs: ISpect.logger.history,
          ),
        ),
      ),
    );
  }

  ISpectActionItem _buildLogViewerAction(BuildContext context) {
    return ISpectActionItem(
      title: context.ispectL10n.logViewer,
      icon: Icons.developer_mode_rounded,
      onTap: (_) {
        // Log viewer functionality - show paste dialog or load from file
        if (widget.options.onLoadLogContent == null) {
          _showPasteDialog(context);
        } else {
          _handleLogViewerTap();
        }
      },
    );
  }

  Future<void> _handleLogViewerTap() async {
    if (!mounted) return;
    final loader = widget.options.onLoadLogContent;
    if (loader == null) return;

    // Show dialog to choose file or paste
    final choice = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.ispectL10n.logViewer),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.file_open),
              title: const Text('Load from File'),
              onTap: () => Navigator.pop(context, 'file'),
            ),
            ListTile(
              leading: const Icon(Icons.paste),
              title: Text(context.ispectL10n.pasteContent),
              onTap: () => Navigator.pop(context, 'paste'),
            ),
          ],
        ),
      ),
    );

    if (!mounted || choice == null) return;

    if (choice == 'file') {
      final content = await loader(context);
      if (content != null && mounted) {
        await widget.options.onLoadLogContent?.call(context);
      }
    } else if (choice == 'paste') {
      _showPasteDialog(context);
    }
  }

  void _showPasteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(context.ispectL10n.pasteContent),
        content: const TextField(
          autofocus: true,
          maxLines: 10,
          decoration: InputDecoration(
            hintText: 'Paste JSON content here...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(context.ispectL10n.cancel),
          ),
        ],
      ),
    );
  }
}

/// A widget that represents a single log entry in the list.
class _LogListItem extends StatelessWidget {
  const _LogListItem({
    required this.logData,
    required this.itemIndex,
    required this.statusIcon,
    required this.statusColor,
    required this.isExpanded,
    required this.isLastItem,
    required this.dividerColor,
    required this.onItemTapped,
    required this.onCopyPressed,
    this.observer,
    super.key,
  });

  final ISpectLogData logData;
  final int itemIndex;
  final IconData statusIcon;
  final Color statusColor;
  final bool isExpanded;
  final bool isLastItem;
  final Color dividerColor;
  final VoidCallback onItemTapped;
  final VoidCallback onCopyPressed;
  final ISpectNavigatorObserver? observer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RepaintBoundary(
          child: LogCard(
            icon: statusIcon,
            color: statusColor,
            data: logData,
            index: itemIndex,
            isExpanded: isExpanded,
            onCopyTap: onCopyPressed,
            onTap: onItemTapped,
            observer: observer,
          ),
        ),
        if (!isLastItem)
          Divider(
            height: 1,
            thickness: 1,
            color: dividerColor,
          ),
      ],
    );
  }
}

/// A widget displayed when there are no logs to show.
class _EmptyLogsWidget extends StatelessWidget {
  const _EmptyLogsWidget();

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.info_outline_rounded,
              size: 40,
              color: Colors.white70,
            ),
            const Gap(8),
            Text(
              context.ispectL10n.notFound.capitalize(),
              style: context.ispectTheme.textTheme.bodyLarge,
            ),
          ],
        ),
      );
}

/// Main logs view widget that displays the scrollable list of logs
class _MainLogsView extends StatelessWidget {
  const _MainLogsView({
    required this.logsData,
    required this.iSpectTheme,
    required this.titleFiltersController,
    required this.searchFocusNode,
    required this.logsScrollController,
    required this.logsViewController,
    required this.onSettingsTap,
    required this.onInfoTap,
    this.appBarTitle,
    this.searchController,
    this.onSearchChanged,
  });

  final List<ISpectLogData> logsData;
  final ISpectScopeModel iSpectTheme;
  final GroupButtonController titleFiltersController;
  final FocusNode searchFocusNode;
  final ScrollController logsScrollController;
  final ISpectViewController logsViewController;
  final VoidCallback onSettingsTap;
  final VoidCallback onInfoTap;
  final String? appBarTitle;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;

  @override
  Widget build(BuildContext context) {
    final filteredLogEntries = logsViewController.applyCurrentFilters(logsData);
    final (allTitles, uniqueTitles) = logsViewController.getTitles(logsData);
    // Convert List<String> to List<String?> for ISpectAppBar
    final allTitlesNullable = allTitles.map((t) => t as String?).toList();
    final uniqueTitlesNullable = uniqueTitles.map((t) => t as String?).toList();
    final dividerColor = _getDividerColor(iSpectTheme, context);
    final options = ISpect.read(context).options;

    return CustomScrollView(
      controller: logsScrollController,
      cacheExtent: 1000,
      slivers: [
        ISpectAppBar(
          focusNode: searchFocusNode,
          title: appBarTitle,
          titlesController: titleFiltersController,
          titles: allTitlesNullable,
          uniqTitles: uniqueTitlesNullable,
          controller: logsViewController,
          searchController: searchController,
          onSearchChanged: onSearchChanged,
          onSettingsTap: onSettingsTap,
          onInfoTap: onInfoTap,
          onToggleTitle: (title, selected) => logsViewController
              .handleTitleFilterToggle(title, isSelected: selected),
          backgroundColor: context.ispectTheme.scaffoldBackgroundColor,
        ),
        if (filteredLogEntries.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: _EmptyLogsWidget(),
          ),
        SliverList.builder(
          itemCount: filteredLogEntries.length,
          itemBuilder: (context, index) {
            final logEntry = logsViewController.getLogEntryAtIndex(
              filteredLogEntries,
              index,
            );
            return _LogListItem(
              key: ValueKey('${logEntry.hashCode}_$index'),
              logData: logEntry,
              itemIndex: index,
              statusIcon:
                  iSpectTheme.theme.getTypeIcon(context, key: logEntry.key),
              statusColor:
                  iSpectTheme.theme.getTypeColor(context, key: logEntry.key) ??
                      Colors.grey,
              isExpanded: logsViewController.activeData?.hashCode ==
                      logEntry.hashCode ||
                  logsViewController.expandedLogs,
              isLastItem: index == filteredLogEntries.length - 1,
              dividerColor: dividerColor,
              observer: options.observer is ISpectNavigatorObserver
                  ? options.observer as ISpectNavigatorObserver?
                  : null,
              onCopyPressed: () => logsViewController.copyLogEntryText(
                context,
                logEntry,
                copyClipboard,
              ),
              onItemTapped: () => logsViewController.handleLogItemTap(logEntry),
            );
          },
        ),
        const SliverGap(8),
      ],
    );
  }

  Color _getDividerColor(ISpectScopeModel iSpect, BuildContext context) =>
      context.ispectTheme.dividerColor;
}

/// Detail view widget for displaying selected log data
class _DetailView extends StatelessWidget {
  const _DetailView({
    required this.activeData,
    required this.onClose,
  });

  final ISpectLogData activeData;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => Flexible(
        child: RepaintBoundary(
          child: JsonScreen(
            key: ValueKey(activeData.hashCode),
            data: activeData.toJson(),
            truncatedData: activeData.toJson(truncated: true),
            onClose: onClose,
          ),
        ),
      );
}
