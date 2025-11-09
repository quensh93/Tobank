import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:device_frame/device_frame.dart';
import 'debug_panel_settings_state.dart';

/// Helper to convert DeviceInfo to string identifier
String _deviceToId(DeviceInfo device) {
  // Use device.identifier.name as the unique identifier
  return device.identifier.name;
}

/// Helper to find DeviceInfo from identifier
DeviceInfo? _deviceFromId(String deviceId) {
  final allDevices = [
    // iOS Devices
    Devices.ios.iPhone15Pro,
    Devices.ios.iPhone15ProMax,
    Devices.ios.iPhone16,
    Devices.ios.iPhone16Pro,
    Devices.ios.iPhone13,
    Devices.ios.iPhoneSE,
    Devices.ios.iPadAir4,
    Devices.ios.iPad,
    Devices.ios.iPadPro11Inches,
    // Android Devices
    Devices.android.samsungGalaxyS20,
    Devices.android.samsungGalaxyS25,
    Devices.android.samsungGalaxyA50,
    Devices.android.googlePixel9,
    Devices.android.onePlus8Pro,
    Devices.android.smallPhone,
    Devices.android.mediumPhone,
    Devices.android.bigPhone,
    Devices.android.smallTablet,
    Devices.android.mediumTablet,
    Devices.android.largeTablet,
  ];
  
  for (final device in allDevices) {
    if (_deviceToId(device) == deviceId) {
      return device;
    }
  }
  return null;
}

/// Device preview state
class DevicePreviewState {
  const DevicePreviewState({
    required this.selectedDevice,
    required this.isFrameVisible,
    required this.isPreviewEnabled,
    required this.orientation,
  });

  final DeviceInfo selectedDevice;
  final bool isFrameVisible;
  final bool isPreviewEnabled;
  final Orientation orientation;

  DevicePreviewState copyWith({
    DeviceInfo? selectedDevice,
    bool? isFrameVisible,
    bool? isPreviewEnabled,
    Orientation? orientation,
  }) {
    return DevicePreviewState(
      selectedDevice: selectedDevice ?? this.selectedDevice,
      isFrameVisible: isFrameVisible ?? this.isFrameVisible,
      isPreviewEnabled: isPreviewEnabled ?? this.isPreviewEnabled,
      orientation: orientation ?? this.orientation,
    );
  }
}

/// Device preview controller
class DevicePreviewController extends Notifier<DevicePreviewState> {
  @override
  DevicePreviewState build() {
    // WATCH the settings provider so we rebuild when settings are loaded
    final settings = ref.watch(debugPanelSettingsProvider);
    
    // Try to load device from settings
    DeviceInfo initialDevice = Devices.ios.iPhone15Pro;
    final savedDevice = _deviceFromId(settings.deviceId);
    if (savedDevice != null) {
      initialDevice = savedDevice;
    } else if (settings.deviceId.isEmpty) {
      // Only update settings if deviceId is empty (first time)
      // Do this after build completes to avoid modifying providers during initialization
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final settingsController = ref.read(debugPanelSettingsProvider.notifier);
        settingsController.setDeviceId(_deviceToId(initialDevice));
      });
    }
    
    return DevicePreviewState(
      selectedDevice: initialDevice,
      isFrameVisible: settings.isFrameVisible,
      isPreviewEnabled: settings.isPreviewEnabled,
      orientation: settings.deviceOrientation,
    );
  }

  /// Select a device
  void selectDevice(DeviceInfo device) {
    state = state.copyWith(selectedDevice: device);
    // Save to centralized settings
    final settingsController = ref.read(debugPanelSettingsProvider.notifier);
    settingsController.setDeviceId(_deviceToId(device));
  }

  /// Toggle frame visibility
  void toggleFrame() {
    final newValue = !state.isFrameVisible;
    state = state.copyWith(isFrameVisible: newValue);
    // Save to centralized settings
    final settingsController = ref.read(debugPanelSettingsProvider.notifier);
    settingsController.setFrameVisible(newValue);
  }

  /// Toggle preview enabled
  void togglePreview() {
    final newValue = !state.isPreviewEnabled;
    state = state.copyWith(isPreviewEnabled: newValue);
    // Save to centralized settings
    final settingsController = ref.read(debugPanelSettingsProvider.notifier);
    settingsController.setPreviewEnabled(newValue);
  }

  /// Rotate device orientation
  void rotate() {
    final newOrientation = state.orientation == Orientation.portrait
        ? Orientation.landscape
        : Orientation.portrait;
    state = state.copyWith(orientation: newOrientation);
    // Save to centralized settings
    final settingsController = ref.read(debugPanelSettingsProvider.notifier);
    settingsController.setDeviceOrientation(newOrientation);
  }
}

/// Device preview provider
final devicePreviewProvider = NotifierProvider<DevicePreviewController, DevicePreviewState>(
  DevicePreviewController.new,
);
