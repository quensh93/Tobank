import '../../widget/svg/svg_icon.dart';

class MenuData {
  String title;
  int id;
  SvgIcons icon;
  SvgIcons iconDark;

  MenuData({
    required this.title,
    required this.id,
    required this.icon,
    required this.iconDark,
  });
}
