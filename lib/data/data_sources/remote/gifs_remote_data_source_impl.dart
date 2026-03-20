import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/domain/data_sources/remote/gifs_remote_data_source.dart';

class GifsRemoteDataSourceImpl implements GifsRemoteDataSource {
  final http.Client client;

  GifsRemoteDataSourceImpl(this.client);

  @override
  Future<List<String>> searchGifs(String query) async {
    final response = await client.get(Uri.parse(AppConstants.klipyApiHost));

    //todo: helper enum class with status codes would be nice here
    if (response.statusCode != 200) {
      //todo: add logs
      return [];
    }

    final results = jsonDecode(response.body)['results'];
    return results;
  }
}
