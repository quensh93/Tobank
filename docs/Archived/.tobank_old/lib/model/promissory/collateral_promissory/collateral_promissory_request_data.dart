class CollateralPromissoryRequestData {
  CollateralPromissoryRequestData({
    required this.amount,
    required this.dueDate,
    required this.description,
    required this.transferable,
    required this.recipientNN,
    required this.recipientCellPhone,
  });

  final int amount;
  final String? dueDate; // On specific date, date format must be 'yyyy-MM-dd' in jalali calendar
  final String? description;
  final bool transferable;
  final String recipientNN;
  final String recipientCellPhone;
}
