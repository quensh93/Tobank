import 'dart:convert';

import '../common/error_response_data.dart';
import '../common/menu_data_model.dart';

MenuResponseModel menuResponseModelFromJson(String str) => MenuResponseModel.fromJson(json.decode(str));

String menuResponseModelToJson(MenuResponseModel data) => json.encode(data.toJson());

class MenuResponseModel {
  MenuResponseModel({
    this.success,
    this.data,
    this.lastestMenuUpdate,
  });

  bool? success;
  MenuDataModel? data;
  int? statusCode;
  String? lastestMenuUpdate;
  late ErrorResponseData errorResponseData;

  factory MenuResponseModel.fromJson(Map<String, dynamic> json) => MenuResponseModel(
        success: json['success'],
        data: json['data'] == null ? null : MenuDataModel.fromJson(json['data']),
        lastestMenuUpdate: json['lastest_menu_update'],
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
        'lastest_menu_update': lastestMenuUpdate,
      };
}
