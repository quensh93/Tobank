import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/addresses/url_addresses.dart';
import '../../../../core/entities/installment_details_params.dart';
import '../../../../core/entities/installment_list_params.dart';
import '../../../../core/services/network/dio/dio_manager.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';
import 'installment_remote_data_source.dart';

/// Implementation of [InstallmentRemoteDataSource] that fetches installment data
/// from a remote API using [DioManager].
@LazySingleton(as: InstallmentRemoteDataSource)
class InstallmentRemoteDataSourceImpl implements InstallmentRemoteDataSource {
  final DioManager dioManager;
  final UrlAddresses addresses;

  InstallmentRemoteDataSourceImpl({
    required this.addresses,
    required this.dioManager,
  });

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getInstallmentList(
      InstallmentListParams params,
      ) async {
    /// Fetches a list of installments from the API.
    return await dioManager.postRequest(
      endpoint: addresses.getInstallmentList,
      data: params.toJson(),
      requireToken: true,
      successStatusCodes: const [200], // Expect a 200 status code for success
      checkVpn: true, // Ensure no VPN is connected
      requireEkycSign: false, // No request signing needed
      requireEncryption: false, // No encryption needed
      requireDecryption: false, // No decryption needed
      requireBase64EncodedBody: false, // No base64 encoding needed
    );
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getInstallmentDetails(
      InstallmentDetailsParams params,
      ) async {
    /// Fetches details of a specific installment from the API.
    return await dioManager.postRequest(
      endpoint: addresses.getInstallmentDetails,
      data: params.toJson(),
      requireToken: true,
      successStatusCodes: const [200], // Expect a 200 status code for success
      checkVpn: true, // Ensure no VPN is connected
      requireEkycSign: false, // No request signing needed
      requireEncryption: false, // No encryption needed
      requireDecryption: false, // No decryption needed
      requireBase64EncodedBody: false, // No base64 encoding needed
    );
  }
}