import '../../../service/core/api_request_model.dart';

class BillDataRequest extends ApiRequestModel {
  BillDataRequest({
    this.billIdentifier,
    this.payId,
    this.mobile = '',
    this.phone = '',
    this.barcode = '',
    this.isStore,
    this.isMidTerm,
    this.title,
    this.customerId,
    this.plateNumber,
  });

  String? billIdentifier;
  String? payId;
  String? mobile;
  String? phone;
  String? barcode;
  bool? isStore;
  bool? isMidTerm;
  String? title;
  String? customerId;
  String? plateNumber;

  @override
  Map<String, dynamic> toJson() => {
        'bill_identifier': billIdentifier,
        'pay_id': payId,
        'mobile': mobile,
        'phone': phone,
        'barcode': barcode,
        'is_store': isStore,
        'midterm': isMidTerm,
        'title': title,
        'customer_id': customerId,
        'plate_number': plateNumber,
      };
}
