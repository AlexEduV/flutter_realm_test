import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_futter_project/core/network/app_http_client.dart';
import 'package:test_futter_project/core/network/server_failure.dart';

class AppHttpClientImpl implements AppHttpClient {
  final http.Client client;

  AppHttpClientImpl(this.client);

  @override
  Future<Either<ServerFailure, String>> get(Uri url) async {
    final response = await client.get(url);

    if (response.statusCode != HttpStatus.ok) {
      debugPrint('Error during GET request at url ${url.path}, status: ${response.statusCode}');
      return const Left(ServerFailure.internalError);
    }

    if (response.body.isEmpty) {
      debugPrint('Empty body on GET request at url ${url.path}, status: ${response.statusCode}');
      return const Left(ServerFailure.notAvailable);
    }

    return Right(response.body);
  }
}
