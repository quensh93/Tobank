import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:universal_io/io.dart';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secure_plugin/secure_plugin.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:zoom_id/zoom_id.dart';

import '../../model/card/response/customer_card_response_data.dart';
import '../../model/common/key_alias_model.dart';
import '../../model/common/menu_data_model.dart';
import '../../model/profile/auth_info_data.dart';
import '../../model/promissory/response/promissory_asset_response_data.dart';
import '../../model/wallet/response/wallet_detail_data.dart';
import '../../service/analytics_service.dart';
import '../../service/core/api_core.dart';
import '../../service/wallet_services.dart';
import '../../util/app_util.dart';
import '../../util/constants.dart';
import '../../util/data_constants.dart';
import '../../util/enums_constants.dart';
import '../../util/secure_web_plugin.dart';
import '../../util/storage_util.dart';

class MainController extends GetxController {
  AuthInfoData? authInfoData;
  int shaparakHubOwnerCount = 0;
  int timestampShaparakHubRequest = 0;
  CustomerCard? customerCardPichak;
  WalletDetailData? walletDetailData;
  bool noConnection = false;
  String? latestMenuUpdate;
  int? destinationEKycProvider;
  EKycProvider? appEKycProvider;
  AnalyticsService analyticsService = AnalyticsService();
  bool? autf;
  int? backgroundTimeForRecheckPass;
  String? advertisementText;
  int? creditInquiryPrice;
  String? deviceUuid;
  String appStore = 'unknown';
  String? isIntroSeen;
  PromissoryAssetResponseData? promissoryAssetResponseData;

  bool? hasDeposit = true;

  BuildContext? overlayContext;

  bool? azkiMenu = false;
  DateTime? getToBackgroundAt;
  bool isOpenCheckLoginBottomSheet = false;
  int paymentTimeForRecheckPass = Constants.paymentTimeForRecheckPass;
  bool getToPayment = false;

  bool isCardMainPageControllerInit = false;
  List<KeyAliasModel> keyAliasModelList = [];

  String? userEnglishName;

  bool activatePromissoryPublishPayment = false;
  bool activateLoanFeePayment = false;
  bool activateWalletChargePayment = false;
  bool activateCreditInquiryPayment = false;

  // TODO : edit this when migrate available
  bool get shouldMigrateZoomIdToYekta => appEKycProvider == EKycProvider.zoomId && destinationEKycProvider == 2;

  MenuDataModel menuDataModel = MenuDataModel(
    facilityServices: [],
    tobankServices: [],
    paymentServices: [],
    citizenServices: [],
  );

  bool activateIncreaseDepositBalance = false;

  @override
  Future<void> onInit() async {
    super.onInit();
    _getAppStoreFromEnv();
  }

  Future<void> init() async {
    await Future.wait([
      _getAuthInfoData(),
      _getDeviceUuid(),
      getMenuData(),
      _initIsIntroSeen(),
      _setUserEnglishName(),
    ]);
    await _initKeyAliasModel(authInfoData?.mobile);
  }

  Future<void> _initIsIntroSeen() async {
    isIntroSeen = await StorageUtil.getIsIntroSeen();
  }

  Future<void> getMenuData() async {
    final String? menuDataString = await StorageUtil.getMainMenuSecureStorage();
    //For show local static menu data, set menuDataString=null here
    //menuDataString = null;
    if (menuDataString != null) {
      menuDataModel = MenuDataModel.fromJson(jsonDecode(menuDataString));
    } else {
      menuDataModel = DataConstants.getMenuDataModel();
      update();
      if (authInfoData != null && authInfoData!.token != null) {
        await Sentry.captureMessage(
          'menuDataIsNull',
        );
      }
    }
    if (menuDataModel.facilityServices.isEmpty) {
      menuDataModel.facilityServices = DataConstants.getMenuDataModel().facilityServices;
    }
    menuDataModel.facilityServices.sort((a, b) => a.order!.compareTo(b.order!));
    menuDataModel.paymentServices.sort((a, b) => a.order!.compareTo(b.order!));
    menuDataModel.citizenServices.sort((a, b) => a.order!.compareTo(b.order!));
    menuDataModel.customerClub?.child?.sort((a, b) => a.order!.compareTo(b.order!));
  }

  Future<void> _getDeviceUuid() async {
    deviceUuid = await StorageUtil.getDeviceUuid();
    if (deviceUuid == null) {
      deviceUuid = const Uuid().v4();
      await StorageUtil.setDeviceUuid(deviceUuid!);
    }
  }

  void _getAppStoreFromEnv() {
    appStore = const String.fromEnvironment(
      'Store',
      defaultValue: 'unknown',
    );
  }

  Future<void> setSentryScope() async {
    if (authInfoData != null) {
      if (authInfoData!.uuid != null) {
        Sentry.configureScope(
          (scope) => scope.setUser(SentryUser(
            id: authInfoData!.uuid,
            username: authInfoData!.mobile,
          )),
        );
      } else {
        authInfoData!.uuid = const Uuid().v4();
        update();
        await StorageUtil.setAuthInfoDataSecureStorage(authInfoData!);
        Sentry.configureScope(
          (scope) => scope.setUser(SentryUser(
            id: authInfoData!.uuid,
            username: authInfoData!.mobile,
          )),
        );
      }
    }
  }

  Future<void> _getAuthInfoData() async {
    authInfoData = await StorageUtil.getAuthInfoDataSecureStorage();
  }

  void updateWallet() {
    final String type = Platform.isAndroid ? 'redesign-android' : 'redesign-ios';
    WalletServices.getWalletDetailRequest(type: type).then(
      (result) {
        switch (result) {
          case Success(value: (final WalletDetailData response, int _)):
            walletDetailData = response;
          case Failure(exception: _):
            break;
        }
      },
    );
  }

  Future<void> getAppEkycProvider_() async {
    List<bool> providers;
    //The license of zoom id is not valid for ServerTest version
    // and should not be used for check authentication
    /// todo: add later to pwa (secure plugin)
    // if (AppUtil.isProduction()) {
    //   providers = await Future.wait([_isEnrollZoomId(), isEnrollYekta()]);
    // } else {
    //   providers = await Future.wait([Future.value(false), isEnrollYekta()]);
    // }
    // final isEnrolled = providers.contains(true);
    // if (isEnrolled) {
      if (false) {
      // appEKycProvider = providers[0] ? EKycProvider.zoomId : EKycProvider.yekta;
      appEKycProvider = EKycProvider.yekta;
    } else {
      appEKycProvider = null;
      authInfoData!.virtualBranchStatus = VirtualBranchStatus.notEnrolled;
      await StorageUtil.setAuthInfoDataSecureStorage(authInfoData!);
    }
  }

  Future<void> getAppEkycProvider() async {
    print('💥 Starting getAppEkycProvider process');
    List<bool> providers;

    //The license of zoom id is not valid for ServerTest version
    // and should not be used for check authentication
    if (AppUtil.isProduction()) {
      print('💥 Running in production environment');
      providers = await Future.wait([_isEnrollZoomId(), isEnrollYekta()]);
      print('💥 Providers check complete: ZoomID=${providers[0]}, Yekta=${providers[1]}');
    } else {
      print('💥 Running in test/development environment');
      providers = await Future.wait([Future.value(false), isEnrollYekta()]);
      print('💥 Providers check complete: ZoomID=false (skipped), Yekta=${providers[1]}');
    }

    final isEnrolled = providers.contains(true);
    print('💥 User enrolled in any eKYC provider: $isEnrolled');

    if (isEnrolled) {
      appEKycProvider = providers[0] ? EKycProvider.zoomId : EKycProvider.yekta;
      print('💥 Selected eKYC provider: ${appEKycProvider.toString()}');
    } else {
      appEKycProvider = null;
      print('💥 No eKYC provider available, setting to null');

      authInfoData!.virtualBranchStatus = VirtualBranchStatus.notEnrolled;
      print('💥 Virtual branch status set to: ${authInfoData!.virtualBranchStatus}');

      print('💥 Saving updated auth info to secure storage');
      await StorageUtil.setAuthInfoDataSecureStorage(authInfoData!);
    }
    print('💥 getAppEkycProvider process completed');
  }

  Future<bool> isEnrollYekta() async {
    print("🔴 $kIsWeb");
    return kIsWeb ? await SecureWebPlugin.isEnroll() : (await SecurePlugin.isEnroll(phoneNumber: keyAliasModelList.first.keyAlias)).isSuccess ?? false;
  }

  Future<bool> _isEnrollZoomId() async {
    bool isEnrolled = false;
    if (Platform.isAndroid ) {
      isEnrolled = await ZoomId.checkRoll(
        license: authInfoData!.zoomIdLicenseAndroid ?? Constants.zoomIdLicense,
        phone: authInfoData!.mobile!,
        nationalId: authInfoData!.nationalCode!,
      );
    } else {
      isEnrolled = await ZoomId.isLoginIos(authInfoData!.mobile!);
    }
    return isEnrolled;
  }

  bool isCustomerHasFullAccess() {
    final bool isCustomerEnable = authInfoData!.shabahangCustomerStatus == 1;
    final bool isCustomerHasShahabCode = authInfoData!.customerNumber != null &&
        authInfoData!.shahabCodeAcquired != null &&
        authInfoData!.shahabCodeAcquired!.toLowerCase() == 'true';

    print("🔴 virtualBranchStatus : ${authInfoData!.virtualBranchStatus.toString()}");
    print("🔴 isCustomerHasShahabCode : ${isCustomerHasShahabCode}");
    print("🔴 isCustomerEnable : ${isCustomerEnable}");
    return authInfoData!.virtualBranchStatus == VirtualBranchStatus.registered &&
        isCustomerHasShahabCode &&
        isCustomerEnable;
  }

  bool hasCustomerNumber() {
    //return true;
    return authInfoData!.customerNumber != null;
  }

  Future<void> _initKeyAliasModel(String? phoneNumber) async {
    if (phoneNumber != null) {
      keyAliasModelList = await StorageUtil.getKeyAliasModel();
      if (keyAliasModelList.isEmpty) {
        keyAliasModelList.add(KeyAliasModel(keyAlias: phoneNumber, timestamp: DateTime.now().millisecondsSinceEpoch));
        await StorageUtil.setKeyAliasModel(keyAliasModelList);
      }
    }
  }

  Future<void> _setUserEnglishName() async {
    userEnglishName = await StorageUtil.getAuthenticateUserEnglishName();
    if (userEnglishName == null) {
      final certificate = await StorageUtil.getAuthenticateCertificateModel();
      if (certificate != null) {
        final String certPem = '${X509Utils.BEGIN_CERT}\n$certificate\n${X509Utils.END_CERT}';
        final cert = X509Utils.x509CertificateFromPem(certPem);
        userEnglishName = cert.tbsCertificate!.subject['2.5.4.3']!.replaceAll('[Mobile Sign]', '').trim();
        await StorageUtil.setAuthenticateUserEnglishName(userEnglishName);
      }
    }
  }
}
