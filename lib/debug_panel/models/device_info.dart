import 'package:flutter/material.dart';

/// Device information for preview
class DeviceInfo {
  const DeviceInfo({
    required this.name,
    required this.identifier,
    required this.screenSize,
    required this.pixelRatio,
    required this.safeAreas,
    this.rotatedSafeAreas,
  });

  final String name;
  final DeviceIdentifier identifier;
  final Size screenSize;
  final double pixelRatio;
  final EdgeInsets safeAreas;
  final EdgeInsets? rotatedSafeAreas;
}

/// Device identifier
class DeviceIdentifier {
  const DeviceIdentifier({
    required this.platform,
    required this.type,
    required this.id,
  });

  final TargetPlatform platform;
  final DeviceType type;
  final String id;
}

/// Device type enum
enum DeviceType {
  phone,
  tablet,
  desktop,
  laptop,
  tv,
}

/// Predefined devices
class Devices {
  static const List<DeviceInfo> all = [
    // iOS Devices
    DeviceInfo(
      name: 'iPhone 15 Pro',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.iOS,
        type: DeviceType.phone,
        id: 'iphone-15-pro',
      ),
      screenSize: Size(393, 852),
      pixelRatio: 3.0,
      safeAreas: EdgeInsets.only(top: 59, bottom: 34),
    ),
    DeviceInfo(
      name: 'iPhone 15',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.iOS,
        type: DeviceType.phone,
        id: 'iphone-15',
      ),
      screenSize: Size(393, 852),
      pixelRatio: 3.0,
      safeAreas: EdgeInsets.only(top: 59, bottom: 34),
    ),
    DeviceInfo(
      name: 'iPhone SE',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.iOS,
        type: DeviceType.phone,
        id: 'iphone-se',
      ),
      screenSize: Size(375, 667),
      pixelRatio: 2.0,
      safeAreas: EdgeInsets.only(top: 20),
    ),
    DeviceInfo(
      name: 'iPad',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.iOS,
        type: DeviceType.tablet,
        id: 'ipad',
      ),
      screenSize: Size(820, 1180),
      pixelRatio: 2.0,
      safeAreas: EdgeInsets.only(top: 20),
    ),
    
    // Android Devices
    DeviceInfo(
      name: 'Pixel 8 Pro',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.android,
        type: DeviceType.phone,
        id: 'pixel-8-pro',
      ),
      screenSize: Size(412, 915),
      pixelRatio: 2.625,
      safeAreas: EdgeInsets.only(top: 24),
    ),
    DeviceInfo(
      name: 'Samsung Galaxy S24',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.android,
        type: DeviceType.phone,
        id: 'galaxy-s24',
      ),
      screenSize: Size(412, 915),
      pixelRatio: 2.625,
      safeAreas: EdgeInsets.only(top: 24),
    ),
    DeviceInfo(
      name: 'Pixel Tablet',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.android,
        type: DeviceType.tablet,
        id: 'pixel-tablet',
      ),
      screenSize: Size(1024, 1366),
      pixelRatio: 1.0,
      safeAreas: EdgeInsets.only(top: 24),
    ),
    
    // Desktop Devices
    DeviceInfo(
      name: 'macOS Desktop',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.macOS,
        type: DeviceType.desktop,
        id: 'macos-desktop',
      ),
      screenSize: Size(1920, 1080),
      pixelRatio: 1.0,
      safeAreas: EdgeInsets.zero,
    ),
    DeviceInfo(
      name: 'Windows Desktop',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.windows,
        type: DeviceType.desktop,
        id: 'windows-desktop',
      ),
      screenSize: Size(1920, 1080),
      pixelRatio: 1.0,
      safeAreas: EdgeInsets.zero,
    ),
    DeviceInfo(
      name: 'Linux Desktop',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.linux,
        type: DeviceType.desktop,
        id: 'linux-desktop',
      ),
      screenSize: Size(1920, 1080),
      pixelRatio: 1.0,
      safeAreas: EdgeInsets.zero,
    ),
    
    // Laptop Devices
    DeviceInfo(
      name: 'MacBook Pro',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.macOS,
        type: DeviceType.laptop,
        id: 'macbook-pro',
      ),
      screenSize: Size(1440, 900),
      pixelRatio: 2.0,
      safeAreas: EdgeInsets.zero,
    ),
    DeviceInfo(
      name: 'Windows Laptop',
      identifier: DeviceIdentifier(
        platform: TargetPlatform.windows,
        type: DeviceType.laptop,
        id: 'windows-laptop',
      ),
      screenSize: Size(1366, 768),
      pixelRatio: 1.0,
      safeAreas: EdgeInsets.zero,
    ),
  ];

  static const ios = _IosDevices();
  static const android = _AndroidDevices();
  static const windows = _WindowsDevices();
  static const macos = _MacOSDevices();
  static const linux = _LinuxDevices();
}

class _IosDevices {
  const _IosDevices();
  
  List<DeviceInfo> get all => Devices.all
      .where((d) => d.identifier.platform == TargetPlatform.iOS)
      .toList();
}

class _AndroidDevices {
  const _AndroidDevices();
  
  List<DeviceInfo> get all => Devices.all
      .where((d) => d.identifier.platform == TargetPlatform.android)
      .toList();
}

class _WindowsDevices {
  const _WindowsDevices();
  
  List<DeviceInfo> get all => Devices.all
      .where((d) => d.identifier.platform == TargetPlatform.windows)
      .toList();
}

class _MacOSDevices {
  const _MacOSDevices();
  
  List<DeviceInfo> get all => Devices.all
      .where((d) => d.identifier.platform == TargetPlatform.macOS)
      .toList();
}

class _LinuxDevices {
  const _LinuxDevices();
  
  List<DeviceInfo> get all => Devices.all
      .where((d) => d.identifier.platform == TargetPlatform.linux)
      .toList();
}
