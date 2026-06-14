import 'package:stac/stac.dart';

/// Helper: Promissory Divider (dashed style similar to MySeparator)
StacWidget buildPromissoryDivider() {
  return StacRow(
    mainAxisAlignment: StacMainAxisAlignment.spaceBetween,
    children: List.generate(
      40,
      (_) => StacContainer(
        width: 3,
        height: 1,
        color: '{{appColors.current.input.borderEnabled}}',
      ),
    ),
  );
}
