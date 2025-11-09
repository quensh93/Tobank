import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ISpect imports - will be tree-shaken if not used  
import 'package:ispect/ispect.dart';
import '../../core/config/ispect_config.dart'; // Also exports ispectNavigatorObserverProvider
// Custom LogsScreen - migrated from ISpect internal API
import 'custom_logs/screens/logs_screen.dart';

/// Logs tab that displays ISpect logger screen
/// 
/// This uses our custom LogsScreen implementation, which was migrated from ISpect's
/// internal API to work standalone with the pub.dev ISpect package.
class LogsTab extends ConsumerStatefulWidget {
  const LogsTab({super.key});

  @override
  ConsumerState<LogsTab> createState() => _LogsTabState();
}

class _LogsTabState extends ConsumerState<LogsTab> {
  @override
  Widget build(BuildContext context) {
    // If ISpect is not enabled, show empty state
    if (!ISpectConfig.shouldInitialize) {
      return _buildEmptyState(context);
    }
    
    // Get the shared observer instance from provider
    // This is the SAME observer instance used in MaterialApp.navigatorObservers
    // This ensures Navigation Flow can access the navigation data
    final observer = ref.watch(ispectNavigatorObserverProvider);
    
    // Wrap with ISpect localizations and ISpect scope
    return Localizations(
      locale: const Locale('en'),
      delegates: ISpectLocalizations.delegates(),
      child: ISpectBuilder(
        isISpectEnabled: false,
        options: ISpectOptions(
          // Use the shared observer instance from provider (same as MaterialApp)
          observer: observer,
          locale: const Locale('en'),
        ),
        child: Navigator(
          key: GlobalKey<NavigatorState>(),
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) {
                // Navigator.builder creates new context
                // Wrap in ScaffoldMessenger so bottom sheets can access it
                return ScaffoldMessenger(
                  child: Builder(
                    builder: (builderContext) {
                      try {
                        final ispectScope = ISpect.read(builderContext);
                        return _buildLogsScreenContent(ispectScope);
                      } catch (e) {
                        return _buildErrorState(builderContext, e.toString());
                      }
                    },
                  ),
                );
              },
              settings: settings,
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildLogsScreenContent(ISpectScopeModel ispectScope) {
    return LogsScreen(
      options: ispectScope.options,
      appBarTitle: '', // Empty title - hides the title but keeps search and settings
    );
  }
  
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bug_report_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'ISpect Not Enabled',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Enable ISpect to view logs in this tab.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'ISpect Context Error',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Unable to access ISpect logger: $error',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
