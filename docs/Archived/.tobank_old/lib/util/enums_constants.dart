import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'app_util.dart';
import 'package:gardeshpay_app/flutter_gen/gen_l10n/app_localizations.dart';
enum PaymentType { wallet, gateway, deposit }

enum OperationType { insert, update }

enum GiftCardScreenType { buy, show }

enum ReportPageType { cardBoard, process }

enum CardStatus { open, close }

enum Gender { male, female }

enum InvoiceScreenType { list, check }

enum InvoiceType { type_1, type_2, type_3, type_4 }

enum TourismServiceType { type_1, type_2 }

enum TransactionStatus { success, failed }

enum TransactionFilterType { wallet, all, tourism }

enum CheckTransferStatus { accept, deny }

enum PermissionType { camera, contacts, storage }

enum NotificationType { update, normal }

enum MobileTermType { midTerm, finalTerm }

enum CustomerClubPointType { listPayPoint, listReceivePoint }

enum CustomerClubMainType { points, codes }

enum FreewayType { list, check }

enum InvestmentFundOrderType { all, issuance, cancel }

enum InvestmentFundIssuanceType { issuance, list }

enum InvestmentFundCancelType { cancel, list }

enum HelperType {
  frontNationalCard,
  backNationalCard,
  birthCertificateMainPages,
  birthCertificateCommentsPages,
  signature,
  personalImage,
  personalVideo;

  String get url {
    switch (this) {
      case HelperType.frontNationalCard:
        return 'https://tobank.ir/app/national-card-front-template';
      case HelperType.backNationalCard:
        return 'https://tobank.ir/app/national-card-back-template';
      case HelperType.birthCertificateMainPages:
        return 'https://tobank.ir/app/birth-certificate-main-template';
      case HelperType.birthCertificateCommentsPages:
        return 'https://tobank.ir/app/birth-certificate-comments-template';
      case HelperType.signature:
        return 'https://tobank.ir/app/signature-template';
      case HelperType.personalImage:
        return 'https://tobank.ir/app/personal-image-template';
      case HelperType.personalVideo:
        return 'https://tobank.ir/app/personal-video-template';
    }
  }

  String get title {//locale
    final locale = AppLocalizations.of(Get.context!)!;
    switch (this) {
      case HelperType.frontNationalCard:
        return locale.front_national_card_guide;
      case HelperType.backNationalCard:
        return locale.back_national_card_guide;
      case HelperType.birthCertificateMainPages:
        return locale.birth_certificate_main_pages_guide;
      case HelperType.birthCertificateCommentsPages:
        return locale.birth_certificate_comments_pages_guide;
      case HelperType.signature:
        return locale.signature_guide;
      case HelperType.personalImage:
        return locale.personal_image_guide;
      case HelperType.personalVideo:
        return locale.personal_video_guide;
    }
  }
}

enum HelperTypeSample {
  frontNationalCard,
  backNationalCard,
  birthCertificateFirstPages,
  birthCertificateFirstOldPages,
  birthCertificateSecondPages,
  birthCertificateSecondOldPages,
  personalImage,
  personalVideo;

  String get url {
    switch (this) {
      case HelperTypeSample.frontNationalCard:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/front_national_card_sample.png';
      case HelperTypeSample.backNationalCard:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/back_national_card_sample.png';
      case HelperTypeSample.birthCertificateFirstPages:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/birth_certificate_first_sample.png';
      case HelperTypeSample.birthCertificateSecondPages:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/birth_certificate_second_page_sample.png';
      case HelperTypeSample.birthCertificateFirstOldPages:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/birth_certificate_first_old_sample.png';
      case HelperTypeSample.birthCertificateSecondOldPages:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/birth_certificate_second_old_sample.png';
      case HelperTypeSample.personalImage:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/personal_picture_sample.png';
      case HelperTypeSample.personalVideo:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/face_movement_video.mp4';
    }
  }
}

enum HelperVoiceType {
  addressPage,
  birthCertificateMain,
  birthCertificateComments,
  certificatePage,
  signaturePage,
  nationalCardFront,
  nationalCardBack,
  personalPhotoVideoCardSerial,
  personalPhotoVideoReceiptSerial,
  personalPhotoCamera,
  personalVideoCamera;

  String get assetUrl {
    switch (this) {
      case HelperVoiceType.addressPage:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/address_page.mp3';
      case HelperVoiceType.birthCertificateMain:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/birth_certificate_main.mp3';
      case HelperVoiceType.birthCertificateComments:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/birth_certificate_comments.mp3';
      case HelperVoiceType.certificatePage:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/certificate_page.mp3';
      case HelperVoiceType.signaturePage:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/signature_page.mp3';
      case HelperVoiceType.nationalCardFront:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/national_card_front.mp3';
      case HelperVoiceType.nationalCardBack:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/national_card_back.mp3';
      case HelperVoiceType.personalPhotoVideoCardSerial:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/personal_photo_video_card_serial.mp3';
      case HelperVoiceType.personalPhotoVideoReceiptSerial:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/personal_photo_video_receipt_serial.mp3';
      case HelperVoiceType.personalPhotoCamera:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/personal_photo_camera.mp3';
      case HelperVoiceType.personalVideoCamera:
        return '${AppUtil.baseUrlStatic()}/media/ekyc/personal_video_camera.mp3';
    }
  }
}

enum EKycProvider { zoomId, yekta }

enum VirtualBranchStatus {
  notEnrolled, // need enroll
  enrolled, // need register
  registered, // register completed
  updatePublicKey // need update public key (no need, use for compatibility)
}

enum CardToCardPageType { cardToCard, list }

enum TransferPageType { transfer, list }

enum InvestmentFundTransactionType { all, buy, sale, profit }

enum PromissoryDetailType { detail, transfer, guarantee, settlements }

enum PromissoryMenuType {
  promissoryServices,
  myPromissory,
}

enum PromissoryStateType {
  published('F'),
  partialSettled('G'),
  settled('S'),
  demanded('D'),
  canceled('C');

  final String jsonValue;

  const PromissoryStateType(this.jsonValue);

  static PromissoryStateType? fromJsonValue(String jsonValue) {
    for (final PromissoryStateType type in PromissoryStateType.values) {
      if (type.jsonValue == jsonValue) {
        return type;
      }
    }
    return null;
  }
}

enum PromissoryCustomerType {
  individual('I'),
  company('C');

  final String jsonValue;

  const PromissoryCustomerType(this.jsonValue);

  static PromissoryCustomerType? fromJsonValue(String jsonValue) {
    for (final PromissoryCustomerType type in PromissoryCustomerType.values) {
      if (type.jsonValue == jsonValue) {
        return type;
      }
    }
    return null;
  }
}

enum PromissoryRoleType {
  issuer('issuer'),
  guarantor('guarantor'),
  previousOwner('previous owner'),
  currentOwner('current owner');

  final String jsonValue;

  const PromissoryRoleType(this.jsonValue);

  static PromissoryRoleType? fromJsonValue(String jsonValue) {
    for (final PromissoryRoleType type in PromissoryRoleType.values) {
      if (type.jsonValue == jsonValue) {
        return type;
      }
    }
    return null;
  }
}

enum PromissoryDocType {
  publish('P'),
  endorsement('E'),
  guarantee('G'),
  settlement('S'),
  gradualSettlement('GR');

  final String jsonValue;

  const PromissoryDocType(this.jsonValue);

  static PromissoryDocType? fromJsonValue(String jsonValue) {
    for (final PromissoryDocType type in PromissoryDocType.values) {
      if (type.jsonValue == jsonValue) {
        return type;
      }
    }
    return null;
  }
}

enum CBSMenuType {
  cbsServices,
  cbsReports,
}

enum TransactionType { tobank, deposit }

enum TransferTypeEnum { iban, deposit, card }

enum AppReviewState { yes, no, later }

enum LauncherState { loading, update, login }

enum MapMarkerType { atm, branch }

enum ModernBankingActivationType {
  internet,
  mobile,
}

enum DestinationType { iban, deposit, card }

enum RequestStatusFilter { open, close, all }

enum DepositTransactionFilterType { byTime, latest10 }

enum CertificateCheckType { login, dashboard }
