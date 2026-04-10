import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/models/sent_attachment_meta_data_model.dart';
import 'package:test_futter_project/presentation/pages/messages/widgets/message_item/widgets/message_file_content.dart';

void main() {
  testWidgets('renders file name and icon for my message', (WidgetTester tester) async {
    final attachment = SentAttachmentMetaDataModel(name: 'file.txt', size: 123);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: MessageFileContent(attachmentMetaData: attachment, isMyMessage: true)),
      ),
    );

    // Check file name
    expect(find.text('file.txt'), findsOneWidget);

    // Check icon color is white
    final icon = tester.widget<Icon>(find.byIcon(Icons.file_present_sharp));
    expect(icon.color, Colors.white);
  });

  testWidgets('renders file name and icon for other message', (WidgetTester tester) async {
    final attachment = SentAttachmentMetaDataModel(name: 'document.pdf', size: 456);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MessageFileContent(attachmentMetaData: attachment, isMyMessage: false),
        ),
      ),
    );

    // Check file name
    expect(find.text('document.pdf'), findsOneWidget);

    // Check icon color is default (null)
    final icon = tester.widget<Icon>(find.byIcon(Icons.file_present_sharp));
    expect(icon.color, isNull);
  });

  testWidgets('renders empty string when attachmentMetaData is null', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: MessageFileContent(attachmentMetaData: null, isMyMessage: false)),
      ),
    );

    expect(find.text(''), findsOneWidget);
  });
}
