import '../../request/complete_task_request_data.dart';

class CompleteCustomerCollateralInfoTaskData extends CompleteTaskRequestData {
  CompleteCustomerCollateralInfoTaskData({
    required this.collateralInfo,
  });

  List<CollateralInfoElement> collateralInfo;

  @override
  Map<String, dynamic> toJson() => {
        'collateralInfo': List<dynamic>.from(collateralInfo.map((x) => x.toJson())),
      };
}

class CollateralInfo {
  CollateralInfo({
    required this.collateralInfo,
  });

  List<CollateralInfoElement> collateralInfo;

  factory CollateralInfo.fromJson(Map<String, dynamic> json) => CollateralInfo(
        collateralInfo:
            List<CollateralInfoElement>.from(json['collateralInfo'].map((x) => CollateralInfoElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'collateralInfo': List<dynamic>.from(collateralInfo.map((x) => x.toJson())),
      };
}

class CollateralInfoElement {
  CollateralInfoElement({
    required this.customerNumber,
    this.guarantorType,
    this.collateralType,
    this.chequeNumber,
    this.collateralDocumentId,
  });

  String customerNumber;
  String? guarantorType;
  String? collateralType;
  String? chequeNumber;
  String? collateralDocumentId;

  factory CollateralInfoElement.fromJson(Map<String, dynamic> json) => CollateralInfoElement(
        customerNumber: json['customerNumber'],
        guarantorType: json['guarantorType'],
        collateralType: json['collateralType'],
        chequeNumber: json['chequeNumber'],
        collateralDocumentId: json['collateralDocumentId'],
      );

  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'guarantorType': guarantorType,
        'collateralType': collateralType,
        'chequeNumber': chequeNumber,
        'collateralDocumentId': collateralDocumentId,
      };
}
