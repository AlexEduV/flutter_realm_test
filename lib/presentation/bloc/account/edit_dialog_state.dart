import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_dialog_state.freezed.dart';

@freezed
abstract class EditDialogState with _$EditDialogState {
  const factory EditDialogState({
    @Default(true) bool isConfirmButtonEnabled,
    @Default(true) bool isPasswordFieldObscure,
    @Default(true) bool isConfirmationPasswordFieldObscure,
  }) = _EditDialogState;
}
