import 'package:test_flutter_project/domain/services/share_service.dart';
import 'package:test_flutter_project/domain/repositories/share_repository.dart';

import '../../domain/models/share_params_model.dart';

class ShareRepositoryImpl implements ShareRepository {
  ShareRepositoryImpl(this._shareService);

  final ShareService _shareService;
  bool _isShareInProgress = false;

  @override
  Future<void> share(ShareParamsModel model) async {
    if (_isShareInProgress) {
      return;
    }

    //iOS 26 fix is not needed when using the newest version of plugin;

    _isShareInProgress = true;
    await _shareService.share(model);
    _isShareInProgress = false;
  }
}
