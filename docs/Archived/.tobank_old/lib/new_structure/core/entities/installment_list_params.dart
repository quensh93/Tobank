class InstallmentListParams {
  final String installmentType;
  final String nationalCode;
  final String fileNumber;

  const InstallmentListParams({
    required this.installmentType,
    required this.nationalCode,
    required this.fileNumber,
  });

  Map<String, dynamic> toJson() {
    // Ensure all values are proper strings
    final Map<String, String> data = {
      'installment_type': installmentType.trim(),
      'national_code': nationalCode.trim(),
      'file_number': fileNumber.trim(),
    };
    
    // Convert nullish or empty values to empty strings
    data.forEach((key, value) {
      if (value.isEmpty) {
        data[key] = '';
      }
    });
    
    print('🔵 toJson output: $data');
    return data;
  }

  @override
  String toString() {
    return '🔵 InstallmentParams(\n'
        'installmentType: "$installmentType"\n'
        'nationalCode: "$nationalCode"\n'
        'fileNumber: "$fileNumber"\n'
        ')';
  }
}