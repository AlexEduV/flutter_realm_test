import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:test_futter_project/common/enums/server_failure.dart';
import 'package:test_futter_project/common/logger/base_logger.dart';
import 'package:test_futter_project/core/network/app_http_client.dart';
import 'package:test_futter_project/core/network/network_info.dart';

class AppHttpClientImpl implements AppHttpClient {
  final http.Client _client;
  final NetworkInfo _networkInfo;
  final BaseLogger _logger;

  AppHttpClientImpl(this._client, this._networkInfo, this._logger);

  //the code of error code handling and error handling is usually moved to the interceptor class,
  //because it's the same for all request types.

  @override
  Future<Either<ServerFailure, String>> get(Uri url) async {
    try {
      final isNetworkAvailable = await _networkInfo.isConnected;
      if (!isNetworkAvailable) {
        _logger.log('No Internet connection on GET request at url ${url.path}, 404');
        return const Left(ServerFailure.noNetwork);
      }

      final response = await _client.get(url);

      if (response.statusCode == HttpStatus.notFound) {
        _logger.log('Not Found on GET request at url ${url.path}, 404');
        return const Left(ServerFailure.notFound);
      }

      if (response.statusCode == HttpStatus.unauthorized) {
        _logger.log('Unauthorised on GET request at url ${url.path}, 401');
        return const Left(ServerFailure.unauthorized);
      }

      if (response.statusCode != HttpStatus.ok) {
        _logger.log('Error during GET request at url ${url.path}, status: ${response.statusCode}');
        return const Left(ServerFailure.internalError);
      }

      if (response.body.isEmpty) {
        _logger.log('Empty body on GET request at url ${url.path}, status: ${response.statusCode}');
        return const Left(ServerFailure.notAvailable);
      }

      _logger.log('Successful GET request at url ${url.path}, status: ${response.statusCode}');
      return Right(response.body);
    } catch (e) {
      _logger.log('Error during GET request at url ${url.path}, exception: $e');
      return const Left(ServerFailure.notAvailable);
    }
  }
}
