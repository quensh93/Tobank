import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/addresses/url_addresses.dart';
import '../../../../core/entities/charge_and_package_list_params.dart';
import '../../../../core/entities/edit_sim_params.dart';
import '../../../../core/services/network/dio/dio_manager.dart';
import '../../../../core/services/network/failures/app_failure/app_failure.dart';
import 'charge_and_package_remote_data_source.dart';

@LazySingleton(as: ChargeAndPackageRemoteDataSource)
class ChargeAndPackageRemoteDataSourceImpl implements ChargeAndPackageRemoteDataSource {
  final DioManager dioManager;
  final UrlAddresses addresses;

  ChargeAndPackageRemoteDataSourceImpl({
    required this.dioManager,
    required this.addresses,
  });

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getProductList(
      ChargeAndPackageListParams request) async {
    return await dioManager.postRequest(
      endpoint: addresses.getProductList,
      data: request.toJson(),
      queryParameters: null, // Not used in the old implementation
      requireToken: true,
      requireEkycSign: false, // Default value
      requireEncryption: false, // Default value
      requireDecryption: false, // Default value
      requireBase64EncodedBody: false, // Default value
      checkVpn: true, // Default value
      successStatusCodes: const [200], // Default value
    );
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> getSimList() async {
    return await dioManager.getRequest(
      endpoint: addresses.getSim,
      data: null, // GET requests typically don't have a body
      queryParameters: {}, // Matches the old implementation
      requireToken: true,
      requireEkycSign: false, // Default value
      requireEncryption: false, // Default value
      requireDecryption: false, // Default value
      requireBase64EncodedBody: false, // Default value
      checkVpn: true, // Default value
      successStatusCodes: const [200], // Default value
    );
  }

  @override
  Future<Either<AppFailure, Map<String, dynamic>>> editSim(
      EditSimCardParams request) async {
    return await dioManager.putRequest(
      endpoint: addresses.getSim,
      data: request.toJson(),
      queryParameters: null, // Not used in the old implementation
      requireToken: true,
      requireEkycSign: false, // Default value
      requireEncryption: false, // Default value
      requireDecryption: false, // Default value
      requireBase64EncodedBody: false, // Default value
      checkVpn: true, // Default value
      successStatusCodes: const [200], // Default value
    );
  }
}