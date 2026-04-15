import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_state.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/message_item/widgets/gif_label.dart';

import '../../../../../../common/extensions/context_extension_test.mocks.dart';

void main() {
  final mockAppLocalisationsCubit = MockAppLocalisationsCubit();

  testWidgets('GifLabel renders with correct text and style', (WidgetTester tester) async {
    when(mockAppLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockAppLocalisationsCubit.state).thenReturn(
      const AppLocalisationsState(localisations: {L10nKeys.gifMessagePlaceholder: 'gif'}),
    );

    // Provide a MaterialApp to supply context and localization
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AppLocalisationsCubit>.value(
          value: mockAppLocalisationsCubit,
          child: const Scaffold(body: GifLabel()),
        ),
      ),
    );

    // Check that the Container is present
    expect(find.byType(Container), findsOneWidget);

    // Check that the text is present (adjust if your localization returns a different string)
    expect(find.textContaining('gif', findRichText: true), findsOneWidget);

    // Optionally, check for the Text widget and its style
    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.style?.fontWeight, FontWeight.w600);
  });
}
