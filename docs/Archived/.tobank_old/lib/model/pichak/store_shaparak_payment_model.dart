import 'dart:convert';

StoreShaparakPaymentModel storeShaparakPaymentModelFromJson(String str) =>
    StoreShaparakPaymentModel.fromJson(json.decode(str));

String storeShaparakPaymentModelToJson(StoreShaparakPaymentModel data) => json.encode(data.toJson());

class StoreShaparakPaymentModel {
  int? timestamp;
  int? count;
  String? manaId;

  StoreShaparakPaymentModel({
    this.timestamp,
    this.count,
    this.manaId,
  });

  factory StoreShaparakPaymentModel.fromJson(Map<String, dynamic> json) => StoreShaparakPaymentModel(
        timestamp: json['timestamp'],
        count: json['count'],
        manaId: json['manaId'],
      );

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'count': count,
        'manaId': manaId,
      };
}
