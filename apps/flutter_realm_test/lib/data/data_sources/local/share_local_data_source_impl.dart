import 'package:share_plus/share_plus.dart';
import 'package:test_flutter_project/domain/models/share_params_model.dart';

import '../../../domain/data_sources/local/share_local_data_source.dart';

class ShareLocalDataSourceImpl implements ShareLocalDataSource {
  @override
  Future<void> share(ShareParamsModel model) async {
    await SharePlus.instance.share(model.toShareParams());
  }
}
