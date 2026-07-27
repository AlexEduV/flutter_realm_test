import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/main.dart' as app;

// Credentials from MockUsers.initialUsers
const _validEmail = 'mock@gmail.com';
const _validPassword = 'qwertyUI10!';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // Start each test with a clean session (no cached userId, no cached mock users)
    SharedPreferences.setMockInitialValues({});
    await serviceLocator.reset();
  });

  group('Login flow', () {
    testWidgets('happy path — valid credentials navigate to home', (tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 3));

      await _goToLoginViaAccountTab(tester);
      await _enterCredentials(tester, email: _validEmail, password: _validPassword);
      await _tapLogin(tester);

      await tester.pumpAndSettle();

      // Avatar only appears on the authenticated account page
      expect(find.bySemanticsLabel(AppSemanticsLabels.avatarWidgetEnhanced), findsOneWidget);
    });

    testWidgets('wrong password — shows inline auth error', (tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 3));

      await _goToLoginViaAccountTab(tester);
      await _enterCredentials(tester, email: _validEmail, password: 'WrongPass1!');
      await _tapLogin(tester);

      await tester.pumpAndSettle();

      expect(find.text('Incorrect password.'), findsOneWidget);
      // Login page is still visible — we did not navigate away
      expect(find.bySemanticsLabel(AppSemanticsLabels.loginButton), findsOneWidget);
    });

    // testWidgets('unknown email — shows inline auth error', (tester) async {
    //   app.main();
    //   await tester.pumpAndSettle();
    //
    //   await _enterCredentials(tester, email: 'nobody@example.com', password: _validPassword);
    //   await _tapLogin(tester);
    //
    //   await tester.pumpAndSettle(
    //     const Duration(milliseconds: 100),
    //     EnginePhase.sendSemanticsUpdate,
    //     _networkTimeout,
    //   );
    //
    //   expect(find.bySemanticsLabel(AppSemanticsLabels.authErrorMessage), findsOneWidget);
    //   expect(find.bySemanticsLabel(AppSemanticsLabels.loginButton), findsOneWidget);
    // });
    //
    // testWidgets('empty fields — client-side validation blocks submission', (tester) async {
    //   app.main();
    //   await tester.pumpAndSettle();
    //
    //   await _tapLogin(tester);
    //
    //   // No network call is made — pumpAndSettle resolves immediately
    //   await tester.pumpAndSettle();
    //
    //   // Still on the login page
    //   expect(find.bySemanticsLabel(AppSemanticsLabels.loginButton), findsOneWidget);
    //   // Home nav is absent
    //   expect(find.bySemanticsLabel(AppSemanticsLabels.homeBottomBarItemHome), findsNothing);
    // });
  });
}

Future<void> _enterCredentials(
  WidgetTester tester, {
  required String email,
  required String password,
}) async {
  final emailField = find.bySemanticsLabel(AppSemanticsLabels.emailTextField);
  final passwordField = find.bySemanticsLabel(AppSemanticsLabels.passwordTextField);

  await tester.tap(emailField);
  await tester.enterText(emailField, email);
  await tester.pump();

  await tester.tap(passwordField);
  await tester.enterText(passwordField, password);
  await tester.pump();
}

Future<void> _goToLoginViaAccountTab(WidgetTester tester) async {
  await tester.tap(find.bySemanticsLabel(AppSemanticsLabels.homeBottomBarItemAccount));
  await tester.pumpAndSettle();
}

Future<void> _tapLogin(WidgetTester tester) async {
  await tester.tap(find.bySemanticsLabel(AppSemanticsLabels.loginButton));
  await tester.pump();
}
