import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../common/enums/server_failure.dart';

abstract interface class AppInterceptor {
  Future<Either<ServerFailure, String>> onRequest({
    required Future<Response> Function() request,
    required String url,
    required String requestType,
  });

  Future<Either<ServerFailure, String>> onFailure({
    required Object error,
    required String url,
    required String requestType,
  });

  Future<Either<ServerFailure, String>> onResponse({
    required Response response,
    required String url,
    required String requestType,
  });
}
