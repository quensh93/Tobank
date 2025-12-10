import '../model/common/config_by_title_response_data.dart';
import 'core/api_core.dart';

class ConfigByTitleServices {
  ConfigByTitleServices._();

  static Future<ApiResult<(ConfigByTitleResponse, int), ApiException>> getReIssuanceFee() async {
    return await ApiClient.instance.requestJson(
      apiProviderEnum: ApiProviderEnum.getConfigByTitle,
      slug: 'dibalite_reissuance_price',
      modelFromJson: (responseBody, statusCode) => ConfigByTitleResponse.fromJson(responseBody),
    );
  }
}
