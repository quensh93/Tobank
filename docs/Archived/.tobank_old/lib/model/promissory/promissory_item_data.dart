import '../../widget/svg/svg_icon.dart';

class PromissoryItemData {
  String title;
  String subtitle;
  SvgIcons icon;
  SvgIcons iconDark;
  int eventId;

  PromissoryItemData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconDark,
    required this.eventId,
  });
}
