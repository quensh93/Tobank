import 'package:equatable/equatable.dart';

class CheckMaterialData extends Equatable {
  final String? title;
  final String? id;

  const CheckMaterialData({this.title, this.id});

  @override
  List<Object?> get props => [id, title];
}
