/// Entry point configuration model
/// 
/// Represents the structure of app_entry_point.json file
class EntryPointConfig {
  final String appName;
  final String version;
  final String initialScreen;
  final Map<String, ScreenConfig> screens;
  final NavigationConfig? navigation;

  EntryPointConfig({
    required this.appName,
    required this.version,
    required this.initialScreen,
    required this.screens,
    this.navigation,
  });

  factory EntryPointConfig.fromJson(Map<String, dynamic> json) {
    return EntryPointConfig(
      appName: json['app_name'] as String? ?? 'STAC Test App',
      version: json['version'] as String? ?? '1.0.0',
      initialScreen: json['initial_screen'] as String? ?? 'login',
      screens: (json['screens'] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(
          key,
          ScreenConfig.fromJson(value as Map<String, dynamic>),
        ),
      ),
      navigation: json['navigation'] != null
          ? NavigationConfig.fromJson(json['navigation'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'app_name': appName,
      'version': version,
      'initial_screen': initialScreen,
      'screens': screens.map((key, value) => MapEntry(key, value.toJson())),
      if (navigation != null) 'navigation': navigation!.toJson(),
    };
  }
}

/// Screen configuration model
class ScreenConfig {
  final String template;
  final String data;

  ScreenConfig({
    required this.template,
    required this.data,
  });

  factory ScreenConfig.fromJson(Map<String, dynamic> json) {
    return ScreenConfig(
      template: json['template'] as String,
      data: json['data'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'template': template,
      'data': data,
    };
  }
}

/// Navigation configuration model
class NavigationConfig {
  final List<RouteConfig> routes;

  NavigationConfig({
    required this.routes,
  });

  factory NavigationConfig.fromJson(Map<String, dynamic> json) {
    return NavigationConfig(
      routes: (json['routes'] as List<dynamic>? ?? [])
          .map((e) => RouteConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'routes': routes.map((e) => e.toJson()).toList(),
    };
  }
}

/// Route configuration model
class RouteConfig {
  final String name;
  final String path;

  RouteConfig({
    required this.name,
    required this.path,
  });

  factory RouteConfig.fromJson(Map<String, dynamic> json) {
    return RouteConfig(
      name: json['name'] as String,
      path: json['path'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'path': path,
    };
  }
}

