/// Cached data model
///
/// Wraps cached JSON data with metadata about when it was cached
/// and when it expires.
class CachedData {
  /// The cached JSON data
  final Map<String, dynamic> data;

  /// When the data was cached
  final DateTime timestamp;

  /// Cache expiry duration
  final Duration expiry;

  const CachedData({
    required this.data,
    required this.timestamp,
    this.expiry = const Duration(minutes: 5),
  });

  /// Check if the cached data has expired
  bool get isExpired {
    final now = DateTime.now();
    final expiryTime = timestamp.add(expiry);
    return now.isAfter(expiryTime);
  }

  /// Check if the cached data is still valid
  bool get isValid => !isExpired;

  /// Get the remaining time until expiry
  Duration get timeUntilExpiry {
    final now = DateTime.now();
    final expiryTime = timestamp.add(expiry);
    final remaining = expiryTime.difference(now);
    return remaining.isNegative ? Duration.zero : remaining;
  }

  /// Get the age of the cached data
  Duration get age {
    final now = DateTime.now();
    return now.difference(timestamp);
  }

  /// Create from JSON
  factory CachedData.fromJson(Map<String, dynamic> json) {
    return CachedData(
      data: json['data'] as Map<String, dynamic>,
      timestamp: DateTime.parse(json['timestamp'] as String),
      expiry: Duration(
        milliseconds: json['expiry_ms'] as int? ?? 300000, // 5 minutes default
      ),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'timestamp': timestamp.toIso8601String(),
      'expiry_ms': expiry.inMilliseconds,
    };
  }

  /// Copy with method
  CachedData copyWith({
    Map<String, dynamic>? data,
    DateTime? timestamp,
    Duration? expiry,
  }) {
    return CachedData(
      data: data ?? this.data,
      timestamp: timestamp ?? this.timestamp,
      expiry: expiry ?? this.expiry,
    );
  }

  @override
  String toString() {
    return 'CachedData(timestamp: $timestamp, expiry: $expiry, '
        'isExpired: $isExpired, age: ${age.inSeconds}s)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CachedData &&
        other.data == data &&
        other.timestamp == timestamp &&
        other.expiry == expiry;
  }

  @override
  int get hashCode {
    return data.hashCode ^ timestamp.hashCode ^ expiry.hashCode;
  }
}
