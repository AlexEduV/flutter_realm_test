import 'package:dartz/dartz.dart';
import 'package:test_futter_project/core/network/server_failure.dart';

abstract class AppHttpClient {
  Future<Either<ServerFailure, String>> get(Uri url);
}
