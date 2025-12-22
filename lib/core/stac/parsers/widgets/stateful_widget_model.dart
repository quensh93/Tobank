class StatefulWidgetModel {
  final Map<String, dynamic>? onInit;
  final Map<String, dynamic>? onBuild;
  final Map<String, dynamic>? onDispose;
  final Map<String, dynamic>? onResume;
  final Map<String, dynamic>? onPause;
  final Map<String, dynamic> child;

  StatefulWidgetModel({
    this.onInit,
    this.onBuild,
    this.onDispose,
    this.onResume,
    this.onPause,
    required this.child,
  });

  factory StatefulWidgetModel.fromJson(Map<String, dynamic> json) {
    return StatefulWidgetModel(
      onInit: json['onInit'] as Map<String, dynamic>?,
      onBuild: json['onBuild'] as Map<String, dynamic>?,
      onDispose: json['onDispose'] as Map<String, dynamic>?,
      onResume: json['onResume'] as Map<String, dynamic>?,
      onPause: json['onPause'] as Map<String, dynamic>?,
      child: json['child'] as Map<String, dynamic>,
    );
  }
}
