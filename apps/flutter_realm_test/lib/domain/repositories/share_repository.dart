import '../models/share_params_model.dart';

abstract interface class ShareRepository {
  Future<void> share(ShareParamsModel model);
}
