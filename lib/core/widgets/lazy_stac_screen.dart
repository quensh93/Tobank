import 'package:flutter/material.dart';
import '../helpers/logger.dart';

/// A widget that implements lazy loading for STAC screens
///
/// This widget loads critical content first and then lazy loads
/// non-critical components to improve perceived performance.
class LazyStacScreen extends StatefulWidget {
  final String screenName;
  final Future<Map<String, dynamic>> Function(String) loadCriticalContent;
  final Future<Map<String, dynamic>> Function(String)? loadNonCriticalContent;
  final Widget Function(BuildContext, Map<String, dynamic>) builder;
  final Widget? loadingWidget;
  final Widget Function(BuildContext, Object)? errorBuilder;

  const LazyStacScreen({
    super.key,
    required this.screenName,
    required this.loadCriticalContent,
    this.loadNonCriticalContent,
    required this.builder,
    this.loadingWidget,
    this.errorBuilder,
  });

  @override
  State<LazyStacScreen> createState() => _LazyStacScreenState();
}

class _LazyStacScreenState extends State<LazyStacScreen> {
  late Future<Map<String, dynamic>> _criticalContentFuture;
  Map<String, dynamic>? _fullContent;
  bool _isLoadingNonCritical = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _loadScreen();
  }

  @override
  void didUpdateWidget(LazyStacScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.screenName != widget.screenName) {
      _loadScreen();
    }
  }

  void _loadScreen() {
    setState(() {
      _fullContent = null;
      _error = null;
      _isLoadingNonCritical = false;
    });

    _criticalContentFuture = widget.loadCriticalContent(widget.screenName);

    // Start loading critical content
    _criticalContentFuture
        .then((criticalContent) {
          if (!mounted) return;

          setState(() {
            _fullContent = criticalContent;
          });

          // Start lazy loading non-critical content
          if (widget.loadNonCriticalContent != null) {
            _loadNonCriticalContent();
          }
        })
        .catchError((error) {
          if (!mounted) return;
          setState(() {
            _error = error;
          });
        });
  }

  Future<void> _loadNonCriticalContent() async {
    if (!mounted) return;

    setState(() {
      _isLoadingNonCritical = true;
    });

    try {
      final nonCriticalContent = await widget.loadNonCriticalContent!(
        widget.screenName,
      );

      if (!mounted) return;

      setState(() {
        // Merge non-critical content with critical content
        _fullContent = {..._fullContent!, ...nonCriticalContent};
        _isLoadingNonCritical = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoadingNonCritical = false;
      });

      // Log error but don't fail the screen
      AppLogger.e('Error loading non-critical content', error);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(context, _error!);
      }
      return _buildDefaultError();
    }

    if (_fullContent == null) {
      return widget.loadingWidget ?? _buildDefaultLoading();
    }

    return Stack(
      children: [
        widget.builder(context, _fullContent!),
        if (_isLoadingNonCritical)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildNonCriticalLoadingIndicator(),
          ),
      ],
    );
  }

  Widget _buildDefaultLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildDefaultError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Failed to load screen',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _error.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _loadScreen, child: const Text('Retry')),
        ],
      ),
    );
  }

  Widget _buildNonCriticalLoadingIndicator() {
    return Container(
      height: 2,
      color: Colors.transparent,
      child: const LinearProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }
}

/// Helper class to split screen content into critical and non-critical parts
class ScreenContentSplitter {
  /// Split screen JSON into critical and non-critical parts
  ///
  /// Critical content includes:
  /// - App bar
  /// - Main layout structure
  /// - Above-the-fold content
  ///
  /// Non-critical content includes:
  /// - Below-the-fold content
  /// - Heavy images
  /// - Complex widgets
  static Map<String, Map<String, dynamic>> split(
    Map<String, dynamic> screenJson,
  ) {
    final critical = <String, dynamic>{};
    final nonCritical = <String, dynamic>{};

    // Copy basic structure to critical
    critical['type'] = screenJson['type'];

    if (screenJson.containsKey('appBar')) {
      critical['appBar'] = screenJson['appBar'];
    }

    // Handle body content
    if (screenJson.containsKey('body')) {
      final body = screenJson['body'];

      if (body is Map<String, dynamic>) {
        final splitBody = _splitWidget(body);
        critical['body'] = splitBody['critical'];
        if (splitBody['nonCritical'] != null) {
          nonCritical['body'] = splitBody['nonCritical'];
        }
      } else {
        critical['body'] = body;
      }
    }

    // Copy other properties
    for (final key in screenJson.keys) {
      if (!['type', 'appBar', 'body'].contains(key)) {
        critical[key] = screenJson[key];
      }
    }

    return {'critical': critical, 'nonCritical': nonCritical};
  }

  static Map<String, dynamic> _splitWidget(Map<String, dynamic> widget) {
    final type = widget['type'] as String?;

    // Widgets that should be loaded lazily
    const lazyTypes = ['image', 'video', 'webview', 'map'];

    if (type != null && lazyTypes.contains(type)) {
      return {
        'critical': {
          'type': 'container',
          'height': widget['height'] ?? 200,
          'child': {
            'type': 'center',
            'child': {'type': 'circularProgressIndicator'},
          },
        },
        'nonCritical': widget,
      };
    }

    // For containers with children, split the children
    if (widget.containsKey('children') && widget['children'] is List) {
      final children = widget['children'] as List;
      final criticalChildren = <dynamic>[];
      final nonCriticalChildren = <dynamic>[];

      for (int i = 0; i < children.length; i++) {
        if (i < 3) {
          // First 3 items are critical
          criticalChildren.add(children[i]);
        } else {
          // Rest are non-critical
          nonCriticalChildren.add(children[i]);
        }
      }

      return {
        'critical': {...widget, 'children': criticalChildren},
        'nonCritical': nonCriticalChildren.isNotEmpty
            ? {...widget, 'children': nonCriticalChildren}
            : null,
      };
    }

    return {'critical': widget, 'nonCritical': null};
  }
}
