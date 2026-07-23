import 'package:test_flutter_project/common/logger/base_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/constants/api_constants.dart';
import '../../domain/services/external_link_service.dart';

class ExternalLinkServiceImpl implements ExternalLinkService {
  ExternalLinkServiceImpl(this._logger);

  final BaseLogger _logger;

  @override
  Future<void> openUrl(String? url) async {
    final link = Uri.parse('${ApiConstants.webHost}${url ?? ''}');
    try {
      await launchUrl(link);
    } catch (e) {
      _logger.e('Could not launch $url: $e');
    }
  }
}
