import 'package:file_picker/file_picker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/data/data_sources/local/file_picker_local_data_source_impl.dart';

import 'file_picker_local_data_source_impl_test.mocks.dart';

@GenerateMocks([FilePickerIO, FilePickerResult])
void main() {
  late MockFilePickerIO mockFilePicker;
  late FilePickerLocalDataSourceImpl dataSource;

  setUp(() {
    mockFilePicker = MockFilePickerIO();
    dataSource = FilePickerLocalDataSourceImpl(mockFilePicker);
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
