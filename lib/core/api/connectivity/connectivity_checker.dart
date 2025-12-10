import 'dart:async';
import 'dart:io';

/// Connectivity checker for detecting network availability
///
/// Provides methods to check internet connectivity and monitor connection status.
class ConnectivityChecker {
  /// Singleton instance
  static final ConnectivityChecker instance = ConnectivityChecker._();

  ConnectivityChecker._();

  /// Stream controller for connectivity changes
  final _connectivityController = StreamController<bool>.broadcast();

  /// Stream of connectivity status changes
  Stream<bool> get onConnectivityChanged => _connectivityController.stream;

  /// Cached connectivity status
  bool? _isConnected;

  /// Last connectivity check timestamp
  DateTime? _lastCheck;

  /// Cache duration for connectivity status
  final Duration _cacheDuration = const Duration(seconds: 5);

  /// Check if device has internet connectivity
  ///
  /// Returns true if connected, false otherwise.
  /// Uses cached result if available and not expired.
  Future<bool> hasConnection() async {
    // Return cached result if available and not expired
    if (_isConnected != null && _lastCheck != null) {
      final now = DateTime.now();
      if (now.difference(_lastCheck!) < _cacheDuration) {
        return _isConnected!;
      }
    }

    // Perform actual connectivity check
    final connected = await _checkConnection();
    _isConnected = connected;
    _lastCheck = DateTime.now();

    // Notify listeners if status changed
    _connectivityController.add(connected);

    return connected;
  }

  /// Perform actual connectivity check
  Future<bool> _checkConnection() async {
    try {
      // Try to lookup a reliable host
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Force a connectivity check (bypasses cache)
  Future<bool> forceCheck() async {
    _isConnected = null;
    _lastCheck = null;
    return await hasConnection();
  }

  /// Start monitoring connectivity
  ///
  /// Periodically checks connectivity and emits status changes.
  void startMonitoring({Duration interval = const Duration(seconds: 10)}) {
    Timer.periodic(interval, (_) async {
      await hasConnection();
    });
  }

  /// Dispose resources
  void dispose() {
    _connectivityController.close();
  }
}
