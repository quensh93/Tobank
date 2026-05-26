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

/// Builder for Mega Gasht webview back navigation.
class StacTobankMegaGashtBackAction extends StacAction {
  const StacTobankMegaGashtBackAction();

  @override
  String get actionType => 'tobankMegaGashtBack';

  @override
  Map<String, dynamic> toJson() => {'actionType': actionType};
}

/// Builder for Acceptor webview back navigation.
class StacTobankAcceptorBackAction extends StacAction {
  const StacTobankAcceptorBackAction();

  @override
  String get actionType => 'tobankAcceptorBack';

  @override
  Map<String, dynamic> toJson() => {'actionType': actionType};
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
  final dynamic action;

  const StacCustomSetValueAction({
    this.key,
    this.value,
    this.values,
    this.action,
  });

  @override
  String get actionType => 'setValue';

  @override
  Map<String, dynamic> toJson() {
    if (values != null) {
      return {
        'actionType': 'setValue',
        'values': values!.map(_processEntry).toList(),
        if (action != null) 'action': _processValue(action),
      };
    }
    final processedValue = _processValue(value);
    return {
      'actionType': 'setValue',
      'key': key,
      'value': processedValue,
      if (action != null) 'action': _processValue(action),
    };
  }

  Map<String, dynamic> _processEntry(Map<String, dynamic> entry) {
    return entry.map((key, value) => MapEntry(key, _processValue(value)));
  }

  dynamic _processValue(dynamic input) {
    if (input is StacGetFormValueAction) {
      return input.toJson();
    }
    if (input is StacAction) {
      return input.toJson();
    }
    if (input is Map) {
      return input.map((key, value) => MapEntry(key, _processValue(value)));
    }
    if (input is List) {
      return input.map(_processValue).toList();
    }
    return input;
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
  final bool includeTime;
  final String? initialTime;
  final double? bottomSheetBottomPadding;
  final dynamic onDateSelected;

  const StacPersianDatePickerAction({
    required this.formFieldId,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    this.includeTime = false,
    this.initialTime,
    this.bottomSheetBottomPadding,
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
      if (includeTime) 'includeTime': includeTime,
      if (initialTime != null) 'initialTime': initialTime,
      if (bottomSheetBottomPadding != null)
        'bottomSheetBottomPadding': bottomSheetBottomPadding,
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
  final String? source;
  final String? cameraDevice;
  final bool cropImage;
  final double? cropAspectRatioX;
  final double? cropAspectRatioY;
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
    this.source,
    this.cameraDevice,
    this.cropImage = false,
    this.cropAspectRatioX,
    this.cropAspectRatioY,
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
    if (source != null) 'source': source,
    if (cameraDevice != null) 'cameraDevice': cameraDevice,
    'cropImage': cropImage,
    if (cropAspectRatioX != null) 'cropAspectRatioX': cropAspectRatioX,
    if (cropAspectRatioY != null) 'cropAspectRatioY': cropAspectRatioY,
    if (allowedExtensions != null) 'allowedExtensions': allowedExtensions,
    'previewBeforeConfirm': previewBeforeConfirm,
    if (previewSheetTitle != null) 'previewSheetTitle': previewSheetTitle,
    if (confirmButtonText != null) 'confirmButtonText': confirmButtonText,
    if (retryButtonText != null) 'retryButtonText': retryButtonText,
  };
}

class StacPickContactPhoneAction extends StacAction {
  final String formFieldId;
  final String? targetKey;
  final dynamic onContactSelected;
  final String? permissionDeniedMessage;
  final String? invalidMobileMessage;
  final String? unsupportedMessage;

  const StacPickContactPhoneAction({
    required this.formFieldId,
    this.targetKey,
    this.onContactSelected,
    this.permissionDeniedMessage,
    this.invalidMobileMessage,
    this.unsupportedMessage,
  });

  @override
  String get actionType => 'pickContactPhone';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'formFieldId': formFieldId,
    if (targetKey != null) 'targetKey': targetKey,
    if (permissionDeniedMessage != null)
      'permissionDeniedMessage': permissionDeniedMessage,
    if (invalidMobileMessage != null)
      'invalidMobileMessage': invalidMobileMessage,
    if (unsupportedMessage != null) 'unsupportedMessage': unsupportedMessage,
    if (onContactSelected != null)
      'onContactSelected': onContactSelected is StacAction
          ? (onContactSelected as StacAction).toJson()
          : onContactSelected,
  };
}

class StacShowRulesBottomSheetAction extends StacAction {
  final String routeName;
  final String? title;

  const StacShowRulesBottomSheetAction({required this.routeName, this.title});

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

class StacShowJobSelectorBottomSheetAction extends StacAction {
  final double heightFactor;

  const StacShowJobSelectorBottomSheetAction({this.heightFactor = 0.75});

  @override
  String get actionType => 'showJobSelectorBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'heightFactor': heightFactor,
  };
}

class StacShowBankAddressBottomSheetAction extends StacAction {
  final String title;
  final String addressLabel;
  final String address;
  final String postalCodeLabel;
  final String postalCode;
  final String editButtonText;
  final String editTitle;
  final String postalCodeHint;
  final String inquiryButtonText;
  final String postalCodeValueKey;
  final dynamic inquiryAction;

  const StacShowBankAddressBottomSheetAction({
    this.title = 'آدرس ثبت‌شده در بانک',
    this.addressLabel = 'آدرس',
    required this.address,
    this.postalCodeLabel = 'کد پستی',
    required this.postalCode,
    this.editButtonText = 'ویرایش',
    this.editTitle = 'ویرایش آدرس ثبت‌شده در بانک',
    this.postalCodeHint = 'کد پستی محل سکونت را وارد کنید',
    this.inquiryButtonText = 'استعلام',
    this.postalCodeValueKey = 'profileRealPostalCode',
    this.inquiryAction,
  });

  @override
  String get actionType => 'showBankAddressBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'title': title,
    'addressLabel': addressLabel,
    'address': address,
    'postalCodeLabel': postalCodeLabel,
    'postalCode': postalCode,
    'editButtonText': editButtonText,
    'editTitle': editTitle,
    'postalCodeHint': postalCodeHint,
    'inquiryButtonText': inquiryButtonText,
    'postalCodeValueKey': postalCodeValueKey,
    if (inquiryAction != null)
      'inquiryAction': inquiryAction is StacAction
          ? (inquiryAction as StacAction).toJson()
          : inquiryAction,
  };
}

class StacShowThemeSelectorBottomSheetAction extends StacAction {
  final String title;
  final String lightLabel;
  final String darkLabel;
  final String systemLabel;

  const StacShowThemeSelectorBottomSheetAction({
    this.title = 'ظاهر برنامه را انتخاب کنید',
    this.lightLabel = 'حالت روز',
    this.darkLabel = 'حالت شب',
    this.systemLabel = 'پیش‌فرض سیستم عامل',
  });

  @override
  String get actionType => 'showThemeSelectorBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'title': title,
    'lightLabel': lightLabel,
    'darkLabel': darkLabel,
    'systemLabel': systemLabel,
  };
}

class StacShowDeleteAccountConfirmBottomSheetAction extends StacAction {
  final String title;
  final String description;
  final String warningMessageOne;
  final String warningMessageTwo;
  final String confirmText;
  final String buttonText;
  final String warningIconAsset;
  final dynamic continueAction;

  const StacShowDeleteAccountConfirmBottomSheetAction({
    this.title = 'حذف اطلاعات حساب کاربری',
    this.description =
        'کاربر گرامی، در صورت انتقال سیم‌کارت یا تمایل به حذف اطلاعات حساب خود می‌توانید اطلاعاتی نظیر تراکنش‌ها، کارت‌های ذخیره شده و ... را از حساب‌کاربری خود حذف کنید.',
    this.warningMessageOne =
        'حتما قبل از حذف اطلاعات، موجودی کیف پول خود را به شماره دیگر خود انتقال دهید.',
    this.warningMessageTwo =
        'تا ۲۴ ساعت بعد از حذف حساب‌کاربری امکان ثبت‌نام مجدد نخواهید داشت',
    this.confirmText = 'میخواهم اطلاعات حساب کاربری خود را حذف کنم.',
    this.buttonText = 'ادامه',
    this.warningIconAsset = 'assets/icons/ic_warning_red.svg',
    this.continueAction,
  });

  @override
  String get actionType => 'showDeleteAccountConfirmBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'title': title,
    'description': description,
    'warningMessageOne': warningMessageOne,
    'warningMessageTwo': warningMessageTwo,
    'confirmText': confirmText,
    'buttonText': buttonText,
    'warningIconAsset': warningIconAsset,
    if (continueAction != null)
      'continueAction': continueAction is StacAction
          ? (continueAction as StacAction).toJson()
          : continueAction,
  };
}

class StacShowLogoutConfirmDialogAction extends StacAction {
  final String title;
  final String description;
  final String positiveText;
  final String negativeText;
  final String warningIconAsset;
  final dynamic positiveAction;
  final dynamic negativeAction;

  const StacShowLogoutConfirmDialogAction({
    this.title = 'مطمئن به خروج از حساب‌کاربری هستید؟',
    this.description =
        'در صورت خروج از حساب‌کاربری، برای ورود مجدد نیاز به احراز هویت خواهد داشت. احراز هویت مجدد، به منظور افزایش امنیت حساب‌کاربری و جلوگیری از دسترسی غیرمجاز افراد ناشناس به حساب شما می‌باشد.',
    this.positiveText = 'بله',
    this.negativeText = 'خیر',
    this.warningIconAsset = 'assets/icons/ic_warning_red.svg',
    this.positiveAction,
    this.negativeAction,
  });

  @override
  String get actionType => 'showLogoutConfirmDialog';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'title': title,
    'description': description,
    'positiveText': positiveText,
    'negativeText': negativeText,
    'warningIconAsset': warningIconAsset,
    if (positiveAction != null)
      'positiveAction': positiveAction is StacAction
          ? (positiveAction as StacAction).toJson()
          : positiveAction,
    if (negativeAction != null)
      'negativeAction': negativeAction is StacAction
          ? (negativeAction as StacAction).toJson()
          : negativeAction,
  };
}

class StacShowAddDestinationCardBottomSheetAction extends StacAction {
  final String title;
  final String scanButtonText;
  final String scanIconAsset;
  final String cardNumberLabel;
  final String cardNumberHint;
  final String cardTitleLabel;
  final String cardTitleHint;
  final String submitText;
  final dynamic scanAction;
  final dynamic submitAction;

  const StacShowAddDestinationCardBottomSheetAction({
    this.title = 'افزودن کارت جدید',
    this.scanButtonText = 'اسکن کارت',
    this.scanIconAsset = 'assets/icons/ic_scanner.svg',
    this.cardNumberLabel = 'شماره کارت',
    this.cardNumberHint = 'یک شماره کارت معتبر وارد نمایید',
    this.cardTitleLabel = 'عنوان کارت',
    this.cardTitleHint = 'عنوان کارت را وارد کنید',
    this.submitText = 'ثبت',
    this.scanAction,
    this.submitAction,
  });

  @override
  String get actionType => 'showAddDestinationCardBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'title': title,
    'scanButtonText': scanButtonText,
    'scanIconAsset': scanIconAsset,
    'cardNumberLabel': cardNumberLabel,
    'cardNumberHint': cardNumberHint,
    'cardTitleLabel': cardTitleLabel,
    'cardTitleHint': cardTitleHint,
    'submitText': submitText,
    if (scanAction != null)
      'scanAction': scanAction is StacAction
          ? (scanAction as StacAction).toJson()
          : scanAction,
    if (submitAction != null)
      'submitAction': submitAction is StacAction
          ? (submitAction as StacAction).toJson()
          : submitAction,
  };
}

class StacShowGiftCardPurchaseBottomSheetAction extends StacAction {
  final String title;
  final String message;
  final String rulesLabel;
  final String continueText;
  final dynamic continueAction;

  const StacShowGiftCardPurchaseBottomSheetAction({
    this.title = 'خرید کارت هدیه',
    this.message =
        'به مبالغ ۳۶,۰۰۰ ریال بابت کارمزد و ۵۷۰,۰۰۰ ریال بابت ارسال کارت هدیه به تحویل گیرنده اضافه می‌گردد',
    this.rulesLabel = 'قوانین و مقررات توبانک را خوانده و قبول دارم',
    this.continueText = 'ادامه',
    this.continueAction,
  });

  @override
  String get actionType => 'showGiftCardPurchaseBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'title': title,
    'message': message,
    'rulesLabel': rulesLabel,
    'continueText': continueText,
    if (continueAction != null)
      'continueAction': continueAction is StacAction
          ? (continueAction as StacAction).toJson()
          : continueAction,
  };
}

class StacShowGiftCardMessageGuideBottomSheetAction extends StacAction {
  final String title;
  final String description;
  final String closeText;

  const StacShowGiftCardMessageGuideBottomSheetAction({
    this.title = 'راهنما',
    this.description =
        'در صورت ورود متن دلخواه، یکی از متن‌های پیش‌فرض را انتخاب کنید تا در صورت عدم موافقت بانک با متن دلخواه شما، متن پیش‌فرض جایگزین آن شود',
    this.closeText = 'بستن',
  });

  @override
  String get actionType => 'showGiftCardMessageGuideBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'title': title,
    'description': description,
    'closeText': closeText,
  };
}

class StacShowGiftCardSelectAmountBottomSheetAction extends StacAction {
  final String title;
  final String inputHint;
  final String confirmText;
  final String amountValueKey;
  final String amountLabelKey;
  final int minAmount;
  final int maxAmount;
  final List<int>? quickAmounts;

  const StacShowGiftCardSelectAmountBottomSheetAction({
    required this.amountValueKey,
    required this.amountLabelKey,
    this.title = 'مبلغ کارت هدیه را وارد یا انتخاب نمایید',
    this.inputHint = 'مبلغ کارت هدیه را به ریال وارد نمایید',
    this.confirmText = 'تایید',
    this.minAmount = 1000000,
    this.maxAmount = 50000000,
    this.quickAmounts,
  });

  @override
  String get actionType => 'showGiftCardSelectAmountBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'title': title,
    'inputHint': inputHint,
    'confirmText': confirmText,
    'amountValueKey': amountValueKey,
    'amountLabelKey': amountLabelKey,
    'minAmount': minAmount,
    'maxAmount': maxAmount,
    if (quickAmounts != null) 'quickAmounts': quickAmounts,
  };
}

class StacShowGiftCardPlanSelectorBottomSheetAction extends StacAction {
  final String title;
  final String? categoryTitle;
  final String selectedPlanIdKey;
  final String selectedPlanTitleKey;
  final String selectedCategoryKey;
  final List<Map<String, dynamic>> plans;
  final dynamic onPlanSelectedAction;

  const StacShowGiftCardPlanSelectorBottomSheetAction({
    required this.plans,
    this.title = 'لطفا طرح کارت هدیه را انتخاب کنید',
    this.categoryTitle,
    this.selectedPlanIdKey = 'giftCardRealSelectedPlanId',
    this.selectedPlanTitleKey = 'giftCardRealSelectedPlanTitle',
    this.selectedCategoryKey = 'giftCardRealSelectedCategory',
    this.onPlanSelectedAction,
  });

  @override
  String get actionType => 'showGiftCardPlanSelectorBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    'title': title,
    if (categoryTitle != null) 'categoryTitle': categoryTitle,
    'selectedPlanIdKey': selectedPlanIdKey,
    'selectedPlanTitleKey': selectedPlanTitleKey,
    'selectedCategoryKey': selectedCategoryKey,
    'plans': plans,
    if (onPlanSelectedAction != null)
      'onPlanSelectedAction': onPlanSelectedAction is StacAction
          ? (onPlanSelectedAction as StacAction).toJson()
          : onPlanSelectedAction,
  };
}

class StacShowBottomSheetAction extends StacAction {
  final Map<String, dynamic>? sheet;
  final String? title;
  final List<Map<String, dynamic>>? items;
  final bool? isScrollControlled;
  final bool? useSafeArea;
  final bool? isDismissible;
  final bool? enableDrag;
  final String? backgroundColor;
  final String? barrierColor;

  const StacShowBottomSheetAction({
    this.sheet,
    this.title,
    this.items,
    this.isScrollControlled,
    this.useSafeArea,
    this.isDismissible,
    this.enableDrag,
    this.backgroundColor,
    this.barrierColor,
  });

  @override
  String get actionType => 'showBottomSheet';

  @override
  Map<String, dynamic> toJson() => {
    'actionType': actionType,
    if (sheet != null) 'sheet': sheet,
    if (title != null) 'title': title,
    if (items != null) 'items': items,
    if (isScrollControlled != null) 'isScrollControlled': isScrollControlled,
    if (useSafeArea != null) 'useSafeArea': useSafeArea,
    if (isDismissible != null) 'isDismissible': isDismissible,
    if (enableDrag != null) 'enableDrag': enableDrag,
    if (backgroundColor != null) 'backgroundColor': backgroundColor,
    if (barrierColor != null) 'barrierColor': barrierColor,
  };
}

class StacShowDialogAction extends StacAction {
  final String dialogActionType;
  final Map<String, dynamic>? dialog;
  final String? title;
  final String? description;
  final String? positiveText;
  final String? negativeText;
  final String? warningIconAsset;
  final dynamic positiveAction;
  final dynamic negativeAction;
  final bool? barrierDismissible;
  final String? barrierColor;
  final String? backgroundColor;

  const StacShowDialogAction({
    this.dialogActionType = 'showAppDialog',
    this.dialog,
    this.title,
    this.description,
    this.positiveText,
    this.negativeText,
    this.warningIconAsset,
    this.positiveAction,
    this.negativeAction,
    this.barrierDismissible,
    this.barrierColor,
    this.backgroundColor,
  });

  @override
  String get actionType => dialogActionType;

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{'actionType': actionType};
    if (dialog != null) {
      json['dialog'] = dialog;
    }
    if (title != null) json['title'] = title;
    if (description != null) json['description'] = description;
    if (positiveText != null) json['positiveText'] = positiveText;
    if (negativeText != null) json['negativeText'] = negativeText;
    if (warningIconAsset != null) json['warningIconAsset'] = warningIconAsset;
    if (barrierDismissible != null) {
      json['barrierDismissible'] = barrierDismissible;
    }
    if (barrierColor != null) {
      json['barrierColor'] = barrierColor;
    }
    if (backgroundColor != null) {
      json['backgroundColor'] = backgroundColor;
    }
    if (positiveAction != null) {
      json['positiveAction'] = positiveAction is StacAction
          ? (positiveAction as StacAction).toJson()
          : positiveAction;
    }
    if (negativeAction != null) {
      json['negativeAction'] = negativeAction is StacAction
          ? (negativeAction as StacAction).toJson()
          : negativeAction;
    }
    return json;
  }
}

class StacCustomSnackBarAction extends StacAction {
  final String title;
  final String detail;
  final String backgroundColor;
  final int duration;
  final String? buttonTitle;
  final bool permanent;
  final dynamic buttonAction;

  const StacCustomSnackBarAction({
    required this.title,
    required this.detail,
    this.backgroundColor = '#00000000',
    this.duration = 10000,
    this.buttonTitle,
    bool permanent = false,
    @Deprecated('Use permanent instead') bool? permenent,
    this.buttonAction,
  }) : permanent = permenent ?? permanent;

  @override
  String get actionType => 'customSnackBar';

  @override
  Map<String, dynamic> toJson() {
    final hasButton = (buttonTitle ?? '').trim().isNotEmpty;
    final rowChildren = <Map<String, dynamic>>[
      if (hasButton)
        {
          'type': 'gestureDetector',
          'onTap': buttonAction ?? {'actionType': 'hideSnackBar'},
          'child': {
            'type': 'container',
            'padding': {'left': 10, 'top': 5, 'right': 10, 'bottom': 5},
            'decoration': {
              'color': '#E31A2F',
              'borderRadius': {
                'topLeft': 8,
                'topRight': 8,
                'bottomLeft': 8,
                'bottomRight': 8,
              },
            },
            'child': {
              'type': 'text',
              'data': buttonTitle,
              'textDirection': 'rtl',
              'style': {
                'type': 'custom',
                'fontSize': 12,
                'fontWeight': 'w700',
                'color': '#FFFFFF',
              },
            },
          },
        },
      if (hasButton) {'type': 'sizedBox', 'width': 10},
      {
        'type': 'expanded',
        'child': {
          'type': 'column',
          'mainAxisSize': 'min',
          'crossAxisAlignment': 'end',
          'children': [
            {
              'type': 'text',
              'data': title,
              'textDirection': 'rtl',
              'textAlign': 'right',
              'style': {
                'type': 'custom',
                'fontSize': 14,
                'fontWeight': 'w700',
                'color': '{{appColors.current.text.title}}',
                'height': 1.45,
              },
            },
            {'type': 'sizedBox', 'height': 4},
            {
              'type': 'text',
              'data': detail,
              'textDirection': 'rtl',
              'textAlign': 'right',
              'style': {
                'type': 'custom',
                'fontSize': 13,
                'fontWeight': 'w500',
                'color': '{{appColors.current.text.subtitle}}',
                'height': 1.45,
              },
            },
          ],
        },
      },
      {'type': 'sizedBox', 'width': 10},
      {
        'type': 'container',
        'width': 1,
        'height': 20,
        'decoration': {
          'color': '{{appColors.current.input.borderEnabled}}',
          'borderRadius': {
            'topLeft': 999,
            'topRight': 999,
            'bottomLeft': 999,
            'bottomRight': 999,
          },
        },
      },
      {'type': 'sizedBox', 'width': 8},
      {
        'type': 'image',
        'src': 'assets/icons/ic_info.svg',
        'imageType': 'asset',
        'width': 20,
        'height': 20,
        'color': '{{appColors.current.text.subtitle}}',
      },
    ];

    return {
      'actionType': actionType,
      'backgroundColor': backgroundColor,
      if (!permanent) 'duration': duration,
      'permanent': permanent,
      'permenent': permanent,
      'child': {
        'type': 'container',
        'decoration': {
          'color': '{{appColors.current.background.surfaceContainer}}',
          'borderRadius': {
            'topLeft': 8,
            'topRight': 8,
            'bottomLeft': 8,
            'bottomRight': 8,
          },
          'border': {
            'color': '{{appColors.current.input.borderEnabled}}',
            'width': 1,
          },
        },
        'padding': {'left': 12, 'top': 10, 'right': 12, 'bottom': 10},
        'child': {
          'type': 'row',
          'textDirection': 'ltr',
          'crossAxisAlignment': 'center',
          'children': rowChildren,
        },
      },
    };
  }
}

@Deprecated('Use StacShowBottomSheetAction instead.')
class StacShowMobileBankServicesBottomSheetAction
    extends StacShowBottomSheetAction {
  const StacShowMobileBankServicesBottomSheetAction({
    super.sheet,
    super.title,
    super.items,
    super.isScrollControlled,
    super.useSafeArea,
    super.isDismissible,
    super.enableDrag,
    super.backgroundColor,
    super.barrierColor,
  });

  @override
  String get actionType => 'showMobileBankServicesBottomSheet';
}
