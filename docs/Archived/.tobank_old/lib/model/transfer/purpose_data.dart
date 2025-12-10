import 'package:equatable/equatable.dart';

class PurposeData extends Equatable {
  final int id;
  final String title;

  const PurposeData({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id];
}
