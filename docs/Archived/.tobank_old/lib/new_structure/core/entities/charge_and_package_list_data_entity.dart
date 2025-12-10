// Base amount model
import 'enums.dart';

class ChargeAmount {
  final int? amount;
  final int? amountWithTax;
  final String? code;

  const ChargeAmount({
    this.amount,
    this.code,
    this.amountWithTax,
  });

  factory ChargeAmount.fromJson(Map<String, dynamic> json) {
    return ChargeAmount(
      amount: json['amount'] as int?,
      code: json['code'] as String?,
      amountWithTax: json['amountWithTax'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'amountWithTax': amountWithTax,
      };

  @override
  String toString() => 'ChargeAmount(amount: $amount, amountWithTax: $amountWithTax)';
}

// Content item model
class ChargeContent {
  final OperatorType operator;
  final String? serviceType;
  final String? name;
  final String? code;
  final PackageType? type;
  final bool? active;
  final String? simType;
  final List<ChargeAndPackageTagType>? tags;
  final List<ChargeAmount>? amounts;
  final String? addedValue;

  const ChargeContent({
    required this.operator,
    this.serviceType,
    this.name,
    this.code,
    this.type,
    this.active,
    this.simType,
    this.tags,
    this.amounts,
    this.addedValue,
  });

  factory ChargeContent.fromJson(Map<String, dynamic> json) {
    final List<ChargeAndPackageTagType> chargeAndPackageTagList = [];
    if (json['tags'] != null) {
      for (final item in (json['tags'] as List)) {
        chargeAndPackageTagList.add(ChargeAndPackageTagType.isExist(item)
            ? ChargeAndPackageTagType.fromJson(item)
            : ChargeAndPackageTagType.OTHER);
      }
    }

    return ChargeContent(
      operator: OperatorType.fromJson(json['operator']),
      serviceType: json['serviceType'] as String?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      type: (json['type'] != null && json['type'] != '')
          ? (PackageType.isExist(json['type']))
              ? PackageType.fromJson(json['type'])
              : PackageType.OTHERS
          : null,
      active: json['active'] as bool?,
      simType: json['simType'] as String?,
      tags: json['tags'] != null ? chargeAndPackageTagList : null,
      addedValue: json['addedValue'] as String?,
      amounts: json['amounts'] != null
          ? (json['amounts'] as List).map((e) => ChargeAmount.fromJson(e as Map<String, dynamic>)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'operator': operator.toString(),
        'serviceType': serviceType,
        'name': name,
        'code': code,
        'type': type,
        'active': active,
        'simType': simType,
        'tags': tags,
        'amounts': amounts?.map((e) => e.toJson()).toList(),
        'addedValue': addedValue,
      };

  @override
  String toString() => 'ChargeContent(name: $name, code: $code)';
}

// FindAllResponse model
class FindAllResponse {
  final String? state;
  final String? message;
  final String? errorCode;
  final List<ChargeContent>? content;
  final int? totalElements;

  const FindAllResponse({
    this.state,
    this.message,
    this.errorCode,
    this.content,
    this.totalElements,
  });

  factory FindAllResponse.fromJson(Map<String, dynamic> json) {
    return FindAllResponse(
      state: json['state'] as String?,
      message: json['message'] as String?,
      errorCode: json['errorCode'] as String?,
      content: json['content'] != null
          ? (json['content'] as List).map((e) => ChargeContent.fromJson(e as Map<String, dynamic>)).toList()
          : null,
      totalElements: json['totalElements'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'state': state,
        'message': message,
        'errorCode': errorCode,
        'content': content?.map((e) => e.toJson()).toList(),
        'totalElements': totalElements,
      };
}

// SimTypesResponse result model
class SimTypeResult {
  final String? simType;
  final OperatorType operator;

  const SimTypeResult({
    required this.operator,
    this.simType,
  });

  factory SimTypeResult.fromJson(Map<String, dynamic> json) {
    return SimTypeResult(
      simType: json['simType'] as String?,
      operator: OperatorType.fromJson(json['operator']),
      // operator: json['operator'] == '' ? OperatorType.RIGHTEL : OperatorType.fromJson(json['operator']),
    );
  }

  Map<String, dynamic> toJson() => {
        'simType': simType,
        'operator': operator.toString(),
      };
}

// SimTypesResponse model
class SimTypesResponse {
  final String? state;
  final String? message;
  final String? errorCode;
  final SimTypeResult? result;

  const SimTypesResponse({
    this.state,
    this.message,
    this.errorCode,
    this.result,
  });

  factory SimTypesResponse.fromJson(Map<String, dynamic> json) {
    return SimTypesResponse(
      state: json['state'] as String?,
      message: json['message'] as String?,
      errorCode: json['errorCode'] as String?,
      result: json['result'] != null ? SimTypeResult.fromJson(json['result'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'state': state,
        'message': message,
        'errorCode': errorCode,
        'result': result?.toJson(),
      };
}

// ExtraData model
class ExtraData {
  final int? packageTimeCode;
  final String? packageTime;
  final String? traffic;
  final String? nightTraffic;
  final String? callNetwork;
  final String? responseDate;
  final String? sellRate;
  final String? otherParams;
  final String? giftTraffic;

  const ExtraData({
    this.packageTimeCode,
    this.packageTime,
    this.traffic,
    this.nightTraffic,
    this.callNetwork,
    this.responseDate,
    this.sellRate,
    this.otherParams,
    this.giftTraffic,
  });

  factory ExtraData.fromJson(Map<String, dynamic> json) {
    return ExtraData(
      packageTimeCode: json['packageTimeCode'] as int?,
      packageTime: json['packageTime'] as String?,
      traffic: json['traffic'] as String?,
      nightTraffic: json['nightTraffic'] as String?,
      callNetwork: json['callNetwork'] as String?,
      responseDate: json['responseDate'] as String?,
      sellRate: json['sellRate'] as String?,
      otherParams: json['otherParams'] as String?,
      giftTraffic: json['giftTraffic'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'packageTimeCode': packageTimeCode,
        'packageTime': packageTime,
        'traffic': traffic,
        'nightTraffic': nightTraffic,
        'callNetwork': callNetwork,
        'responseDate': responseDate,
        'sellRate': sellRate,
        'otherParams': otherParams,
        'giftTraffic': giftTraffic,
      };
}

// Main response model
class ChargeResponse {
  final String? message;
  final bool? success;
  final ChargeAndPackageListDataEntity? data;

  const ChargeResponse({
    this.message,
    this.success,
    this.data,
  });

  factory ChargeResponse.fromJson(Map<String, dynamic> json) {
    return ChargeResponse(
      message: json['message'] as String?,
      success: json['success'] as bool?,
      data: json['data'] != null
          ? ChargeAndPackageListDataEntity.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data?.toJson(),
      };
}

// Data model
class ChargeAndPackageListDataEntity {
  final FindAllResponse? findAllResponse;
  final SimTypesResponse? simTypesResponse;
  final HamrahiResponse? hamrahiResponse;
  final ExtraData? extraData;
  final int? provider;
  final int? minimumAmount;
  final int? maximumAmount;
  final double? taxPercent;
  final String? message;
  final bool? invalidOperator;

  const ChargeAndPackageListDataEntity({
    this.findAllResponse,
    this.simTypesResponse,
    this.extraData,
    this.provider,
    this.minimumAmount,
    this.maximumAmount,
    this.taxPercent,
    this.message,
    this.invalidOperator,
    this.hamrahiResponse,
  });

  factory ChargeAndPackageListDataEntity.fromJson(Map<String, dynamic> json) {
    return ChargeAndPackageListDataEntity(
      findAllResponse: json['findAllResponse'] != null
          ? FindAllResponse.fromJson(json['findAllResponse'] as Map<String, dynamic>)
          : null,
      simTypesResponse: json['simTypesResponse'] != null
          ? SimTypesResponse.fromJson(json['simTypesResponse'] as Map<String, dynamic>)
          : null,
      extraData:
          json['extraData'] != null ? ExtraData.fromJson(json['extraData'] as Map<String, dynamic>) : null,
      provider: json['provider'] as int?,
      minimumAmount: json['minimum_amount'] as int?,
      maximumAmount: json['maximum_amount'] as int?,
      taxPercent: json['tax_percent'] as double?,
      message: json['message'] as String?,
      invalidOperator: json['invalidOperator'] as bool?,
      hamrahiResponse: json['hamrahiResponse'] != null
          ? HamrahiResponse.fromJson(json['hamrahiResponse'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'findAllResponse': findAllResponse?.toJson(),
        'simTypesResponse': simTypesResponse?.toJson(),
        'extraData': extraData?.toJson(),
        'provider': provider,
        'minimum_amount': minimumAmount,
        'maximum_amount': maximumAmount,
        'tax_percent': taxPercent,
        'message': message,
        'invalidOperator': invalidOperator,
        'hamrahiResponse': hamrahiResponse?.toJson(),
      };
}

//charge package list response
class HamrahiResponse {
  final String? state;
  final String? message;
  final String? errorCode;
  final String? traceId;
  final int? count;
  final List<ChargeContent>? packageList;

  const HamrahiResponse({
    this.state,
    this.message,
    this.errorCode,
    this.traceId,
    this.count,
    this.packageList,
  });

  factory HamrahiResponse.fromJson(Map<String, dynamic> json) {
    return HamrahiResponse(
      state: json['state'] as String?,
      message: json['message'] as String?,
      errorCode: json['errorCode'] as String?,
      traceId: json['result'] != null ? json['result']['traceId'] as String? : null,
      count: json['result'] != null ? json['result']['count'] as int? : null,
      packageList: json['result'] != null && json['result']['packageList'] != null
          ? (json['result']['packageList'] as List)
              .map((e) => ChargeContent.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'state': state,
        'message': message,
        'errorCode': errorCode,
        'result': {
          'traceId': traceId,
          'count': count,
          'packageList': packageList?.map((e) => e.toJson()).toList(),
        },
      };
}
