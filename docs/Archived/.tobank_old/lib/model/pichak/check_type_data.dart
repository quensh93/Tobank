import 'package:equatable/equatable.dart';

class CheckTypeData extends Equatable {
  final String? title;
  final String? id;

  const CheckTypeData({this.title, this.id});

  @override
  List<Object?> get props => [id, title];
}
