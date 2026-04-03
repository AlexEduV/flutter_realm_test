import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_cubit.dart';
import 'package:test_futter_project/presentation/bloc/account/edit_dialog_state.dart';

void main() {
  group('EditDialogCubit', () {
    late EditDialogCubit cubit;

    setUp(() {
      cubit = EditDialogCubit();
    });

    test('initial state is EditDialogState()', () {
      expect(cubit.state, const EditDialogState());
    });

    blocTest<EditDialogCubit, EditDialogState>(
      'setConfirmButtonEnabled emits updated state',
      build: () => EditDialogCubit(),
      act: (cubit) => cubit.setConfirmButtonEnabled(true),
      expect: () => [const EditDialogState().copyWith(isConfirmButtonEnabled: true)],
    );

    blocTest<EditDialogCubit, EditDialogState>(
      'setPasswordFieldObscurity emits updated state',
      build: () => EditDialogCubit(),
      act: (cubit) => cubit.setPasswordFieldObscurity(false),
      expect: () => [const EditDialogState().copyWith(isPasswordFieldObscure: false)],
    );

    blocTest<EditDialogCubit, EditDialogState>(
      'setPasswordConfirmationFieldObscurity emits updated state',
      build: () => EditDialogCubit(),
      act: (cubit) => cubit.setPasswordConfirmationFieldObscurity(false),
      expect: () => [const EditDialogState().copyWith(isConfirmationPasswordFieldObscure: false)],
    );
  });
}
