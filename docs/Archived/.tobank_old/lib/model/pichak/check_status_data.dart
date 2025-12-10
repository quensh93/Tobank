import 'package:equatable/equatable.dart';

class CheckStatusData extends Equatable {
  final String? title;
  final int? id;

  const CheckStatusData({this.title, this.id});

  @override
  List<Object?> get props => [id, title];
}
