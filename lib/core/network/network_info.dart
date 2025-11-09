/// Interface for network information
abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<bool> get hasConnection;
}

/// Implementation of NetworkInfo
class NetworkInfoImpl implements NetworkInfo {
  // Can be implemented using connectivity_plus package
  // For now, it's a placeholder for future implementation

  @override
  Future<bool> get isConnected async {
    // TODO: Implement actual network check using connectivity_plus
    return true;
  }

  @override
  Future<bool> get hasConnection => isConnected;
}
