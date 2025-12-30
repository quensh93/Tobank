import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../utils/registry_notifier.dart';

class RegistryReactiveWidgetModel {
  final Map<String, dynamic>? child;

  const RegistryReactiveWidgetModel({this.child});

  factory RegistryReactiveWidgetModel.fromJson(Map<String, dynamic> json) {
    return RegistryReactiveWidgetModel(
      child: json['child'] as Map<String, dynamic>?,
    );
  }
}

class RegistryReactiveWidgetParser extends StacParser<RegistryReactiveWidgetModel> {
  const RegistryReactiveWidgetParser();

  @override
  String get type => 'registryReactive';

  @override
  RegistryReactiveWidgetModel getModel(Map<String, dynamic> json) {
    return RegistryReactiveWidgetModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, RegistryReactiveWidgetModel model) {
    return ValueListenableBuilder<int>(
      valueListenable: RegistryNotifier.instance.listenable,
      builder: (context, _, child) {
        final childWidget = model.child != null
            ? Stac.fromJson(model.child!, context)
            : const SizedBox.shrink();
        return childWidget ?? const SizedBox.shrink();
      },
    );
  }
}
