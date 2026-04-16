import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:test_flutter_project/common/logger/base_logger.dart';
import 'package:test_flutter_project/core/network/base_interceptor.dart';
import 'package:test_flutter_project/core/network/network_info.dart';

import '../../common/enums/server_failure.dart';

class AppInterceptor implements BaseInterceptor {
  final NetworkInfo _networkInfo;
  final String _path;
  final BaseLogger _logger;
  final String _requestType;

  AppInterceptor(this._networkInfo, this._path, this._logger, this._requestType);

  @override
  Future<Either<ServerFailure, String>> onRequest(Future<Response> Function() request) async {
    try {
      final isNetworkAvailable = await _networkInfo.isConnected;
      if (!isNetworkAvailable) {
        _logger.e('No Internet connection on $_requestType request at url $_path, 404');
        return const Left(ServerFailure.noNetwork);
      }

      final response = await request();

      if (response.statusCode == HttpStatus.notFound) {
        _logger.e('Not Found on $_requestType request at url $_path, 404');
        return const Left(ServerFailure.notFound);
      }

      if (response.statusCode == HttpStatus.unauthorized) {
        _logger.e('Unauthorised on $_requestType request at url $_path, 401');
        return const Left(ServerFailure.unauthorized);
      }

      if (response.statusCode != HttpStatus.ok) {
        _logger.e(
          'Error during $_requestType request at url $_path, status: ${response.statusCode}',
        );
        return const Left(ServerFailure.internalError);
      }

      if (response.body.isEmpty) {
        _logger.e(
          'Empty body on $_requestType request at url $_path, status: ${response.statusCode}',
        );
        return const Left(ServerFailure.notAvailable);
      }

      _logger.i('Successful $_requestType request at url $_path, status: ${response.statusCode}');
      return Right(response.body);
    } catch (e) {
      _logger.e('Error during $_requestType request at url $_path, exception: $e');
      return const Left(ServerFailure.notAvailable);
    }
  }
}
