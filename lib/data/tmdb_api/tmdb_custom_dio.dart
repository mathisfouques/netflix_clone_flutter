import 'package:dio/dio.dart';

const String tmdbApiKey = String.fromEnvironment("tmdbApiKey");
const String tmdbAccessToken = String.fromEnvironment("tmdbAccessToken");

class TmdbCustomDio {
  static final TmdbCustomDio _singleton = TmdbCustomDio._internal();

  factory TmdbCustomDio() {
    return _singleton;
  }

  TmdbCustomDio._internal();

  late final Dio dio = Dio()..options.headers = headers;
  final Map<String, dynamic> headers = {
    "Authorization": "Bearer $tmdbAccessToken",
    "accept": "application/json"
  };
}
