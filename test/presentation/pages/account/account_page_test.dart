import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_futter_project/presentation/bloc/user/user_data_state.dart';
import 'package:test_futter_project/presentation/pages/account/account_page.dart';
import 'package:test_futter_project/presentation/pages/authentication/login_page.dart';
import 'package:test_futter_project/utils/l10n.dart';

import '../../../utils/app_router_test.mocks.dart';
import '../authentication/login_page_test.mocks.dart';

void main() {
  late MockUserDataCubit userDataCubit;
  late MockAuthenticationCubit authenticationCubit;

  setUp(() {
    userDataCubit = MockUserDataCubit();
    authenticationCubit = MockAuthenticationCubit();

    AppLocalisations.localisations = {
      'pages.account.items.personalDetails': 'Personal Details',
      'pages.account.items.location': 'Location',
      'pages.account.items.myItems': 'My Items',
      'pages.account.items.recentlyViewed': 'Viewed',
      'pages.account.items.clearData': 'Clear Data',
      'pages.account.items.logOut': 'Logout',
      'pages.account.items.deleteAccount': 'Delete Account',
    };
  });

  Widget makeTestableWidget(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserDataCubit>.value(value: userDataCubit),
        BlocProvider<AuthenticationCubit>.value(value: authenticationCubit),
      ],
      child: MaterialApp(home: child),
    );
  }

  testWidgets('shows LoginPage when user is not authenticated', (tester) async {
    when(userDataCubit.stream).thenAnswer((_) => Stream.fromIterable([const UserDataState()]));
    when(
      authenticationCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const AuthenticationState()]));

    when(userDataCubit.state).thenReturn(
      const UserDataState(isUserAuthenticated: false, firstName: '', lastName: '', email: ''),
    );
    when(authenticationCubit.state).thenReturn(const AuthenticationState());

    await tester.pumpWidget(makeTestableWidget(const AccountPage()));

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('shows user info and account items when authenticated', (tester) async {
    when(userDataCubit.stream).thenAnswer((_) => Stream.fromIterable([const UserDataState()]));
    when(
      authenticationCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const AuthenticationState()]));

    when(userDataCubit.state).thenReturn(
      const UserDataState(
        isUserAuthenticated: true,
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
      ),
    );

    when(authenticationCubit.state).thenReturn(const AuthenticationState());

    await tester.pumpWidget(makeTestableWidget(const AccountPage()));

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('john.doe@example.com'), findsOneWidget);

    // Check for account items (replace with actual localized strings if needed)
    expect(find.textContaining('Personal'), findsOneWidget);
    expect(find.textContaining('Location'), findsOneWidget);
    expect(find.textContaining('My Items'), findsOneWidget);
    expect(find.textContaining('Viewed'), findsOneWidget);
    expect(find.textContaining('Clear Data'), findsOneWidget);
    expect(find.textContaining('Logout'), findsOneWidget);
    expect(find.textContaining('Delete Account'), findsOneWidget);
  });

  testWidgets('tapping logout calls cubit methods', (tester) async {
    when(userDataCubit.stream).thenAnswer((_) => Stream.fromIterable([const UserDataState()]));
    when(
      authenticationCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const AuthenticationState()]));

    when(authenticationCubit.state).thenReturn(const AuthenticationState());

    when(userDataCubit.state).thenReturn(
      const UserDataState(
        isUserAuthenticated: true,
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
      ),
    );
    when(authenticationCubit.logOut()).thenAnswer((_) async {});
    when(userDataCubit.logOutUser()).thenReturn(null);

    await tester.pumpWidget(makeTestableWidget(const AccountPage()));

    // Tap the logout item (replace with actual localized string if needed)
    final logoutFinder = find.textContaining('Logout');
    expect(logoutFinder, findsOneWidget);

    await tester.tap(logoutFinder);
    await tester.pumpAndSettle();

    verify(authenticationCubit.logOut()).called(1);
    verify(userDataCubit.logOutUser()).called(1);
  });

  testWidgets('tapping delete account calls cubit methods', (tester) async {
    when(userDataCubit.stream).thenAnswer((_) => Stream.fromIterable([const UserDataState()]));
    when(
      authenticationCubit.stream,
    ).thenAnswer((_) => Stream.fromIterable([const AuthenticationState()]));

    when(authenticationCubit.state).thenReturn(const AuthenticationState());

    when(userDataCubit.state).thenReturn(
      const UserDataState(
        isUserAuthenticated: true,
        firstName: 'John',
        lastName: 'Doe',
        email: 'john.doe@example.com',
      ),
    );
    when(authenticationCubit.deleteAccount(any)).thenAnswer((_) async {});
    when(userDataCubit.logOutUser()).thenReturn(null);

    await tester.pumpWidget(makeTestableWidget(const AccountPage()));

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));

    // Tap the delete account item (replace with actual localized string if needed)
    final deleteAccountFinder = find.textContaining('Delete Account');
    expect(deleteAccountFinder, findsOneWidget);

    await tester.tap(deleteAccountFinder);
    await tester.pumpAndSettle();

    verify(authenticationCubit.deleteAccount('john.doe@example.com')).called(1);
    verify(userDataCubit.logOutUser()).called(1);
  });
}
