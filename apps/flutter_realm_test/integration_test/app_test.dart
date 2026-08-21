@Tags(['integration'])
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_project/common/constants/app_semantics_labels.dart';
import 'package:test_flutter_project/core/di/injection_container.dart';
import 'package:test_flutter_project/main.dart' as app;
import 'package:test_flutter_project/presentation/features/authentication/login_page_identifiers.dart';
import 'package:test_flutter_project/presentation/features/home_bottom_bar/home_bottom_bar_identifiers.dart';

// Credentials from SeedUsers.initialUsers
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

      final loginPage = LoginPagePOM(tester);
      final homePage = HomePagePOM(tester);

      await homePage.openAccountTab();
      await loginPage.enterCredentials(email: _validEmail, password: _validPassword);
      await loginPage.tapLoginButton();

      await tester.pumpAndSettle();

      // Avatar only appears on the authenticated account page
      expect(find.bySemanticsLabel(AppSemanticsLabels.avatarWidgetEnhanced), findsOneWidget);
    });

    testWidgets('wrong password — shows inline auth error', (tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 3));

      final loginPage = LoginPagePOM(tester);
      final homePage = HomePagePOM(tester);

      await homePage.openAccountTab();
      await loginPage.enterCredentials(email: _validEmail, password: 'WrongPass1!');
      await loginPage.tapLoginButton();

      await tester.pumpAndSettle();

      expect(find.text('Incorrect password.'), findsOneWidget);
      loginPage.assertLoginButtonVisible();
    });

    testWidgets('unknown email — shows inline auth error', (tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 3));

      final loginPage = LoginPagePOM(tester);
      final homePage = HomePagePOM(tester);

      await homePage.openAccountTab();
      await loginPage.enterCredentials(email: 'nobody@example.com', password: _validPassword);
      await loginPage.tapLoginButton();

      await tester.pumpAndSettle();

      expect(find.text('The user not found.'), findsOneWidget);
      loginPage.assertLoginButtonVisible();
    });

    testWidgets('empty fields — client-side validation blocks submission', (tester) async {
      app.main();
      await tester.pump(const Duration(seconds: 3));

      final loginPage = LoginPagePOM(tester);
      final homePage = HomePagePOM(tester);

      await homePage.openAccountTab();
      await loginPage.tapLoginButton();

      // No network call is made — pumpAndSettle resolves immediately
      await tester.pumpAndSettle();

      // Still on the login page
      loginPage.assertLoginButtonVisible();
      // Home nav is absent
      expect(find.bySemanticsLabel(HomeBottomBarPageIds.homeBottomBarItemHome), findsNothing);
    });
  });
}

class LoginPagePOM {
  LoginPagePOM(this._tester);

  final WidgetTester _tester;

  Future<void> tapLoginButton() async {
    await _tester.tap(find.bySemanticsLabel(LoginPageIds.loginButton));
    await _tester.pump();
  }

  Future<void> enterCredentials({required String email, required String password}) async {
    final emailField = find.bySemanticsLabel(LoginPageIds.emailTextField);
    final passwordField = find.bySemanticsLabel(LoginPageIds.passwordTextField);

    await _tester.tap(emailField);
    await _tester.enterText(emailField, email);
    await _tester.pump();

    await _tester.tap(passwordField);
    await _tester.enterText(passwordField, password);
    await _tester.pump();
  }

  void assertLoginButtonVisible() {
    expect(find.bySemanticsLabel(LoginPageIds.loginButton), findsOneWidget);
  }
}

class HomePagePOM {
  HomePagePOM(this._tester);

  final WidgetTester _tester;

  Future<void> openAccountTab() async {
    await _tester.tap(find.bySemanticsLabel(HomeBottomBarPageIds.homeBottomBarItemAccount));
    await _tester.pumpAndSettle();
  }
}
