import 'package:dartz/dartz.dart';
import 'package:test_flutter_project/common/enums/server_failure.dart';

abstract class AppHttpClient {
  Future<Either<ServerFailure, String>> get(Uri url);
}
