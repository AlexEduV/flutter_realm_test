import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_cubit.dart';
import 'package:test_futter_project/presentation/bloc/authentication/authentication_state.dart';
import 'package:test_futter_project/presentation/pages/authentication/login_page.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/auth_error_widget.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/auth_form_switcher.dart';
import 'package:test_futter_project/utils/l10n/l10n.dart';

import 'login_page_test.mocks.dart';

@GenerateMocks([AuthenticationCubit])
void main() {
  late MockAuthenticationCubit authenticationCubit;

  setUp(() {
    authenticationCubit = MockAuthenticationCubit();
    AppLocalisations.localisations = {
      'forms.ui.welcomeLoginTitle': 'Welcome Back',
      'forms.ui.welcomeRegisterTitle': 'Join us',
    };
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<AuthenticationCubit>.value(value: authenticationCubit, child: child),
    );
  }

  testWidgets('shows login welcome text in login mode', (tester) async {
    when(authenticationCubit.state).thenReturn(const AuthenticationState(isLoginMode: true));
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    expect(find.text(AppLocalisations.loginPageLoginWelcomeText), findsOneWidget);
  });

  testWidgets('shows registration welcome text in registration mode', (tester) async {
    when(authenticationCubit.state).thenReturn(const AuthenticationState(isLoginMode: false));
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    expect(find.text(AppLocalisations.loginPageRegistrationWelcomeText), findsOneWidget);
  });

  testWidgets('shows error message when authenticationErrorText is set', (tester) async {
    when(authenticationCubit.state).thenReturn(
      const AuthenticationState(isLoginMode: true, authenticationErrorText: 'Invalid credentials'),
    );
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    expect(find.text('Invalid credentials'), findsOneWidget);
  });

  testWidgets('does not show error message when authenticationErrorText is null', (tester) async {
    when(
      authenticationCubit.state,
    ).thenReturn(const AuthenticationState(isLoginMode: true, authenticationErrorText: null));
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    final finder = find.byType(AuthErrorWidget);
    final errorWidget = tester.widget<AuthErrorWidget>(finder.first);

    expect(errorWidget.text, isNull);
  });

  testWidgets('shows AuthFormsSwitcher with correct mode', (tester) async {
    when(authenticationCubit.state).thenReturn(const AuthenticationState(isLoginMode: true));
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    // Find AuthFormsSwitcher and check its isLoginMode property
    final switcherFinder = find.byType(AuthFormsSwitcher);
    expect(switcherFinder, findsOneWidget);

    final switcherWidget = tester.widget<AuthFormsSwitcher>(switcherFinder);
    expect(switcherWidget.isLoginMode, isTrue);
  });

  testWidgets('shows background image', (tester) async {
    when(authenticationCubit.state).thenReturn(const AuthenticationState(isLoginMode: true));
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    // Check for the image asset
    expect(find.byType(Image), findsOneWidget);
  });
}
