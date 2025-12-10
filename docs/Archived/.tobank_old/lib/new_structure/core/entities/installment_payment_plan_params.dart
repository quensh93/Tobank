
import 'enums.dart';

class InstallmentPaymentPlanParams {
  // final String installmentType;
  // final String nationalCode;
  final String fileNumber;
  final PaymentType paymentType;
  final int amount;
  final String depositNumber;

  const InstallmentPaymentPlanParams({
    // required this.installmentType,
    // required this.nationalCode,
    required this.fileNumber,
    required this.paymentType,
    required this.amount,
    required this.depositNumber,
  });

  Map<String, dynamic> toJson() {
    // Ensure string values are proper strings and trim them
    final Map<String, dynamic> data = {
      // 'installment_type': installmentType.trim(),
      // 'national_code': nationalCode.trim(),
      'file_number': fileNumber.trim(),
      'amount': amount,
      'deposit_number': depositNumber.trim(),
    };

    // Convert nullish or empty string values to empty strings


    print('🔵 toJson output: $data');
    return data;
  }

  @override
  String toString() {
    return '🔵 InstallmentPaymentPlanParams(\n'
        // 'installmentType: "$installmentType"\n'
        // 'nationalCode: "$nationalCode"\n'
        'fileNumber: "$fileNumber"\n'
        'amount: $amount\n'
        'depositNumber: "$depositNumber"\n'
        ')';
  }
}