import 'dart:convert';

import 'package:flip_card/flip_card_controller.dart';

import '../../common/error_response_data.dart';

CardIssuanceTemplateResponse cardIssuanceTemplateResponseFromJson(String str) =>
    CardIssuanceTemplateResponse.fromJson(json.decode(str));

class CardIssuanceTemplateResponse {
  CardIssuanceTemplateResponse({
    this.data,
    this.success,
    this.message,
  });

  Data? data;
  bool? success;
  String? message;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory CardIssuanceTemplateResponse.fromJson(Map<String, dynamic> json) => CardIssuanceTemplateResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        success: json['success'],
        message: json['message'],
      );
}

class Data {
  Data({
    this.trackingNumber,
    this.registrationDate,
    this.status,
    this.cardTemplates,
  });

  String? trackingNumber;
  int? registrationDate;
  int? status;
  List<CardTemplate>? cardTemplates;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        cardTemplates: json['cardTemplates'] == null
            ? null
            : List<CardTemplate>.from(json['cardTemplates'].map((x) => CardTemplate.fromJson(x))),
      );
}

class CardTemplate {
  CardTemplate({
    this.templateId,
    this.cardGroupId,
    this.localName,
    this.globalName,
    this.status,
    this.templateImage,
  });

  int? templateId;
  int? cardGroupId;
  String? localName;
  String? globalName;
  int? status;
  TemplateImage? templateImage;
  FlipCardController flipCardController = FlipCardController();
  bool isFront = true;

  factory CardTemplate.fromJson(Map<String, dynamic> json) => CardTemplate(
        templateId: json['templateId'],
        cardGroupId: json['cardGroupId'],
        localName: json['localName'],
        globalName: json['globalName'],
        status: json['status'],
        templateImage: json['template_image'] == null ? null : TemplateImage.fromJson(json['template_image']),
      );
}

class TemplateImage {
  TemplateImage({
    this.templateId,
    this.template,
    this.templateBack,
    this.color,
    this.colorName,
  });

  int? templateId;
  String? template;
  String? templateBack;
  String? color;
  String? colorName;

  factory TemplateImage.fromJson(Map<String, dynamic> json) => TemplateImage(
        templateId: json['template_id'],
        template: json['template'],
        templateBack: json['template_back'],
        color: json['color'],
        colorName: json['color_name'],
      );
}
