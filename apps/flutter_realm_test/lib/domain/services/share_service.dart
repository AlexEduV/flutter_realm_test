import 'package:test_flutter_project/domain/models/share_params_model.dart';

abstract class ShareService {
  Future<void> share(ShareParamsModel model);
}
