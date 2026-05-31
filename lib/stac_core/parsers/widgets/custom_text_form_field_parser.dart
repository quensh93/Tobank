// ignore_for_file: implementation_imports
import 'package:flutter/material.dart';
import 'package:stac/src/parsers/foundation/colors/stac_brightness_parser.dart';
import 'package:stac/src/parsers/foundation/decoration/stac_input_decoration_parser.dart';
import 'package:stac/src/parsers/foundation/forms/stac_autovalidate_mode_parser.dart';
import 'package:stac/src/parsers/foundation/forms/stac_input_formatter_type_parser.dart';
import 'package:stac/src/parsers/foundation/forms/stac_max_length_enforcement_parser.dart';
import 'package:stac/src/parsers/foundation/geometry/stac_edge_insets_parser.dart';
import 'package:stac/src/parsers/foundation/text/stac_smart_dashes_type_parser.dart';
import 'package:stac/src/parsers/foundation/text/stac_smart_quotes_type_parser.dart';
import 'package:stac/src/parsers/foundation/text/stac_text_align_parser.dart';
import 'package:stac/src/parsers/foundation/text/stac_text_capitalization_parser.dart';
import 'package:stac/src/parsers/foundation/text/stac_text_direction_parser.dart';
import 'package:stac/src/parsers/foundation/text/stac_text_input_action_parser.dart';
import 'package:stac/src/parsers/foundation/text/stac_text_input_type_parser.dart'
    as kbtype;
import 'package:stac/src/parsers/foundation/text/stac_text_style_parser.dart';
import 'package:stac/src/utils/input_validations.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import '../../../core/helpers/logger.dart'; // Use AppLogger instead of stac_logger
import '../../registry/text_form_field_controller_registry.dart';

/// Custom TextFormField parser that registers controllers in the registry
/// This allows external code (like the date picker) to update TextFormField values
class CustomTextFormFieldParser extends StacParser<StacTextFormField> {
  const CustomTextFormFieldParser();

  // Static map to store raw JSON temporarily, keyed by model hash
  static final Map<int, Map<String, dynamic>> _jsonCache = {};

  @override
  StacTextFormField getModel(Map<String, dynamic> json) {
    // Check if onTap or onChanged exists in JSON before processing
    final hasOnTap = json.containsKey('onTap');
    final hasOnChanged = json.containsKey('onChanged');
    if (hasOnTap) {
      AppLogger.d('ðŸ“ TextFormField JSON contains onTap: ${json['onTap']}');
    }
    if (hasOnChanged) {
      AppLogger.d(
        'ðŸ“ TextFormField JSON contains onChanged: ${json['onChanged']}',
      );
    }

    // Generate key from JSON content (before model creation) to ensure consistency
    final key = _generateKeyFromJson(json);

    final model = StacTextFormField.fromJson(json);
    // Store the raw JSON keyed by JSON content hash
    _jsonCache[key] = Map<String, dynamic>.from(
      json,
    ); // Create a copy to preserve onTap and onChanged
    AppLogger.d(
      'ðŸ’¾ Stored JSON for TextFormField id=${json['id']}, hasOnTap=$hasOnTap, hasOnChanged=$hasOnChanged, key=$key',
    );
    return model;
  }

  @override
  String get type => WidgetType.textFormField.name;

  @override
  Widget parse(BuildContext context, StacTextFormField model) {
    // We need to find the JSON in cache - but we don't have the original JSON here
    // So we'll search for it by model properties, or use a different approach
    // Actually, we can't reliably match here without the original JSON
    // Let's try a different approach: store JSON keyed by a combination that we can recreate

    // Try to find JSON by matching model properties
    // DON'T remove from cache - keep it for onChanged callbacks
    Map<String, dynamic>? rawJson;
    for (final entry in _jsonCache.entries) {
      final cachedJson = entry.value;
      // Match by id first (most reliable)
      if (model.id != null && cachedJson['id'] == model.id) {
        rawJson = Map<String, dynamic>.from(
          entry.value,
        ); // Create a copy, don't remove
        break;
      }
      // Fallback: match by other properties if no ID
      if (model.id == null &&
          cachedJson['id'] == null &&
          cachedJson['readOnly'] == model.readOnly &&
          cachedJson['enabled'] == model.enabled) {
        rawJson = Map<String, dynamic>.from(
          entry.value,
        ); // Create a copy, don't remove
        break;
      }
    }

    if (rawJson != null) {
      final hasOnTap = rawJson.containsKey('onTap');
      final hasOnChanged = rawJson.containsKey('onChanged');
      AppLogger.d(
        'ðŸ” Retrieved JSON for TextFormField id=${model.id}, hasOnTap=$hasOnTap, hasOnChanged=$hasOnChanged',
      );
      if (hasOnTap) {
        AppLogger.d('âœ… Found onTap action: ${rawJson['onTap']}');
      }
      if (hasOnChanged) {
        AppLogger.d('âœ… Found onChanged action: ${rawJson['onChanged']}');
      }
      if (!hasOnTap && !hasOnChanged) {
        AppLogger.w(
          'âš ï¸ Neither onTap nor onChanged found in retrieved JSON. Keys: ${rawJson.keys.toList()}',
        );
      }
    } else {
      AppLogger.w(
        'âš ï¸ No cached JSON found for TextFormField id=${model.id}',
      );
      AppLogger.w(
        'ðŸ“Š Cache size: ${_jsonCache.length}, Keys: ${_jsonCache.keys.toList()}',
      );
    }

    return _CustomTextFormFieldWidget(
      model,
      StacFormScope.of(context),
      rawJson,
    );
  }

  // Generate a unique key from JSON content
  int _generateKeyFromJson(Map<String, dynamic> json) {
    return Object.hash(
      json['id'],
      json['initialValue'],
      json['readOnly'],
      json['enabled'],
      json['hintText'],
    );
  }
}

class _CustomTextFormFieldWidget extends StatefulWidget {
  const _CustomTextFormFieldWidget(this.model, this.formScope, this.rawJson);

  final StacTextFormField model;
  final StacFormScope? formScope;
  final Map<String, dynamic>? rawJson;

  @override
  State<_CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState
    extends State<_CustomTextFormFieldWidget> {
  late final TextEditingController _controller;
  final _focusNode = FocusNode();
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.model.initialValue);
    _obscureText = widget.model.obscureText ?? false;
    if (_shouldFormatThousands && _controller.text.isNotEmpty) {
      final formatted = _formatThousands(_controller.text, _thousandsSeparator);
      if (formatted != _controller.text) {
        _controller.text = formatted;
        _controller.selection = TextSelection.collapsed(
          offset: _controller.text.length,
        );
      }
    }

    // Register the controller in the registry if field has an ID
    if (widget.model.id != null) {
      TextFormFieldControllerRegistry.instance.register(
        widget.model.id!,
        _controller,
      );

      // Also update formData
      widget.formScope?.formData[widget.model.id!] =
          widget.model.initialValue ?? '';
    }
  }

  bool get _shouldFormatThousands {
    final rj = widget.rawJson;
    if (rj == null) return false;
    final formatFlag = rj['formatThousands'];
    if (formatFlag is bool && formatFlag) return true;
    return rj.containsKey('thousandsSeparator');
  }

  String get _thousandsSeparator {
    final rj = widget.rawJson;
    if (rj == null) return ',';
    final sep = rj['thousandsSeparator'];
    if (sep is String && sep.isNotEmpty) return sep;
    return ',';
  }

  String _formatThousands(String value, String sep) {
    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return '';
    final buffer = StringBuffer();
    var count = 0;
    for (int i = digits.length - 1; i >= 0; i--) {
      buffer.write(digits[i]);
      count++;
      if (i > 0 && count % 3 == 0) {
        buffer.write(sep);
      }
    }
    return buffer.toString().split('').reversed.join();
  }

  @override
  void dispose() {
    // Unregister the controller when disposed
    if (widget.model.id != null) {
      TextFormFieldControllerRegistry.instance.unregister(widget.model.id!);
    }
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onTapAction = widget.rawJson?['onTap'] as Map<String, dynamic>?;
    final supportTextDirection = _parseSupportTextDirection();
    final fieldTextDirection = supportTextDirection ?? widget.model.textDirection?.parse;

    final obscuringCharacter = _normalizeObscuringCharacter(
      widget.model.obscuringCharacter,
    );

    final textField = TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      onTap: onTapAction == null
          ? null
          : () {
              AppLogger.d(
                '👆 TextFormField tapped! Executing onTap action: $onTapAction',
              );
              Stac.onCallFromJson(onTapAction, context);
            },
      onChanged: (value) {
        AppLogger.i(
          'ðŸ”„ TextFormField onChanged triggered for id=${widget.model.id}, value="$value"',
        );
        if (_shouldFormatThousands) {
          final formatted = _formatThousands(value, _thousandsSeparator);
          if (formatted != value) {
            _controller.value = _controller.value.copyWith(
              text: formatted,
              selection: TextSelection.collapsed(offset: formatted.length),
              composing: TextRange.empty,
            );
            if (widget.model.id != null) {
              widget.formScope?.formData[widget.model.id!] = formatted;
            }
          }
        }
        if (widget.model.id != null) {
          final stored = _shouldFormatThousands ? _controller.text : value;
          widget.formScope?.formData[widget.model.id!] = stored;
          AppLogger.d('ðŸ“ Updated formData[${widget.model.id}] = "$stored"');
        }

        // Check if onChanged action is provided in raw JSON
        if (widget.rawJson != null) {
          AppLogger.d(
            'ðŸ” Checking for onChanged in raw JSON for id=${widget.model.id}',
          );
          AppLogger.d('ðŸ“‹ Raw JSON keys: ${widget.rawJson!.keys.toList()}');
          final onChangedAction =
              widget.rawJson?['onChanged'] as Map<String, dynamic>?;
          if (onChangedAction != null) {
            AppLogger.i(
              'âœ… onChanged action found! Executing calculateSum action...',
            );
            AppLogger.d('ðŸ“‹ Action JSON: $onChangedAction');
            // Execute asynchronously to avoid blocking the UI
            Future.microtask(() {
              try {
                if (context.mounted) {
                  Stac.onCallFromJson(onChangedAction, context);
                  AppLogger.i('âœ… onChanged action executed successfully');
                }
              } catch (e, stackTrace) {
                AppLogger.e('âŒ Error executing onChanged action: $e');
                AppLogger.e('ðŸ“‹ Stack trace: $stackTrace');
              }
            });
          } else {
            AppLogger.w(
              'âš ï¸ No onChanged action found in raw JSON for id=${widget.model.id}',
            );
            AppLogger.w(
              'ðŸ“‹ Available keys: ${widget.rawJson!.keys.toList()}',
            );
          }
        } else {
          AppLogger.e(
            'âŒ rawJson is null for id=${widget.model.id}, cannot check onChanged',
          );
        }
      },
      keyboardType: widget.model.keyboardType == null
          ? null
          : kbtype.StacTextInputTypeParser(widget.model.keyboardType!).parse,
      textInputAction: widget.model.textInputAction?.parse,
      textCapitalization:
          widget.model.textCapitalization?.parse ?? TextCapitalization.none,
      textAlign: widget.model.textAlign?.parse ?? TextAlign.start,
      // Use supportTextDirection for the whole field so helper/error text
      // follows the expected RTL/LTR layout as well.
      textDirection: fieldTextDirection,
      readOnly: widget.model.readOnly ?? false,
      showCursor: widget.model.showCursor,
      autofocus: widget.model.autofocus ?? false,
      autovalidateMode: widget.model.autovalidateMode?.parse,
      obscuringCharacter: obscuringCharacter,
      maxLines: widget.model.maxLines ?? 1,
      minLines: widget.model.minLines,
      maxLength: widget.model.maxLength,
      buildCounter:
          (
            context, {
            required currentLength,
            required isFocused,
            required maxLength,
          }) => null,
      obscureText: _obscureText,
      autocorrect: widget.model.autocorrect ?? true,
      smartDashesType: widget.model.smartDashesType?.parse,
      smartQuotesType: widget.model.smartQuotesType?.parse,
      maxLengthEnforcement: widget.model.maxLengthEnforcement?.parse,
      expands: widget.model.expands ?? false,
      keyboardAppearance: widget.model.keyboardAppearance?.parse,
      scrollPadding:
          widget.model.scrollPadding?.parse ?? const EdgeInsets.all(20),
      restorationId: widget.model.restorationId,
      enableIMEPersonalizedLearning:
          widget.model.enableIMEPersonalizedLearning ?? true,
      enableSuggestions: widget.model.enableSuggestions ?? true,
      enabled: widget.model.enabled,
      cursorWidth: widget.model.cursorWidth ?? 2.0,
      cursorHeight: widget.model.cursorHeight,
      cursorColor: widget.model.cursorColor?.toColor(context),
      style: widget.model.style?.parse(context),
      decoration: _buildDecoration(context),
      inputFormatters: widget.model.inputFormatters
          ?.map(
            (inputFormatter) =>
                inputFormatter.type.parse.format(inputFormatter.rule ?? ""),
          )
          .toList(),
      validator: (value) {
        String? v = value;
        if (_shouldFormatThousands && v != null) {
          v = v.replaceAll(RegExp(r'[^0-9]'), '');
        }
        return _validate(v, widget.model);
      },
    );

    // Check if onTap or onChanged action is provided in raw JSON
    if (widget.rawJson != null) {
      AppLogger.d(
        'ðŸ” Checking for onTap/onChanged in TextFormField id=${widget.model.id}',
      );
      AppLogger.d('ðŸ“‹ Raw JSON keys: ${widget.rawJson!.keys.toList()}');
    }

    if (supportTextDirection != null) {
      return Directionality(
        textDirection: supportTextDirection,
        child: textField,
      );
    }

    return textField;
  }

  TextDirection? _parseSupportTextDirection() {
    final rawValue = widget.rawJson?['supportTextDirection'];
    if (rawValue is! String) {
      return null;
    }

    switch (rawValue.toLowerCase().trim()) {
      case 'rtl':
        return TextDirection.rtl;
      case 'ltr':
        return TextDirection.ltr;
      default:
        return null;
    }
  }

  InputDecoration? _buildDecoration(BuildContext context) {
    final parsedDecoration = widget.model.decoration?.parse(context);
    final rawDecoration = widget.rawJson?['decoration'];
    if (rawDecoration is! Map) {
      return parsedDecoration;
    }
    final decorationMap = Map<String, dynamic>.from(rawDecoration);

    final hintTextAlign = _parseTextAlign(decorationMap['hintTextAlign']);
    if (hintTextAlign == null) {
      // Even when no custom hint alignment is requested, still honor
      // explicit border overrides from raw JSON (e.g. type: none).
      return parsedDecoration?.copyWith(
        border:
            _parseInputBorder(decorationMap['border']) ?? parsedDecoration.border,
        enabledBorder:
            _parseInputBorder(decorationMap['enabledBorder']) ??
            parsedDecoration.enabledBorder,
        focusedBorder:
            _parseInputBorder(decorationMap['focusedBorder']) ??
            parsedDecoration.focusedBorder,
        errorBorder:
            _parseInputBorder(decorationMap['errorBorder']) ??
            parsedDecoration.errorBorder,
        focusedErrorBorder:
            _parseInputBorder(decorationMap['focusedErrorBorder']) ??
            parsedDecoration.focusedErrorBorder,
        disabledBorder:
            _parseInputBorder(decorationMap['disabledBorder']) ??
            parsedDecoration.disabledBorder,
      );
    }

    final hintText = decorationMap['hintText']?.toString();
    if (hintText == null || hintText.isEmpty) {
      return parsedDecoration;
    }

    final hintTextDirection = _parseTextDirection(
      decorationMap['hintTextDirection'],
      context,
    );
    final hintAlignment = _mapHintAlignment(hintTextAlign, hintTextDirection);
    final hintStyle = widget.model.decoration?.hintStyle?.parse(context);

    // Build a base decoration without hint/hintText to avoid Flutter assertion:
    // "Declaring both hint and hintText is not supported."
    final rawWithoutHint = Map<String, dynamic>.from(decorationMap)
      ..remove('hint')
      ..remove('hintText')
      ..remove('hintTextDirection')
      ..remove('hintTextAlign');
    final baseDecoration = StacInputDecoration.fromJson(
      rawWithoutHint,
    ).parse(context);

    return baseDecoration.copyWith(
      hint: Align(
        alignment: hintAlignment,
        child: Text(
          hintText,
          textAlign: hintTextAlign,
          textDirection: hintTextDirection,
          style: hintStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      border: _parseInputBorder(decorationMap['border']) ?? baseDecoration.border,
      enabledBorder:
          _parseInputBorder(decorationMap['enabledBorder']) ??
          baseDecoration.enabledBorder,
      focusedBorder:
          _parseInputBorder(decorationMap['focusedBorder']) ??
          baseDecoration.focusedBorder,
      errorBorder:
          _parseInputBorder(decorationMap['errorBorder']) ??
          baseDecoration.errorBorder,
      focusedErrorBorder:
          _parseInputBorder(decorationMap['focusedErrorBorder']) ??
          baseDecoration.focusedErrorBorder,
      disabledBorder:
          _parseInputBorder(decorationMap['disabledBorder']) ??
          baseDecoration.disabledBorder,
    );
  }

  InputBorder? _parseInputBorder(dynamic rawBorder) {
    if (rawBorder is! Map) return null;
    final type = rawBorder['type']?.toString().trim().toLowerCase();
    if (type == 'none') {
      return InputBorder.none;
    }
    return null;
  }

  TextAlign? _parseTextAlign(dynamic value) {
    if (value is! String) return null;
    switch (value.trim().toLowerCase()) {
      case 'left':
        return TextAlign.left;
      case 'right':
        return TextAlign.right;
      case 'center':
        return TextAlign.center;
      case 'start':
        return TextAlign.start;
      case 'end':
        return TextAlign.end;
      case 'justify':
        return TextAlign.justify;
      default:
        return null;
    }
  }

  TextDirection _parseTextDirection(dynamic value, BuildContext context) {
    if (value is String) {
      switch (value.trim().toLowerCase()) {
        case 'ltr':
          return TextDirection.ltr;
        case 'rtl':
          return TextDirection.rtl;
      }
    }
    return Directionality.of(context);
  }

  Alignment _mapHintAlignment(TextAlign textAlign, TextDirection textDirection) {
    switch (textAlign) {
      case TextAlign.left:
        return Alignment.centerLeft;
      case TextAlign.right:
        return Alignment.centerRight;
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.start:
        return textDirection == TextDirection.rtl
            ? Alignment.centerRight
            : Alignment.centerLeft;
      case TextAlign.end:
        return textDirection == TextDirection.rtl
            ? Alignment.centerLeft
            : Alignment.centerRight;
      case TextAlign.justify:
        return Alignment.centerRight;
    }
  }

  String _normalizeObscuringCharacter(String? value) {
    final fallback = '•';
    if (value == null || value.isEmpty) return fallback;

    // Flutter asserts that obscuringCharacter must be exactly 1 character.
    // Some inputs may be mojibake like U+00E2 U+20AC U+00A2 due to encoding.
    return value.characters.first;
  }

  String? _validate(String? value, StacTextFormField model) {
    if (value != null && (widget.model.validatorRules?.isNotEmpty ?? false)) {
      for (final validator in widget.model.validatorRules!) {
        try {
          if (!InputValidators.validate(
            validator.rule,
            value,
            options: validator.options,
          )) {
            return validator.message;
          }
        } catch (e) {
          AppLogger.e(e);
        }
      }
    }

    return null;
  }
}
