class DepositsListParams {
  final String customerNumber;

  const DepositsListParams({
    required this.customerNumber,
  });

  Map<String, dynamic> toJson() {
    // Ensure all values are proper strings
    final Map<String, String> data = {
      'customer_number': customerNumber.trim(),
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
    return '🔵 DepositsListParams(\n'
        'customerNumber: "$customerNumber"\n'
        ')';
  }
}