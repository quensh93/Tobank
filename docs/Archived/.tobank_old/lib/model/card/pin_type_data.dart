import '../../widget/svg/svg_icon.dart';

class PinTypeData {
  String title;
  SvgIcons icon;
  SvgIcons iconDark;
  int eventId;

  PinTypeData({
    required this.title,
    required this.icon,
    required this.iconDark,
    required this.eventId,
  });
}
