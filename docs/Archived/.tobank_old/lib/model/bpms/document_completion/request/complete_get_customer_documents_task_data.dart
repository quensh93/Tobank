import '../../request/complete_task_request_data.dart';
import '../customer_document.dart';

class GetCustomerDocumentsTaskData extends CompleteTaskRequestData {
  RequiredCustomerDocuments requiredCustomerDocuments;

  GetCustomerDocumentsTaskData({
    required this.requiredCustomerDocuments,
  });

  @override
  Map<String, dynamic> toJson() => {
        'requiredCustomerDocuments': requiredCustomerDocuments.toJson(),
      };
}

class RequiredCustomerDocuments {
  CustomerDocumentValue? value;

  RequiredCustomerDocuments({
    this.value,
  });

  Map<String, dynamic> toJson() => {
        'value': value?.toJson(),
      };
}

class CustomerDocumentValue {
  List<CustomerDocument>? customerDocuments;

  CustomerDocumentValue({
    this.customerDocuments,
  });

  Map<String, dynamic> toJson() => {
        'customerDocuments':
            customerDocuments == null ? [] : List<dynamic>.from(customerDocuments!.map((x) => x.toJson())),
      };
}
