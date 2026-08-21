import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/common/enums/auth_mode.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_cubit.dart';
import 'package:test_flutter_project/presentation/features/authentication/authentication_state.dart';
import 'package:test_flutter_project/presentation/features/authentication/login_page.dart';
import 'package:test_flutter_project/presentation/features/authentication/login_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/authentication/widgets/auth_error_widget.dart';
import 'package:test_flutter_project/presentation/features/authentication/widgets/auth_form_switcher.dart';
import 'package:test_flutter_project/presentation/features/l10n/app_localisations_cubit.dart';

import 'login_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationCubit>()])
void main() {
  late MockAuthenticationCubit authenticationCubit;
  final appLocalisationsCubit = AppLocalisationsCubit();

  setUp(() {
    authenticationCubit = MockAuthenticationCubit();

    serviceLocator.registerLazySingleton(() => appLocalisationsCubit);
    final localisations = {
      'forms.ui.welcomeLoginTitle': 'Welcome Back',
      'forms.ui.welcomeRegisterTitle': 'Join us',
    };

    appLocalisationsCubit.load(localisations);
  });

  tearDown(() {
    serviceLocator.unregister<AppLocalisationsCubit>();
  });

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationCubit>.value(value: authenticationCubit),
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
        ],
        child: child,
      ),
    );
  }

  testWidgets('shows login welcome text in login mode', (tester) async {
    when(
      authenticationCubit.state,
    ).thenReturn(const AuthenticationState(currentAuthMode: AuthMode.login));
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    expect(
      find.text(appLocalisationsCubit.getLocalisationByKey(LoginPageIds.loginPageLoginWelcomeText)),
      findsOneWidget,
    );
  });

  testWidgets('shows registration welcome text in registration mode', (tester) async {
    when(
      authenticationCubit.state,
    ).thenReturn(const AuthenticationState(currentAuthMode: AuthMode.register));
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    expect(
      find.text(
        appLocalisationsCubit.getLocalisationByKey(LoginPageIds.loginPageRegistrationWelcomeText),
      ),
      findsOneWidget,
    );
  });

  testWidgets('shows error message when authenticationErrorText is set', (tester) async {
    when(authenticationCubit.state).thenReturn(
      const AuthenticationState(
        currentAuthMode: AuthMode.login,
        authenticationErrorText: 'Invalid credentials',
      ),
    );
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    expect(find.text('Invalid credentials'), findsOneWidget);
  });

  testWidgets('does not show error message when authenticationErrorText is null', (tester) async {
    when(authenticationCubit.state).thenReturn(
      const AuthenticationState(currentAuthMode: AuthMode.login, authenticationErrorText: null),
    );
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    final finder = find.byType(AuthErrorWidget);
    final errorWidget = tester.widget<AuthErrorWidget>(finder.first);

    expect(errorWidget.text, isNull);
  });

  testWidgets('shows AuthFormsSwitcher with correct mode', (tester) async {
    when(
      authenticationCubit.state,
    ).thenReturn(const AuthenticationState(currentAuthMode: AuthMode.login));
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    // Find AuthFormsSwitcher and check its isLoginMode property
    final switcherFinder = find.byType(AuthFormsSwitcher);
    expect(switcherFinder, findsOneWidget);

    final switcherWidget = tester.widget<AuthFormsSwitcher>(switcherFinder);
    expect(switcherWidget.isLoginMode, isTrue);
  });

  testWidgets('shows background image', (tester) async {
    when(
      authenticationCubit.state,
    ).thenReturn(const AuthenticationState(currentAuthMode: AuthMode.login));
    when(authenticationCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(makeTestableWidget(const LoginPage()));

    // Check for the image asset
    expect(find.byType(Image), findsOneWidget);
  });
}
