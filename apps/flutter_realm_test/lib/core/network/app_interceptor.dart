import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:test_flutter_project/common/logger/base_logger.dart';
import 'package:test_flutter_project/core/network/base_interceptor.dart';
import 'package:test_flutter_project/core/network/network_info.dart';

import '../../common/enums/server_failure.dart';

class AppInterceptor implements BaseInterceptor {
  final NetworkInfo _networkInfo;
  final BaseLogger _logger;

  AppInterceptor(this._networkInfo, this._logger);

  @override
  Future<Either<ServerFailure, String>> onRequest(
    Future<Response> Function() request,
    String url,
    String requestType,
  ) async {
    try {
      final isNetworkAvailable = await _networkInfo.isConnected;
      if (!isNetworkAvailable) {
        _logger.e('No Internet connection on $requestType request at url $url, 404');
        return const Left(ServerFailure.noNetwork);
      }

      final response = await request();

      if (response.statusCode == HttpStatus.notFound) {
        _logger.e('Not Found on $request request at url $url, 404');
        return const Left(ServerFailure.notFound);
      }

      if (response.statusCode == HttpStatus.unauthorized) {
        _logger.e('Unauthorised on $requestType request at url $url, 401');
        return const Left(ServerFailure.unauthorized);
      }

      if (response.statusCode != HttpStatus.ok) {
        _logger.e('Error during $requestType request at url $url, status: ${response.statusCode}');
        return const Left(ServerFailure.internalError);
      }

      if (response.body.isEmpty) {
        _logger.e('Empty body on $requestType request at url $url, status: ${response.statusCode}');
        return const Left(ServerFailure.notAvailable);
      }

      _logger.i('Successful $requestType request at url $url, status: ${response.statusCode}');
      return Right(response.body);
    } catch (e) {
      _logger.e('Error during $requestType request at url $url, exception: $e');
      return const Left(ServerFailure.notAvailable);
    }
  }
}
