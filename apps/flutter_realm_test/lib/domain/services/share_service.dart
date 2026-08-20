import 'package:test_flutter_project/domain/models/share_params_model.dart';

abstract interface class ShareService {
  Future<void> share(ShareParamsModel model);
}
