# Documentation Dio Latest Dio Dio-Library.Html

[](https://pub.dev/)
  1. 
  2. 
  3. dio.dart

dio.dart

#  dio library [](https://pub.dev/documentation/dio/latest/topics/Migration%20Guide-topic.html) [](https://pub.dev/documentation/dio/latest/topics/-topic.html)
A powerful HTTP client for Dart and Flutter, which supports global settings, Interceptors, FormData, aborting and canceling a request, files uploading and downloading, requests timeout, custom adapters, etc.
## Classes 

Background 
     The default [](https://pub.dev/documentation/dio/latest/dio/-class.html) for Dio.  

BaseOptions 
     A set of base settings for each `Dio()`. BaseOptions and Options will be merged into one RequestOptions before sending the requests. See Options.compose.  

CancelToken 
     Controls cancellation of Dio's requests.  

Dio 
     Dio enables you to make HTTP requests easily.  

DioMixin 

ErrorInterceptorHandler 
     The handler for interceptors to handle error occurred during the request.  

FormData 
     A class to create readable "multipart/form-data" streams. It can be used to submit forms and file uploads to http server.  

Fused 
     A [](https://pub.dev/documentation/dio/latest/dio/-class.html) that has a fast path for decoding UTF8-encoded JSON. If the response is utf8-encoded JSON and no custom decoder is specified in the RequestOptions, this transformer is significantly faster than the default Sync and the Background. This improvement is achieved by using a fused Utf8Decoder and JsonDecoder to decode the response, which is faster than decoding the utf8-encoded JSON in two separate steps, since Dart uses a special fast decoder for this case. See  

Headers 
     The headers class for requests and responses.  

[](https://pub.dev/documentation/dio/latest/dio/-class.html) 
     `HttpAdapter` is a bridge between Dio and HttpClient.  

Interceptor 
     Interceptor helps to deal with RequestOptions, Response, and DioException during the lifecycle of a request before it reaches users.  

Interceptors 
     A Queue-Model list for Interceptors.  

InterceptorsWrapper 
     A helper class to create interceptors in ease.  

ListParam 
     Indicates a param being used as queries or form data, and how does it gets formatted.  

LogInterceptor 
     LogInterceptor is used to print logs during network requests. It should be the last interceptor added, otherwise modifications by following interceptors will not be logged. This is because the execution of interceptors is in the order of addition.  

MultipartFile 
     An upload content that is a part of `MultipartRequest`. This doesn't need to correspond to a physical file.  

Options 
     The configuration for a single request. BaseOptions and Options will be merged into one RequestOptions before sending the requests. See Options.compose.  

QueuedInterceptor 
     Interceptor in queue.  

QueuedInterceptorsWrapper 
     A helper class to create QueuedInterceptor in ease.  

RedirectRecord 
     A record that records the redirection happens during requests, including status code, request method, and the location.  

RequestInterceptorHandler 
     The handler for interceptors to handle before the request has been sent.  

RequestOptions 
     The internal request option class that is the eventual result after BaseOptions and Options are composed.  

Response 
     The Response class contains the payload (could be transformed) that respond from the request, and other information of the response.  

ResponseBody 
     The response wrapper class for adapters.  

ResponseInterceptorHandler 
     The handler for interceptors to handle after respond.  

Sync 
     If you want to custom the transformation of request/response data, you can provide a [](https://pub.dev/documentation/dio/latest/dio/-class.html) by your self, and replace the transformer by setting the Dio.transformer.  

[](https://pub.dev/documentation/dio/latest/dio/-class.html) 
     [](https://pub.dev/documentation/dio/latest/dio/-class.html) allows changes to the request/response data before it is sent/received to/from the server. 
## Enums 

DioExceptionType 
     The exception enumeration indicates what type of exception has happened during requests.  

FileAccessMode 
     The file access mode when downloading a file, corresponds to a subset of dart:io::FileMode.  

ListFormat 
     Specifies the array format (a single parameter with multiple parameter or multiple parameters with the same name). and the separator for array items.  

ResponseType 
     Indicates which transformation should be applied to the response data. 
## Mixins 

OptionsMixin 
     The mixin class for options that provides common attributes. 
## Functions 

defaultDioExceptionReadableStringBuilder(DioException e) → String 
     The default implementation of building a readable string of DioException. 
## Typedefs 

Default = Sync 

DioError = DioException 
     DioError describes the exception info when a request failed.  

DioErrorType = DioExceptionType 
     Deprecated in favor of DioExceptionType and will be removed in future major versions.  

DioExceptionReadableStringBuilder = String Function(DioException e) 
     The readable string builder's signature of DioException.readableStringBuilder.  

DioMediaType = MediaType 
     The type (alias) for specifying the content-type of the `MultipartFile`.  

HeaderForEachCallback = void Function(String name, List values) 
     The signature that iterates header fields.  

InterceptorErrorCallback = void Function(DioException error, ErrorInterceptorHandler handler) 
     The signature of Interceptor.onError.  

InterceptorSendCallback = void Function(RequestOptions options, RequestInterceptorHandler handler) 
     The signature of Interceptor.onRequest.  

InterceptorSuccessCallback = void Function(Response response, ResponseInterceptorHandler handler) 
     The signature of Interceptor.onResponse.  

JsonDecodeCallback = FutureOr Function(String) 
     The callback definition for decoding a JSON string.  

JsonEncodeCallback = FutureOr Function(Object) 
     The callback definition for encoding a JSON object.  

ProgressCallback = void Function(int count, int total) 
     The type of a progress listening callback when sending or receiving data.  

RequestEncoder = FutureOr> Function(String request, RequestOptions options) 
     The type of a request encoding callback.  

ResponseDecoder = FutureOr Function(List responseBytes, RequestOptions options, ResponseBody responseBody) 
     The type of a response decoding callback.  

ValidateStatus = bool Function(int? status) 
     The type of a response status code validate callback. 
## Exceptions / Errors 

DioException 
     DioException describes the exception info when a request failed.  

NotNullableError 
     A TypeError thrown by `_checkNotNullable`. 
  1. 
  2. 
  3. dio.dart

#####  dio package
  1. Topics
  2. [](https://pub.dev/documentation/dio/latest/topics/Migration%20Guide-topic.html)
  3. [](https://pub.dev/documentation/dio/latest/topics/-topic.html)
  4. 
  5. browser
  6. io
  7. 
  8. dio
  9. 
  10. dio

##### dio library
dio 5.9.0