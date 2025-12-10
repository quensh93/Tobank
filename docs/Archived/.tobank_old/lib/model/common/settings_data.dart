import '../../widget/svg/svg_icon.dart';

class SettingsItemData {
  SvgIcons icon;
  SvgIcons iconDark;
  String title;
  int event;

  SettingsItemData({
    required this.icon,
    required this.iconDark,
    required this.title,
    required this.event,
  });
}
