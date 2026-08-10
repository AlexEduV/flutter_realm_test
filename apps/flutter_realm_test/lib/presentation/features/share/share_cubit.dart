import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/domain/models/share_params_model.dart';
import 'package:test_flutter_project/domain/usecases/share/share_use_case.dart';
import 'package:test_flutter_project/presentation/features/share/share_state.dart';

class ShareCubit extends Cubit<ShareState> {
  ShareCubit(this._shareUseCase) : super(const ShareState());

  final ShareUseCase _shareUseCase;

  Future<void> share(ShareParamsModel model) async {
    await _shareUseCase.call(model);
  }
}
