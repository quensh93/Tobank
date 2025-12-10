import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/stac_api_service_provider.dart';
import '../exceptions/api_exceptions.dart';
import '../../helpers/logger.dart';

/// A widget that wraps a STAC screen with pull-to-refresh functionality
///
/// This widget provides a RefreshIndicator that allows users to manually
/// refresh the screen data by pulling down.
///
/// Example usage:
/// ```dart
/// RefreshableStacScreen(
///   screenName: 'home_screen',
///   builder: (context, screenData) {
///     return StacService.fromJson(screenData, context);
///   },
/// )
/// ```
class RefreshableStacScreen extends ConsumerWidget {
  /// The name of the screen to fetch
  final String screenName;

  /// Builder function that receives the screen data
  final Widget Function(BuildContext context, Map<String, dynamic> data) builder;

  /// Optional loading widget
  final Widget? loadingWidget;

  /// Optional error widget builder
  final Widget Function(BuildContext context, Object error)? errorBuilder;

  /// Whether to show a refresh indicator
  final bool showRefreshIndicator;

  /// Callback when refresh is triggered
  final VoidCallback? onRefresh;

  const RefreshableStacScreen({
    super.key,
    required this.screenName,
    required this.builder,
    this.loadingWidget,
    this.errorBuilder,
    this.showRefreshIndicator = true,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenAsync = ref.watch(fetchScreenProvider(screenName));

    return screenAsync.when(
      data: (screenData) {
        final content = builder(context, screenData);

        if (!showRefreshIndicator) {
          return content;
        }

        return RefreshIndicator(
          onRefresh: () => _handleRefresh(ref),
          child: content,
        );
      },
      loading: () {
        return loadingWidget ??
            const Center(
              child: CircularProgressIndicator(),
            );
      },
      error: (error, stackTrace) {
        AppLogger.e('Error loading screen: $screenName', error, stackTrace);

        if (errorBuilder != null) {
          return errorBuilder!(context, error);
        }

        return _buildDefaultErrorWidget(context, error, ref);
      },
    );
  }

  /// Handle refresh action
  Future<void> _handleRefresh(WidgetRef ref) async {
    try {
      AppLogger.i('🔄 Refreshing screen: $screenName');
      
      // Trigger the refresh
      await ref.read(apiRefreshProvider.notifier).refresh();
      
      // Invalidate the screen provider to refetch
      ref.invalidate(fetchScreenProvider(screenName));
      
      // Call the optional callback
      onRefresh?.call();
      
      AppLogger.i('✅ Screen refreshed: $screenName');
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to refresh screen: $screenName', e, stackTrace);
      rethrow;
    }
  }

  /// Build default error widget
  Widget _buildDefaultErrorWidget(
    BuildContext context,
    Object error,
    WidgetRef ref,
  ) {
    String errorMessage = 'An error occurred';
    IconData errorIcon = Icons.error_outline;

    if (error is ScreenNotFoundException) {
      errorMessage = 'Screen not found: $screenName';
      errorIcon = Icons.search_off;
    } else if (error is NetworkException) {
      errorMessage = 'Network error: ${error.message}';
      errorIcon = Icons.wifi_off;
    } else if (error is ApiException) {
      errorMessage = error.message;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              errorIcon,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Oops!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _handleRefresh(ref),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget that provides manual refresh button for STAC screens
///
/// This widget adds a floating action button that allows users to
/// manually trigger a refresh of the screen data.
class StacScreenWithRefreshButton extends ConsumerWidget {
  /// The screen content
  final Widget child;

  /// The screen name to refresh
  final String? screenName;

  /// Whether to show the refresh button
  final bool showRefreshButton;

  /// Custom refresh button widget
  final Widget? refreshButton;

  /// Callback when refresh is triggered
  final VoidCallback? onRefresh;

  const StacScreenWithRefreshButton({
    super.key,
    required this.child,
    this.screenName,
    this.showRefreshButton = true,
    this.refreshButton,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!showRefreshButton) {
      return child;
    }

    return Scaffold(
      body: child,
      floatingActionButton: refreshButton ??
          FloatingActionButton(
            onPressed: () => _handleRefresh(ref, context),
            tooltip: 'Refresh',
            child: const Icon(Icons.refresh),
          ),
    );
  }

  /// Handle refresh action
  Future<void> _handleRefresh(WidgetRef ref, BuildContext context) async {
    try {
      AppLogger.i('🔄 Manual refresh triggered');
      
      // Trigger the refresh
      await ref.read(apiRefreshProvider.notifier).refresh();
      
      // Invalidate the screen provider if screenName is provided
      if (screenName != null) {
        ref.invalidate(fetchScreenProvider(screenName!));
      }
      
      // Call the optional callback
      onRefresh?.call();
      
      AppLogger.i('✅ Manual refresh completed');
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to refresh', e, stackTrace);
      
      // Show error snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to refresh: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _handleRefresh(ref, context),
            ),
          ),
        );
      }
    }
  }
}

/// A widget that provides pull-to-refresh for any scrollable content
///
/// This is a generic wrapper that can be used with any scrollable widget.
class PullToRefreshWrapper extends ConsumerWidget {
  /// The scrollable child widget
  final Widget child;

  /// Callback when refresh is triggered
  final Future<void> Function()? onRefresh;

  /// Whether to enable pull-to-refresh
  final bool enabled;

  const PullToRefreshWrapper({
    super.key,
    required this.child,
    this.onRefresh,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!enabled) {
      return child;
    }

    return RefreshIndicator(
      onRefresh: () async {
        if (onRefresh != null) {
          await onRefresh!();
        } else {
          // Default behavior: refresh the API cache
          await ref.read(apiRefreshProvider.notifier).refresh();
        }
      },
      child: child,
    );
  }
}
