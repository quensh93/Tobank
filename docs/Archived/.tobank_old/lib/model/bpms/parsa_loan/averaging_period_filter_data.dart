import 'package:equatable/equatable.dart';

class AveragingPeriodFilterData extends Equatable {
  final String? title;
  final int? durationInMonths;

  const AveragingPeriodFilterData({this.title, this.durationInMonths});

  @override
  List<Object?> get props => [durationInMonths];
}
