import 'dart:convert';
import 'package:universal_io/io.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../model/common/key_alias_model.dart';
import '../model/profile/auth_info_data.dart';
import '../model/register/response/authorized_api_token_response_data.dart';
import 'app_util.dart';
import 'authentication_constants.dart';
import 'constants.dart';
import 'shared_preferences_util.dart';

class StorageUtil {
  static FlutterSecureStorage storage = const FlutterSecureStorage();
  static GetStorage box = GetStorage();

  StorageUtil._();

  static Future<void> initSecureStorage() async {
    if (Platform.isIOS) {
      final isIOSDeviceInitialized = SharedPreferencesUtil().getBool(Constants.isIOSDeviceInitialized);
      if (isIOSDeviceInitialized != true) {
        Sentry.captureMessage('Cleaned iOS Storage', params: [
          {'isIOSDeviceInitialized': isIOSDeviceInitialized}
        ]);
        await StorageUtil.reset();
        await SharedPreferencesUtil().setBool(Constants.isIOSDeviceInitialized, true);
      }
    }

    final AuthInfoData? authInfoDataSecure = await SharedPreferencesUtil().getAuthInfoSecureBackup();
    if (authInfoDataSecure != null) {
      await storage.write(key: Constants.authInfoSecureStorage, value: jsonEncode(authInfoDataSecure.toJson()));
      await SharedPreferencesUtil().remove(Constants.authInfoSecure);
    }
    final String? menuDataString = box.read(Constants.mainMenuStoredData);
    if (menuDataString != null) {
      await setMainMenuSecureStorage(menuDataString);
      box.remove(Constants.mainMenuStoredData);
    }
    final String? latestMenuUpdate = box.read(Constants.latestMenuUpdate);
    if (latestMenuUpdate != null) {
      await setLatestMenuUpdateSecureStorage(latestMenuUpdate);
      box.remove(Constants.latestMenuUpdate);
    }
    final String? storedContacts = box.read(Constants.storedContacts);
    if (storedContacts != null) {
      await setStoredContactsSecureStorage(storedContacts);
      box.remove(Constants.storedContacts);
    }
    final String? certificate = box.read(AuthenticationConstants.authenticateCertificateModel);
    if (certificate != null) {
      await setAuthenticateCertificateModel(certificate);
      box.remove(AuthenticationConstants.authenticateCertificateModel);
    }
    final String? base64UserSignatureImage = box.read(AuthenticationConstants.base64UserSignatureImage);
    if (base64UserSignatureImage != null) {
      await setBase64UserSignatureImage(base64UserSignatureImage);
      box.remove(AuthenticationConstants.base64UserSignatureImage);
    }
    final String? listShaparakHubStringEncrypted = box.read(Constants.shaparakHubStoredData);
    if (listShaparakHubStringEncrypted != null) {
      final String shaparakHubSecureStorage = AppUtil.decryptWithAES(listShaparakHubStringEncrypted);
      await setShaparakHubSecureStorage(shaparakHubSecureStorage);
      box.remove(Constants.shaparakHubStoredData);
    }

    final String? automaticDynamicPinStoredDataString =
        SharedPreferencesUtil().getString(Constants.automaticDynamicPinStoredData);
    if (automaticDynamicPinStoredDataString != null) {
      await setAutomaticDynamicPinStored(automaticDynamicPinStoredDataString);
      SharedPreferencesUtil().remove(Constants.automaticDynamicPinStoredData);
    }
    final String? encryptionKeyPair = SharedPreferencesUtil().getString(Constants.encryptionKeyPair);
    if (encryptionKeyPair != null) {
      await setEncryptionKeyPair(encryptionKeyPair);
      SharedPreferencesUtil().remove(Constants.encryptionKeyPair);
    }

    final String? password = SharedPreferencesUtil().getString(Constants.password);
    if (password != null) {
      await setPassword(password);
      SharedPreferencesUtil().remove(Constants.password);
    }
  }

  static Future<void> reset() async {
    await storage.deleteAll();
    await box.erase();
  }

  static Future<AuthInfoData?> getAuthInfoDataSecureStorage() async {
    final String? value = await storage.read(key: Constants.authInfoSecureStorage);
    if (value != null) {
      return authInfoFromJson(value);
    } else {
      return null;
    }
  }

  static Future<void> setAuthInfoDataSecureStorage(AuthInfoData authInfoData) async {
    await storage.write(key: Constants.authInfoSecureStorage, value: jsonEncode(authInfoData.toJson()));
  }

  static Future<String?> getMainMenuSecureStorage() async {
    return await storage.read(key: Constants.mainRedesignMenuSecureStorage);
  }

  static Future<void> setMainMenuSecureStorage(String menuDataString) async {
    await storage.write(key: Constants.mainRedesignMenuSecureStorage, value: menuDataString);
  }

  static Future<String?> getLatestMenuUpdateSecureStorage() async {
    return await storage.read(key: Constants.latestMenuUpdateSecureStorage);
  }

  static Future<void> setLatestMenuUpdateSecureStorage(String? latestMenuUpdate) async {
    await storage.write(key: Constants.latestMenuUpdateSecureStorage, value: latestMenuUpdate);
  }

  static Future<String?> getStoredContactsSecureStorage() async {
    return await storage.read(key: Constants.storedContactsSecureStorage);
  }

  static Future<void> setStoredContactsSecureStorage(String? storedContacts) async {
    await storage.write(key: Constants.storedContactsSecureStorage, value: storedContacts);
  }

  static Future<String?> getAuthenticateCertificateModel() async {
    return await storage.read(key: AuthenticationConstants.authenticateCertificateModelSecureStorage);
  }

  static Future<void> setAuthenticateCertificateModel(String? certificate) async {
    await storage.write(key: AuthenticationConstants.authenticateCertificateModelSecureStorage, value: certificate);
  }

  static Future<void> deleteAuthenticateCertificateModel() async {
    await storage.delete(key: AuthenticationConstants.authenticateCertificateModelSecureStorage);
  }

  static Future<String?> getBase64UserSignatureImage() async {
    return await storage.read(key: AuthenticationConstants.base64UserSignatureImageSecureStorage);
  }

  static Future<void> setBase64UserSignatureImage(String? base64UserSignatureImage) async {
    await storage.write(
        key: AuthenticationConstants.base64UserSignatureImageSecureStorage, value: base64UserSignatureImage);
  }

  static Future<String?> getAuthenticateUserEnglishName() async {
    return await storage.read(key: AuthenticationConstants.userEnNameSecureStorage);
  }

  static Future<void> setAuthenticateUserEnglishName(String? englishName) async {
    await storage.write(key: AuthenticationConstants.userEnNameSecureStorage, value: englishName);
  }

  static Future<String?> getShaparakHubSecureStorage() async {
    return await storage.read(key: Constants.shaparakHubSecureStorage);
  }

  static Future<void> setShaparakHubSecureStorage(String? shaparakHubSecureStorage) async {
    await storage.write(key: Constants.shaparakHubSecureStorage, value: shaparakHubSecureStorage);
  }

  static Future<void> deleteShaparakHubSecureStorage() async {
    await storage.delete(
      key: Constants.shaparakHubSecureStorage,
    );
  }

  static Future<void> setAutomaticDynamicPinStored(String? automaticDynamicPinStoredString) async {
    await storage.write(key: Constants.automaticDynamicPinSecureStorage, value: automaticDynamicPinStoredString);
  }

  static Future<String?> getAutomaticDynamicPinStored() async {
    return await storage.read(
      key: Constants.automaticDynamicPinSecureStorage,
    );
  }

  static Future<void> setCardToCardGardeshgaryGuideSeen(bool isSeen) async {
    await storage.write(key: Constants.cardToCardGardeshgaryGuideSecureStorage, value: isSeen.toString());
  }

  static Future<bool> getCardToCardGardeshgaryGuideSeen() async {
    return await storage.read(key: Constants.cardToCardGardeshgaryGuideSecureStorage) == 'true';
  }

  static Future<void> setEncryptionKeyPair(String? encryptionKeyPairString) async {
    await storage.write(key: Constants.encryptionKeyPairSecureStorage, value: encryptionKeyPairString);
  }

  static Future<String?> getEncryptionKeyPair() async {
    return await storage.read(
      key: Constants.encryptionKeyPairSecureStorage,
    );
  }

  static Future<void> removeCustomerKeyPair() async {
    await storage.delete(key: Constants.encryptionKeyPairSecureStorage);
  }

  static Future<void> setPassword(String password) async {
    await storage.write(key: Constants.passwordSecureStorage, value: password);
  }

  static Future<String?> getPassword() async {
    return await storage.read(key: Constants.passwordSecureStorage);
  }

  static Future<void> setDeviceUuid(String deviceUuid) async {
    await storage.write(key: Constants.deviceUuid, value: deviceUuid);
  }

  static Future<String?> getDeviceUuid() async {
    return await storage.read(key: Constants.deviceUuid);
  }

  static Future<void> setIsIntroSeen(String isIntroSeen) async {
    await storage.write(key: Constants.isIntroSeen, value: isIntroSeen);
  }

  static Future<String?> getIsIntroSeen() async {
    return await storage.read(key: Constants.isIntroSeen);
  }

  static Future<void> setShouldUseYektaEkyc(String shouldUseYekta) async {
    await storage.write(key: Constants.shouldUseYektaEkyc, value: shouldUseYekta);
  }

  static Future<String?> getShouldUseYektaEkyc() async {
    return await storage.read(key: Constants.shouldUseYektaEkyc);
  }

  static String? getThemeCode() {
    return box.read(Constants.themeCode);
  }

  static void setThemeCode({required String themeCode}) {
    box.write(Constants.themeCode, themeCode);
  }

  static Future<void> setGoftinoInitialized(bool isInitialized) async {
    await storage.write(key: Constants.goftinoInitialized, value: isInitialized.toString());
  }

  static Future<bool> getGoftinoInitialized() async {
    return await storage.read(key: Constants.goftinoInitialized) == 'true';
  }

  static Future<bool?> getShowCBSIntroduction() async {
    return await storage.read(key: Constants.showCBSIntroduction) != 'false';
  }

  static Future<void> setShowCBSIntroduction(bool? showIntroduction) async {
    await storage.write(key: Constants.showCBSIntroduction, value: showIntroduction.toString());
  }

  static Future<void> setDisableShowAppReview() async {
    await storage.write(key: Constants.disableShowAppReview, value: true.toString());
  }

  static Future<bool> isShowAppReviewDisabled() async {
    return await storage.read(key: Constants.disableShowAppReview) == 'true';
  }

  static Future<void> setEkycPreRegistrationModel(AuthorizedApiTokenResponse authorizedApiTokenResponse) async {
    await storage.write(
        key: Constants.ekycPreRegistrationModel, value: jsonEncode(authorizedApiTokenResponse.toJson()));
  }

  static Future<AuthorizedApiTokenResponse?> getEkycPreRegistrationModel() async {
    final String? value = await storage.read(key: Constants.ekycPreRegistrationModel);
    if (value != null) {
      return authorizedApiTokenResponseFromJson(value);
    } else {
      return null;
    }
  }

  static Future<void> removeEkycPreRegistrationModel() async {
    await storage.delete(key: Constants.encryptionKeyPairSecureStorage);
  }

  static Future<void> setKeyAliasModel(List<KeyAliasModel> keyAliasModelList) async {
    await storage.write(key: Constants.keyAliasModel, value: keyAliasModelToJson(keyAliasModelList));
  }

  static Future<List<KeyAliasModel>> getKeyAliasModel() async {
    final String? result = await storage.read(key: Constants.keyAliasModel);
    if (result != null) {
      return keyAliasModelFromJson(result);
    } else {
      return [];
    }
  }

  /// todo: add later to pwa
  static Future<void> setEncryptionWebKeyPair(String? encryptionKeyPairString) async {
    await storage.write(key: Constants.encryptionWebKeyPairSecureStorage, value: encryptionKeyPairString);
  }

  /// todo: add later to pwa
  static Future<String?> getEncryptionWebKeyPair() async {
    return await storage.read(
      key: Constants.encryptionWebKeyPairSecureStorage,
    );
  }

  /// todo: add later to pwa
  static Future<void> removeEncryptionWebKeyPair() async {
    await storage.delete(key: Constants.encryptionWebKeyPairSecureStorage);
  }
}
