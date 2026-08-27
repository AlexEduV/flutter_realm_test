import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:test_flutter_project/common/enums/request_type.dart';
import 'package:test_flutter_project/common/enums/server_failure.dart';
import 'package:test_flutter_project/data/network/app_http_client.dart';
import 'package:test_flutter_project/data/network/app_http_response.dart';

import '../../data/network/app_interceptor.dart';

class AppHttpClientImpl implements AppHttpClient {
  AppHttpClientImpl(this._client, this._appInterceptor);

  final http.Client _client;
  final AppInterceptor _appInterceptor;

  @override
  Future<Either<ServerFailure, String>> get(Uri url, {Map<String, String>? headers, String? logUrl}) {
    return _appInterceptor.onRequest(
      request: () async {
        return AppHttpResponse.fromHttp(await _client.get(url, headers: headers));
      },
      url: logUrl ?? url.path,
      requestType: HttpRequestType.get.name,
    );
  }

  void close() => _client.close();

  @override
  Future<Either<ServerFailure, String>> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    String? logUrl,
  }) {
    return _appInterceptor.onRequest(
      request: () async {
        return AppHttpResponse.fromHttp(
          await _client.post(url, headers: headers, body: body, encoding: encoding),
        );
      },
      url: logUrl ?? url.path,
      requestType: HttpRequestType.post.name,
    );
  }
}
