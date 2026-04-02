import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_futter_project/presentation/bloc/l10n/app_localisations_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/personal_details/personal_details_page.dart';
import 'package:test_futter_project/presentation/pages/account/sub_pages/personal_details/widgets/personal_details_list_item.dart';

import '../../../../../common/extensions/context_extension_test.mocks.dart';
import '../../../../../utils/app_router_test.mocks.dart';
import '../../../authentication/login_page_test.mocks.dart';

void main() {
  setUpAll(() {
    provideDummy(const UserDataState());
  });

  testWidgets('PersonalDetailsPage renders all PersonalDetailsListItems with correct data', (
    WidgetTester tester,
  ) async {
    // Arrange
    final mockUserDataCubit = MockUserDataCubit();
    final mockAuthenticationCubit = MockAuthenticationCubit();
    final mockAppLocalisationsCubit = MockAppLocalisationsCubit();

    // Provide a fake state
    when(mockUserDataCubit.state).thenReturn(
      const UserDataState(
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
        password: 'secret',
      ),
    );
    when(mockUserDataCubit.stream).thenAnswer((_) => const Stream.empty());

    when(mockAppLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(
      mockAppLocalisationsCubit.state,
    ).thenReturn(const AppLocalisationsState(localisations: {}));

    // Mock context.read<T>() for cubits
    //late BuildContext capturedContext;
    Widget testWidget = MultiBlocProvider(
      providers: [
        BlocProvider<UserDataCubit>.value(value: mockUserDataCubit),
        BlocProvider<AppLocalisationsCubit>.value(value: mockAppLocalisationsCubit),
        BlocProvider<AuthenticationCubit>.value(value: mockAuthenticationCubit),
      ],
      child: Builder(
        builder: (context) {
          //capturedContext = context;
          return const MaterialApp(home: PersonalDetailsPage());
        },
      ),
    );

    // Act
    await tester.pumpWidget(testWidget);

    // Assert: AppBar and ListItems
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(PersonalDetailsListItem), findsNWidgets(4));
    expect(find.text('John'), findsOneWidget);
    expect(find.text('Doe'), findsOneWidget);
    expect(find.text('john.doe@example.com'), findsOneWidget);
    // Password is obscured, so check for the correct obscured string
    expect(find.text('******'), findsOneWidget);

    // Optionally, test tapping a list item triggers the dialog
    // You may need to use mockito/mocktail to verify DialogHelper.showEditDialog is called
    // For example, if you use mocktail:
    // when(() => DialogHelper.showEditDialog(any(), ...)).thenAnswer((_) async {});
    // await tester.tap(find.byType(PersonalDetailsListItem).first);
    // verify(() => DialogHelper.showEditDialog(any(), ...)).called(1);
  });
}
