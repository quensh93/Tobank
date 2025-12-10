import 'package:equatable/equatable.dart';

class BPMSOwnershipData extends Equatable {
  final String title;
  final int id;
  final String key;

  const BPMSOwnershipData({
    required this.title,
    required this.id,
    required this.key,
  });

  @override
  List<Object?> get props => [id];
}
