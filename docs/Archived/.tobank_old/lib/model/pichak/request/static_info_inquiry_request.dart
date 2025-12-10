import '../../../service/core/api_request_model.dart';
import '../check_material_data.dart';
import '../check_type_data.dart';

class StaticInfoInquiryRequest extends ApiRequestModel {
  StaticInfoInquiryRequest({
    this.chequeId,
  });

  CheckTypeData? selectedCheckTypeData;
  CheckMaterialData? selectedCheckMaterialData;
  String? chequeId;

  @override
  Map<String, dynamic> toJson() => {
        'chequeType': selectedCheckTypeData?.id,
        'chequeId': chequeId,
        'chequeMedia': selectedCheckMaterialData?.id,
      };
}
