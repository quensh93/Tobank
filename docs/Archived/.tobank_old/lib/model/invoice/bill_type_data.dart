import 'package:equatable/equatable.dart';

import '../../widget/svg/svg_icon.dart';

class BillTypeData extends Equatable {
  final int id;
  final String title;
  final SvgIcons icon;
  final SvgIcons iconDark;

  const BillTypeData({
    required this.id,
    required this.title,
    required this.icon,
    required this.iconDark,
  });

  @override
  List<Object?> get props => [id];
}
