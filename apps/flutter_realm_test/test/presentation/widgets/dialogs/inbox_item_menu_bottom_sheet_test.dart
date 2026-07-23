import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/home/inbox_page/inbox_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/inbox_page/inbox_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/pages/account/widgets/account_item_separated.dart';
import 'package:test_flutter_project/presentation/widgets/dialogs/inbox_item_menu_bottom_sheet.dart';

import '../../pages/messages/messages_page_test.mocks.dart';

void main() {
  final appLocalisationsCubit = AppLocalisationsCubit();

  setUpAll(() {
    appLocalisationsCubit.load({L10nKeys.conversationDialogDeleteItemTitle: 'Delete conversation'});
  });

  testWidgets('InboxItemMenuBottomSheet renders and handles delete tap', (
    WidgetTester tester,
  ) async {
    final mockCubit = MockInboxPageCubit();
    const conversationId = 'conv123';

    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.state).thenReturn(const InboxPageState());
    when(mockCubit.deleteConversation(any)).thenAnswer((_) async {});

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (_) => const InboxItemMenuBottomSheet(conversationId: conversationId),
                ),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      ],
    );

    // Providers must be above MaterialApp.router so modal bottom sheet routes
    // can find them through the navigator overlay context.
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AppLocalisationsCubit>.value(value: appLocalisationsCubit),
          BlocProvider<InboxPageCubit>.value(value: mockCubit),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(AccountItemSeparated), findsOneWidget);

    await tester.tap(find.byType(AccountItemSeparated));
    await tester.pumpAndSettle();

    verify(mockCubit.deleteConversation(conversationId)).called(1);
    expect(find.byType(InboxItemMenuBottomSheet), findsNothing);
  });
}
