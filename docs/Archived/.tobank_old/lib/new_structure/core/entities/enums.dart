import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../util/app_theme.dart';
import '../../../widget/svg/svg_icon.dart';

//locale
final locale = AppLocalizations.of(Get.context!)!;

enum ChargeAndPackageType {
  CHARGE,
  INTERNET;

  String toJson() => name;

  static ChargeAndPackageType fromJson(String json) => values.byName(json);
}

extension ChargeAndPackageTypeString on ChargeAndPackageType {
  String getString(BuildContext context) {
    final List<String> strings = <String>[locale.charge, locale.internet];
    return strings[index];
  }
}

enum ChargeServiceType {
  charge,
  internet,
  installment;

  String toJson() => name;

  static ChargeServiceType fromJson(String json) => values.byName(json);
}

extension ChargeServiceTypeString on ChargeServiceType {
  String getString(BuildContext context) {
    final List<String> strings = <String>[
      'charge',
      'internet',
      'installment',
    ];
    return strings[index];
  }
}

enum ChargeAndPackageTagType {
  NORMAL,
  AMAZING,
  WOW,
  SNS,
  YOUTH,
  WOMEN,
  GENERAL,
  NEW_COSTUMERS,
  OPTIONARY,
  OTHER;

  String toJson() => name;
  static ChargeAndPackageTagType fromJson(String json) => values.byName(json);
  static bool isExist(String json) {
    bool isExist = false;
    for (final e in values) {
      if (e.toJson() == json) {
        isExist = true;
      }
    }
    return isExist;
  }
}

extension ChargeAndPackageTagTypeString on ChargeAndPackageTagType {
  String getString(BuildContext context) {
    final List<String> strings = <String>[
      'NORMAL',
      locale.amazing,
      locale.wow,
      'SNS',
      'YOUTH',
      'WOMEN',
      'GENERAL',
      'NEW_COSTUMERS',
      'OPTIONARY',
      'OTHER',
    ];
    return strings[index];
  }
}

enum PackageType {
  DAILY,
  WEEKLY,
  MONTHLY,
  OTHERS;

  String toJson() => name;

  static PackageType fromJson(String json) => values.byName(json);

  static bool isExist(String json) {
    bool isExist = false;
    for (final e in values) {
      if (e.toJson() == json) {
        isExist = true;
      }
    }
    return isExist;
  }
}

extension PackageTypeString on PackageType {
  String getString(BuildContext context) {
    final List<String> strings = <String>[
      locale.daily,
      locale.weekly,
      locale.monthly,
      locale.others_,
    ];
    return strings[index];
  }
}

enum OperatorType {
  MCI,
  MTN,
  RIGHTEL;

  String toJson() => name;

  static OperatorType fromJson(String json) => values.byName(json);
}

extension OperatorTypeString on OperatorType {
  ChargeAndPackageTagType getTagTypeByOperatorType(BuildContext context) {
    if (index == 0) {
      return ChargeAndPackageTagType.AMAZING;
    } else if (index == 1) {
      return ChargeAndPackageTagType.WOW;
    } else if (index == 2) {
      return ChargeAndPackageTagType.SNS;
    } else {
      return ChargeAndPackageTagType.AMAZING;
    }
  }

  String getString(BuildContext context) {
    final List<String> strings = <String>[
      locale.mci_fa,
      locale.iran_cell,
      locale.rightel_fa,
    ];
    return strings[index];
  }

  // String getAmazing(BuildContext context) {
  //   final List<String> strings = <String>[
  //     locale.amazing,
  //     locale.wow,
  //     locale.SNS,
  //   ];
  //   return strings[index];
  // }

  SvgIcons getIcon(BuildContext context) {
    final List<SvgIcons> strings = <SvgIcons>[
      SvgIcons.icHamrahAval,
      SvgIcons.icIrancell,
      SvgIcons.icRightel,
    ];
    return strings[index];
  }
}

enum SimType {
  PREPAID,
  PERMANENT;

  String toJson() => name;

  static SimType fromJson(String json) => values.byName(json);
}

extension SimTypeString on SimType {
  String getString(BuildContext context) {
    final List<String> strings = <String>[locale.credit, locale.permanent];
    return strings[index];
  }
}

enum PaymentListType {
  myselfLoan,
  othersLoan,
  charge,
  package;

  String toJson() => name;

  static PaymentListType fromJson(String json) => values.byName(json);
}

extension PaymentListTypeString on PaymentListType {
  ChargeServiceType getServiceByPaymentListType(BuildContext context) {
    if (index == 0) {
      return ChargeServiceType.installment;
    } else if (index == 1) {
      return ChargeServiceType.installment;
    } else if (index == 2) {
      return ChargeServiceType.charge;
    } else if (index == 3) {
      return ChargeServiceType.internet;
    } else {
      return ChargeServiceType.installment;
    }
  }

  String getString(BuildContext context) {
    final List<String> strings = <String>[
      locale.pay_loans,
      locale.pay_others_loan,
      locale.charge,
      locale.package,
    ];
    return strings[index];
  }
}

enum DestinationType {
  deposit,
  wallet;

  String toJson() => name;

  static DestinationType fromJson(String json) => values.byName(json);
}

extension DestinationTypeString on DestinationType {
  String getString(BuildContext context) {
    final List<String> strings = <String>[
      locale.account,
      locale.wallet,
    ];
    return strings[index];
  }
}

enum ReceiptType {
  success,
  fail,
  unknown;

  String toJson() => name;

  static ReceiptType fromJson(String json) => values.byName(json);
}

extension ReceiptTypeString on ReceiptType {
  SvgIcons getIcon(BuildContext context) {
    final List<SvgIcons> strings = <SvgIcons>[
      SvgIcons.transactionSuccess,
      SvgIcons.transactionFailed,
      SvgIcons.transactionPending,
    ];
    return strings[index];
  }

  Color getColor(BuildContext context) {
    final List<Color> strings = <Color>[
      AppTheme.successColor,
      AppTheme.failColor,
      AppTheme.warningColor,
    ];
    return strings[index];
  }

  String getString(BuildContext context) {
    final List<String> strings = <String>[
      locale.payment_successful,
      locale.payment_unsuccessful,
      locale.unknown_error,
    ];
    return strings[index];
  }
}

enum PaymentType {
  desiredAmount,
  loanSettlement,
  installmentPayment;

  String toJson() => name;

  static PaymentType fromJson(String json) => values.byName(json);
}

extension PaymentTypeString on PaymentType {
  String getString(BuildContext context) {
    final List<String> strings = <String>[
      locale.desired_value,
      locale.loan_settlement,
      locale.pay_loan,
    ];
    return strings[index];
  }
}
