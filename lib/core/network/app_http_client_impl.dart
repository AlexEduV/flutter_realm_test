import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_futter_project/core/network/app_http_client.dart';

class AppHttpClientImpl implements AppHttpClient {
  final http.Client client;

  AppHttpClientImpl(this.client);

  @override
  Future<String> get(Uri url) async {
    final response = await client.get(url);

    if (response.statusCode != HttpStatus.ok) {
      debugPrint('Error during GET request at url ${url.path}, status: ${response.statusCode}');
      return '';
    }

    if (response.body.isEmpty) {
      debugPrint('Empty body on GET request at url ${url.path}, status: ${response.statusCode}');
      return '';
    }

    return response.body;
  }
}
