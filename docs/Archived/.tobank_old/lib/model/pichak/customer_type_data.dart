import 'package:equatable/equatable.dart';

class CustomerTypeData extends Equatable {
  final String? title;
  final int? id;

  const CustomerTypeData({this.title, this.id});

  @override
  List<Object?> get props => [id, title];
}
