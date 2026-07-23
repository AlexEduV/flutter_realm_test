import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/data/services/file_picker_service_impl.dart';

import 'file_picker_service_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FilePickerIO>(), MockSpec<FilePickerResult>()])
void main() {
  late MockFilePickerIO mockFilePicker;
  late FilePickerServiceImpl dataSource;

  setUp(() {
    mockFilePicker = MockFilePickerIO();
    dataSource = FilePickerServiceImpl(mockFilePicker);
  });

  test('returns null if no file is picked', () async {
    when(mockFilePicker.pickFiles(type: FileType.media)).thenAnswer((_) async => null);

    final result = await dataSource.pickFile();

    expect(result, isNull);
    verify(mockFilePicker.pickFiles(type: FileType.media)).called(1);
  });

  test('returns null if files list is empty', () async {
    final mockResult = MockFilePickerResult();
    when(mockResult.files).thenReturn([]);
    when(mockFilePicker.pickFiles(type: FileType.media)).thenAnswer((_) async => mockResult);

    final result = await dataSource.pickFile();

    expect(result, isNull);
    verify(mockFilePicker.pickFiles(type: FileType.media)).called(1);
  });
}
