import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

import '../../common/enums/server_failure.dart';

abstract class BaseInterceptor {
  Future<Either<ServerFailure, String>> onRequest(Future<Response> Function() request);
}
