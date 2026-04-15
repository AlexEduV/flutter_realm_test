import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/models/sent_image_meta_data_model.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/l10n/app_localisations_state.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/message_item/widgets/gif_label.dart';
import 'package:test_flutter_project/presentation/pages/messages/widgets/message_item/widgets/message_gif_content.dart';

import '../../../../../../common/extensions/context_extension_test.mocks.dart';

void main() {
  final appLocalisationsCubit = MockAppLocalisationsCubit();

  setUpAll(() {
    when(appLocalisationsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(appLocalisationsCubit.state).thenReturn(const AppLocalisationsState(localisations: {}));
  });

  testWidgets('renders SizedBox with correct dimensions and GifLabel', (WidgetTester tester) async {
    // Assume AppDimensions.imageMessageSize is 100.0 for this test
    final imageMetaData = SentImageMetaDataModel(
      url: 'http://example.com/image.gif',
      width: 200.0,
      height: 50.0,
    );

    // Mock AppDimensions if needed, or set the value in your test environment

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AppLocalisationsCubit>.value(
          value: appLocalisationsCubit,
          child: Scaffold(body: MessageGifContent(imageMetaData: imageMetaData)),
        ),
      ),
    );

    // Find the SizedBox and check its dimensions
    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
    expect(sizedBox.width, 200.0);
    expect(sizedBox.height, 50.0);

    // Check that GifLabel is present
    expect(find.byType(GifLabel), findsOneWidget);
  });

  testWidgets('uses default image factor when imageMetaData is null', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AppLocalisationsCubit>.value(
          value: appLocalisationsCubit,
          child: const Scaffold(body: MessageGifContent(imageMetaData: null)),
        ),
      ),
    );
    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
    expect(sizedBox.width, 200.0);
    expect(sizedBox.height, 200.0);

    expect(find.byType(GifLabel), findsOneWidget);
  });
}
