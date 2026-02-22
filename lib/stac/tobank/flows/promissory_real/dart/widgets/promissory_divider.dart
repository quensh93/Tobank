import 'package:stac_core/stac_core.dart';

/// Helper: Promissory Divider
StacWidget buildPromissoryDivider() {
  return StacContainer(
    height: 1,
    color: '{{appColors.current.input.borderEnabled}}',
  );
}
