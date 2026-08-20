import 'package:dartz/dartz.dart';
import 'package:test_flutter_project/data/network/app_http_response.dart';

import '../../common/enums/server_failure.dart';

abstract interface class AppInterceptor {
  Future<Either<ServerFailure, String>> onRequest({
    required Future<AppHttpResponse> Function() request,
    required String url,
    required String requestType,
  });

  Future<Either<ServerFailure, String>> onFailure({
    required Object error,
    required String url,
    required String requestType,
  });

  Future<Either<ServerFailure, String>> onResponse({
    required AppHttpResponse response,
    required String url,
    required String requestType,
  });
}
