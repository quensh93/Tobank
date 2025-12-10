import 'package:equatable/equatable.dart';

class CloseDepositTypeItemData extends Equatable {
  final String title;
  final int id;
  final String value;

  const CloseDepositTypeItemData({
    required this.title,
    required this.id,
    required this.value,
  });

  @override
  List<Object?> get props => [id];
}
