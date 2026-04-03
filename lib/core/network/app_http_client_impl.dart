import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/core/network/app_http_client.dart';
import 'package:test_futter_project/core/network/server_failure.dart';

class AppHttpClientImpl implements AppHttpClient {
  final http.Client client;

  AppHttpClientImpl(this.client);

  @override
  Future<Either<ServerFailure, String>> get(Uri url) async {
    try {
      final response = await client.get(url);

      if (response.statusCode == HttpStatus.notFound) {
        if (AppConstants.showNetworkLogs) {
          debugPrint('Not Found on GET request at url ${url.path}, 404');
        }
        return const Left(ServerFailure.notFound);
      }

      if (response.statusCode == HttpStatus.unauthorized) {
        if (AppConstants.showNetworkLogs) {
          debugPrint('Unauthorised on GET request at url ${url.path}, 401');
        }
        return const Left(ServerFailure.unauthorized);
      }

      if (response.statusCode != HttpStatus.ok) {
        if (AppConstants.showNetworkLogs) {
          debugPrint('Error during GET request at url ${url.path}, status: ${response.statusCode}');
        }
        return const Left(ServerFailure.internalError);
      }

      if (response.body.isEmpty) {
        if (AppConstants.showNetworkLogs) {
          debugPrint(
            'Empty body on GET request at url ${url.path}, status: ${response.statusCode}',
          );
        }
        return const Left(ServerFailure.notAvailable);
      }

      if (AppConstants.showNetworkLogs) {
        debugPrint('Successful GET request at url ${url.path}, status: ${response.statusCode}');
      }
      return Right(response.body);
    } catch (e) {
      debugPrint('Error during GET request at url ${url.path}, exception: $e');
      return const Left(ServerFailure.noNetwork);
    }
  }
}
