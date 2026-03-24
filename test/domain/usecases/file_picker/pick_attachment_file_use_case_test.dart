import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_futter_project/domain/entities/attachment_entity.dart';
import 'package:test_futter_project/domain/repositories/file_picker_repository.dart';
import 'package:test_futter_project/domain/usecases/file_picker/pick_attachment_file_use_case.dart';

import 'pick_attachment_file_use_case_test.mocks.dart';

@GenerateMocks([FilePickerRepository])
void main() {
  late MockFilePickerRepository mockRepository;
  late PickAttachmentFileUseCase useCase;

  setUp(() {
    mockRepository = MockFilePickerRepository();
    useCase = PickAttachmentFileUseCase(mockRepository);
  });

  test('should call pickFile on repository and return AttachmentEntity', () async {
    final attachment = AttachmentEntity(name: 'file.txt', path: '/path/file.txt', size: 2000);
    when(mockRepository.pickFile()).thenAnswer((_) async => attachment);

    final result = await useCase.call();

    expect(result, equals(attachment));
    verify(mockRepository.pickFile()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return null when repository returns null', () async {
    when(mockRepository.pickFile()).thenAnswer((_) async => null);

    final result = await useCase.call();

    expect(result, isNull);
    verify(mockRepository.pickFile()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
