import 'package:stac_core/stac_core.dart';

class StacCloseDialogAction extends StacAction {
  final dynamic result;

  const StacCloseDialogAction({this.result});

  @override
  String get actionType => 'closeDialog';

  @override
  Map<String, dynamic> toJson() {
    return {'actionType': 'closeDialog', if (result != null) 'result': result};
  }
}
