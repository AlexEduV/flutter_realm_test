import 'package:test_futter_project/domain/data_sources/local/share_local_data_source.dart';
import 'package:test_futter_project/domain/repositories/share_repository.dart';

import '../../domain/models/share_params_model.dart';

class ShareRepositoryImpl implements ShareRepository {
  final ShareLocalDataSource _shareLocalDataSource;
  bool _isShareInProgress = false;

  ShareRepositoryImpl(this._shareLocalDataSource);

  @override
  Future<void> share(ShareParamsModel model) async {
    if (_isShareInProgress) return;

    //iOS 26 fix is not needed when using the newest version of plugin;

    _isShareInProgress = true;
    await _shareLocalDataSource.share(model);
    _isShareInProgress = false;
  }
}
