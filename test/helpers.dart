import 'package:dio/dio.dart';

extension CustomDioException on DioException {
  static badResponse() => DioException.badResponse(
      statusCode: 404,
      requestOptions: RequestOptions(),
      response: Response(requestOptions: RequestOptions()));
  static connectionTimeout() => DioException.connectionTimeout(
      requestOptions: RequestOptions(), timeout: const Duration(seconds: 1));
}
