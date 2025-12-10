import '../widget/svg/svg_icon.dart';

class ServiceItemData {
  String title;
  SvgIcons icon;
  SvgIcons iconDark;
  int eventCode;

  ServiceItemData({
    required this.title,
    required this.icon,
    required this.iconDark,
    required this.eventCode,
  });
}
