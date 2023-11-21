import 'package:dio/dio.dart';

const String _tmdbApiKey = String.fromEnvironment("tmdbApiKey");
const String _tmdbAccessToken = String.fromEnvironment("tmdbAccessToken");

class TmdbCustomDio {
  static final TmdbCustomDio _singleton = TmdbCustomDio._internal();

  factory TmdbCustomDio() {
    return _singleton;
  }

  TmdbCustomDio._internal();

  late final Dio dio = Dio()..options.headers = headers;
  final Map<String, dynamic> headers = {
    "Authorization": "Bearer $_tmdbAccessToken",
    "accept": "application/json"
  };
}
