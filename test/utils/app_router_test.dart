import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/utils/app_router.dart';

void main() {
  //todo: the bloc provider is missing from the widget tree
  // testWidgets('Navigates to HomePage on root route', (WidgetTester tester) async {
  //   await tester.pumpWidget(CupertinoApp.router(routerConfig: AppRouter.router));
  //   await tester.pumpAndSettle();
  //
  //   expect(find.byType(HomePage), findsOneWidget);
  //   expect(find.byType(SearchPage), findsNothing);
  // });
  //
  // testWidgets('Navigates to SearchPage on /search route', (WidgetTester tester) async {
  //   await tester.pumpWidget(CupertinoApp.router(routerConfig: AppRouter.router));
  //   await tester.pumpAndSettle();
  //
  //   // Navigate to /search
  //   AppRouter.router.go('/search');
  //   await tester.pumpAndSettle();
  //
  //   expect(find.byType(SearchPage), findsOneWidget);
  //   expect(find.byType(HomePage), findsNothing);
  // });

  test('AppRouter.router is a GoRouter', () {
    expect(AppRouter.router, isA<GoRouter>());
  });
}
