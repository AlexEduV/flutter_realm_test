import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:test_flutter_project/data/network/app_http_response.dart';
import 'package:test_flutter_project/data/network/app_interceptor.dart';
import 'package:test_flutter_project/domain/services/logging_service.dart';

import '../../common/enums/server_failure.dart';

class AppInterceptorImpl implements AppInterceptor {
  AppInterceptorImpl({required this.loggingService, this.isVerboseOutput = false});

  final LoggingService loggingService;
  final bool isVerboseOutput;

  @override
  Future<Either<ServerFailure, String>> onRequest({
    required Future<AppHttpResponse> Function() request,
    required String url,
    required String requestType,
  }) async {
    loggingService.info('-> $requestType $url');

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
      loggingService.error('No network on $requestType request at url $url, exception: $error');
      return const Left(ServerFailure.noNetwork);
    }
    loggingService.error('Error during $requestType request at url $url, exception: $error');
    return const Left(ServerFailure.notAvailable);
  }

  @override
  Future<Either<ServerFailure, String>> onResponse({
    required AppHttpResponse response,
    required String url,
    required String requestType,
  }) async {
    loggingService.info('<- $requestType ${response.statusCode} $url');

    if (response.statusCode == HttpStatus.notFound) {
      if (isVerboseOutput) {
        loggingService.error('Not Found on $requestType request at url $url, 404');
      }
      return const Left(ServerFailure.notFound);
    }

    if (response.statusCode == HttpStatus.unauthorized) {
      if (isVerboseOutput) {
        loggingService.error('Unauthorised on $requestType request at url $url, 401');
      }
      return const Left(ServerFailure.unauthorized);
    }

    if (response.statusCode != HttpStatus.ok) {
      if (isVerboseOutput) {
        loggingService.error(
          'Error during $requestType request at url $url, status: ${response.statusCode}',
        );
      }
      return const Left(ServerFailure.internalError);
    }

    if (response.body.isEmpty) {
      if (isVerboseOutput) {
        loggingService.error(
          'Empty body on $requestType request at url $url, status: ${response.statusCode}',
        );
      }
      return const Left(ServerFailure.notAvailable);
    }

    if (isVerboseOutput) {
      loggingService.info(
        'Successful $requestType request at url $url, status: ${response.statusCode}',
      );
    }
    return Right(response.body);
  }
}
