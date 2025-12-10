import '../../widget/svg/svg_icon.dart';

class PichakItemData {
  int? eventId;
  SvgIcons iconName;
  SvgIcons iconDark;
  String? title;
  String? description;

  PichakItemData({
    required this.iconName,
    required this.iconDark,
    this.eventId,
    this.title,
    this.description,
  });
}
