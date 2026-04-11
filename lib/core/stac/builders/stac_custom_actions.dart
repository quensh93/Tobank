import 'package:stac_core/stac_core.dart';

export 'close_dialog_action.dart' show StacCloseDialogAction;
export 'stac_finger_print_action.dart';

/// Builder for 'sequence' action.
/// Executes a list of actions in order (awaiting Futures).
class StacSequenceAction extends StacAction {
  final List<dynamic> actions;

  const StacSequenceAction({required this.actions});

  @override
  String get actionType => 'sequence';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'sequence',
      'actions': actions.map((a) {
        if (a is StacAction) return a.toJson();
        if (a is Map) return a;
        try {
          return a.toJson();
        } catch (_) {
          return a;
        }
      }).toList(),
    };
  }
}

/// Builder for 'log' action.
class StacLogAction extends StacAction {
  final String message;
  final String? level;

  const StacLogAction({required this.message, this.level});

  @override
  String get actionType => 'log';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'log',
      'message': message,
      if (level != null) 'level': level,
    };
  }
}

/// Builder for 'validateFields' action.
class StacValidateFieldsAction extends StacAction {
  final String resultKey;
  final List<Map<String, dynamic>> fields;

  const StacValidateFieldsAction({
    required this.resultKey,
    required this.fields,
  });

  @override
  String get actionType => 'validateFields';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'validateFields',
      'resultKey': resultKey,
      'fields': fields,
    };
  }
}

/// Builder for 'setValue' action.
/// (This might overlap with core StacSetValueAction but enables custom behavior if needed)
class StacCustomSetValueAction extends StacAction {
  final String? key;
  final dynamic value;
  final List<Map<String, dynamic>>? values;

  const StacCustomSetValueAction({this.key, this.value, this.values});

  @override
  String get actionType => 'setValue';

  @override
  Map<String, dynamic> toJson() {
    if (values != null) {
      return {'actionType': 'setValue', 'values': values};
    }
    dynamic processedValue = value;
    if (value is StacGetFormValueAction) {
      processedValue = value.toJson();
    } else if (value is StacAction) {
      processedValue = value.toJson();
    }
    return {'actionType': 'setValue', 'key': key, 'value': processedValue};
  }
}

/// Helper for 'getFormValue' action used inside setValue
class StacGetFormValueAction {
  final String id;

  const StacGetFormValueAction({required this.id});

  Map<String, dynamic> toJson() {
    return {'actionType': 'getFormValue', 'id': id};
  }
}

/// Builder for 'networkRequest' action.
class StacNetworkRequestAction extends StacAction {
  final String url;
  final String method;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? headers;
  final List<dynamic>? results;
  final String? dataBind;

  const StacNetworkRequestAction({
    required this.url,
    this.method = 'get',
    this.data,
    this.headers,
    this.results,
    this.dataBind,
  });

  @override
  String get actionType => 'networkRequest';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'networkRequest',
      'url': url,
      'method': method,
      if (data != null) 'data': data,
      if (headers != null) 'headers': headers,
      if (dataBind != null) 'dataBind': dataBind,
      if (results != null)
        'results': results!.map((r) {
          if (r is Map) {
            // Check if any values inside the map are StacAction objects and serialize them
            return r.map((key, value) {
              if (value is StacAction) {
                return MapEntry(key, value.toJson());
              }
              return MapEntry(key, value);
            }).cast<String, dynamic>();
          }
          try {
            return (r as dynamic).toJson();
          } catch (_) {
            return r;
          }
        }).toList(),
    };
  }
}

/// Builder for 'persianDatePicker' action.
class StacPersianDatePickerAction extends StacAction {
  final String formFieldId;
  final String firstDate;
  final String lastDate;
  final String? initialDate;
  final dynamic onDateSelected;

  const StacPersianDatePickerAction({
    required this.formFieldId,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    this.onDateSelected,
  });

  @override
  String get actionType => 'persianDatePicker';

  @override
  Map<String, dynamic> toJson() {
    return {
      'actionType': 'persianDatePicker',
      'formFieldId': formFieldId,
      'firstDate': firstDate,
      'lastDate': lastDate,
      if (initialDate != null) 'initialDate': initialDate,
      if (onDateSelected != null)
        'onDateSelected': onDateSelected is StacAction
            ? onDateSelected.toJson()
            : onDateSelected,
    };
  }
}

/// Builder for custom 'pickFile' action.
class StacFilePickerAction extends StacAction {
  final String fileType;
  final bool allowMultiple;
  final String targetKey;
  final String? hasValueKey;
  final String? fileNameKey;
  final List<String>? allowedExtensions;
  final bool previewBeforeConfirm;
  final String? previewSheetTitle;
  final String? confirmButtonText;
  final String? retryButtonText;

  const StacFilePickerAction({
    this.fileType = 'image',
    this.allowMultiple = false,
    required this.targetKey,
    this.hasValueKey,
    this.fileNameKey,
    this.allowedExtensions,
    this.previewBeforeConfirm = false,
    this.previewSheetTitle,
    this.confirmButtonText,
    this.retryButtonText,
  });

  @override
  String get actionType => 'pickFile';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'fileType': fileType,
    'allowMultiple': allowMultiple,
    'targetKey': targetKey,
    if (hasValueKey != null) 'hasValueKey': hasValueKey,
    if (fileNameKey != null) 'fileNameKey': fileNameKey,
    if (allowedExtensions != null) 'allowedExtensions': allowedExtensions,
    'previewBeforeConfirm': previewBeforeConfirm,
    if (previewSheetTitle != null) 'previewSheetTitle': previewSheetTitle,
    if (confirmButtonText != null) 'confirmButtonText': confirmButtonText,
    if (retryButtonText != null) 'retryButtonText': retryButtonText,
  };
}

class StacShowRulesBottomSheetAction extends StacAction {
  final String routeName;
  final String? title;

  const StacShowRulesBottomSheetAction({
    required this.routeName,
    this.title,
  });

  @override
  String get actionType => 'showRulesBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'routeName': routeName,
    if (title != null) 'title': title,
  };
}

class StacShowGuideOptionsBottomSheetAction extends StacAction {
  final String title;
  final List<Map<String, dynamic>> options;

  const StacShowGuideOptionsBottomSheetAction({
    required this.title,
    required this.options,
  });

  @override
  String get actionType => 'showGuideOptionsBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'title': title,
    'options': options,
  };
}

class StacShowPhotoTipsBottomSheetAction extends StacAction {
  final String title;
  final String? iconAsset;
  final List<String> tips;
  final String? previewAsset;
  final dynamic continueAction;
  final String continueText;
  final String cancelText;

  const StacShowPhotoTipsBottomSheetAction({
    required this.title,
    required this.tips,
    required this.continueAction,
    this.iconAsset,
    this.previewAsset,
    this.continueText = 'ادامه',
    this.cancelText = 'بازگشت',
  });

  @override
  String get actionType => 'showPhotoTipsBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'title': title,
    if (iconAsset != null) 'iconAsset': iconAsset,
    'tips': tips,
    if (previewAsset != null) 'previewAsset': previewAsset,
    'continueAction': continueAction is StacAction
        ? (continueAction as StacAction).toJson()
        : continueAction,
    'continueText': continueText,
    'cancelText': cancelText,
  };
}
