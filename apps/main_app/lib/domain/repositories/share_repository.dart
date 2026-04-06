import '../models/share_params_model.dart';

abstract class ShareRepository {
  Future<void> share(ShareParamsModel model);
}
