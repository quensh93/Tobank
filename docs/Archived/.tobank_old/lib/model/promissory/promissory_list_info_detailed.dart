import 'promissory_list_info.dart';

class PromissoryListInfoDetail extends PromissoryListInfo {
  PromissoryListInfoDetail({
    required Map<String, dynamic> json,
    this.isUsed,
  }) : super.fromJson(json);

  bool? isUsed;

  factory PromissoryListInfoDetail.fromJson(Map<String, dynamic> json) => PromissoryListInfoDetail(
        json: json,
        isUsed: json['is_used'],
      );
}
