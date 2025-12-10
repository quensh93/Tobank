import 'dart:convert';

BannerIdsData bannerIdsDataFromJson(String str) => BannerIdsData.fromJson(json.decode(str));

String bannerIdsDataToJson(BannerIdsData data) => json.encode(data.toJson());

class BannerIdsData {
  BannerIdsData({
    this.bannerIds,
  });

  List<String>? bannerIds;

  factory BannerIdsData.fromJson(Map<String, dynamic> json) => BannerIdsData(
    bannerIds: json['bannerIds'] == null ? [] : List<String>.from(json['bannerIds']!.map((x) => x)),
      );

  Map<String, dynamic> toJson() =>
      {
        'bannerIds': bannerIds == null ? [] : List<dynamic>.from(bannerIds!.map((x) => x)),
      };
}
