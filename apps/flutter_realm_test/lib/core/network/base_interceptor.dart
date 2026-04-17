import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../common/enums/server_failure.dart';

abstract class BaseInterceptor {
  Future<Either<ServerFailure, String>> onRequest({
    required Future<Response> Function() request,
    required String url,
    required String requestType,
  });
}
