// lib/dummy/services/api_service.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'https://httpbin.org/')
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

    // GET endpoints - returns JSON data
  @GET('/get')
  Future<dynamic> getData(@Queries() Map<String, dynamic> queries);

  @GET('/status/{code}')
  Future<void> getStatus(@Path('code') int code);

  // POST endpoints
  @POST('/post')
  Future<dynamic> postData(@Body() Map<String, dynamic> data);

  @POST('/json')
  Future<dynamic> postJson(@Body() Map<String, dynamic> json);

  // PUT endpoint
  @PUT('/put')
  Future<dynamic> putData(@Body() Map<String, dynamic> data);

  // DELETE endpoint
  @DELETE('/delete')
  Future<dynamic> deleteData();

  // Headers endpoint
  @GET('/headers')
  Future<dynamic> getHeaders();

  // User agent endpoint
  @GET('/user-agent')
  Future<dynamic> getUserAgent();
}
