import 'dart:convert';

TransactionData transactionDataFromJson(String str) => TransactionData.fromJson(json.decode(str));

String transactionDataToJson(TransactionData data) => json.encode(data.toJson());

class TransactionData {
  TransactionData({
    this.destComment,
    this.destUser,
    this.hashId,
    this.id,
    this.isCredit,
    this.isSuccess,
    this.message,
    this.owner,
    this.service,
    this.serviceId,
    this.sourceUser,
    this.srcComment,
    this.timestampDate,
    this.trAmount,
    this.trDate,
    this.trDest,
    this.trOrigin,
    this.trType,
    this.dstCardFullName,
    this.extraField,
    this.trCode,
    this.trStatus,
    this.discountPrice,
    this.trTypeFa,
    this.charityName,
  });

  dynamic destComment;
  UserData? destUser;
  String? hashId;
  int? id;
  bool? isCredit;
  bool? isSuccess;
  String? message;
  String? owner;
  String? service;
  int? serviceId;
  UserData? sourceUser;
  String? srcComment;
  String? timestampDate;
  int? trAmount;
  String? trDate;
  String? trDest;
  String? trOrigin;
  String? trType;
  int? statusCode;
  String? dstCardFullName;
  ExtraField? extraField;
  String? trCode;
  String? trStatus;
  int? discountPrice;
  String? trTypeFa;
  String? charityName;

  bool get isShaparakHub => extraField != null && (extraField!.isShaparakHub ?? false);

  factory TransactionData.fromJson(Map<String, dynamic> json) => TransactionData(
        destComment: json['dest_comment'],
        destUser: json['dest_user'] == null ? null : UserData.fromJson(json['dest_user']),
        hashId: json['hash_id'],
        id: json['id'],
        isCredit: json['is_credit'],
        isSuccess: json['is_success'],
        message: json['message'],
        owner: json['owner'],
        service: json['service'],
        serviceId: json['service_id'],
        sourceUser: json['source_user'] == null ? null : UserData.fromJson(json['source_user']),
        srcComment: json['src_comment'],
        timestampDate: json['timestamp_date'],
        trAmount: json['tr_amount'],
        trDate: json['tr_date'],
        trDest: json['tr_dest'],
        trOrigin: json['tr_origin'],
        trType: json['tr_type'],
        dstCardFullName: json['dst_card_fullname'],
        trCode: json['tr_code'],
        trStatus: json['tr_status'],
        extraField: json['extra_field'] == null ? null : ExtraField.fromJson(json['extra_field']),
        discountPrice: json['discounted_price'],
        trTypeFa: json['tr_type_fa'],
        charityName: json['charity_name'],
      );

  Map<String, dynamic> toJson() => {
        'dest_comment': destComment,
        'dest_user': destUser?.toJson(),
        'hash_id': hashId,
        'id': id,
        'is_credit': isCredit,
        'is_success': isSuccess,
        'message': message,
        'owner': owner,
        'service': service,
        'service_id': serviceId,
        'source_user': sourceUser?.toJson(),
        'src_comment': srcComment,
        'timestamp_date': timestampDate,
        'tr_amount': trAmount,
        'tr_date': trDate,
        'tr_dest': trDest,
        'tr_origin': trOrigin,
        'tr_type': trType,
        'dst_card_fullname': dstCardFullName,
        'tr_code': trCode,
        'tr_status': trStatus,
        'extra_field': extraField?.toJson(),
        'discounted_price': discountPrice,
        'tr_type_fa': trTypeFa,
        'charity_name': charityName,
      };
}

class UserData {
  UserData({
    this.firstName,
    this.id,
    this.lastName,
    this.mobile,
  });

  String? firstName;
  int? id;
  String? lastName;
  String? mobile;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        firstName: json['first_name'],
        id: json['id'],
        lastName: json['last_name'],
        mobile: json['mobile'],
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'id': id,
        'last_name': lastName,
        'mobile': mobile,
      };
}

class ExtraField {
  ExtraField({
    this.mobile,
    this.nationalCode,
    this.billId,
    this.payId,
    this.transactionId,
    this.registrationDate,
    this.isShaparakHub,
    this.chargeTitle,
    this.destMobile,
    this.itolInquiryResponse,
    this.standardPlateNumber,
    this.plateNumber,
    this.topResponseVa,
    this.topResponseCa,
    this.topResponseMv,
    this.topResponseAp,
    this.topResponseLs,
    this.topResponseLnp,
    this.topResponseCs,
    this.topResponseNe,
    this.topResponsePs,
    this.yektaRequestPayload,
    this.promissoryAmounts,
    this.openbankingResponse,
    this.depositNumber,
  });

  String? mobile;
  String? nationalCode;
  String? billId;
  String? payId;
  String? transactionId;
  int? registrationDate;
  bool? isShaparakHub;
  String? chargeTitle;
  String? destMobile;
  ItolInquiryResponse? itolInquiryResponse;
  StandardPlateNumber? standardPlateNumber;
  String? plateNumber;
  YektaRequestPayload? yektaRequestPayload;
  PromissoryAmounts? promissoryAmounts;
  TopResponseVa? topResponseVa;
  TopResponseCa? topResponseCa;
  TopResponseMv? topResponseMv;
  TopResponseAp? topResponseAp;
  TopResponseLs? topResponseLs;
  TopResponseLnp? topResponseLnp;
  TopResponseCs? topResponseCs;
  TopResponseNe? topResponseNe;
  TopResponsePs? topResponsePs;
  OpenbankingResponse? openbankingResponse;
  String? depositNumber;

  factory ExtraField.fromJson(Map<String, dynamic> json) => ExtraField(
        mobile: json['mobile'],
        nationalCode: json['national_code'],
        billId: json['bill_id'],
        payId: json['pay_id'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        isShaparakHub: json['is_shaparak_hub'],
        chargeTitle: json['charge_title'],
        destMobile: json['destination_mobile'],
        itolInquiryResponse: json['itol_inquiry_response'] == null
            ? null
            : ItolInquiryResponse.fromJson(
                json['itol_inquiry_response'],
              ),
        standardPlateNumber:
            json['standard_plate_number'] == null ? null : StandardPlateNumber.fromJson(json['standard_plate_number']),
        plateNumber: json['plate_number'],
        yektaRequestPayload:
            json['yekta_request_payload'] == null ? null : YektaRequestPayload.fromJson(json['yekta_request_payload']),
        topResponseVa: json['top_response_va'] == null ? null : TopResponseVa.fromJson(json['top_response_va']),
        topResponseCa: json['top_response_ca'] == null ? null : TopResponseCa.fromJson(json['top_response_ca']),
        topResponseMv: json['top_response_mv'] == null ? null : TopResponseMv.fromJson(json['top_response_mv']),
        topResponseAp: json['top_response_ap'] == null ? null : TopResponseAp.fromJson(json['top_response_ap']),
        topResponseLs: json['top_response_ls'] == null ? null : TopResponseLs.fromJson(json['top_response_ls']),
        topResponseLnp: json['top_response_lnp'] == null ? null : TopResponseLnp.fromJson(json['top_response_lnp']),
        topResponseCs: json['top_response_cs'] == null ? null : TopResponseCs.fromJson(json['top_response_cs']),
        topResponseNe: json['top_response_ne'] == null ? null : TopResponseNe.fromJson(json['top_response_ne']),
        topResponsePs: json['top_response_ps'] == null ? null : TopResponsePs.fromJson(json['top_response_ps']),
        openbankingResponse:
            json['openbanking_response'] == null ? null : OpenbankingResponse.fromJson(json['openbanking_response']),
        depositNumber: json['deposit_number'],
      );

  Map<String, dynamic> toJson() => {
        'mobile': mobile,
        'national_code': nationalCode,
        'bill_id': billId,
        'pay_id': payId,
        'transactionId': billId,
        'registrationDate': payId,
        'is_shaparak_hub': isShaparakHub,
        'charge_title': chargeTitle,
        'dest_mobile': destMobile,
        'itol_inquiry_response': itolInquiryResponse?.toJson(),
        'standard_plate_number': standardPlateNumber?.toJson(),
        'plate_number': plateNumber,
        'top_response_va': topResponseVa?.toJson(),
        'top_response_ca': topResponseCa?.toJson(),
        'top_response_mv': topResponseMv?.toJson(),
        'top_response_ap': topResponseAp?.toJson(),
        'top_response_ls': topResponseLs?.toJson(),
        'top_response_lnp': topResponseLnp?.toJson(),
        'top_response_cs': topResponseCs?.toJson(),
        'top_response_ne': topResponseNe?.toJson(),
        'top_response_ps': topResponsePs?.toJson(),
        'yekta_request_payload': yektaRequestPayload?.toJson(),
        'openbanking_response': openbankingResponse?.toJson(),
      };
}

class ItolInquiryResponse {
  ItolInquiryResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;

  factory ItolInquiryResponse.fromJson(Map<String, dynamic> json) => ItolInquiryResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.type,
    this.items,
    this.totalPrice,
    this.error,
    this.probablyWrongBarcode,
  });

  String? type;
  List<Item>? items;
  int? totalPrice;
  bool? error;
  bool? probablyWrongBarcode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json['type'],
        items: json['items'] == null ? null : List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
        totalPrice: json['total_price'],
        error: json['error'],
        probablyWrongBarcode: json['probably_wrong_barcode'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'items': items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson())),
        'total_price': totalPrice,
        'error': error,
        'probably_wrong_barcode': probablyWrongBarcode,
      };
}

class Item {
  Item({
    this.id,
    this.type,
    this.description,
    this.code,
    this.price,
    this.city,
    this.location,
    this.date,
    this.serial,
    this.dataValue,
    this.barcode,
    this.license,
    this.billId,
    this.paymentId,
    this.normalizedDate,
    this.isPayable,
    this.policemanCode,
    this.hasImage,
  });

  String? id;
  String? type;
  String? description;
  String? code;
  int? price;
  dynamic city;
  String? location;
  String? date;
  String? serial;
  String? dataValue;
  dynamic barcode;
  String? license;
  String? billId;
  String? paymentId;
  DateTime? normalizedDate;
  bool? isPayable;
  dynamic policemanCode;
  bool? hasImage;
  bool isChecked = false;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        type: json['type'],
        description: json['description'],
        code: json['code'],
        price: json['price'],
        city: json['city'],
        location: json['location'],
        date: json['date'],
        serial: json['serial'],
        dataValue: json['dataValue'],
        barcode: json['barcode'],
        license: json['license'],
        billId: json['billId'],
        paymentId: json['paymentId'],
        normalizedDate: json['normalizedDate'] == null ? null : DateTime.parse(json['normalizedDate']),
        isPayable: json['isPayable'],
        policemanCode: json['policemanCode'],
        hasImage: json['hasImage'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'description': description,
        'code': code,
        'price': price,
        'city': city,
        'location': location,
        'date': date,
        'serial': serial,
        'dataValue': dataValue,
        'barcode': barcode,
        'license': license,
        'billId': billId,
        'paymentId': paymentId,
        'normalizedDate': normalizedDate?.toIso8601String(),
        'isPayable': isPayable,
        'policemanCode': policemanCode,
        'hasImage': hasImage,
      };
}

class StandardPlateNumber {
  StandardPlateNumber({
    this.firstSectionNumber,
    this.alphabet,
    this.lastSectionNumber,
    this.cityCode,
  });

  String? firstSectionNumber;
  String? alphabet;
  String? lastSectionNumber;
  String? cityCode;

  factory StandardPlateNumber.fromJson(Map<String, dynamic> json) => StandardPlateNumber(
        firstSectionNumber: json['first_section_number'],
        alphabet: json['alphabet'],
        lastSectionNumber: json['last_section_number'],
        cityCode: json['city_code'],
      );

  Map<String, dynamic> toJson() => {
        'first_section_number': firstSectionNumber,
        'alphabet': alphabet,
        'last_section_number': lastSectionNumber,
        'city_code': cityCode,
      };
}

class TopResponseVa {
  TopResponseVa({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  TopResponseVaData? data;
  int? code;
  bool? success;
  String? message;

  factory TopResponseVa.fromJson(Map<String, dynamic> json) => TopResponseVa(
        data: json['data'] == null ? null : TopResponseVaData.fromJson(json['data']),
        code: json['code'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'code': code,
        'success': success,
        'message': message,
      };
}

class TopResponseVaData {
  TopResponseVaData({
    this.errorCode,
    this.plateChar,
    this.priceStatus,
    this.paperId,
    this.paymentId,
    this.warningPrice,
  });

  String? errorCode;
  String? plateChar;
  String? priceStatus;
  String? paperId;
  String? paymentId;
  String? warningPrice;

  factory TopResponseVaData.fromJson(Map<String, dynamic> json) => TopResponseVaData(
        errorCode: json['errorCode'],
        plateChar: json['plateChar'],
        priceStatus: json['priceStatus'],
        paperId: json['paperId'],
        paymentId: json['paymentId'],
        warningPrice: json['warningPrice'],
      );

  Map<String, dynamic> toJson() => {
        'errorCode': errorCode,
        'plateChar': plateChar,
        'priceStatus': priceStatus,
        'paperId': paperId,
        'paymentId': paymentId,
        'warningPrice': warningPrice,
      };
}

class TopResponseCa {
  TopResponseCa({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  TopResponseCaData? data;
  int? code;
  bool? success;
  String? message;

  factory TopResponseCa.fromJson(Map<String, dynamic> json) => TopResponseCa(
        data: json['data'] == null ? null : TopResponseCaData.fromJson(json['data']),
        code: json['code'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'code': code,
        'success': success,
        'message': message,
      };
}

class TopResponseCaData {
  TopResponseCaData({
    this.priceStatus,
    this.parmDate,
    this.warningDtOs,
    this.totalPrice,
    this.totalPaperId,
    this.totalPaymentId,
  });

  String? priceStatus;
  String? parmDate;
  List<WarningDto>? warningDtOs;
  String? totalPrice;
  String? totalPaperId;
  String? totalPaymentId;

  factory TopResponseCaData.fromJson(Map<String, dynamic> json) => TopResponseCaData(
        priceStatus: json['priceStatus'],
        parmDate: json['parmDate'],
        warningDtOs: json['warningDTOs'] == null
            ? null
            : List<WarningDto>.from(json['warningDTOs'].map((x) => WarningDto.fromJson(x))),
        totalPrice: json['totalPrice'],
        totalPaperId: json['totalPaperId'],
        totalPaymentId: json['totalPaymentId'],
      );

  Map<String, dynamic> toJson() => {
        'priceStatus': priceStatus,
        'parmDate': parmDate,
        'warningDTOs': warningDtOs == null ? null : List<dynamic>.from(warningDtOs!.map((x) => x.toJson())),
        'totalPrice': totalPrice,
        'totalPaperId': totalPaperId,
        'totalPaymentId': totalPaymentId,
      };
}

class WarningDto {
  WarningDto({
    this.serialNo,
    this.violationOccureDate,
    this.violationOccureTime,
    this.finalPrice,
    this.paperId,
    this.paymentId,
    this.violationDeliveryType,
    this.violationTypeId,
    this.violationType,
    this.violatoinAddress,
    this.hasImage,
  });

  String? serialNo;
  String? violationOccureDate;
  String? violationOccureTime;
  String? finalPrice;
  String? paperId;
  String? paymentId;
  String? violationDeliveryType;
  String? violationTypeId;
  String? violationType;
  String? violatoinAddress;
  int? hasImage;
  bool isChecked = false;

  factory WarningDto.fromJson(Map<String, dynamic> json) => WarningDto(
        serialNo: json['serialNo'],
        violationOccureDate: json['violationOccureDate'],
        violationOccureTime: json['violationOccureTime'],
        finalPrice: json['finalPrice'],
        paperId: json['paperId'],
        paymentId: json['paymentId'],
        violationDeliveryType: json['violationDeliveryType'],
        violationTypeId: json['violationTypeId'],
        violationType: json['violationType'],
        violatoinAddress: json['violatoinAddress'],
        hasImage: json['hasImage'],
      );

  Map<String, dynamic> toJson() => {
        'serialNo': serialNo,
        'violationOccureDate': violationOccureDate,
        'violationOccureTime': violationOccureTime,
        'finalPrice': finalPrice,
        'paperId': paperId,
        'paymentId': paymentId,
        'violationDeliveryType': violationDeliveryType,
        'violationTypeId': violationTypeId,
        'violationType': violationType,
        'violatoinAddress': violatoinAddress,
        'hasImage': hasImage,
      };
}

class TopResponseMv {
  TopResponseMv({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  TopResponseMvData? data;
  int? code;
  bool? success;
  String? message;

  factory TopResponseMv.fromJson(Map<String, dynamic> json) => TopResponseMv(
        data: json['data'] == null ? null : TopResponseMvData.fromJson(json['data']),
        code: json['code'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'code': code,
        'success': success,
        'message': message,
      };
}

class TopResponseMvData {
  TopResponseMvData({
    this.priceStatus,
    this.parmDate,
    this.warningDtOs,
    this.totalPrice,
    this.totalPaperId,
    this.totalPaymentId,
  });

  String? priceStatus;
  String? parmDate;
  List<MotorWarningDto>? warningDtOs;
  String? totalPrice;
  String? totalPaperId;
  String? totalPaymentId;

  factory TopResponseMvData.fromJson(Map<String, dynamic> json) => TopResponseMvData(
        priceStatus: json['priceStatus'],
        parmDate: json['parmDate'],
        warningDtOs: json['warningDTOs'] == null
            ? null
            : List<MotorWarningDto>.from(json['warningDTOs'].map((x) => MotorWarningDto.fromJson(x))),
        totalPrice: json['totalPrice'],
        totalPaperId: json['totalPaperId'],
        totalPaymentId: json['totalPaymentId'],
      );

  Map<String, dynamic> toJson() => {
        'priceStatus': priceStatus,
        'parmDate': parmDate,
        'warningDTOs': warningDtOs == null ? null : List<dynamic>.from(warningDtOs!.map((x) => x.toJson())),
        'totalPrice': totalPrice,
        'totalPaperId': totalPaperId,
        'totalPaymentId': totalPaymentId,
      };
}

class MotorWarningDto {
  MotorWarningDto({
    this.serialNo,
    this.violationOccureDate,
    this.violationOccureTime,
    this.finalPrice,
    this.paperId,
    this.paymentId,
    this.violationDeliveryType,
    this.violationTypeId,
    this.violationType,
    this.violatoinAddress,
    this.hasImage,
  });

  String? serialNo;
  String? violationOccureDate;
  String? violationOccureTime;
  String? finalPrice;
  String? paperId;
  String? paymentId;
  String? violationDeliveryType;
  String? violationTypeId;
  String? violationType;
  String? violatoinAddress;
  int? hasImage;

  factory MotorWarningDto.fromJson(Map<String, dynamic> json) => MotorWarningDto(
        serialNo: json['serialNo'],
        violationOccureDate: json['violationOccureDate'],
        violationOccureTime: json['violationOccureTime'],
        finalPrice: json['finalPrice'],
        paperId: json['paperId'],
        paymentId: json['paymentId'],
        violationDeliveryType: json['violationDeliveryType'],
        violationTypeId: json['violationTypeId'],
        violationType: json['violationType'],
        violatoinAddress: json['violatoinAddress'],
        hasImage: json['hasImage'],
      );

  Map<String, dynamic> toJson() => {
        'serialNo': serialNo,
        'violationOccureDate': violationOccureDate,
        'violationOccureTime': violationOccureTime,
        'finalPrice': finalPrice,
        'paperId': paperId,
        'paymentId': paymentId,
        'violationDeliveryType': violationDeliveryType,
        'violationTypeId': violationTypeId,
        'violationType': violationType,
        'violatoinAddress': violatoinAddress,
        'hasImage': hasImage,
      };
}

class TopResponseAp {
  TopResponseAp({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  List<TopResponseApData>? data;
  int? code;
  bool? success;
  String? message;

  factory TopResponseAp.fromJson(Map<String, dynamic> json) => TopResponseAp(
        data: json['data'] == null
            ? null
            : List<TopResponseApData>.from(json['data'].map((x) => TopResponseApData.fromJson(x))),
        code: json['code'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        'code': code,
        'success': success,
        'message': message,
      };
}

class TopResponseApData {
  TopResponseApData({
    this.plakNumber,
    this.plak,
    this.secInSerial,
    this.socialNo,
    this.mnfkShdnDate,
    this.isFak,
    this.description,
  });

  String? plakNumber;
  String? plak;
  String? secInSerial;
  String? socialNo;
  String? mnfkShdnDate;
  String? isFak;
  String? description;

  factory TopResponseApData.fromJson(Map<String, dynamic> json) => TopResponseApData(
        plakNumber: json['plakNumber'],
        plak: json['plak'],
        secInSerial: json['secInSerial'],
        socialNo: json['socialNo'],
        mnfkShdnDate: json['mnfk_SHDN_DATE'],
        isFak: json['is_FAK'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'plakNumber': plakNumber,
        'plak': plak,
        'secInSerial': secInSerial,
        'socialNo': socialNo,
        'mnfk_SHDN_DATE': mnfkShdnDate,
        'is_FAK': isFak,
        'description': description,
      };
}

class TopResponseLs {
  TopResponseLs({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  List<TopResponseLsData>? data;
  int? code;
  bool? success;
  String? message;

  factory TopResponseLs.fromJson(Map<String, dynamic> json) => TopResponseLs(
        data: json['data'] == null
            ? null
            : List<TopResponseLsData>.from(json['data'].map((x) => TopResponseLsData.fromJson(x))),
        code: json['code'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
        'code': code,
        'success': success,
        'message': message,
      };
}

class TopResponseLsData {
  TopResponseLsData({
    this.nationalNo,
    this.firstName,
    this.lastName,
    this.title,
    this.rahvarStatus,
    this.barcode,
    this.printDate,
    this.printNum,
    this.validYears,
  });

  String? nationalNo;
  String? firstName;
  String? lastName;
  String? title;
  String? rahvarStatus;
  String? barcode;
  String? printDate;
  String? printNum;
  String? validYears;

  factory TopResponseLsData.fromJson(Map<String, dynamic> json) => TopResponseLsData(
        nationalNo: json['nationalNo'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        title: json['title'],
        rahvarStatus: json['rahvarStatus'],
        barcode: json['barcode'],
        printDate: json['printDate'],
        printNum: json['printNum'],
        validYears: json['validYears'],
      );

  Map<String, dynamic> toJson() => {
        'nationalNo': nationalNo,
        'firstName': firstName,
        'lastName': lastName,
        'title': title,
        'rahvarStatus': rahvarStatus,
        'barcode': barcode,
        'printDate': printDate,
        'printNum': printNum,
        'validYears': validYears,
      };
}

class TopResponseLnp {
  TopResponseLnp({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  TopResponseLnpData? data;
  int? code;
  bool? success;
  String? message;

  factory TopResponseLnp.fromJson(Map<String, dynamic> json) => TopResponseLnp(
        data: json['data'] == null ? null : TopResponseLnpData.fromJson(json['data']),
        code: json['code'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'code': code,
        'success': success,
        'message': message,
      };
}

class TopResponseLnpData {
  TopResponseLnpData({
    this.negPoint,
    this.ruleId,
    this.allowable,
  });

  String? negPoint;
  String? ruleId;
  String? allowable;

  factory TopResponseLnpData.fromJson(Map<String, dynamic> json) => TopResponseLnpData(
        negPoint: json['negPoint'],
        ruleId: json['ruleId'],
        allowable: json['allowable'],
      );

  Map<String, dynamic> toJson() => {
        'negPoint': negPoint,
        'ruleId': ruleId,
        'allowable': allowable,
      };
}

class TopResponseCs {
  TopResponseCs({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  TopResponseCsData? data;
  int? code;
  bool? success;
  String? message;

  factory TopResponseCs.fromJson(Map<String, dynamic> json) => TopResponseCs(
        data: json['data'] == null ? null : TopResponseCsData.fromJson(json['data']),
        code: json['code'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'code': code,
        'success': success,
        'message': message,
      };
}

class TopResponseCsData {
  TopResponseCsData({
    this.cardPrintDate,
    this.cardPostalBarcode,
    this.cardStatusTitle,
    this.documentPrintDate,
    this.documentStatusTitle,
    this.plateWord,
  });

  String? cardPrintDate;
  String? cardPostalBarcode;
  String? cardStatusTitle;
  String? documentPrintDate;
  String? documentStatusTitle;
  String? plateWord;

  factory TopResponseCsData.fromJson(Map<String, dynamic> json) => TopResponseCsData(
        cardPrintDate: json['cardPrintDate'],
        cardPostalBarcode: json['cardPostalBarcode'],
        cardStatusTitle: json['cardStatusTitle'],
        documentPrintDate: json['documentPrintDate'],
        documentStatusTitle: json['documentStatusTitle'],
        plateWord: json['plateWord'],
      );

  Map<String, dynamic> toJson() => {
        'cardPrintDate': cardPrintDate,
        'cardPostalBarcode': cardPostalBarcode,
        'cardStatusTitle': cardStatusTitle,
        'documentPrintDate': documentPrintDate,
        'documentStatusTitle': documentStatusTitle,
        'plateWord': plateWord,
      };
}

class TopResponseNe {
  TopResponseNe({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  TopResponseNeData? data;
  int? code;
  bool? success;
  String? message;

  factory TopResponseNe.fromJson(Map<String, dynamic> json) => TopResponseNe(
        data: json['data'] == null ? null : TopResponseNeData.fromJson(json['data']),
        code: json['code'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'code': code,
        'success': success,
        'message': message,
      };
}

class TopResponseNeData {
  TopResponseNeData({
    this.result,
  });

  String? result;

  factory TopResponseNeData.fromJson(Map<String, dynamic> json) => TopResponseNeData(
        result: json['result'],
      );

  Map<String, dynamic> toJson() => {
        'result': result,
      };
}

class TopResponsePs {
  TopResponsePs({
    this.data,
    this.code,
    this.success,
    this.message,
  });

  TopResponsePsData? data;
  int? code;
  bool? success;
  String? message;

  factory TopResponsePs.fromJson(Map<String, dynamic> json) => TopResponsePs(
        data: json['data'] == null ? null : TopResponsePsData.fromJson(json['data']),
        code: json['code'],
        success: json['success'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'code': code,
        'success': success,
        'message': message,
      };
}

class TopResponsePsData {
  TopResponsePsData({
    this.barcodePosti,
    this.hasPassport,
    this.shomarehPassport,
    this.tarikhSodoor,
    this.tarikhEtebar,
    this.vaziatPassport,
    this.hasDarkhast,
    this.vaziatDarkhast,
    this.tarikhDarkhast,
    this.shakhsFinded,
  });

  String? barcodePosti;
  bool? hasPassport;
  String? shomarehPassport;
  String? tarikhSodoor;
  String? tarikhEtebar;
  String? vaziatPassport;
  String? hasDarkhast;
  String? vaziatDarkhast;
  String? tarikhDarkhast;
  String? shakhsFinded;

  factory TopResponsePsData.fromJson(Map<String, dynamic> json) => TopResponsePsData(
        barcodePosti: json['barcodePosti'],
        hasPassport: json['hasPassport'],
        shomarehPassport: json['shomarehPassport'],
        tarikhSodoor: json['tarikhSodoor'],
        tarikhEtebar: json['tarikhEtebar'],
        vaziatPassport: json['vaziatPassport'],
        hasDarkhast: json['hasDarkhast'],
        vaziatDarkhast: json['vaziatDarkhast'],
        tarikhDarkhast: json['tarikhDarkhast'],
        shakhsFinded: json['shakhsFinded'],
      );

  Map<String, dynamic> toJson() => {
        'barcodePosti': barcodePosti,
        'hasPassport': hasPassport,
        'shomarehPassport': shomarehPassport,
        'tarikhSodoor': tarikhSodoor,
        'tarikhEtebar': tarikhEtebar,
        'vaziatPassport': vaziatPassport,
        'hasDarkhast': hasDarkhast,
        'vaziatDarkhast': vaziatDarkhast,
        'tarikhDarkhast': tarikhDarkhast,
        'shakhsFinded': shakhsFinded,
      };
}

class PromissoryAmounts {
  PromissoryAmounts({
    this.stampFee,
    this.wage,
    this.totalAmount,
  });

  int? stampFee;
  int? wage;
  int? totalAmount;

  factory PromissoryAmounts.fromJson(Map<String, dynamic> json) => PromissoryAmounts(
        stampFee: json['stamp_fee'],
        wage: json['wage'],
        totalAmount: json['total_amount'],
      );

  Map<String, dynamic> toJson() => {
        'stamp_fee': stampFee,
        'wage': wage,
        'total_amount': totalAmount,
      };
}

class YektaRequestPayload {
  YektaRequestPayload({
    this.yektaPayloadsIssuerType,
    this.issuerNn,
    this.issuerSanaCode,
    this.issuerCellphone,
    this.issuerFullName,
    this.issuerAccountNumber,
    this.issuerAddress,
    this.issuerPostalCode,
    this.recipientType,
    this.recipientNn,
    this.recipientSanaCode,
    this.recipientCellphone,
    this.recipientFullName,
    this.recipientAddress,
    this.amount,
    this.dueDate,
    this.description,
    this.wallet,
    this.issuerType,
  });

  String? yektaPayloadsIssuerType;
  String? issuerNn;
  String? issuerSanaCode;
  int? issuerCellphone;
  String? issuerFullName;
  dynamic issuerAccountNumber;
  String? issuerAddress;
  String? issuerPostalCode;
  String? recipientType;
  String? recipientNn;
  String? recipientSanaCode;
  int? recipientCellphone;
  String? recipientFullName;
  String? recipientAddress;
  int? amount;
  String? dueDate;
  String? description;
  bool? wallet;
  String? issuerType;

  factory YektaRequestPayload.fromJson(Map<String, dynamic> json) => YektaRequestPayload(
        yektaPayloadsIssuerType: json['issuerType'],
        issuerNn: json['issuerNN'],
        issuerSanaCode: json['issuerSanaCode'],
        issuerCellphone: json['issuerCellphone'],
        issuerFullName: json['issuerFullName'],
        issuerAccountNumber: json['issuerAccountNumber'],
        issuerAddress: json['issuerAddress'],
        issuerPostalCode: json['issuerPostalCode'],
        recipientType: json['recipientType'],
        recipientNn: json['recipientNN'],
        recipientSanaCode: json['recipientSanaCode'],
        recipientCellphone: json['recipientCellphone'],
        recipientFullName: json['recipientFullName'],
        recipientAddress: json['recipientAddress'],
        amount: json['amount'],
        dueDate: json['dueDate'],
        description: json['description'],
        wallet: json['wallet'],
        issuerType: json['IssuerType'],
      );

  Map<String, dynamic> toJson() => {
        'issuerType': yektaPayloadsIssuerType,
        'issuerNN': issuerNn,
        'issuerSanaCode': issuerSanaCode,
        'issuerCellphone': issuerCellphone,
        'issuerFullName': issuerFullName,
        'issuerAccountNumber': issuerAccountNumber,
        'issuerAddress': issuerAddress,
        'issuerPostalCode': issuerPostalCode,
        'recipientType': recipientType,
        'recipientNN': recipientNn,
        'recipientSanaCode': recipientSanaCode,
        'recipientCellphone': recipientCellphone,
        'recipientFullName': recipientFullName,
        'recipientAddress': recipientAddress,
        'amount': amount,
        'dueDate': dueDate,
        'description': description,
        'wallet': wallet,
        'IssuerType': issuerType,
      };
}

class OpenbankingResponse {
  OpenbankingResponse({
    this.fullname,
    this.pdfFile,
    this.referenceCode,
    this.success,
    this.status,
    this.orderId,
    this.message,
  });

  String? fullname;
  String? pdfFile;
  String? referenceCode;
  bool? success;
  int? status;
  String? orderId;
  String? message;

  factory OpenbankingResponse.fromJson(Map<String, dynamic> json) => OpenbankingResponse(
        fullname: json['fullname'],
        pdfFile: json['pdf_file'],
        referenceCode: json['reference_code'],
        success: json['success'],
        status: json['status'],
        orderId: json['order_id'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'fullname': fullname,
        'pdf_file': pdfFile,
        'reference_code': referenceCode,
        'success': success,
        'status': status,
        'order_id': orderId,
        'message': message,
      };
}
