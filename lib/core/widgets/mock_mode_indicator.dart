import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../api/providers/api_config_provider.dart';
import '../api/providers/mock_api_service_provider.dart';
import '../api/api_config.dart';

/// Mock mode indicator widget
///
/// Displays a visual indicator when the app is running in mock API mode.
/// Shows the current API mode and provides quick actions for switching modes
/// and reloading mock data.
class MockModeIndicator extends ConsumerWidget {
  /// Whether to show as a banner (full width) or badge (compact)
  final bool showAsBanner;

  /// Whether to show reload button
  final bool showReloadButton;

  /// Whether to show mode switcher
  final bool showModeSwitcher;

  const MockModeIndicator({
    super.key,
    this.showAsBanner = false,
    this.showReloadButton = true,
    this.showModeSwitcher = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiMode = ref.watch(apiConfigProvider).mode;
    final isMockMode = apiMode == ApiMode.mock;
    final reloadCount = ref.watch(mockDataReloadCountProvider);

    if (!isMockMode && !showModeSwitcher) {
      // Don't show indicator if not in mock mode and mode switcher is disabled
      return const SizedBox.shrink();
    }

    if (showAsBanner) {
      return _buildBanner(context, ref, apiMode, reloadCount);
    } else {
      return _buildBadge(context, ref, apiMode, reloadCount);
    }
  }

  Widget _buildBanner(
    BuildContext context,
    WidgetRef ref,
    ApiMode apiMode,
    int reloadCount,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _getModeColor(apiMode).withValues(alpha: 0.1),
        border: Border(
          bottom: BorderSide(color: _getModeColor(apiMode), width: 2),
        ),
      ),
      child: Row(
        children: [
          Icon(_getModeIcon(apiMode), color: _getModeColor(apiMode), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getModeLabel(apiMode),
                  style: TextStyle(
                    color: _getModeColor(apiMode),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (apiMode == ApiMode.mock && reloadCount > 0)
                  Text(
                    'Reloaded $reloadCount time${reloadCount == 1 ? '' : 's'}',
                    style: TextStyle(
                      color: _getModeColor(apiMode).withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          if (showReloadButton && apiMode == ApiMode.mock) ...[
            const SizedBox(width: 8),
            _buildReloadButton(context, ref),
          ],
          if (showModeSwitcher) ...[
            const SizedBox(width: 8),
            _buildModeSwitcher(context, ref, apiMode),
          ],
        ],
      ),
    );
  }

  Widget _buildBadge(
    BuildContext context,
    WidgetRef ref,
    ApiMode apiMode,
    int reloadCount,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getModeColor(apiMode).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _getModeColor(apiMode), width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getModeIcon(apiMode), color: _getModeColor(apiMode), size: 16),
          const SizedBox(width: 6),
          Text(
            _getModeLabel(apiMode),
            style: TextStyle(
              color: _getModeColor(apiMode),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          if (showReloadButton && apiMode == ApiMode.mock) ...[
            const SizedBox(width: 6),
            _buildReloadButton(context, ref, compact: true),
          ],
          if (showModeSwitcher) ...[
            const SizedBox(width: 6),
            _buildModeSwitcher(context, ref, apiMode, compact: true),
          ],
        ],
      ),
    );
  }

  Widget _buildReloadButton(
    BuildContext context,
    WidgetRef ref, {
    bool compact = false,
  }) {
    return IconButton(
      icon: Icon(Icons.refresh, size: compact ? 16 : 20),
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
        minWidth: compact ? 24 : 32,
        minHeight: compact ? 24 : 32,
      ),
      tooltip: 'Reload mock data',
      onPressed: () async {
        await ref.read(mockDataReloadProvider.notifier).reloadMockData();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mock data reloaded'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
    );
  }

  Widget _buildModeSwitcher(
    BuildContext context,
    WidgetRef ref,
    ApiMode currentMode, {
    bool compact = false,
  }) {
    return PopupMenuButton<ApiMode>(
      icon: Icon(Icons.swap_horiz, size: compact ? 16 : 20),
      padding: EdgeInsets.zero,
      tooltip: 'Switch API mode',
      onSelected: (mode) {
        switch (mode) {
          case ApiMode.mock:
            ref.read(apiConfigProvider.notifier).useMockApi();
            break;
          case ApiMode.supabase:
            // [TODO]: Prompt for Supabase credentials
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Supabase mode not yet implemented'),
              ),
            );
            break;
          case ApiMode.custom:
            // [TODO]: Prompt for custom API URL
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Custom API mode not yet implemented'),
              ),
            );
            break;
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: ApiMode.mock,
          child: Row(
            children: [
              Icon(Icons.storage, color: _getModeColor(ApiMode.mock), size: 18),
              const SizedBox(width: 8),
              const Text('Mock API'),
              if (currentMode == ApiMode.mock) ...[
                const Spacer(),
                const Icon(Icons.check, size: 18),
              ],
            ],
          ),
        ),
        PopupMenuItem(
          value: ApiMode.supabase,
          child: Row(
            children: [
              Icon(
                Icons.cloud,
                color: _getModeColor(ApiMode.supabase),
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text('Supabase'),
              if (currentMode == ApiMode.supabase) ...[
                const Spacer(),
                const Icon(Icons.check, size: 18),
              ],
            ],
          ),
        ),
        PopupMenuItem(
          value: ApiMode.custom,
          child: Row(
            children: [
              Icon(Icons.api, color: _getModeColor(ApiMode.custom), size: 18),
              const SizedBox(width: 8),
              const Text('Custom API'),
              if (currentMode == ApiMode.custom) ...[
                const Spacer(),
                const Icon(Icons.check, size: 18),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Color _getModeColor(ApiMode mode) {
    switch (mode) {
      case ApiMode.mock:
        return Colors.orange;
      case ApiMode.supabase:
        return Colors.blue;
      case ApiMode.custom:
        return Colors.green;
    }
  }

  IconData _getModeIcon(ApiMode mode) {
    switch (mode) {
      case ApiMode.mock:
        return Icons.storage;
      case ApiMode.supabase:
        return Icons.cloud;
      case ApiMode.custom:
        return Icons.api;
    }
  }

  String _getModeLabel(ApiMode mode) {
    switch (mode) {
      case ApiMode.mock:
        return 'Mock API Mode';
      case ApiMode.supabase:
        return 'Supabase Mode';
      case ApiMode.custom:
        return 'Custom API Mode';
    }
  }
}

/// Floating mock mode indicator
///
/// A draggable floating indicator that can be positioned anywhere on the screen.
/// Useful for showing mock mode status without taking up permanent screen space.
class FloatingMockModeIndicator extends StatefulWidget {
  const FloatingMockModeIndicator({super.key});

  @override
  State<FloatingMockModeIndicator> createState() =>
      _FloatingMockModeIndicatorState();
}

class _FloatingMockModeIndicatorState extends State<FloatingMockModeIndicator> {
  Offset _position = const Offset(20, 100);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: Draggable(
        feedback: Material(
          color: Colors.transparent,
          child: Opacity(
            opacity: 0.7,
            child: MockModeIndicator(
              showAsBanner: false,
              showReloadButton: true,
              showModeSwitcher: true,
            ),
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.3,
          child: MockModeIndicator(
            showAsBanner: false,
            showReloadButton: true,
            showModeSwitcher: true,
          ),
        ),
        onDragEnd: (details) {
          setState(() {
            _position = details.offset;
          });
        },
        child: MockModeIndicator(
          showAsBanner: false,
          showReloadButton: true,
          showModeSwitcher: true,
        ),
      ),
    );
  }
}
