import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter_project/common/enums/request_type.dart';
import 'package:test_flutter_project/common/enums/server_failure.dart';
import 'package:test_flutter_project/common/logger/base_logger.dart';
import 'package:test_flutter_project/core/network/app_http_client.dart';
import 'package:test_flutter_project/core/network/app_interceptor.dart';
import 'package:test_flutter_project/core/network/network_info.dart';

class AppHttpClientImpl implements AppHttpClient {
  final http.Client _client;
  final NetworkInfo _networkInfo;
  final BaseLogger _logger;

  AppHttpClientImpl(this._client, this._networkInfo, this._logger);

  late final appInterceptor = AppInterceptor(_networkInfo, _logger);

  @override
  Future<Either<ServerFailure, String>> get(Uri url, {Map<String, String>? headers}) {
    return appInterceptor.onRequest(
      request: () => _client.get(url, headers: headers),
      url: url.path,
      requestType: HttpRequestType.get.label,
    );
  }

  @override
  Future<Either<ServerFailure, String>> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) {
    return appInterceptor.onRequest(
      request: () => _client.post(url, headers: headers, body: body, encoding: encoding),
      url: url.path,
      requestType: HttpRequestType.get.label,
    );
  }
}
