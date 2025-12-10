import '../../widget/svg/svg_icon.dart';

class TransferMethodData {
  int id;
  String title;
  String description;
  SvgIcons icon;
  SvgIcons iconDark;

  TransferMethodData({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconDark,
  });
}
