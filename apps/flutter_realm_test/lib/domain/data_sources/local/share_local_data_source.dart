import 'package:test_futter_project/domain/models/share_params_model.dart';

abstract class ShareLocalDataSource {
  Future<void> share(ShareParamsModel model);
}
