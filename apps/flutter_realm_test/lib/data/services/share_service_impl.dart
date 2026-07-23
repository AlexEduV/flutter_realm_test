import 'package:share_plus/share_plus.dart';
import 'package:test_flutter_project/domain/models/share_params_model.dart';

import '../../domain/services/share_service.dart';

class ShareServiceImpl implements ShareService {
  @override
  Future<void> share(ShareParamsModel model) async {
    await SharePlus.instance.share(model.toShareParams());
  }
}
