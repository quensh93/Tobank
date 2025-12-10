import '../../../service/core/api_request_model.dart';

class PromissorySettlementGradualRequest extends ApiRequestModel {
  PromissorySettlementGradualRequest({
    required this.promissoryId,
    required this.ownerNn,
    required this.settlementAmount,
  });

  String promissoryId;
  String ownerNn;
  int settlementAmount;

  @override
  Map<String, dynamic> toJson() => {
        'promissoryId': promissoryId,
        'ownerNN': ownerNn,
        'settlementAmount': settlementAmount,
      };
}
