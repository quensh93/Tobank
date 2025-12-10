import '../../request/complete_task_request_data.dart';

class CompleteCustomerCollateralInfoTaskData extends CompleteTaskRequestData {
  CompleteCustomerCollateralInfoTaskData({
    this.collateralInfo,
  });

  List<CollateralInfoElement>? collateralInfo;

  @override
  Map<String, dynamic> toJson() => {
        'collateralInfo': collateralInfo == null ? null : List<dynamic>.from(collateralInfo!.map((x) => x.toJson())),
      };
}

class CollateralInfoElement {
  CollateralInfoElement({
    this.customerNumber,
    this.guarantorType,
    this.collateralType,
    this.chequeNumber,
    this.collateralDocumentId,
    this.collateralDocumentStatus,
    this.collateralDocumentDescription,
  });

  String? customerNumber;
  String? guarantorType;
  String? collateralType;
  String? chequeNumber;
  String? collateralDocumentId;
  String? collateralDocumentStatus;
  String? collateralDocumentDescription;

  factory CollateralInfoElement.fromJson(Map<String, dynamic> json) => CollateralInfoElement(
        customerNumber: json['customerNumber'],
        guarantorType: json['guarantorType'],
        collateralType: json['collateralType'],
        chequeNumber: json['chequeNumber'],
        collateralDocumentId: json['collateralDocumentId'],
        collateralDocumentStatus: json['collateralDocumentStatus'],
        collateralDocumentDescription: json['collateralDocumentDescription'],
      );

  Map<String, dynamic> toJson() => {
        'customerNumber': customerNumber,
        'guarantorType': guarantorType,
        'collateralType': collateralType,
        'chequeNumber': chequeNumber,
        'collateralDocumentId': collateralDocumentId,
        'collateralDocumentStatus': collateralDocumentStatus,
        'collateralDocumentDescription': collateralDocumentDescription,
      };
}
