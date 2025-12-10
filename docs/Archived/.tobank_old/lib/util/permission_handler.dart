import 'package:universal_io/io.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'enums_constants.dart';

class PermissionHandler {
  final PermissionType _permissionType;

  PermissionHandler._(this._permissionType);

  static var camera = PermissionHandler._(PermissionType.camera);
  static var contacts = PermissionHandler._(PermissionType.contacts);
  static var storage = PermissionHandler._(PermissionType.storage);

  Future<bool> get isGranted async {
    switch (_permissionType) {
      case PermissionType.camera:
        return await Permission.camera.isGranted;
      case PermissionType.contacts:
        return await Permission.contacts.isGranted;
      case PermissionType.storage:
        if (Platform.isAndroid) {
          final deviceInfo = await DeviceInfoPlugin().androidInfo;
          if (deviceInfo.version.sdkInt > 32) {
            return await Permission.photos.isGranted;
          } else {
            return await Permission.storage.isGranted;
          }
        } else {
          return await Permission.storage.isGranted;
        }
    }
  }

  Future<PermissionStatus> _requestPermission() async {
    switch (_permissionType) {
      case PermissionType.camera:
        return await Permission.camera.request();
      case PermissionType.contacts:
        return await Permission.contacts.request();
      case PermissionType.storage:
        if (Platform.isAndroid) {
          final deviceInfo = await DeviceInfoPlugin().androidInfo;
          if (deviceInfo.version.sdkInt > 32) {
            return await Permission.photos.request();
          } else {
            return await Permission.storage.request();
          }
        } else {
          return await Permission.storage.request();
        }
    }
  }

  Future<bool> handlePermission() async {
    if (await isGranted) {
      return true;
    }
    final status = await _requestPermission();
    if (status.isGranted) {
      return true;
    }

    return false;
  }
}
