import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/models/share_params_model.dart';
import 'package:test_flutter_project/domain/repositories/share_repository.dart';
import 'package:test_flutter_project/presentation/features/share/share_state.dart';

class ShareCubit extends Cubit<ShareState> {
  ShareCubit(this._shareRepository) : super(const ShareState());

  final ShareRepository _shareRepository;

  Future<void> share(ShareParamsModel model) async {
    await _shareRepository.share(model);
  }
}
