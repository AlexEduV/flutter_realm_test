import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:test_flutter_project/data/network/app_interceptor.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';

import '../../common/enums/server_failure.dart';

class AppInterceptorImpl implements AppInterceptor {
  AppInterceptorImpl(this._logger);

  final LoggingService _logger;

  //todo: implement authorisation with token for Klipy here

  @override
  Future<Either<ServerFailure, String>> onRequest({
    required Future<Response> Function() request,
    required String url,
    required String requestType,
  }) async {
    try {
      final response = await request();
      return onResponse(response: response, url: url, requestType: requestType);
    } catch (e) {
      return onFailure(error: e, url: url, requestType: requestType);
    }
  }

  @override
  Future<Either<ServerFailure, String>> onFailure({
    required Object error,
    required String url,
    required String requestType,
  }) async {
    if (error is SocketException) {
      _logger.error('No network on $requestType request at url $url, exception: $error');
      return const Left(ServerFailure.noNetwork);
    }
    _logger.error('Error during $requestType request at url $url, exception: $error');
    return const Left(ServerFailure.notAvailable);
  }

  @override
  Future<Either<ServerFailure, String>> onResponse({
    required Response response,
    required String url,
    required String requestType,
  }) async {
    if (response.statusCode == HttpStatus.notFound) {
      _logger.error('Not Found on $requestType request at url $url, 404');
      return const Left(ServerFailure.notFound);
    }

    if (response.statusCode == HttpStatus.unauthorized) {
      _logger.error('Unauthorised on $requestType request at url $url, 401');
      return const Left(ServerFailure.unauthorized);
    }

    if (response.statusCode != HttpStatus.ok) {
      _logger.error(
        'Error during $requestType request at url $url, status: ${response.statusCode}',
      );
      return const Left(ServerFailure.internalError);
    }

    if (response.body.isEmpty) {
      _logger.error(
        'Empty body on $requestType request at url $url, status: ${response.statusCode}',
      );
      return const Left(ServerFailure.notAvailable);
    }

    _logger.info('Successful $requestType request at url $url, status: ${response.statusCode}');
    return Right(response.body);
  }
}
