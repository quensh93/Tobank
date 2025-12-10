import '../../widget/svg/svg_icon.dart';

class MainMenuItemData {
  String? uuid;
  String? title;
  SvgIcons? icon;
  SvgIcons? iconDark;

  MainMenuItemData({
    required this.uuid,
    this.title,
    this.icon,
    this.iconDark,
  });
}
