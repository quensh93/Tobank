import 'dart:convert';

import '../../common/error_response_data.dart';

ProcessDetailResponse processDetailResponseFromJson(String str) => ProcessDetailResponse.fromJson(json.decode(str));

String processDetailResponseToJson(ProcessDetailResponse data) => json.encode(data.toJson());

class ProcessDetailResponse {
  ProcessDetailResponse({
    this.data,
    this.message,
    this.success,
  });

  Data? data;
  String? message;
  bool? success;
  int? statusCode;
  late ErrorResponseData errorResponseModel;

  factory ProcessDetailResponse.fromJson(Map<String, dynamic> json) => ProcessDetailResponse(
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        message: json['message'],
        success: json['success'],
      );

  Map<String, dynamic> toJson() =>
      {
        'data': data?.toJson(),
        'message': message,
        'success': success,
      };
}

class Data {
  Data({
    this.trackingNumber,
    this.transactionId,
    this.registrationDate,
    this.status,
    this.message,
    this.errors,
    this.process,
    this.tasks,
  });

  String? trackingNumber;
  String? transactionId;
  int? registrationDate;
  int? status;
  dynamic message;
  dynamic errors;
  Process? process;
  List<ProcessTask>? tasks;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingNumber: json['trackingNumber'],
        transactionId: json['transactionId'],
        registrationDate: json['registrationDate'],
        status: json['status'],
        message: json['message'],
        errors: json['errors'],
        process: json['process'] == null ? null : Process.fromJson(json['process']),
        tasks: json['tasks'] == null ? null : List<ProcessTask>.from(json['tasks'].map((x) => ProcessTask.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'trackingNumber': trackingNumber,
        'transactionId': transactionId,
        'registrationDate': registrationDate,
        'status': status,
        'message': message,
        'errors': errors,
        'process': process?.toJson(),
        'tasks': tasks == null ? null : List<dynamic>.from(tasks!.map((x) => x.toJson())),
      };
}

class Process {
  Process({
    this.id,
    this.eventType,
    this.startTime,
    this.endTime,
    this.processInstanceId,
    this.processDefinitionId,
    this.processDefinitionKey,
    this.processDefinitionVersion,
    this.processDefinitionName,
    this.businessKey,
    this.startUserId,
    this.state,
    this.variables,
  });

  String? id;
  dynamic eventType;
  int? startTime;
  dynamic endTime;
  String? processInstanceId;
  String? processDefinitionId;
  String? processDefinitionKey;
  int? processDefinitionVersion;
  String? processDefinitionName;
  String? businessKey;
  String? startUserId;
  String? state;
  ProcessVariables? variables;

  factory Process.fromJson(Map<String, dynamic> json) => Process(
        id: json['id'],
        eventType: json['eventType'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        processInstanceId: json['processInstanceId'],
        processDefinitionId: json['processDefinitionId'],
        processDefinitionKey: json['processDefinitionKey'],
        processDefinitionVersion: json['processDefinitionVersion'],
        processDefinitionName: json['processDefinitionName'],
        businessKey: json['businessKey'],
        startUserId: json['startUserId'],
        state: json['state'],
        variables: json['variables'] == null ? null : ProcessVariables.fromJson(json['variables']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'eventType': eventType,
        'startTime': startTime,
        'endTime': endTime,
        'processInstanceId': processInstanceId,
        'processDefinitionId': processDefinitionId,
        'processDefinitionKey': processDefinitionKey,
        'processDefinitionVersion': processDefinitionVersion,
        'processDefinitionName': processDefinitionName,
        'businessKey': businessKey,
        'startUserId': startUserId,
        'state': state,
        'variables': variables?.toJson(),
      };
}

class CustomerAddress {
  CustomerAddress({
    this.province,
    this.township,
    this.city,
    this.village,
    this.localityName,
    this.lastStreet,
    this.secondLastStreet,
    this.alley,
    this.plaque,
    this.unit,
    this.postalCode,
    this.description,
    this.longitude,
    this.latitude,
  });

  String? province;
  String? township;
  String? city;
  String? village;
  String? localityName;
  String? lastStreet;
  String? secondLastStreet;
  String? alley;
  String? plaque;
  String? unit;
  String? postalCode;
  String? description;
  dynamic longitude;
  dynamic latitude;

  factory CustomerAddress.fromJson(Map<String, dynamic> json) => CustomerAddress(
        province: json['province'] ?? '',
        township: json['township'] ?? '',
        city: json['city'] ?? '',
        village: json['village'] ?? '',
        localityName: json['localityName'] ?? '',
        lastStreet: json['lastStreet'] ?? '',
        secondLastStreet: json['secondLastStreet'] ?? '',
        alley: json['alley'] ?? '',
        plaque: json['plaque'] ?? '',
        unit: json['unit'] ?? '',
        postalCode: json['postalCode'] ?? '',
        description: json['description'] ?? '',
        longitude: json['longitude'] ?? 0.0,
        latitude: json['latitude'] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        'province': province,
        'township': township,
        'city': city,
        'village': village,
        'localityName': localityName,
        'lastStreet': lastStreet,
        'secondLastStreet': secondLastStreet,
        'alley': alley,
        'plaque': plaque,
        'unit': unit,
        'postalCode': postalCode,
        'description': description,
        'longitude': longitude,
        'latitude': latitude,
      };
}

class ProcessVariables {
  ProcessVariables({
    this.applicantBirthCertificateMarriageDocumentDescription,
    this.guarantorAcceptedGuarantee,
    this.newGuarantorIsNeeded,
    this.guarantorCustomerNumber,
    this.applicantBirthCertificateChildrenDocumentDescription,
    this.initiator,
    this.applicantCity,
    this.requestAmount,
    this.applicantEmploymentDocumentId,
    this.applicantResidencyType,
    this.applicantResidencyDescription,
    this.applicantResidencyDocumentId,
    this.applicantBirthCertificateChildrenDocumentStatus,
    this.bOUserGroup,
    this.applicantBirthCertificateMarriageDocumentId,
    this.guarantorBirthDate,
    this.applicantBirthCertificateDeathInfoDocumentStatus,
    this.applicantBirthCertificateMarriageDocumentStatus,
    this.applicantResidencyDocumentDescription,
    this.bOSeniorUserGroup,
    this.bOJuniorUserGroup,
    this.customerNumber,
    this.applicantResidencyDocumentStatus,
    this.applicantBirthCertificateChildrenDocumentId,
    this.branchCode,
    this.personalityType,
    this.guarantorApproved,
    this.applicantResidencyTrackingCode,
    this.applicantProvince,
    this.applicantPostalCode,
    this.applicantEmploymentDocumentStatus,
    this.guarantorMobile,
    this.guarantorNationalId,
    this.applicantBirthCertificateDeathInfoDocumentId,
    this.applicantAccepted,
    this.rejectReason,
    this.customerAddress,
    this.pan,
    this.postBarcode,
    this.postParcelStatus,
    this.depositClosingDescription,
    this.depositClosingDone,
    this.depositClosingType,
    this.depositPart,
    this.depositPartAmount,
    this.destinationDeposit,
    this.destinationDepositAgent,
    this.majorTypeCode,
    this.sourceDeposit,
    this.unitAmount,
    this.requestResult,
    this.promissoryAmount,
    this.promissoryDueDate,
    this.promissoryId,
    this.finalApprovalStatus,
    this.finalApprovalRejectReason,
    this.requestResultDescription,
  });

  String? applicantBirthCertificateMarriageDocumentDescription;
  bool? guarantorAcceptedGuarantee;
  bool? newGuarantorIsNeeded;
  dynamic guarantorCustomerNumber;
  String? applicantBirthCertificateChildrenDocumentDescription;
  String? initiator;
  String? applicantCity;
  String? requestAmount;
  String? applicantEmploymentDocumentId;
  String? applicantResidencyType;
  String? applicantResidencyDescription;
  String? applicantResidencyDocumentId;
  String? applicantBirthCertificateChildrenDocumentStatus;
  String? bOUserGroup;
  String? applicantBirthCertificateMarriageDocumentId;
  int? guarantorBirthDate;
  String? applicantBirthCertificateDeathInfoDocumentStatus;
  String? applicantBirthCertificateMarriageDocumentStatus;
  String? applicantResidencyDocumentDescription;
  String? bOSeniorUserGroup;
  String? bOJuniorUserGroup;
  String? customerNumber;
  String? applicantResidencyDocumentStatus;
  String? applicantBirthCertificateChildrenDocumentId;
  String? branchCode;
  String? personalityType;
  bool? guarantorApproved;
  String? applicantResidencyTrackingCode;
  String? applicantProvince;
  String? applicantPostalCode;
  String? applicantEmploymentDocumentStatus;
  String? guarantorMobile;
  String? guarantorNationalId;
  String? applicantBirthCertificateDeathInfoDocumentId;
  bool? applicantAccepted;
  String? rejectReason;
  dynamic postBarcode;
  dynamic postParcelStatus;
  dynamic pan;
  CustomerAddress? customerAddress;
  String? depositClosingDescription;
  bool? depositClosingDone;
  String? depositClosingType;
  int? depositPart;
  dynamic depositPartAmount;
  String? destinationDeposit;
  dynamic destinationDepositAgent;
  int? majorTypeCode;
  String? sourceDeposit;
  int? unitAmount;
  String? requestResult;
  double? promissoryAmount;
  int? promissoryDueDate;
  String? promissoryId;
  String? finalApprovalStatus;
  String? finalApprovalRejectReason;
  String? requestResultDescription;

  factory ProcessVariables.fromJson(Map<String, dynamic> json) => ProcessVariables(
        applicantBirthCertificateMarriageDocumentDescription:
            json['applicantBirthCertificateMarriageDocumentDescription'],
        guarantorAcceptedGuarantee: json['guarantorAcceptedGuarantee'],
        newGuarantorIsNeeded: json['newGuarantorIsNeeded'],
        guarantorCustomerNumber: json['guarantorCustomerNumber'],
        applicantBirthCertificateChildrenDocumentDescription:
            json['applicantBirthCertificateChildrenDocumentDescription'],
        initiator: json['initiator'],
        applicantCity: json['applicantCity'],
        requestAmount: json['requestAmount'],
        applicantEmploymentDocumentId: json['applicantEmploymentDocumentId'],
        applicantResidencyType: json['applicantResidencyType'],
        applicantResidencyDescription: json['applicantResidencyDescription'],
        applicantResidencyDocumentId: json['applicantResidencyDocumentId'],
        applicantBirthCertificateChildrenDocumentStatus: json['applicantBirthCertificateChildrenDocumentStatus'],
        bOUserGroup: json['bOUserGroup'],
        applicantBirthCertificateMarriageDocumentId: json['applicantBirthCertificateMarriageDocumentId'],
        guarantorBirthDate: json['guarantorBirthDate'],
        applicantBirthCertificateDeathInfoDocumentStatus: json['applicantBirthCertificateDeathInfoDocumentStatus'],
        applicantBirthCertificateMarriageDocumentStatus: json['applicantBirthCertificateMarriageDocumentStatus'],
        applicantResidencyDocumentDescription: json['applicantResidencyDocumentDescription'],
        bOSeniorUserGroup: json['bOSeniorUserGroup'],
        bOJuniorUserGroup: json['bOJuniorUserGroup'],
        customerNumber: json['customerNumber'],
        applicantResidencyDocumentStatus: json['applicantResidencyDocumentStatus'],
        applicantBirthCertificateChildrenDocumentId: json['applicantBirthCertificateChildrenDocumentId'],
        branchCode: json['branchCode'],
        personalityType: json['personalityType'],
        guarantorApproved: json['guarantorApproved'],
        applicantResidencyTrackingCode: json['applicantResidencyTrackingCode'],
        applicantProvince: json['applicantProvince'],
        applicantPostalCode: json['applicantPostalCode'],
        applicantEmploymentDocumentStatus: json['applicantEmploymentDocumentStatus'],
        guarantorMobile: json['guarantorMobile'],
        guarantorNationalId: json['guarantorNationalId'],
        applicantBirthCertificateDeathInfoDocumentId: json['applicantBirthCertificateDeathInfoDocumentId'],
        applicantAccepted: json['applicantAccepted'],
        rejectReason: json['rejectReason'],
        pan: json['pan'],
        postBarcode: json['postBarcode'],
        postParcelStatus: json['postParcelStatus'],
        customerAddress: json['customerAddress'] == null ? null : CustomerAddress.fromJson(json['customerAddress']),
        depositClosingDescription: json['depositClosingDescription'],
        depositClosingDone: json['depositClosingDone'],
        depositClosingType: json['depositClosingType'],
        depositPart: json['depositPart'],
        depositPartAmount: json['depositPartAmount'],
        destinationDeposit: json['destinationDeposit'],
        destinationDepositAgent: json['destinationDepositAgent'],
        majorTypeCode: json['majorTypeCode'],
        sourceDeposit: json['sourceDeposit'],
        unitAmount: json['unitAmount'],
        requestResult: json['requestResult'],
        promissoryAmount: json['promissoryAmount'],
        promissoryDueDate: json['promissoryDueDate'],
        promissoryId: json['promissoryId'],
        finalApprovalStatus: json['finalApprovalStatus'],
        finalApprovalRejectReason: json['finalApprovalRejectReason'],
        requestResultDescription: json['requestResultDescription'],
      );

  Map<String, dynamic> toJson() => {
        'applicantBirthCertificateMarriageDocumentDescription': applicantBirthCertificateMarriageDocumentDescription,
        'guarantorAcceptedGuarantee': guarantorAcceptedGuarantee,
        'newGuarantorIsNeeded': newGuarantorIsNeeded,
        'guarantorCustomerNumber': guarantorCustomerNumber,
        'applicantBirthCertificateChildrenDocumentDescription': applicantBirthCertificateChildrenDocumentDescription,
        'initiator': initiator,
        'applicantCity': applicantCity,
        'requestAmount': requestAmount,
        'applicantEmploymentDocumentId': applicantEmploymentDocumentId,
        'applicantResidencyType': applicantResidencyType,
        'applicantResidencyDescription': applicantResidencyDescription,
        'applicantResidencyDocumentId': applicantResidencyDocumentId,
        'applicantBirthCertificateChildrenDocumentStatus': applicantBirthCertificateChildrenDocumentStatus,
        'bOUserGroup': bOUserGroup,
        'applicantBirthCertificateMarriageDocumentId': applicantBirthCertificateMarriageDocumentId,
        'guarantorBirthDate': guarantorBirthDate,
        'applicantBirthCertificateDeathInfoDocumentStatus': applicantBirthCertificateDeathInfoDocumentStatus,
        'applicantBirthCertificateMarriageDocumentStatus': applicantBirthCertificateMarriageDocumentStatus,
        'applicantResidencyDocumentDescription': applicantResidencyDocumentDescription,
        'bOSeniorUserGroup': bOSeniorUserGroup,
        'bOJuniorUserGroup': bOJuniorUserGroup,
        'customerNumber': customerNumber,
        'applicantResidencyDocumentStatus': applicantResidencyDocumentStatus,
        'applicantBirthCertificateChildrenDocumentId': applicantBirthCertificateChildrenDocumentId,
        'branchCode': branchCode,
        'personalityType': personalityType,
        'guarantorApproved': guarantorApproved,
        'applicantResidencyTrackingCode': applicantResidencyTrackingCode,
        'applicantProvince': applicantProvince,
        'applicantPostalCode': applicantPostalCode,
        'applicantEmploymentDocumentStatus': applicantEmploymentDocumentStatus,
        'guarantorMobile': guarantorMobile,
        'guarantorNationalId': guarantorNationalId,
        'applicantBirthCertificateDeathInfoDocumentId': applicantBirthCertificateDeathInfoDocumentId,
        'applicantAccepted': applicantAccepted,
        'rejectReason': rejectReason,
        'depositClosingDescription': depositClosingDescription,
        'depositClosingDone': depositClosingDone,
        'depositClosingType': depositClosingType,
        'depositPart': depositPart,
        'depositPartAmount': depositPartAmount,
        'destinationDeposit': destinationDeposit,
        'destinationDepositAgent': destinationDepositAgent,
        'majorTypeCode': majorTypeCode,
        'sourceDeposit': sourceDeposit,
        'unitAmount': unitAmount,
        'requestResult': requestResult,
        'promissoryAmount': promissoryAmount,
        'promissoryDueDate': promissoryDueDate,
        'promissoryId': promissoryId,
        'finalApprovalStatus': finalApprovalStatus,
        'finalApprovalRejectReason': finalApprovalRejectReason,
        'requestResultDescription': requestResultDescription,
      };
}

class ProcessTask {
  ProcessTask({
    this.id,
    this.assignee,
    this.name,
    this.description,
    this.createTime,
    this.dueDate,
    this.followUpDate,
    this.executionId,
    this.processInstanceId,
    this.processDefinitionId,
    this.taskDefinitionKey,
    this.isDeleted,
    this.deleteReason,
    this.formKey,
    this.startTime,
    this.endTime,
    this.variables,
  });

  String? id;
  String? assignee;
  String? name;
  dynamic description;
  dynamic createTime;
  dynamic dueDate;
  dynamic followUpDate;
  String? executionId;
  String? processInstanceId;
  String? processDefinitionId;
  String? taskDefinitionKey;
  bool? isDeleted;
  String? deleteReason;
  dynamic formKey;
  int? startTime;
  int? endTime;
  TaskVariables? variables;

  factory ProcessTask.fromJson(Map<String, dynamic> json) => ProcessTask(
        id: json['id'],
        assignee: json['assignee'],
        name: json['name'],
        description: json['description'],
        createTime: json['createTime'],
        dueDate: json['dueDate'],
        followUpDate: json['followUpDate'],
        executionId: json['executionId'],
        processInstanceId: json['processInstanceId'],
        processDefinitionId: json['processDefinitionId'],
        taskDefinitionKey: json['taskDefinitionKey'],
        isDeleted: json['isDeleted'],
        deleteReason: json['deleteReason'],
        formKey: json['formKey'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        variables: json['variables'] == null ? null : TaskVariables.fromJson(json['variables']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'assignee': assignee,
        'name': name,
        'description': description,
        'createTime': createTime,
        'dueDate': dueDate,
        'followUpDate': followUpDate,
        'executionId': executionId,
        'processInstanceId': processInstanceId,
        'processDefinitionId': processDefinitionId,
        'taskDefinitionKey': taskDefinitionKey,
        'isDeleted': isDeleted,
        'deleteReason': deleteReason,
        'formKey': formKey,
        'startTime': startTime,
        'endTime': endTime,
        'variables': variables?.toJson(),
      };
}

class TaskVariables {
  TaskVariables({
    this.applicantBirthCertificateChildrenDocumentId,
    this.applicantBirthCertificateMarriageDocumentId,
    this.applicantEmploymentDocumentId,
    this.applicantBirthCertificateDeathInfoDocumentId,
    this.applicantResidencyDocumentStatus,
    this.applicantBirthCertificateMarriageDocumentDescription,
    this.applicantBirthCertificateChildrenDocumentStatus,
    this.applicantBirthCertificateChildrenDocumentDescription,
    this.applicantBirthCertificateDeathInfoDocumentStatus,
    this.applicantBirthCertificateMarriageDocumentStatus,
    this.applicantEmploymentDocumentStatus,
    this.guarantorNationalId,
    this.guarantorMobile,
    this.personalityType,
    this.guarantorBirthDate,
    this.applicantResidencyDocumentDescription,
    this.guarantorCustomerNumber,
    this.guarantorAcceptedGuarantee,
    this.applicantResidencyType,
    this.applicantResidencyDescription,
    this.applicantResidencyDocumentId,
    this.applicantAddress,
    this.applicantResidencyTrackingCode,
    this.applicantProvince,
    this.applicantPostalCode,
    this.applicantCity,
    this.applicantRejected,
    this.rejectReason,
    this.description,
  });

  String? applicantBirthCertificateChildrenDocumentId;
  String? applicantBirthCertificateMarriageDocumentId;
  String? applicantEmploymentDocumentId;
  String? applicantBirthCertificateDeathInfoDocumentId;
  String? applicantResidencyDocumentStatus;
  String? applicantBirthCertificateMarriageDocumentDescription;
  String? applicantBirthCertificateChildrenDocumentStatus;
  String? applicantBirthCertificateChildrenDocumentDescription;
  String? applicantBirthCertificateDeathInfoDocumentStatus;
  String? applicantBirthCertificateMarriageDocumentStatus;
  String? applicantEmploymentDocumentStatus;
  String? guarantorNationalId;
  String? guarantorMobile;
  dynamic personalityType;
  int? guarantorBirthDate;
  String? applicantResidencyDocumentDescription;
  String? guarantorCustomerNumber;
  bool? guarantorAcceptedGuarantee;
  String? applicantResidencyType;
  String? applicantResidencyDescription;
  String? applicantResidencyDocumentId;
  dynamic applicantAddress;
  String? applicantResidencyTrackingCode;
  String? applicantProvince;
  String? applicantPostalCode;
  String? applicantCity;
  bool? applicantRejected;
  String? rejectReason;
  String? description;

  factory TaskVariables.fromJson(Map<String, dynamic> json) => TaskVariables(
        applicantBirthCertificateChildrenDocumentId: json['applicantBirthCertificateChildrenDocumentId'],
        applicantBirthCertificateMarriageDocumentId: json['applicantBirthCertificateMarriageDocumentId'],
        applicantEmploymentDocumentId: json['applicantEmploymentDocumentId'],
        applicantBirthCertificateDeathInfoDocumentId: json['applicantBirthCertificateDeathInfoDocumentId'],
        applicantResidencyDocumentStatus: json['applicantResidencyDocumentStatus'],
        applicantBirthCertificateMarriageDocumentDescription:
            json['applicantBirthCertificateMarriageDocumentDescription'],
        applicantBirthCertificateChildrenDocumentStatus: json['applicantBirthCertificateChildrenDocumentStatus'],
        applicantBirthCertificateChildrenDocumentDescription:
            json['applicantBirthCertificateChildrenDocumentDescription'],
        applicantBirthCertificateDeathInfoDocumentStatus: json['applicantBirthCertificateDeathInfoDocumentStatus'],
        applicantBirthCertificateMarriageDocumentStatus: json['applicantBirthCertificateMarriageDocumentStatus'],
        applicantEmploymentDocumentStatus: json['applicantEmploymentDocumentStatus'],
        guarantorNationalId: json['guarantorNationalId'],
        guarantorMobile: json['guarantorMobile'],
        personalityType: json['personalityType'],
        guarantorBirthDate: json['guarantorBirthDate'],
        applicantResidencyDocumentDescription: json['applicantResidencyDocumentDescription'],
        guarantorCustomerNumber: json['guarantorCustomerNumber'],
        guarantorAcceptedGuarantee: json['guarantorAcceptedGuarantee'],
        applicantResidencyType: json['applicantResidencyType'],
        applicantResidencyDescription: json['applicantResidencyDescription'],
        applicantResidencyDocumentId: json['applicantResidencyDocumentId'],
        applicantAddress: json['applicantAddress'],
        applicantResidencyTrackingCode: json['applicantResidencyTrackingCode'],
        applicantProvince: json['applicantProvince'],
        applicantPostalCode: json['applicantPostalCode'],
        applicantCity: json['applicantCity'],
        applicantRejected: json['applicantRejected'],
        rejectReason: json['rejectReason'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'applicantBirthCertificateChildrenDocumentId': applicantBirthCertificateChildrenDocumentId,
        'applicantBirthCertificateMarriageDocumentId': applicantBirthCertificateMarriageDocumentId,
        'applicantEmploymentDocumentId': applicantEmploymentDocumentId,
        'applicantBirthCertificateDeathInfoDocumentId': applicantBirthCertificateDeathInfoDocumentId,
        'applicantResidencyDocumentStatus': applicantResidencyDocumentStatus,
        'applicantBirthCertificateMarriageDocumentDescription': applicantBirthCertificateMarriageDocumentDescription,
        'applicantBirthCertificateChildrenDocumentStatus': applicantBirthCertificateChildrenDocumentStatus,
        'applicantBirthCertificateChildrenDocumentDescription': applicantBirthCertificateChildrenDocumentDescription,
        'applicantBirthCertificateDeathInfoDocumentStatus': applicantBirthCertificateDeathInfoDocumentStatus,
        'applicantBirthCertificateMarriageDocumentStatus': applicantBirthCertificateMarriageDocumentStatus,
        'applicantEmploymentDocumentStatus': applicantEmploymentDocumentStatus,
        'guarantorNationalId': guarantorNationalId,
        'guarantorMobile': guarantorMobile,
        'personalityType': personalityType,
        'guarantorBirthDate': guarantorBirthDate,
        'applicantResidencyDocumentDescription': applicantResidencyDocumentDescription,
        'guarantorCustomerNumber': guarantorCustomerNumber,
        'guarantorAcceptedGuarantee': guarantorAcceptedGuarantee,
        'applicantResidencyType': applicantResidencyType,
        'applicantResidencyDescription': applicantResidencyDescription,
        'applicantResidencyDocumentId': applicantResidencyDocumentId,
        'applicantAddress': applicantAddress,
        'applicantResidencyTrackingCode': applicantResidencyTrackingCode,
        'applicantProvince': applicantProvince,
        'applicantPostalCode': applicantPostalCode,
        'applicantCity': applicantCity,
        'applicantRejected': applicantRejected,
        'rejectReason': rejectReason,
        'description': description,
      };
}
