import 'package:stac_core/stac_core.dart';

/// Helper: Promissory Detail Row
StacWidget buildPromissoryDetailRow(String label, String value) {
  return StacRow(
    textDirection: StacTextDirection.rtl,
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    crossAxisAlignment: StacCrossAxisAlignment.start,
    children: [
      StacExpanded(
        child: StacText(
          data: label,
          textDirection: StacTextDirection.rtl,
          style: StacCustomTextStyle(
            fontSize: 14,
            color: '{{appColors.current.text.subtitle}}',
          ),
        ),
      ),
      StacSizedBox(width: 16),
      StacExpanded(
        child: StacText(
          data: value,
          textDirection: StacTextDirection.rtl,
          textAlign: StacTextAlign.left,
          style: StacCustomTextStyle(
            fontSize: 14,
            fontWeight: StacFontWeight.w600,
            color: '{{appColors.current.text.title}}',
          ),
        ),
      ),
    ],
  );
}
