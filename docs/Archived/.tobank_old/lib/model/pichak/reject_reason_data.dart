import 'package:equatable/equatable.dart';

class RejectReasonData extends Equatable {
  final String title;
  final int id;

  const RejectReasonData({required this.title, required this.id});

  @override
  List<Object?> get props => [id];
}
