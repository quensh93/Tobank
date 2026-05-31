import 'package:stac_core/stac_core.dart';

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
    this.style,
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
  final Map<String, dynamic>? style;
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
    if (style != null) 'style': style,
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
    this.scale,
  });

  final String? id;
  final String valueKey;
  final bool? initialValue;
  final dynamic onChanged;
  final String? activeColor;
  final String? inactiveTrackColor;
  final String? inactiveThumbColor;
  final double? scale;

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
    if (scale != null) 'scale': scale,
  };
}

/// Builder for custom 'otpCountdownButton' payloads handled by OtpCountdownButtonParser.
class StacOtpCountdownButton extends StacWidget {
  const StacOtpCountdownButton({
    this.initialSeconds,
    this.retryLabel,
    this.iconAsset,
    this.onRetry,
    this.borderColor,
    this.countdownTextColor,
    this.retryTextColor,
    this.backgroundColor,
    this.height,
    this.minWidth,
  });

  final int? initialSeconds;
  final String? retryLabel;
  final String? iconAsset;
  final dynamic onRetry;
  final String? borderColor;
  final String? countdownTextColor;
  final String? retryTextColor;
  final String? backgroundColor;
  final double? height;
  final double? minWidth;

  @override
  String get type => 'otpCountdownButton';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    if (initialSeconds != null) 'initialSeconds': initialSeconds,
    if (retryLabel != null) 'retryLabel': retryLabel,
    if (iconAsset != null) 'iconAsset': iconAsset,
    if (onRetry != null)
      'onRetry': onRetry is StacAction
          ? (onRetry as StacAction).toJson()
          : onRetry,
    if (borderColor != null) 'borderColor': borderColor,
    if (countdownTextColor != null) 'countdownTextColor': countdownTextColor,
    if (retryTextColor != null) 'retryTextColor': retryTextColor,
    if (backgroundColor != null) 'backgroundColor': backgroundColor,
    if (height != null) 'height': height,
    if (minWidth != null) 'minWidth': minWidth,
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

/// Builder for custom 'copyToClipboard' action.
class StacCopyToClipboardAction extends StacAction {
  const StacCopyToClipboardAction({
    this.text,
    this.valueKey,
    this.successMessage,
    this.duration,
  });

  final String? text;
  final String? valueKey;
  final String? successMessage;
  final int? duration;

  @override
  String get actionType => 'copyToClipboard';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    if (text != null) 'text': text,
    if (valueKey != null) 'valueKey': valueKey,
    if (successMessage != null) 'successMessage': successMessage,
    if (duration != null) 'duration': duration,
  };
}

/// Builder for custom 'shareText' action.
class StacShareTextAction extends StacAction {
  const StacShareTextAction({this.text, this.valueKey, this.subject});

  final String? text;
  final String? valueKey;
  final String? subject;

  @override
  String get actionType => 'shareText';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    if (text != null) 'text': text,
    if (valueKey != null) 'valueKey': valueKey,
    if (subject != null) 'subject': subject,
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

/// Builder for custom 'tobankBannerCarousel' payloads handled by
/// TobankBannerCarouselParser.
class StacTobankBannerCarousel extends StacWidget {
  const StacTobankBannerCarousel({
    required this.imageUrls,
    this.height,
    this.borderRadius,
    this.autoScrollSeconds,
    this.showIndicators,
    this.indicatorActiveColor,
    this.indicatorInactiveColor,
    this.indicatorSpacing,
  });

  final List<String> imageUrls;
  final double? height;
  final double? borderRadius;
  final int? autoScrollSeconds;
  final bool? showIndicators;
  final String? indicatorActiveColor;
  final String? indicatorInactiveColor;
  final double? indicatorSpacing;

  @override
  String get type => 'tobankBannerCarousel';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'imageUrls': imageUrls,
    if (height != null) 'height': height,
    if (borderRadius != null) 'borderRadius': borderRadius,
    if (autoScrollSeconds != null) 'autoScrollSeconds': autoScrollSeconds,
    if (showIndicators != null) 'showIndicators': showIndicators,
    if (indicatorActiveColor != null)
      'indicatorActiveColor': indicatorActiveColor,
    if (indicatorInactiveColor != null)
      'indicatorInactiveColor': indicatorInactiveColor,
    if (indicatorSpacing != null) 'indicatorSpacing': indicatorSpacing,
  };
}

/// Builder for custom 'tobankCardsCarousel' payloads handled by
/// TobankCardsCarouselParser.
class StacTobankCardsCarousel extends StacWidget {
  const StacTobankCardsCarousel({
    required this.pages,
    this.height,
    this.initialPage,
    this.showIndicators,
    this.indicatorTopSpacing,
    this.indicatorActiveColor,
    this.indicatorInactiveColor,
    this.indicatorSpacing,
    this.indicatorSize,
  });

  final List<Map<String, dynamic>> pages;
  final double? height;
  final int? initialPage;
  final bool? showIndicators;
  final double? indicatorTopSpacing;
  final String? indicatorActiveColor;
  final String? indicatorInactiveColor;
  final double? indicatorSpacing;
  final double? indicatorSize;

  @override
  String get type => 'tobankCardsCarousel';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'pages': pages,
    if (height != null) 'height': height,
    if (initialPage != null) 'initialPage': initialPage,
    if (showIndicators != null) 'showIndicators': showIndicators,
    if (indicatorTopSpacing != null) 'indicatorTopSpacing': indicatorTopSpacing,
    if (indicatorActiveColor != null)
      'indicatorActiveColor': indicatorActiveColor,
    if (indicatorInactiveColor != null)
      'indicatorInactiveColor': indicatorInactiveColor,
    if (indicatorSpacing != null) 'indicatorSpacing': indicatorSpacing,
    if (indicatorSize != null) 'indicatorSize': indicatorSize,
  };
}

/// Builder for custom 'tobankCardManagementSlider' payloads handled by
/// TobankCardManagementSliderParser.
class StacTobankCardManagementSlider extends StacWidget {
  const StacTobankCardManagementSlider({
    required this.pages,
    this.enabledStates,
    this.cardTypes,
    this.selectedEnabledKey,
    this.selectedIndexKey,
    this.selectedTypeKey,
    this.selectedIsWalletKey,
    this.selectedIsGardeshgaryKey,
    this.selectedIsNonTobankKey,
    this.selectedIsBlockedKey,
    this.height,
    this.initialPage,
    this.initialPageKey,
    this.indicatorTopSpacing,
    this.indicatorActiveColor,
    this.indicatorInactiveColor,
    this.indicatorSpacing,
    this.indicatorSize,
  });

  final List<Map<String, dynamic>> pages;
  final List<bool>? enabledStates;
  final List<String>? cardTypes;
  final String? selectedEnabledKey;
  final String? selectedIndexKey;
  final String? selectedTypeKey;
  final String? selectedIsWalletKey;
  final String? selectedIsGardeshgaryKey;
  final String? selectedIsNonTobankKey;
  final String? selectedIsBlockedKey;
  final double? height;
  final int? initialPage;
  final String? initialPageKey;
  final double? indicatorTopSpacing;
  final String? indicatorActiveColor;
  final String? indicatorInactiveColor;
  final double? indicatorSpacing;
  final double? indicatorSize;

  @override
  String get type => 'tobankCardManagementSlider';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'pages': pages,
    if (enabledStates != null) 'enabledStates': enabledStates,
    if (cardTypes != null) 'cardTypes': cardTypes,
    if (selectedEnabledKey != null) 'selectedEnabledKey': selectedEnabledKey,
    if (selectedIndexKey != null) 'selectedIndexKey': selectedIndexKey,
    if (selectedTypeKey != null) 'selectedTypeKey': selectedTypeKey,
    if (selectedIsWalletKey != null) 'selectedIsWalletKey': selectedIsWalletKey,
    if (selectedIsGardeshgaryKey != null)
      'selectedIsGardeshgaryKey': selectedIsGardeshgaryKey,
    if (selectedIsNonTobankKey != null)
      'selectedIsNonTobankKey': selectedIsNonTobankKey,
    if (selectedIsBlockedKey != null)
      'selectedIsBlockedKey': selectedIsBlockedKey,
    if (height != null) 'height': height,
    if (initialPage != null) 'initialPage': initialPage,
    if (initialPageKey != null) 'initialPageKey': initialPageKey,
    if (indicatorTopSpacing != null) 'indicatorTopSpacing': indicatorTopSpacing,
    if (indicatorActiveColor != null)
      'indicatorActiveColor': indicatorActiveColor,
    if (indicatorInactiveColor != null)
      'indicatorInactiveColor': indicatorInactiveColor,
    if (indicatorSpacing != null) 'indicatorSpacing': indicatorSpacing,
    if (indicatorSize != null) 'indicatorSize': indicatorSize,
  };
}

/// Builder for custom 'tobankCardsStackScroller' payloads handled by
/// TobankCardsStackScrollerParser.
class StacTobankCardsStackScroller extends StacWidget {
  const StacTobankCardsStackScroller({
    required this.walletCard,
    required this.cards,
    this.scrollHandle,
    this.topSpacerHeight,
    this.bottomSpacerHeight,
    this.itemHeight,
    this.itemHeightFactor,
    this.scaleDistance,
    this.minScale,
    this.fadeStart,
    this.horizontalPadding,
    this.maxWidthInset,
    this.handleTop,
  });

  final Map<String, dynamic> walletCard;
  final List<Map<String, dynamic>> cards;
  final Map<String, dynamic>? scrollHandle;
  final double? topSpacerHeight;
  final double? bottomSpacerHeight;
  final double? itemHeight;
  final double? itemHeightFactor;
  final double? scaleDistance;
  final double? minScale;
  final double? fadeStart;
  final double? horizontalPadding;
  final double? maxWidthInset;
  final double? handleTop;

  @override
  String get type => 'tobankCardsStackScroller';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'walletCard': walletCard,
    'cards': cards,
    if (scrollHandle != null) 'scrollHandle': scrollHandle,
    if (topSpacerHeight != null) 'topSpacerHeight': topSpacerHeight,
    if (bottomSpacerHeight != null) 'bottomSpacerHeight': bottomSpacerHeight,
    if (itemHeight != null) 'itemHeight': itemHeight,
    if (itemHeightFactor != null) 'itemHeightFactor': itemHeightFactor,
    if (scaleDistance != null) 'scaleDistance': scaleDistance,
    if (minScale != null) 'minScale': minScale,
    if (fadeStart != null) 'fadeStart': fadeStart,
    if (horizontalPadding != null) 'horizontalPadding': horizontalPadding,
    if (maxWidthInset != null) 'maxWidthInset': maxWidthInset,
    if (handleTop != null) 'handleTop': handleTop,
  };
}

/// Builder for custom 'tobankMegaGashtWebView' payloads handled by
/// TobankMegaGashtWebViewParser.
class StacTobankMegaGashtWebView extends StacWidget {
  const StacTobankMegaGashtWebView({
    this.initialUrl = 'https://on.megagasht.com/',
    this.onResumeUrl = 'https://on.megagasht.com/Panel-Dashboard.bc',
  });

  final String initialUrl;
  final String onResumeUrl;

  @override
  String get type => 'tobankMegaGashtWebView';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'initialUrl': initialUrl,
    'onResumeUrl': onResumeUrl,
  };
}

/// Builder for custom 'tobankAcceptorWebView' payloads handled by
/// TobankAcceptorWebViewParser.
class StacTobankAcceptorWebView extends StacWidget {
  const StacTobankAcceptorWebView({
    this.initialUrl = 'https://my.gardeshpay.ir/',
    this.onResumeUrl = 'https://my.gardeshpay.ir/wallet',
    this.paymentRedirectPrefix =
        'https://ipg.gardeshpay.ir/v1/provider/payment/redirect/',
  });

  final String initialUrl;
  final String onResumeUrl;
  final String paymentRedirectPrefix;

  @override
  String get type => 'tobankAcceptorWebView';

  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'initialUrl': initialUrl,
    'onResumeUrl': onResumeUrl,
    'paymentRedirectPrefix': paymentRedirectPrefix,
  };
}
