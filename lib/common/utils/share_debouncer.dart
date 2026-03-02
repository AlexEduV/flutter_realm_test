import 'package:share_plus/share_plus.dart';

class ShareDebouncer {
  static bool _isShareInProgress = false;

  static Future<void> share(ShareParams params) async {
    if (_isShareInProgress) return;

    _isShareInProgress = true;
    await SharePlus.instance.share(params);
    _isShareInProgress = false;
  }
}
