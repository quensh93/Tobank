import 'package:equatable/equatable.dart';

class InternetPlanFilterData extends Equatable {
  final String? title;
  final List<int>? durationInHours;
  final int? index;

  const InternetPlanFilterData({this.title, this.durationInHours, this.index});

  @override
  List<Object?> get props => [index];
}
