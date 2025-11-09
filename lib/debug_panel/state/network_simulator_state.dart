import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:slow_net_simulator/slow_net_simulator.dart';
import '../../core/helpers/logger.dart';

/// Network speed options for simulator
enum NetworkSpeedOption {
  gprs2G,
  edge2G,
  hspa3G,
  lte4G;

  NetworkSpeed toNetworkSpeed() {
    switch (this) {
      case NetworkSpeedOption.gprs2G:
        return NetworkSpeed.GPRS_2G;
      case NetworkSpeedOption.edge2G:
        return NetworkSpeed.EDGE_2G;
      case NetworkSpeedOption.hspa3G:
        return NetworkSpeed.HSPA_3G;
      case NetworkSpeedOption.lte4G:
        return NetworkSpeed.LTE_4G;
    }
  }

  String get displayName {
    switch (this) {
      case NetworkSpeedOption.gprs2G:
        return 'GPRS (2G)';
      case NetworkSpeedOption.edge2G:
        return 'EDGE (2G)';
      case NetworkSpeedOption.hspa3G:
        return 'HSPA (3G)';
      case NetworkSpeedOption.lte4G:
        return 'LTE (4G)';
    }
  }

  static NetworkSpeedOption fromNetworkSpeed(NetworkSpeed speed) {
    switch (speed) {
      case NetworkSpeed.GPRS_2G:
        return NetworkSpeedOption.gprs2G;
      case NetworkSpeed.EDGE_2G:
        return NetworkSpeedOption.edge2G;
      case NetworkSpeed.HSPA_3G:
        return NetworkSpeedOption.hspa3G;
      case NetworkSpeed.LTE_4G:
        return NetworkSpeedOption.lte4G;
    }
  }
}

/// Network simulator state
class NetworkSimulatorState {
  const NetworkSimulatorState({
    this.isEnabled = false,
    this.networkSpeed = NetworkSpeedOption.hspa3G,
    this.failureProbability = 0.0,
  });

  final bool isEnabled;
  final NetworkSpeedOption networkSpeed;
  final double failureProbability; // 0.0 to 1.0

  NetworkSimulatorState copyWith({
    bool? isEnabled,
    NetworkSpeedOption? networkSpeed,
    double? failureProbability,
  }) {
    return NetworkSimulatorState(
      isEnabled: isEnabled ?? this.isEnabled,
      networkSpeed: networkSpeed ?? this.networkSpeed,
      failureProbability: failureProbability ?? this.failureProbability,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isEnabled': isEnabled,
      'networkSpeed': networkSpeed.name,
      'failureProbability': failureProbability,
    };
  }

  factory NetworkSimulatorState.fromJson(Map<String, dynamic> json) {
    return NetworkSimulatorState(
      isEnabled: json['isEnabled'] as bool? ?? false,
      networkSpeed: NetworkSpeedOption.values.firstWhere(
        (e) => e.name == json['networkSpeed'],
        orElse: () => NetworkSpeedOption.hspa3G,
      ),
      failureProbability: (json['failureProbability'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

/// Network simulator controller
class NetworkSimulatorController extends Notifier<NetworkSimulatorState> {
  static const String _storageFileName = 'network_simulator_settings.json';
  bool _isLoading = false;

  @override
  NetworkSimulatorState build() {
    _loadSettingsImmediate();
    return const NetworkSimulatorState();
  }

  void _loadSettingsImmediate() {
    _isLoading = true;
    _loadSettings().then((_) {
      _isLoading = false;
      AppLogger.d('✅ Network simulator settings loaded');
      // Apply settings to SlowNetSimulator
      _applySettingsToSimulator();
    }).catchError((e) {
      _isLoading = false;
      AppLogger.e('❌ Network simulator settings loading failed: $e');
    });
  }

  Future<File> _getStorageFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$_storageFileName');
      return file;
    } catch (e) {
      AppLogger.e('❌ Failed to get storage directory: $e');
      return File(_storageFileName);
    }
  }

  Future<void> _loadSettings() async {
    try {
      final file = await _getStorageFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        final data = jsonDecode(contents) as Map<String, dynamic>;
        final settings = NetworkSimulatorState.fromJson(data);
        state = settings;
        AppLogger.d('✅ Network simulator settings loaded: ${settings.toJson()}');
      }
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to load network simulator settings: $e');
      AppLogger.e('❌ Stack trace: $stackTrace');
    }
  }

  Future<void> _saveSettings() async {
    if (_isLoading) {
      AppLogger.d('⏸️ Skipping save during initial load');
      return;
    }

    try {
      final file = await _getStorageFile();
      final data = Map<String, dynamic>.from(state.toJson());
      data['savedAt'] = DateTime.now().toIso8601String();
      final jsonString = jsonEncode(data);

      final sink = file.openWrite(mode: FileMode.write);
      try {
        sink.write(jsonString);
        await sink.flush();
      } finally {
        await sink.close();
      }

      AppLogger.d('💾 Network simulator settings saved');
      // Apply settings to SlowNetSimulator
      _applySettingsToSimulator();
    } catch (e, stackTrace) {
      AppLogger.e('❌ Failed to save network simulator settings: $e');
      AppLogger.e('❌ Stack trace: $stackTrace');
    }
  }

  void _applySettingsToSimulator() {
    if (state.isEnabled) {
      SlowNetSimulator.configure(
        speed: state.networkSpeed.toNetworkSpeed(),
        failureProbability: state.failureProbability,
      );
      AppLogger.d('✅ Network simulator configured: ${state.networkSpeed.displayName}, failure: ${state.failureProbability}');
    } else {
      // When disabled, DO NOT configure SlowNetSimulator at all
      // The NetworkSimulatorAdapter will bypass simulation by checking isEnabled()
      // Configuring it even with fastest speed could have side effects
      // Instead, we rely on the adapter's isEnabled() check to bypass
      AppLogger.d('⚠️ Network simulator disabled - adapter will bypass simulation (no global config applied)');
    }
  }

  /// Enable/disable network simulator
  void setEnabled(bool enabled) {
    state = state.copyWith(isEnabled: enabled);
    _saveSettings();
  }

  /// Set network speed
  void setNetworkSpeed(NetworkSpeedOption speed) {
    state = state.copyWith(networkSpeed: speed);
    _saveSettings();
  }

  /// Set failure probability (0.0 to 1.0)
  void setFailureProbability(double probability) {
    final clamped = probability.clamp(0.0, 1.0);
    state = state.copyWith(failureProbability: clamped);
    _saveSettings();
  }
}

/// Network simulator provider
final networkSimulatorProvider =
    NotifierProvider<NetworkSimulatorController, NetworkSimulatorState>(
  NetworkSimulatorController.new,
);

