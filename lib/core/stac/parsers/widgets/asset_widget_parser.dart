import 'package:flutter/material.dart';
import 'package:stac/stac.dart';
import '../../services/widget/stac_widget_resolver.dart';

class AssetWidgetModel {
  AssetWidgetModel({required this.assetPath});

  final String assetPath;

  factory AssetWidgetModel.fromJson(Map<String, dynamic> json) {
    return AssetWidgetModel(assetPath: (json['assetPath'] as String?) ?? '');
  }
}

/// Renders a widget tree loaded from a local JSON/API asset path.
class AssetWidgetParser extends StacParser<AssetWidgetModel> {
  const AssetWidgetParser();

  @override
  String get type => 'assetWidget';

  @override
  AssetWidgetModel getModel(Map<String, dynamic> json) {
    return AssetWidgetModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, AssetWidgetModel model) {
    if (model.assetPath.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<Widget>(
      future: StacWidgetResolver.resolveFromAssetPath(context, model.assetPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const SizedBox.shrink();
        }

        return snapshot.data ?? const SizedBox.shrink();
      },
    );
  }
}
