class DeviceHeaders {
  const DeviceHeaders._();

  static const String appPlatform = 'android';
  static const String appVersion = '456';
  static const String deviceUuid = '5109ab4c-77ca-4f0c-9858-da4df58031d2';
  static const String serviceAuthorization =
      'Basic Z2ZRdDVha3U2anVCQW9DWHhPcEJya3J2S1dRYTpxUmZkUXp5WmhYSFRKcmZ0UGd6Zk9CRFpCUllhbDBaT0RUZ291MEVST2d3YQ==';

  static Map<String, String> get all => {
    'accept': '*/*',
    'app-platform': appPlatform,
    'app-store': 'application/json',
    'app-version': appVersion,
    'device-uuid': deviceUuid,
    'serviceauthorization': serviceAuthorization,
  };
}
