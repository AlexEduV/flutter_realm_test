import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:test_flutter_project/common/enums/server_failure.dart';

abstract interface class AppHttpClient {
  Future<Either<ServerFailure, String>> get(Uri url, {Map<String, String>? headers, String? logUrl});
  Future<Either<ServerFailure, String>> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
    String? logUrl,
  });
}
