import 'dart:async';

import '../model/common/base_response_data.dart';
import '../model/invoice/invoice_data.dart';
import '../model/invoice/request/bill_data_request.dart';
import '../model/invoice/request/get_bill_detail_by_pay_id_bill_id_request.dart';
import '../model/invoice/response/bill_data_response.dart';
import '../model/invoice/response/bill_detail_data.dart';
import '../model/invoice/response/bill_inquiry_response.dart';
import '../model/invoice/response/list_bill_data.dart';
import '../model/invoice/response/pay_bill_data.dart';
import '../model/transaction/response/transaction_data_response.dart';
import 'core/api_core.dart';

class InvoiceServices {
  InvoiceServices._();

  static Future<ApiResult<(BillInquiryDataResponse, int), ApiException>> getBillDetailDataRequest({
    required BillDataRequest billDataRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getBillDetail,
        data: billDataRequest,
        modelFromJson: (responseBody, statusCode) => BillInquiryDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(PayBillData, int), ApiException>> payBillInternetRequest({
    required InvoiceData invoiceData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.payBill,
        data: invoiceData,
        modelFromJson: (responseBody, statusCode) => PayBillData.fromJson(responseBody));
  }

  static Future<ApiResult<(TransactionDataResponse, int), ApiException>> payBillWalletRequest({
    required InvoiceData invoiceData,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.payBill,
        data: invoiceData,
        modelFromJson: (responseBody, statusCode) => TransactionDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(BillDetailData, int), ApiException>> getBillDetailWithPayIdBillId({
    required GetBillDetailByPayIdBillIdRequest getBillDetailRequest,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getBillDetailWithPayIdBillId,
        data: getBillDetailRequest,
        modelFromJson: (responseBody, statusCode) => BillDetailData.fromJson(responseBody));
  }

  static Future<ApiResult<(ListBillData, int), ApiException>> getBillListRequest() async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.getUserBills,
        modelFromJson: (responseBody, statusCode) => ListBillData.fromJson(responseBody));
  }

  static Future<ApiResult<(BillDataResponse, int), ApiException>> updateBillRequest({
    required BillDataRequest billDataRequest,
    required int billId,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.updateBillRequest,
        slug: billId.toString(),
        data: billDataRequest,
        modelFromJson: (responseBody, statusCode) => BillDataResponse.fromJson(responseBody));
  }

  static Future<ApiResult<(BaseResponseData, int), ApiException>> deleteBillRequest({
    required int billId,
  }) async {
    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.deleteBillRequest,
        slug: billId.toString(),
        modelFromJson: (responseBody, statusCode) => BaseResponseData.fromJson(responseBody));
  }

  static Future<ApiResult<(BillInquiryDataResponse, int), ApiException>> inquiryBillRequest({
    required int billId,
  }) async {
    final Map<String, dynamic> queryParameters = <String, dynamic>{};
    queryParameters['id'] = billId;

    return await ApiClient.instance.requestJson(
        apiProviderEnum: ApiProviderEnum.inquiryBillRequest,
        queryParameters: queryParameters,
        modelFromJson: (responseBody, statusCode) => BillInquiryDataResponse.fromJson(responseBody));
  }
}
