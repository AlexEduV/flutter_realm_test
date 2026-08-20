import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../common/enums/server_failure.dart';

abstract interface class AppInterceptor {
  Future<Either<ServerFailure, String>> onRequest({
    required Future<Response> Function() request,
    required String url,
    required String requestType,
  });

  //todo: implement onFailure for logging unification

  //todo: implement onResponse

  //todo: learn what 'base' keyword does
}
