import 'package:share_plus/share_plus.dart';

import '../../domain/models/share_params_model.dart';

class ShareDebouncer {
  static bool _isShareInProgress = false;

  static Future<void> share(ShareParamsModel model) async {
    if (_isShareInProgress) return;

    //iOS 26 fix is not needed when using the newest version of plugin;

    _isShareInProgress = true;
    //todo: move this to the service too
    await SharePlus.instance.share(model.toShareParams());
    _isShareInProgress = false;
  }
}
