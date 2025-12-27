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
import 'package:stac/src/parsers/foundation/text/stac_text_input_type_parser.dart';
import 'package:stac/src/parsers/foundation/text/stac_text_style_parser.dart';
import 'package:stac/src/parsers/widgets/stac_form/stac_form_scope.dart';
import 'package:stac/src/utils/color_utils.dart';
import 'package:stac/src/utils/input_validations.dart';
import 'package:stac/stac.dart';
import 'package:stac_core/stac_core.dart';
import 'package:stac_framework/stac_framework.dart';
import '../../../helpers/logger.dart'; // Use AppLogger instead of stac_logger
import '../../utils/text_form_field_controller_registry.dart';

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
      AppLogger.d('📝 TextFormField JSON contains onTap: ${json['onTap']}');
    }
    if (hasOnChanged) {
      AppLogger.d(
        '📝 TextFormField JSON contains onChanged: ${json['onChanged']}',
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
      '💾 Stored JSON for TextFormField id=${json['id']}, hasOnTap=$hasOnTap, hasOnChanged=$hasOnChanged, key=$key',
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
        '🔍 Retrieved JSON for TextFormField id=${model.id}, hasOnTap=$hasOnTap, hasOnChanged=$hasOnChanged',
      );
      if (hasOnTap) {
        AppLogger.d('✅ Found onTap action: ${rawJson['onTap']}');
      }
      if (hasOnChanged) {
        AppLogger.d('✅ Found onChanged action: ${rawJson['onChanged']}');
      }
      if (!hasOnTap && !hasOnChanged) {
        AppLogger.w(
          '⚠️ Neither onTap nor onChanged found in retrieved JSON. Keys: ${rawJson.keys.toList()}',
        );
      }
    } else {
      AppLogger.w('⚠️ No cached JSON found for TextFormField id=${model.id}');
      AppLogger.w(
        '📊 Cache size: ${_jsonCache.length}, Keys: ${_jsonCache.keys.toList()}',
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
    final textField = TextFormField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: (value) {
        AppLogger.i(
          '🔄 TextFormField onChanged triggered for id=${widget.model.id}, value="$value"',
        );
        if (widget.model.id != null) {
          widget.formScope?.formData[widget.model.id!] = value;
          AppLogger.d('📝 Updated formData[${widget.model.id}] = "$value"');
        }

        // Check if onChanged action is provided in raw JSON
        if (widget.rawJson != null) {
          AppLogger.d(
            '🔍 Checking for onChanged in raw JSON for id=${widget.model.id}',
          );
          AppLogger.d('📋 Raw JSON keys: ${widget.rawJson!.keys.toList()}');
          final onChangedAction =
              widget.rawJson?['onChanged'] as Map<String, dynamic>?;
          if (onChangedAction != null) {
            AppLogger.i(
              '✅ onChanged action found! Executing calculateSum action...',
            );
            AppLogger.d('📋 Action JSON: $onChangedAction');
            // Execute asynchronously to avoid blocking the UI
            Future.microtask(() {
              try {
                Stac.onCallFromJson(onChangedAction, context);
                AppLogger.i('✅ onChanged action executed successfully');
              } catch (e, stackTrace) {
                AppLogger.e('❌ Error executing onChanged action: $e');
                AppLogger.e('📋 Stack trace: $stackTrace');
              }
            });
          } else {
            AppLogger.w(
              '⚠️ No onChanged action found in raw JSON for id=${widget.model.id}',
            );
            AppLogger.w('📋 Available keys: ${widget.rawJson!.keys.toList()}');
          }
        } else {
          AppLogger.e(
            '❌ rawJson is null for id=${widget.model.id}, cannot check onChanged',
          );
        }
      },
      keyboardType: widget.model.keyboardType?.parse,
      textInputAction: widget.model.textInputAction?.parse,
      textCapitalization:
          widget.model.textCapitalization?.parse ?? TextCapitalization.none,
      textAlign: widget.model.textAlign?.parse ?? TextAlign.start,
      textDirection: widget.model.textDirection?.parse,
      readOnly: widget.model.readOnly ?? false,
      showCursor: widget.model.showCursor,
      autofocus: widget.model.autofocus ?? false,
      autovalidateMode: widget.model.autovalidateMode?.parse,
      obscuringCharacter: widget.model.obscuringCharacter ?? '•',
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
      decoration: widget.model.decoration?.parse(context),
      inputFormatters: widget.model.inputFormatters
          ?.map(
            (inputFormatter) =>
                inputFormatter.type.parse.format(inputFormatter.rule ?? ""),
          )
          .toList(),
      validator: (value) {
        return _validate(value, widget.model);
      },
    );

    // Check if onTap or onChanged action is provided in raw JSON
    if (widget.rawJson != null) {
      AppLogger.d(
        '🔍 Checking for onTap/onChanged in TextFormField id=${widget.model.id}',
      );
      AppLogger.d('📋 Raw JSON keys: ${widget.rawJson!.keys.toList()}');
    }

    final onTapAction = widget.rawJson?['onTap'] as Map<String, dynamic>?;
    if (onTapAction != null) {
      AppLogger.d(
        '✅ onTap action found! Wrapping TextFormField in GestureDetector',
      );
      // Wrap in GestureDetector with opaque behavior to ensure taps are received
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          AppLogger.d(
            '👆 TextFormField tapped! Executing onTap action: $onTapAction',
          );
          Stac.onCallFromJson(onTapAction, context);
        },
        child: textField,
      );
    } else {
      AppLogger.w(
        '⚠️ No onTap action found for TextFormField id=${widget.model.id}',
      );
    }

    return textField;
  }

  String? _validate(String? value, StacTextFormField model) {
    if (value != null && (widget.model.validatorRules?.isNotEmpty ?? false)) {
      for (final validator in widget.model.validatorRules!) {
        try {
          final validationType = InputValidationType.values.firstWhere(
            (e) => e.name == validator.rule,
            orElse: () => InputValidationType.general,
          );

          if (validationType == InputValidationType.general) {
            if (!InputValidationType.general.validate(value, validator.rule)) {
              return validator.message;
            }
          } else {
            if (!validationType.validate(value, validator.rule)) {
              return validator.message;
            }
          }
        } catch (e) {
          AppLogger.e(e);
        }
      }
    }

    return null;
  }
}
