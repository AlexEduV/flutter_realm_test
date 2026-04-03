import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/constants/api_constants.dart';
import '../../../domain/data_sources/local/url_launch_local_data_source.dart';

class UrlLaunchLocalDataSourceImpl implements UrlLaunchLocalDataSource {
  @override
  Future<void> openUrl(String? url) async {
    final link = Uri.parse('${ApiConstants.webHost}${url ?? ''}');
    try {
      await launchUrl(link);
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }
}
