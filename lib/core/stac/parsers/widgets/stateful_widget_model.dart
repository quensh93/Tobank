class StatefulWidgetModel {
  final Map<String, dynamic>? onInit;
  final Map<String, dynamic>? onBuild;
  final Map<String, dynamic>? onDependenciesChanged;
  final Map<String, dynamic>? onWidgetUpdated;
  final Map<String, dynamic>? onReassemble;
  final Map<String, dynamic>? onDeactivate;
  final Map<String, dynamic>? onDispose;
  final Map<String, dynamic>? onResume;
  final Map<String, dynamic>? onPause;
  final Map<String, dynamic>? onInactive;
  final Map<String, dynamic>? onHidden;
  final Map<String, dynamic>? onDetached;
  final Map<String, dynamic> child;

  StatefulWidgetModel({
    this.onInit,
    this.onBuild,
    this.onDependenciesChanged,
    this.onWidgetUpdated,
    this.onReassemble,
    this.onDeactivate,
    this.onDispose,
    this.onResume,
    this.onPause,
    this.onInactive,
    this.onHidden,
    this.onDetached,
    required this.child,
  });

  factory StatefulWidgetModel.fromJson(Map<String, dynamic> json) {
    return StatefulWidgetModel(
      onInit: json['onInit'] as Map<String, dynamic>?,
      onBuild: json['onBuild'] as Map<String, dynamic>?,
      onDependenciesChanged:
          json['onDependenciesChanged'] as Map<String, dynamic>?,
      onWidgetUpdated: json['onWidgetUpdated'] as Map<String, dynamic>?,
      onReassemble: json['onReassemble'] as Map<String, dynamic>?,
      onDeactivate: json['onDeactivate'] as Map<String, dynamic>?,
      onDispose: json['onDispose'] as Map<String, dynamic>?,
      onResume: json['onResume'] as Map<String, dynamic>?,
      onPause: json['onPause'] as Map<String, dynamic>?,
      onInactive: json['onInactive'] as Map<String, dynamic>?,
      onHidden: json['onHidden'] as Map<String, dynamic>?,
      onDetached: json['onDetached'] as Map<String, dynamic>?,
      child: json['child'] as Map<String, dynamic>,
    );
  }
}
