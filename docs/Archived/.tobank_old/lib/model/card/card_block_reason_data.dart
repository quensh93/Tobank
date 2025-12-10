import 'package:equatable/equatable.dart';

class CardBlockReasonData extends Equatable {
  final String title;
  final int id;

  const CardBlockReasonData({
    required this.title,
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
