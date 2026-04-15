import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_flutter_project/domain/repositories/image_picker_repository.dart';
import 'package:test_flutter_project/domain/usecases/image_picker/pick_image_from_gallery_use_case.dart';

import 'pick_image_from_gallery_use_case_test.mocks.dart';

@GenerateMocks([ImagePickerRepository])
void main() {
  late MockImagePickerRepository mockRepository;
  late PickImageFromGalleryUseCase useCase;

  setUp(() {
    mockRepository = MockImagePickerRepository();
    useCase = PickImageFromGalleryUseCase(mockRepository);
  });

  test('should call pickImage on repository and return image path', () async {
    final imagePath = '/path/to/image.jpg';
    when(mockRepository.pickImage()).thenAnswer((_) async => imagePath);

    final result = await useCase.call();

    expect(result, equals(imagePath));
    verify(mockRepository.pickImage()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return null when repository returns null', () async {
    when(mockRepository.pickImage()).thenAnswer((_) async => null);

    final result = await useCase.call();

    expect(result, isNull);
    verify(mockRepository.pickImage()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
