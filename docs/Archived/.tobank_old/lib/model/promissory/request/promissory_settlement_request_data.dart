import '../../../service/core/api_request_model.dart';

class PromissorySettlementRequest extends ApiRequestModel {
  PromissorySettlementRequest({
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
