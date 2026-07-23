import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/presentation/bloc/account/edit_dialog_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/account/edit_dialog_state.dart';
import 'package:test_flutter_project/presentation/pages/account/sub_pages/personal_details/widgets/edit_password_field_widget.dart';
import 'package:test_flutter_project/presentation/pages/authentication/widgets/animated_password_visibility_icon.dart';
import 'package:test_flutter_project/presentation/widgets/app_semantics.dart';

void main() {
  setUpAll(() {
    provideDummy(const EditDialogState());
  });

  testWidgets('EditPasswordFieldWidget renders and interacts correctly', (
    WidgetTester tester,
  ) async {
    // Arrange
    final controller = TextEditingController();
    final focusNode = FocusNode();
    bool validateEditFieldCalled = false;
    bool onSuffixIconTapCalled = false;

    Widget buildTestWidget({bool isObscure = true}) {
      return MaterialApp(
        home: BlocProvider<EditDialogCubit>(
          create: (_) => EditDialogCubit(),
          child: Scaffold(
            body: EditPasswordFieldWidget(
              textEditingController: controller,
              focusNode: focusNode,
              validateEditField: (context, value, validationCallback) {
                validateEditFieldCalled = true;
              },
              onSuffixIconTap: () {
                onSuffixIconTapCalled = true;
              },
              isObscureText: isObscure,
            ),
          ),
        ),
      );
    }

    // Act
    await tester.pumpWidget(buildTestWidget());

    // Assert: TextFormField is present
    expect(find.byType(TextFormField), findsOneWidget);

    // Assert: AppSemantics is present
    expect(find.byType(AppSemantics), findsWidgets);

    // Assert: obscureText is set
    final textFormField = tester.widget<EditPasswordFieldWidget>(
      find.byType(EditPasswordFieldWidget),
    );
    expect(textFormField.isObscureText, isTrue);

    // Assert: AnimatedVisibilityIcon is present
    expect(find.byType(AnimatedVisibilityIcon), findsOneWidget);

    // Act: Change text to trigger validateEditField
    await tester.enterText(find.byType(TextFormField), 'newPassword');
    await tester.pump();
    expect(validateEditFieldCalled, isTrue);

    // Act: Tap the suffix icon
    await tester.tap(find.byType(InkWell));
    await tester.pump();
    expect(onSuffixIconTapCalled, isTrue);
  });

  testWidgets('EditPasswordFieldWidget shows not obscured text when isObscureText is false', (
    WidgetTester tester,
  ) async {
    final controller = TextEditingController();
    final focusNode = FocusNode();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<EditDialogCubit>(
          create: (_) => EditDialogCubit(),
          child: Scaffold(
            body: EditPasswordFieldWidget(
              textEditingController: controller,
              focusNode: focusNode,
              validateEditField: (_, __, ___) {},
              onSuffixIconTap: () {},
              isObscureText: false,
            ),
          ),
        ),
      ),
    );

    final textFormField = tester.widget<EditPasswordFieldWidget>(
      find.byType(EditPasswordFieldWidget),
    );
    expect(textFormField.isObscureText, isFalse);
  });
}
