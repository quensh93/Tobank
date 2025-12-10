class IncreaseBalanceEntity {
  final String url;
  final int transactionId;

  IncreaseBalanceEntity({
    required this.url,
    required this.transactionId,
  });

  factory IncreaseBalanceEntity.fromJson(Map<String, dynamic> json) {
    return IncreaseBalanceEntity(
      url: json['url'] as String,
      transactionId: json['transaction_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'transaction_id': transactionId,
    };
  }

  @override
  String toString() {
    return '🔵 IncreaseBalanceEntity(\n'
        'url: $url\n'
        'transactionId: $transactionId\n'
        ')';
  }
}