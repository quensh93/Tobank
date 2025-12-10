import 'package:equatable/equatable.dart';

class CheckBlockStatusData extends Equatable {
  final String? title;
  final int? id;

  const CheckBlockStatusData({this.title, this.id});

  @override
  List<Object?> get props => [id, title];
}
