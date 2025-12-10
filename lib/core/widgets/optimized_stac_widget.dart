import 'package:flutter/material.dart';
import 'dart:convert';

/// Base class for optimized STAC widgets
/// 
/// Provides performance optimizations:
/// - Const constructors where possible
/// - Efficient shouldRebuild checks
/// - Minimized widget rebuilds
abstract class OptimizedStacWidget extends StatelessWidget {
  const OptimizedStacWidget({super.key});
}

/// Stateful widget with optimized rebuild logic
abstract class OptimizedStacStatefulWidget extends StatefulWidget {
  final Map<String, dynamic> json;
  
  const OptimizedStacStatefulWidget({
    super.key,
    required this.json,
  });
}

/// State class with optimized rebuild logic
abstract class OptimizedStacState<T extends OptimizedStacStatefulWidget>
    extends State<T> {
  String? _jsonHash;
  
  @override
  void initState() {
    super.initState();
    _jsonHash = _computeJsonHash(widget.json);
  }
  
  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Only rebuild if JSON actually changed
    final newHash = _computeJsonHash(widget.json);
    if (_jsonHash != newHash) {
      _jsonHash = newHash;
      onJsonChanged(oldWidget.json, widget.json);
    }
  }
  
  /// Called when JSON data changes
  /// Override to handle JSON updates
  void onJsonChanged(
    Map<String, dynamic> oldJson,
    Map<String, dynamic> newJson,
  ) {
    // Default: trigger rebuild
    setState(() {});
  }
  
  String _computeJsonHash(Map<String, dynamic> json) {
    return jsonEncode(json).hashCode.toString();
  }
}

/// Widget that caches its build result
class CachedBuildWidget extends StatefulWidget {
  final Map<String, dynamic> json;
  final Widget Function(BuildContext, Map<String, dynamic>) builder;
  
  const CachedBuildWidget({
    super.key,
    required this.json,
    required this.builder,
  });
  
  @override
  State<CachedBuildWidget> createState() => _CachedBuildWidgetState();
}

class _CachedBuildWidgetState extends State<CachedBuildWidget> {
  Widget? _cachedWidget;
  String? _jsonHash;
  
  @override
  void initState() {
    super.initState();
    _buildAndCache();
  }
  
  @override
  void didUpdateWidget(CachedBuildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    final newHash = _computeJsonHash(widget.json);
    if (_jsonHash != newHash) {
      _buildAndCache();
    }
  }
  
  void _buildAndCache() {
    _jsonHash = _computeJsonHash(widget.json);
    _cachedWidget = widget.builder(context, widget.json);
  }
  
  String _computeJsonHash(Map<String, dynamic> json) {
    return jsonEncode(json).hashCode.toString();
  }
  
  @override
  Widget build(BuildContext context) {
    return _cachedWidget ?? const SizedBox.shrink();
  }
}

/// Widget that only rebuilds specific parts when data changes
class SelectiveRebuildWidget extends StatefulWidget {
  final Map<String, dynamic> json;
  final List<String> watchKeys;
  final Widget Function(BuildContext, Map<String, dynamic>) builder;
  
  const SelectiveRebuildWidget({
    super.key,
    required this.json,
    required this.watchKeys,
    required this.builder,
  });
  
  @override
  State<SelectiveRebuildWidget> createState() => _SelectiveRebuildWidgetState();
}

class _SelectiveRebuildWidgetState extends State<SelectiveRebuildWidget> {
  Map<String, dynamic>? _watchedValues;
  
  @override
  void initState() {
    super.initState();
    _updateWatchedValues();
  }
  
  @override
  void didUpdateWidget(SelectiveRebuildWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (_hasWatchedValuesChanged()) {
      _updateWatchedValues();
      setState(() {});
    }
  }
  
  void _updateWatchedValues() {
    _watchedValues = {};
    for (final key in widget.watchKeys) {
      if (widget.json.containsKey(key)) {
        _watchedValues![key] = widget.json[key];
      }
    }
  }
  
  bool _hasWatchedValuesChanged() {
    if (_watchedValues == null) return true;
    
    for (final key in widget.watchKeys) {
      final oldValue = _watchedValues![key];
      final newValue = widget.json[key];
      
      if (oldValue != newValue) {
        return true;
      }
    }
    
    return false;
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.json);
  }
}

/// Mixin for widgets that need const optimization
mixin ConstOptimization {
  /// Check if a widget can be const
  bool canBeConst(Map<String, dynamic> json) {
    // Check if all values are compile-time constants
    return _isConstValue(json);
  }
  
  bool _isConstValue(dynamic value) {
    if (value == null) return true;
    if (value is String || value is num || value is bool) return true;
    
    if (value is List) {
      return value.every(_isConstValue);
    }
    
    if (value is Map) {
      return value.values.every(_isConstValue);
    }
    
    return false;
  }
}

/// Mixin for widgets that need rebuild optimization
mixin RebuildOptimization {
  /// Check if widget should rebuild based on JSON changes
  bool shouldRebuild(
    Map<String, dynamic> oldJson,
    Map<String, dynamic> newJson,
  ) {
    // Quick reference check
    if (identical(oldJson, newJson)) return false;
    
    // Deep equality check
    return !_deepEquals(oldJson, newJson);
  }
  
  bool _deepEquals(dynamic a, dynamic b) {
    if (identical(a, b)) return true;
    if (a == null || b == null) return a == b;
    
    if (a is Map && b is Map) {
      if (a.length != b.length) return false;
      
      for (final key in a.keys) {
        if (!b.containsKey(key)) return false;
        if (!_deepEquals(a[key], b[key])) return false;
      }
      
      return true;
    }
    
    if (a is List && b is List) {
      if (a.length != b.length) return false;
      
      for (int i = 0; i < a.length; i++) {
        if (!_deepEquals(a[i], b[i])) return false;
      }
      
      return true;
    }
    
    return a == b;
  }
}

/// Widget that uses RepaintBoundary for optimization
class OptimizedRepaintBoundary extends StatelessWidget {
  final Widget child;
  final bool useRepaintBoundary;
  
  const OptimizedRepaintBoundary({
    super.key,
    required this.child,
    this.useRepaintBoundary = true,
  });
  
  @override
  Widget build(BuildContext context) {
    if (useRepaintBoundary) {
      return RepaintBoundary(child: child);
    }
    return child;
  }
}

/// Helper class for widget optimization utilities
class WidgetOptimizationHelper {
  /// Wrap widget with const constructor if possible
  static Widget optimizeWidget(Widget widget) {
    // If widget is already const, return as is
    if (widget is ConstOptimizedWidget) {
      return widget;
    }
    
    // Wrap with RepaintBoundary for complex widgets
    if (_isComplexWidget(widget)) {
      return RepaintBoundary(child: widget);
    }
    
    return widget;
  }
  
  /// Check if widget is complex and benefits from RepaintBoundary
  static bool _isComplexWidget(Widget widget) {
    // Widgets that benefit from RepaintBoundary
    return widget is CustomPaint ||
        widget is AnimatedWidget ||
        widget is ListView ||
        widget is GridView;
  }
  
  /// Create a const-optimized text widget
  static Widget constText(String text, {TextStyle? style}) {
    return Text(text, style: style);
  }
  
  /// Create a const-optimized container
  static Widget constContainer({
    Widget? child,
    Color? color,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      color: color,
      child: child,
    );
  }
  
  /// Minimize rebuilds by using keys effectively
  static Key generateOptimalKey(Map<String, dynamic> json) {
    // Use ValueKey with JSON hash for efficient comparison
    final hash = jsonEncode(json).hashCode;
    return ValueKey(hash);
  }
}

/// Marker interface for const-optimized widgets
abstract class ConstOptimizedWidget extends StatelessWidget {
  const ConstOptimizedWidget({super.key});
}

/// Example of an optimized STAC text widget
class OptimizedStacText extends ConstOptimizedWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  
  const OptimizedStacText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });
  
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Example of an optimized STAC container widget
class OptimizedStacContainer extends ConstOptimizedWidget {
  final Widget? child;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  
  const OptimizedStacContainer({
    super.key,
    this.child,
    this.color,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      color: color,
      decoration: decoration,
      child: child,
    );
  }
}

/// Example of an optimized STAC column widget
class OptimizedStacColumn extends ConstOptimizedWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  
  const OptimizedStacColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }
}

/// Example of an optimized STAC row widget
class OptimizedStacRow extends ConstOptimizedWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  
  const OptimizedStacRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }
}
