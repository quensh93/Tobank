class Constants {
  Constants._();

  //static const String baseUrlStatic = 'https://appapi-stage.tobank.ir/api/v1.0';

  //static const String baseUrl = 'https://appapi-stage.tobank.ir/api/';
  // static const String baseUrlSSLFingerprint = 'b118a786f6cdd300ed3519cb9a2183a81dc966924aeb8f7014f74c6a9bf5e25d';
  //static const String baseUrlSSLFingerprint = '3b878a917307c4330fe090276d1adfc62559dba52ea86b8ac743949db15e911b';

  //------------------------------------------------------------------
  //static const String devBaseStaticUrl = 'https://appapi-stage.tobank.ir/api/v1.0';

  //static const String devBaseUrl = 'https://appapi-stage.tobank.ir/api/';
  // static const String devBaseUrlSSLFingerprint = '96374b9f6cdbcf1dd251bca6eed780ecfc227e701b3351db52fe8a27d6557d3b';
  //static const String devBaseUrlSSLFingerprint = '3b878a917307c4330fe090276d1adfc62559dba52ea86b8ac743949db15e911b';

  //------------------------------------------------------------------
  static const String token = 'token';
  static const String authInfo = 'auth-info';
  static const String authInfoSecure = 'secure-auth-info';
  static const String fingerPrint = 'finger-print';

  //static const String PASS_CODE_STATUS = 'passcode-status';
  static const String passCode = 'password-code';
  static const String timeToRequest = 'time-to-request';
  static const int timeOutSeconds = 60;

  //static const String shaparakHubBaseUrl = 'https://tsm.shaparak.ir/';

  static const int authenticationMethod = 1;
  static const String shaparakHubStoredData = 'shaparak-hub-stored-data';
  static const String automaticDynamicPinStoredData = 'automatic-dynamic-pin-stored-data';

  static const String aesKey = 'pCEcEGuGw2wn0cvW';
  static const String aesIV = 'BmFi50usZmFAQOVq';

  static const String password = 'password';

  static const String storeShaparakPayment = 'store-shaparak-payment';
  static const int halfHourMS = 1800000;
  static const int amountLength = 14;

  static const int passTimeOut = 5 * 60 * 1000;
  static const int paymentTimeForRecheckPass = 60 * 10;

  static const double nationalCardMaxSize = 512000;
  static const double birthCertificateMaxSize = 819200;
  static const double personalImageMaxSize = 819200;
  static const double signatureMinSize = 1200;
  static const double customerDocumentMaxSize = 200000;

  static const int fileSize400 = 400000;
  static const int fileSize200 = 200000;

  static const int width1000 = 1000;
  static const int height1000 = 1000;
  static const int width700 = 700;
  static const int height700 = 700;
  static const int compressQuality80 = 80;
  static const int compressQuality100 = 100;

  static const int postalCodeLength = 10;
  static const int nationalCodeLength = 10;
  static const int companyNationalCodeLength = 11;
  static const int mobileNumberLength = 11;
  static const int phoneNumberLength = 11;
  static const int trackingCodeLength = 10;
  static const int cardNumberLength = 16;
  static const int cardNumberWithDashLength = 19;
  static const int chequeIdLength = 16;
  static const int ibanLength = 24;
  static const int otpLength = 5;

  static const String mobileStartingDigits = '09';
  static const String iranCountryCode = '+98';

  static const int milliseconds100 = 100;
  static const int milliseconds200 = 200;
  static const int milliseconds300 = 300;
  static const int milliseconds500 = 500;
  static const Duration duration100 = Duration(milliseconds: milliseconds100);
  static const Duration duration200 = Duration(milliseconds: milliseconds200);
  static const Duration duration300 = Duration(milliseconds: milliseconds300);
  static const Duration duration500 = Duration(milliseconds: milliseconds500);

  static const int minValidAmount = 10000;
  static const int minValidDepositAmount = 10000000;
  static const int minReasonValidationChequeAmount = 1000000000;
  static const int minValidPromissoryAmount = 20000000;

  static const String iranConcertUrl = 'https://www.iranconcert.com/link/go/25';
  static const String honarTicketUrl = 'https://www.honarticket.com/ali.gh2';

  static const String acceptorAuthInfo = 'acceptor-auth-info';
  static const String storedContacts = 'stored-contact';

  static const String themeCode = 'theme-code';
  static const String crispBaseUrl = 'https://go.crisp.chat';

  //static const String pardakhtsaziBaseUrl = 'https://api.pardakhtsazi.ir/';
  static const String mainMenuStoredData = 'main-menu-stored-data';

  static const String latestMenuUpdate = 'latest-menu-update';

  static const String defaultCardRequest = 'default-card-request';

  static const String isEnrollKey = 'is-enroll-key';

  static const String authInfoSecureStorage = 'auth-info-secure-storage';
  static const String mainRedesignMenuSecureStorage = 'main-redesign-menu-secure-storage';
  static const String latestMenuUpdateSecureStorage = 'latest-menu-update-secure-storage';
  static const String storedContactsSecureStorage = 'stored-contact-secure-storage';

  static const String shaparakHubSecureStorage = 'shaparak-hub-secure-storage';

  static const String automaticDynamicPinSecureStorage = 'automatic-dynamic-pin-secure-storage';

  static const String cardToCardGardeshgaryGuideSecureStorage = 'card-to-card-gardeshgary-guide-secure-storage';

  static const String passwordSecureStorage = 'password-secure-storage';

  static const List<String> signatureHash = ['TpNH1d02/qUR6bK0u/lEqOhdXBc=', 'JLXJMM1Dwn3fqpqQKpc7KwaxIls='];

  static const String isIOSDeviceInitialized = 'is-ios-device-initialized';

  static const String deviceUuid = 'device-uuid';

  static const String isIntroSeen = 'is-intro-seen';

  static const List<int> citizenServiceIds = [78, 79, 81, 82];
  static const List<int> topServiceIds = [73, 74, 75, 77, 80];

  static var goftinoInitialized = 'goftino-initialized';

  static const String showCBSIntroduction = 'show-cbs-introduction';

  static const String disableShowAppReview = 'disable-show-app-review';

  static const double cardHeightFactor = 0.6;

  static const String userInfoModel = 'user-info-model';

  static const String encryptionKeyPair = 'encryption-key-pair';

  static const String shouldUseYektaEkyc = 'should-use-yekta-ekyc';

  static const String zoomIdLicense =
      'Xycwf3WUfdu5fD59zxmgY/ibuUxYGbpB9mLUA64ICOjEovdNY0FECWjuflJwj0baJvatBXicaNLuUmRgpbk133hJCrigwm0HZn67ORyd9vTKjy30u97xUYmaVd99bXMVDCS+XdztYSfeEEvjK3VwkkRd4RihKR4qnZ/JAUKYn8L6bBLk4COeCiXsujeEgDM5GKPJk6pNgXq/4J3ilWARXRf63zfZakBuPmhNV3cEC/PqXFbATG44eS34CvSeoq2/B9vnIV0Wr7CD63JIBf4HRPpWGjqiw9ZMV2ejXJi1Wzk16EwBwlgYR9f3g+1VoWKy2SZhEekT7adZrsD5BxULB2xpAAy+qjHmbtNJv/Nrzcu34/gOWU5xCOVFBUFFYkQvlOXk3FehZl6NrDyNcI1Mbx4yOpr5Cwt+qh6LeJIXZgWZLl2+rdcrWnOAI77T00LQ2tYDytpI+H2ltFCk9B5O8BtztVncJezieTiJDPg2tptl1hOC8BMP6FsoXb0uT5ZzdL3iQkqngXIiNRRJ8jT6Vo7Up/qGzPDA1g6kFlR+Ah8jxgZLRT3XNEQv85ipQBzP:U4hAPD1nXjk7R15hcZHEzVlXw4A7DUhsDr9b/JTWpUPc/jEDIUFuy3TmSA2UxurvlmZlw9UQF4IQlrFGt4UogeT4o6wUTMUqRF/C8STpmye70OCSRwRnAWUDuPzgA8Blt3inKzM6nGFJirtV0OjHCDjvGZzAmiigI9qGuO48f/s=';

  static const String zoomIdLicenseIos =
      'BEQ806uX6f3wBwdV2TOHPQPE9SQDLCmf9Bm7e8Qx7ZDsME6HzwT72ewHIJRz+RcoHmT6dS8iFDLoPyBmVwh1H6aF96JOJ0nBzxNHI+3haoj/Z827qWlJk2yYF4PZIPg7x7JscooW8ezW29ZI3cVc/jzHIOmWgYw6wuiIM1ksYRQt3QdUoY0NHI7ip4sl7vRD9aQcsxojE+EZXKVK6XF5nYACgIz7IDjqOSOq5NZeNWxU8qzAqE4CwZD+aeT0xLSLkkrL2rZJOgTm8LtmQw89jBm4oc++MKooy3cNh3E0WXFilcdnj/mKZorQWuT9X+pamUijs7366JVak/DxoTuYM4A1XMmQgbWWY3YaohxKiAO2kOS4zzk+hxebJYKoy2GJ3n3aREYf3Eb1T5uxE9TZpkP1Te8ltp4jdPU01oQMIoDsv1TMz39+d6sbhg6hN7XOuLVMZKKqsEy+Ur50dNjbUmxX6uE077r7uWLTrEwqV4SERTDaVY6Wfhy70C9lJkp0';

  static const String encryptionKeyPairSecureStorage = 'encryption-key-pair';

  static String rsaPublicKey =
      '-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApO75qg6k6Pcmbmy3/pMFwbPwY6JHH+V8SIFH4XASBBgVzKj1Qdj/pCHeWGV8+X4jEKK/vgqCRwhZzziYDXVeRkTcR/9jxuqAzpPE28gxyrK4ubI2IiuqimHUQuJObF5GqE1FdlKSM4lx8xSuW42oDu/Omo7LzIkpQGAlIkiqTw+ee38y2dObzqFkcsLNEKPSvfwgo7cYBz+7yvkilQ8Y5Bsrl0/DGTTHykwS+SXy+yk0aFjlLJyDTQ5RzNUg3ce/gP0/PHeOP4WTKNGndNXVI3IUPmHNJFVkl2KnJsUWUX38hzWAtdW2rDaoD+jz3r6Slo2iXABSKP8845+FZU8mmQIDAQAB\n-----END PUBLIC KEY-----';

  static const String ekycPreRegistrationModel = 'ekyc-pre-registration-model';

  static const String keyAliasModel = 'key-alias-model';

  static const int expireDays = 30;
  static const int expireDaysHazard = 10;

  static const String internalUrl = 'internalUrl';
  static const String externalUrl = 'externalUrl';
  static const String showScreen = 'showScreen';

  /// todo: add later to pwa (cropper web)
  static var encryptionWebKeyPairSecureStorage = 'encryption-web-key-pair';

  static const String temporaryAuthToken = 'temporaryAuthToken';}
