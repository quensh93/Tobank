import 'package:flutter/material.dart';
import 'package:ispect/ispect.dart';

/// Navigation flow screen showing navigation transitions and route history
/// 
/// Displays a visual timeline of all navigation transitions captured by
/// the ISpectNavigatorObserver, including route names, timestamps, and types.
class ISpectNavigationFlowScreen extends StatefulWidget {
  const ISpectNavigationFlowScreen({
    required this.observer,
    this.log,
    super.key,
  });

  final ISpectNavigatorObserver observer;
  final RouteLog? log;

  void push(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => this,
        settings: const RouteSettings(
          name: 'ISpect Navigation Flow Screen',
        ),
      ),
    );
  }

  @override
  State<ISpectNavigationFlowScreen> createState() =>
      _ISpectNavigationFlowScreenState();
}

class _ISpectNavigationFlowScreenState
    extends State<ISpectNavigationFlowScreen> {
  int _lastTransitionCount = 0;
  
  @override
  void initState() {
    super.initState();
    _lastTransitionCount = widget.observer.transitions.length;
    
    // Listen to observer changes for live updates
    if (widget.observer is ChangeNotifier) {
      (widget.observer as ChangeNotifier).addListener(_onObserverChanged);
    }
    
    // Poll for changes as fallback (in case observer doesn't notify)
    _startPolling();
  }

  @override
  void dispose() {
    _stopPolling();
    // Remove listener when widget is disposed
    if (widget.observer is ChangeNotifier) {
      (widget.observer as ChangeNotifier).removeListener(_onObserverChanged);
    }
    super.dispose();
  }

  void _onObserverChanged() {
    _checkForUpdates();
  }

  void _checkForUpdates() {
    if (!mounted) return;
    
    final currentCount = widget.observer.transitions.length;
    if (currentCount != _lastTransitionCount) {
      _lastTransitionCount = currentCount;
      setState(() {
        // Force rebuild when transitions change
      });
    }
  }

  // Polling mechanism as fallback
  void _startPolling() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _checkForUpdates();
        _startPolling(); // Continue polling
      }
    });
  }

  void _stopPolling() {
    // Polling is stopped by checking mounted in _startPolling
  }

  @override
  Widget build(BuildContext context) {
    final transitions = widget.observer.transitions;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Flow'),
        actions: [
          if (transitions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '${transitions.length} transitions',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: transitions.isEmpty
          ? _buildEmptyState(context)
          : _buildTransitionsList(context, transitions),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.route_rounded,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No Navigation Transitions',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Navigation transitions will appear here as you navigate through the app.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransitionsList(BuildContext context, List<dynamic> transitions) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: transitions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final transition = transitions[index];
        final isLast = index == transitions.length - 1;
        
        // Parse transition data
        final parsedData = _parseTransition(transition, index);

        return _TransitionCard(
          index: index,
          routeName: parsedData.routeName,
          transitionType: parsedData.transitionType,
          timestamp: parsedData.timestamp,
          fromRoute: parsedData.fromRoute,
          toRoute: parsedData.toRoute,
          isLast: isLast,
          theme: theme,
          colorScheme: colorScheme,
        );
      },
    );
  }

  _TransitionData _parseTransition(dynamic transition, int index) {
    try {
      // Try to access RouteTransition properties
      final dynamic t = transition;
      
      // Extract route names from 'from' and 'to' RouteSettings
      String? fromRoute;
      String? toRoute;
      
      try {
        final from = t.from;
        if (from != null) {
          final settings = from.settings;
          if (settings != null) {
            fromRoute = _extractRouteName(settings);
          }
        }
      } catch (_) {}
      
      try {
        final to = t.to;
        if (to != null) {
          final settings = to.settings;
          if (settings != null) {
            toRoute = _extractRouteName(settings);
          }
        }
      } catch (_) {}
      
      // Extract transition type
      String transitionType = 'Unknown';
      try {
        final type = t.type;
        if (type != null) {
          final typeStr = type.toString();
          // Extract from strings like "TransitionType.push" -> "push"
          if (typeStr.contains('.')) {
            transitionType = typeStr.split('.').last;
          } else {
            transitionType = typeStr;
          }
        }
      } catch (_) {
        // Try to extract from toString if it's in the format
        final toString = transition.toString();
        if (toString.contains('type: ')) {
          final match = RegExp(r'type: (\w+)').firstMatch(toString);
          if (match != null) {
            transitionType = match.group(1) ?? 'Unknown';
          }
        }
      }
      
      // Extract timestamp
      DateTime? timestamp;
      try {
        final ts = t.timestamp;
        if (ts is DateTime) {
          timestamp = ts;
        }
      } catch (_) {}
      
      // Determine route name (prefer 'to' route, fallback to 'from')
      final routeName = toRoute ?? fromRoute ?? 'Unknown Route';
      
      // Format timestamp
      String timeStr = '#${index + 1}';
      if (timestamp != null) {
        final hour = timestamp.hour.toString().padLeft(2, '0');
        final minute = timestamp.minute.toString().padLeft(2, '0');
        final second = timestamp.second.toString().padLeft(2, '0');
        final millisecond = timestamp.millisecond.toString().padLeft(3, '0');
        timeStr = '$hour:$minute:$second.$millisecond';
      }
      
      return _TransitionData(
        routeName: routeName,
        transitionType: transitionType,
        timestamp: timeStr,
        fromRoute: fromRoute,
        toRoute: toRoute,
      );
    } catch (e) {
      // Fallback: try to extract from toString
      return _parseFromString(transition.toString());
    }
  }

  String _extractRouteName(dynamic settings) {
    try {
      // Try to get route name from RouteSettings
      final name = settings.name;
      if (name != null && name.isNotEmpty) {
        return name;
      }
      
      // Try to get from arguments or other properties
      final arguments = settings.arguments;
      if (arguments != null) {
        return arguments.toString();
      }
    } catch (_) {}
    
    // Fallback: parse from toString
    final str = settings.toString();
    final match = RegExp(r'RouteSettings\("([^"]+)"').firstMatch(str);
    if (match != null) {
      return match.group(1) ?? 'Unknown';
    }
    
    return 'Unknown';
  }

  _TransitionData _parseFromString(String transitionStr) {
    // Extract route name
    String routeName = 'Unknown Route';
    final routeMatch = RegExp(r'RouteSettings\("([^"]+)"').allMatches(transitionStr);
    if (routeMatch.isNotEmpty) {
      final matches = routeMatch.toList();
      if (matches.length > 1) {
        // Multiple routes: use the last one (to route)
        routeName = matches.last.group(1) ?? 'Unknown Route';
      } else if (matches.isNotEmpty) {
        routeName = matches.first.group(1) ?? 'Unknown Route';
      }
    }
    
    // Extract transition type
    String transitionType = 'Unknown';
    final typeMatch = RegExp(r'type: (TransitionType\.)?(\w+)').firstMatch(transitionStr);
    if (typeMatch != null) {
      transitionType = typeMatch.group(2) ?? 'Unknown';
    }
    
    // Extract from/to routes
    String? fromRoute;
    String? toRoute;
    final fromMatch = RegExp(r'from:.*?RouteSettings\("([^"]+)"').firstMatch(transitionStr);
    if (fromMatch != null) {
      fromRoute = fromMatch.group(1);
    }
    final toMatch = RegExp(r'to:.*?RouteSettings\("([^"]+)"').firstMatch(transitionStr);
    if (toMatch != null) {
      toRoute = toMatch.group(1);
    }
    
    // Extract timestamp
    String timeStr = '#?';
    final timeMatch = RegExp(r'timestamp: (\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\.\d+)').firstMatch(transitionStr);
    if (timeMatch != null) {
      try {
        final fullTime = timeMatch.group(1)!;
        final parts = fullTime.split(' ');
        if (parts.length == 2) {
          final timePart = parts[1];
          timeStr = timePart;
        }
      } catch (_) {}
    }
    
    return _TransitionData(
      routeName: toRoute ?? routeName,
      transitionType: transitionType,
      timestamp: timeStr,
      fromRoute: fromRoute,
      toRoute: toRoute,
    );
  }
}

class _TransitionData {
  final String routeName;
  final String transitionType;
  final String timestamp;
  final String? fromRoute;
  final String? toRoute;

  _TransitionData({
    required this.routeName,
    required this.transitionType,
    required this.timestamp,
    this.fromRoute,
    this.toRoute,
  });
}

class _TransitionCard extends StatelessWidget {
  const _TransitionCard({
    required this.index,
    required this.routeName,
    required this.transitionType,
    required this.timestamp,
    this.fromRoute,
    this.toRoute,
    required this.isLast,
    required this.theme,
    required this.colorScheme,
  });

  final int index;
  final String routeName;
  final String transitionType;
  final String timestamp;
  final String? fromRoute;
  final String? toRoute;
  final bool isLast;
  final ThemeData theme;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final icon = _getTransitionIcon(transitionType);
    final color = _getTransitionColor(transitionType, colorScheme);

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator
            Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: 2),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: colorScheme.outline.withValues(alpha: 0.3),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Route name and timestamp
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          routeName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        timestamp,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontFeatures: [const FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Route transition description
                  if (fromRoute != null || toRoute != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (fromRoute != null) ...[
                            Text(
                              fromRoute!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontFamily: 'monospace',
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              size: 14,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            toRoute ?? routeName,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 6),
                  // Transition type badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      transitionType.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTransitionIcon(String type) {
    final lowerType = type.toLowerCase();
    if (lowerType.contains('push')) return Icons.arrow_forward_ios;
    if (lowerType.contains('pop')) return Icons.arrow_back_ios;
    if (lowerType.contains('replace')) return Icons.swap_horiz;
    if (lowerType.contains('remove')) return Icons.remove_circle_outline;
    return Icons.route;
  }

  Color _getTransitionColor(String type, ColorScheme colorScheme) {
    final lowerType = type.toLowerCase();
    if (lowerType.contains('push')) return colorScheme.primary;
    if (lowerType.contains('pop')) return colorScheme.secondary;
    if (lowerType.contains('replace')) return colorScheme.tertiary;
    return colorScheme.onSurfaceVariant;
  }
}
