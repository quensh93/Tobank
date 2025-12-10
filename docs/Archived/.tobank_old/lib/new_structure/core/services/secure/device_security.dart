import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';


/// todo: add later to pwa (pin and biometric for web)
final LocalAuthentication auth = LocalAuthentication();

Future<bool> checkDeviceSecurity() async {
  if(kIsWeb){
    return true;
  }else{
    try {
      // Check if biometrics are available
      // final bool canCheckBiometrics = await auth.canCheckBiometrics;
      // Check if device supports local authentication
      final bool isDeviceSupported = await auth.isDeviceSupported();

      // return (canCheckBiometrics || isDeviceSupported);
      return (isDeviceSupported);
    } catch (e) {
      return false ;
    }
  }

}