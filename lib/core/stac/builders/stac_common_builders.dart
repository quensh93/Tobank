import 'package:stac_core/stac_core.dart';
export 'stac_registry.dart';

/// Raw JSON widget helper
/// Use this when you need to construct a widget from a raw JSON map
/// or when a specific builder is not available.
class StacRawJsonWidget implements StacWidget {
  final Map<String, dynamic> json;
  StacRawJsonWidget(this.json);

  @override
  Map<String, dynamic> get jsonData => json;

  @override
  Map<String, dynamic> toJson() => json;

  @override
  String get type => json['type'] as String;
  String? get id => json['id'] as String?;
}

/// Custom widget helper for parser-driven widget types when a dedicated
/// strongly-typed builder is not yet available.
class StacCustomWidget implements StacWidget {
  final Map<String, dynamic> json;
  const StacCustomWidget.fromJson(this.json);

  @override
  Map<String, dynamic> get jsonData => json;

  @override
  Map<String, dynamic> toJson() => json;

  @override
  String get type => json['type'] as String;
  String? get id => json['id'] as String?;
}

/// Raw JSON action helper
/// Use this when you need to construct an action from a raw JSON map
/// or when a specific builder is not available.
class StacRawJsonAction extends StacAction {
  final Map<String, dynamic> json;
  StacRawJsonAction(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}

/// Custom action helper for parser-driven action types when a dedicated
/// strongly-typed builder is not yet available.
class StacCustomAction extends StacAction {
  final Map<String, dynamic> json;
  const StacCustomAction.fromJson(this.json);

  @override
  String get actionType => json['actionType'] as String;

  @override
  Map<String, dynamic> toJson() => json;
}

/// Builder for custom textFormField payloads handled by CustomTextFormFieldParser.
///
/// Use this when you need parser-specific keys (for example
/// `formatThousands` / `thousandsSeparator`) that are not exposed by
/// `StacTextFormField` in stac_core.
class StacCustomTextFormField extends StacWidget {
  const StacCustomTextFormField({
    this.id,
    this.textDirection,
    this.textAlign,
    this.formatThousands,
    this.thousandsSeparator,
    this.decoration,
    this.keyboardType,
    this.textInputAction,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.inputFormatters,
    this.validatorRules,
    this.onChanged,
    this.onTap,
    this.initialValue,
    this.readOnly,
    this.enabled,
  });

  final String? id;
  final String? textDirection;
  final String? textAlign;
  final bool? formatThousands;
  final String? thousandsSeparator;
  final Map<String, dynamic>? decoration;
  final String? keyboardType;
  final String? textInputAction;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final List<Map<String, dynamic>>? inputFormatters;
  final List<Map<String, dynamic>>? validatorRules;
  final dynamic onChanged;
  final dynamic onTap;
  final String? initialValue;
  final bool? readOnly;
  final bool? enabled;

  @override
  String get type => 'textFormField';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (id != null) 'id': id,
    if (textDirection != null) 'textDirection': textDirection,
    if (textAlign != null) 'textAlign': textAlign,
    if (formatThousands != null) 'formatThousands': formatThousands,
    if (thousandsSeparator != null) 'thousandsSeparator': thousandsSeparator,
    if (decoration != null) 'decoration': decoration,
    if (keyboardType != null) 'keyboardType': keyboardType,
    if (textInputAction != null) 'textInputAction': textInputAction,
    if (maxLength != null) 'maxLength': maxLength,
    if (minLines != null) 'minLines': minLines,
    if (maxLines != null) 'maxLines': maxLines,
    if (inputFormatters != null) 'inputFormatters': inputFormatters,
    if (validatorRules != null) 'validatorRules': validatorRules,
    if (onChanged != null)
      'onChanged': onChanged is StacAction
          ? (onChanged as StacAction).toJson()
          : onChanged,
    if (onTap != null)
      'onTap': onTap is StacAction ? (onTap as StacAction).toJson() : onTap,
    if (initialValue != null) 'initialValue': initialValue,
    if (readOnly != null) 'readOnly': readOnly,
    if (enabled != null) 'enabled': enabled,
  };
}

/// Builder for custom 'visibility' widget payloads handled by CustomVisibilityParser.
class StacCustomVisibility extends StacWidget {
  const StacCustomVisibility({
    this.visible,
    this.child,
    this.replacement,
    this.maintainState,
    this.maintainAnimation,
    this.maintainSize,
    this.maintainSemantics,
    this.maintainInteractivity,
  });

  final dynamic visible;
  final Map<String, dynamic>? child;
  final Map<String, dynamic>? replacement;
  final bool? maintainState;
  final bool? maintainAnimation;
  final bool? maintainSize;
  final bool? maintainSemantics;
  final bool? maintainInteractivity;

  @override
  String get type => 'visibility';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (visible != null) 'visible': visible,
    if (child != null) 'child': child,
    if (replacement != null) 'replacement': replacement,
    if (maintainState != null) 'maintainState': maintainState,
    if (maintainAnimation != null) 'maintainAnimation': maintainAnimation,
    if (maintainSize != null) 'maintainSize': maintainSize,
    if (maintainSemantics != null) 'maintainSemantics': maintainSemantics,
    if (maintainInteractivity != null)
      'maintainInteractivity': maintainInteractivity,
  };
}

/// Builder for custom 'reactiveSwitch' widget payloads handled by ReactiveSwitchParser.
class StacCustomReactiveSwitch extends StacWidget {
  const StacCustomReactiveSwitch({
    this.id,
    required this.valueKey,
    this.initialValue,
    this.onChanged,
    this.activeColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
  });

  final String? id;
  final String valueKey;
  final bool? initialValue;
  final dynamic onChanged;
  final String? activeColor;
  final String? inactiveTrackColor;
  final String? inactiveThumbColor;

  @override
  String get type => 'reactiveSwitch';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (id != null) 'id': id,
    'valueKey': valueKey,
    if (initialValue != null) 'initialValue': initialValue,
    if (onChanged != null)
      'onChanged': onChanged is StacAction
          ? (onChanged as StacAction).toJson()
          : onChanged,
    if (activeColor != null) 'activeColor': activeColor,
    if (inactiveTrackColor != null) 'inactiveTrackColor': inactiveTrackColor,
    if (inactiveThumbColor != null) 'inactiveThumbColor': inactiveThumbColor,
  };
}

/// Builder for custom 'reactiveElevatedButton' payloads handled by ReactiveElevatedButtonParser.
class StacCustomReactiveElevatedButton extends StacWidget {
  const StacCustomReactiveElevatedButton({
    this.enabledKey,
    this.loadingKey,
    this.enabled,
    this.onPressed,
    this.style,
    this.disabledStyle,
    this.child,
    this.loadingChild,
  });

  final String? enabledKey;
  final String? loadingKey;
  final bool? enabled;
  final dynamic onPressed;
  final Map<String, dynamic>? style;
  final Map<String, dynamic>? disabledStyle;
  final Map<String, dynamic>? child;
  final Map<String, dynamic>? loadingChild;

  @override
  String get type => 'reactiveElevatedButton';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (enabledKey != null) 'enabledKey': enabledKey,
    if (loadingKey != null) 'loadingKey': loadingKey,
    if (enabled != null) 'enabled': enabled,
    if (onPressed != null)
      'onPressed': onPressed is StacAction
          ? (onPressed as StacAction).toJson()
          : onPressed,
    if (style != null) 'style': style,
    if (disabledStyle != null) 'disabledStyle': disabledStyle,
    if (child != null) 'child': child,
    if (loadingChild != null) 'loadingChild': loadingChild,
  };
}

/// Builder for custom 'reactiveListView' payloads handled by ReactiveListViewParser.
class StacCustomReactiveListView extends StacWidget {
  const StacCustomReactiveListView({
    this.dataKey,
    this.dataPath,
    this.isLoadedKey,
    this.errorKey,
    this.itemIdField,
    this.selectedIdKey,
    this.padding,
    this.separator,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
    this.onItemTap,
    this.itemTemplate,
  });

  final String? dataKey;
  final String? dataPath;
  final String? isLoadedKey;
  final String? errorKey;
  final String? itemIdField;
  final String? selectedIdKey;
  final Map<String, dynamic>? padding;
  final Map<String, dynamic>? separator;
  final Map<String, dynamic>? loadingWidget;
  final Map<String, dynamic>? errorWidget;
  final Map<String, dynamic>? emptyWidget;
  final dynamic onItemTap;
  final Map<String, dynamic>? itemTemplate;

  @override
  String get type => 'reactiveListView';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (dataKey != null) 'dataKey': dataKey,
    if (dataPath != null) 'dataPath': dataPath,
    if (isLoadedKey != null) 'isLoadedKey': isLoadedKey,
    if (errorKey != null) 'errorKey': errorKey,
    if (itemIdField != null) 'itemIdField': itemIdField,
    if (selectedIdKey != null) 'selectedIdKey': selectedIdKey,
    if (padding != null) 'padding': padding,
    if (separator != null) 'separator': separator,
    if (loadingWidget != null) 'loadingWidget': loadingWidget,
    if (errorWidget != null) 'errorWidget': errorWidget,
    if (emptyWidget != null) 'emptyWidget': emptyWidget,
    if (onItemTap != null)
      'onItemTap': onItemTap is StacAction
          ? (onItemTap as StacAction).toJson()
          : onItemTap,
    if (itemTemplate != null) 'itemTemplate': itemTemplate,
  };
}

/// Builder for custom 'opacity' payloads.
class StacCustomOpacity extends StacWidget {
  const StacCustomOpacity({required this.opacity, this.child});

  final dynamic opacity;
  final Map<String, dynamic>? child;

  @override
  String get type => 'opacity';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'opacity': opacity,
    if (child != null) 'child': child,
  };
}

/// Builder for custom 'container' payloads with dynamic values.
class StacCustomContainer extends StacWidget {
  const StacCustomContainer({
    this.width,
    this.height,
    this.clipBehavior,
    this.decoration,
    this.child,
  });

  final dynamic width;
  final dynamic height;
  final String? clipBehavior;
  final Map<String, dynamic>? decoration;
  final Map<String, dynamic>? child;

  @override
  String get type => 'container';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (width != null) 'width': width,
    if (height != null) 'height': height,
    if (clipBehavior != null) 'clipBehavior': clipBehavior,
    if (decoration != null) 'decoration': decoration,
    if (child != null) 'child': child,
  };
}

/// Builder for custom 'stack' payloads.
class StacCustomStack extends StacWidget {
  const StacCustomStack({required this.children});

  final List<Map<String, dynamic>> children;

  @override
  String get type => 'stack';

  @override
  Map<String, dynamic> toJson() => {'type': type, 'children': children};
}

/// Builder for custom 'registryReactive' payloads.
class StacCustomRegistryReactive extends StacWidget {
  const StacCustomRegistryReactive({this.registryKey, this.child});

  final String? registryKey;
  final Map<String, dynamic>? child;

  @override
  String get type => 'registryReactive';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (registryKey != null) 'registryKey': registryKey,
    if (child != null) 'child': child,
  };
}

/// Builder for custom 'pdfPreview' payloads.
class StacCustomPdfPreview extends StacWidget {
  const StacCustomPdfPreview({
    this.src,
    this.registryKey,
    this.width,
    this.height,
  });

  final String? src;
  final String? registryKey;
  final dynamic width;
  final dynamic height;

  @override
  String get type => 'pdfPreview';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (src != null) 'src': src,
    if (registryKey != null) 'registryKey': registryKey,
    if (width != null) 'width': width,
    if (height != null) 'height': height,
  };
}

/// Builder for 'showResult' action.
class StacShowResultAction extends StacAction {
  final String title;
  final String content;

  const StacShowResultAction({required this.title, required this.content});

  @override
  String get actionType => 'showResult';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': 'showResult',
    'title': title,
    'content': content,
  };
}

/// Builder for custom 'saveFile' action.
class StacSaveFileAction extends StacAction {
  const StacSaveFileAction({
    required this.fileName,
    this.registryKey,
    this.content,
    this.isBase64,
  });

  final String fileName;
  final String? registryKey;
  final String? content;
  final bool? isBase64;

  @override
  String get actionType => 'saveFile';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'fileName': fileName,
    if (registryKey != null) 'registryKey': registryKey,
    if (content != null) 'content': content,
    if (isBase64 != null) 'isBase64': isBase64,
  };
}

/// Builder for custom 'shareFile' action.
class StacShareFileAction extends StacAction {
  const StacShareFileAction({
    required this.fileName,
    this.registryKey,
    this.content,
    this.mimeType,
  });

  final String fileName;
  final String? registryKey;
  final String? content;
  final String? mimeType;

  @override
  String get actionType => 'shareFile';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'fileName': fileName,
    if (registryKey != null) 'registryKey': registryKey,
    if (content != null) 'content': content,
    if (mimeType != null) 'mimeType': mimeType,
  };
}

/// Helper class to support alias text styles in StacText
class StacAliasTextStyle implements StacTextStyle {
  final String alias;
  const StacAliasTextStyle(this.alias);

  @override
  StacTextStyleType get type => StacTextStyleType.custom;

  @override
  Map<String, dynamic> toJson() => {'type': 'alias', 'value': alias};
}
