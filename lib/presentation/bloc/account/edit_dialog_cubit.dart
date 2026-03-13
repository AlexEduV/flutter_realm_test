import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_state.dart';

class EditDialogCubit extends Cubit<EditDialogState> {
  EditDialogCubit() : super(const EditDialogState());

  void setConfirmButtonEnabled(bool newState) {
    emit(state.copyWith(isConfirmButtonEnabled: newState));
  }

  void setPasswordObscurity(bool newValue) {
    emit(
      state.copyWith(
        isPasswordFieldObscure: newValue,
        isConfirmationPasswordFieldObscure: newValue,
      ),
    );
  }
}
